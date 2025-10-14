<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserResource;
use App\Models\Agent;
use App\Models\SalesOrder;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
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

    public function show(Request $request, User $customer): UserResource
    {
        $user = $request->user();
        $this->ensureCustomerAccess($user);

        if ($customer->role !== User::ROLE_CUSTOMER) {
            abort(404);
        }

        if (in_array($user->role, [User::ROLE_AGENT, User::ROLE_AGENT_ADMIN], true)) {
            $agentId = Agent::where('user_id', $user->id)->value('id');

            if (! $agentId) {
                abort(404);
            }

            $assigned = SalesOrder::query()
                ->where('agent_id', $agentId)
                ->where('customer_id', $customer->id)
                ->exists();

            if (! $assigned) {
                abort(403, 'You are not authorised to view this customer.');
            }
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

    private function applyAgentScope(Builder $query, ?User $user): void
    {
        if (! $user || ! in_array($user->role, [User::ROLE_AGENT, User::ROLE_AGENT_ADMIN], true)) {
            return;
        }

        $agentId = Agent::where('user_id', $user->id)->value('id');

        if (! $agentId) {
            $query->whereRaw('0 = 1');

            return;
        }

        $query->whereIn('id', function ($subQuery) use ($agentId) {
            $subQuery->select('customer_id')
                ->from('sales_orders')
                ->where('agent_id', $agentId);
        });
    }
}
