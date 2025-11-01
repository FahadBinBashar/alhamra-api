<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreCustomerRequest;
use App\Http\Resources\UserResource;
use App\Models\Agent;
use App\Models\Employee;
use App\Models\SalesOrder;
use App\Models\User;
use App\Notifications\CustomerCredentialNotification;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class CustomerController extends Controller
{
    public function index(Request $request): AnonymousResourceCollection
    {
        $user = $request->user();
        $this->ensureCustomerAccess($user);

        $query = User::query()
            ->where('role', User::ROLE_CUSTOMER);

        $this->applyAgentScope($query, $user);

        if ($request->filled('search')) {
            $search = $request->string('search')->toString();

            $query->where(function (Builder $builder) use ($search) {
                $builder->where('name', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%");
            });
        }

        $customers = $query
            ->orderBy('name')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return UserResource::collection($customers);
    }

    public function store(StoreCustomerRequest $request): JsonResponse
    {
        $user = $request->user();
        $this->ensureCustomerAccess($user);

        $data = $request->validated();
        $password = $data['password'];
        $sourceEmployee = $this->resolveSourceEmployee($data['source_me_id'] ?? null);

        $customer = User::create(array_merge($data, [
            'role' => User::ROLE_CUSTOMER,
            'added_by_role' => $this->resolveAddedByRole($user),
            'added_by_branch_id' => $this->resolveBranchId($user) ?? $sourceEmployee?->branch_id,
            'added_by_agent_id' => $this->resolveAgent($user)?->id ?? $sourceEmployee?->agent_id,
            'source_me_id' => $sourceEmployee?->id,
        ]));

        $customer->notify(new CustomerCredentialNotification($customer->email, $password));

        return (new UserResource($customer))
            ->response()
            ->setStatusCode(201);
    }

    public function show(Request $request, User $customer): UserResource
    {
        $user = $request->user();
        $this->ensureCustomerAccess($user);

        if ($customer->role !== User::ROLE_CUSTOMER) {
            abort(404);
        }

        $agent = $this->resolveAgent($user);

        if ($agent) {
            if ((int) $customer->added_by_agent_id === $agent->id) {
                return new UserResource($customer);
            }

            $assigned = SalesOrder::query()
                ->where('agent_id', $agent->id)
                ->where('customer_id', $customer->id)
                ->exists();

            if (! $assigned) {
                abort(403, 'You are not authorised to view this customer.');
            }
        } elseif ($this->isBranchAdmin($user)) {
            $branchId = $this->resolveBranchId($user);

            if (! $branchId) {
                abort(403, 'You are not authorised to view this customer.');
            }

            if ((int) $customer->added_by_branch_id === $branchId) {
                return new UserResource($customer);
            }

            $assigned = SalesOrder::query()
                ->where('branch_id', $branchId)
                ->where('customer_id', $customer->id)
                ->exists();

            if (! $assigned) {
                abort(403, 'You are not authorised to view this customer.');
            }
        } elseif ($this->requiresAgentScope($user)) {
            abort(404);
        }

        return new UserResource($customer);
    }

    private function ensureCustomerAccess(?User $user): void
    {
        if (! $user || ! in_array($user->role, [
            User::ROLE_ADMIN,
            User::ROLE_BRANCH_ADMIN,
            User::ROLE_AGENT_ADMIN,
            User::ROLE_AGENT,
        ], true)) {
            abort(403, 'You are not authorised to manage customers.');
        }
    }

    private function resolveSourceEmployee(?int $employeeId): ?Employee
    {
        if (! $employeeId) {
            return null;
        }

        return Employee::find($employeeId);
    }

    private function applyAgentScope(Builder $query, ?User $user): void
    {
        $agent = $this->resolveAgent($user);

        if ($agent) {
            $query->where(function (Builder $builder) use ($agent) {
                $builder->whereIn('id', function ($subQuery) use ($agent) {
                    $subQuery->select('customer_id')
                        ->from('sales_orders')
                        ->where('agent_id', $agent->id);
                })->orWhere('added_by_agent_id', $agent->id);
            });

            return;
        }

        if ($this->isBranchAdmin($user)) {
            $branchId = $this->resolveBranchId($user);

            if (! $branchId) {
                $query->whereRaw('0 = 1');

                return;
            }

            $query->where(function (Builder $builder) use ($branchId) {
                $builder->whereIn('id', function ($subQuery) use ($branchId) {
                    $subQuery->select('customer_id')
                        ->from('sales_orders')
                        ->where('branch_id', $branchId);
                })->orWhere('added_by_branch_id', $branchId);
            });

            return;
        }

        if ($this->requiresAgentScope($user)) {
            $query->whereRaw('0 = 1');
        }
    }

    private function resolveAgent(?User $user): ?Agent
    {
        if (! $user || ! in_array($user->role, [User::ROLE_AGENT, User::ROLE_AGENT_ADMIN], true)) {
            return null;
        }

        $agent = $user->agent;

        if ($agent instanceof Agent) {
            return $agent;
        }

        return $user->employee?->agent;
    }

    private function resolveBranchId(?User $user): ?int
    {
        if (! $user) {
            return null;
        }

        return $user->employee?->branch_id ?? $this->resolveAgent($user)?->branch_id;
    }

    private function resolveAddedByRole(?User $user): ?string
    {
        return $user?->role;
    }

    private function isBranchAdmin(?User $user): bool
    {
        return $user?->role === User::ROLE_BRANCH_ADMIN;
    }

    private function requiresAgentScope(?User $user): bool
    {
        return $user !== null && in_array($user->role, [User::ROLE_AGENT, User::ROLE_AGENT_ADMIN], true);
    }
}
