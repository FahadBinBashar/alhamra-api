<?php

namespace App\Http\Controllers;

use App\Http\Resources\CommissionResource;
use App\Http\Resources\EmployeeActivityResource;
use App\Http\Resources\EmployeeWalletResource;
use App\Http\Resources\SalesOrderResource;
use App\Http\Resources\UserResource;
use App\Models\Commission;
use App\Models\Employee;
use App\Models\EmployeeActivity;
use App\Models\EmployeeWallet;
use App\Models\EmployeeWalletTransaction;
use App\Models\MonthlyIncentive;
use App\Models\SalesOrder;
use App\Models\User;
use App\Models\WalletWithdrawRequest;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Arr;
use Illuminate\Support\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Validation\Rule;

class EmployeeDashboardController extends Controller
{
    public function customers(Request $request): AnonymousResourceCollection
    {
        $employeeId = $this->resolveEmployeeId($request);

        $query = User::query()->where('role', User::ROLE_CUSTOMER);

        if ($employeeId) {
            $query->where(function (Builder $builder) use ($employeeId) {
                $builder->where('source_me_id', $employeeId)
                    ->orWhereExists(function ($subQuery) use ($employeeId) {
                        $subQuery->selectRaw('1')
                            ->from('sales_orders')
                            ->whereColumn('sales_orders.customer_id', 'users.id')
                            ->where(function ($salesQuery) use ($employeeId) {
                                $salesQuery->where('sales_orders.employee_id', $employeeId)
                                    ->orWhere('sales_orders.source_me_id', $employeeId);
                            });
                    });
            });
        }

        if ($request->filled('search')) {
            $search = $request->string('search')->toString();

            $query->where(function (Builder $builder) use ($search) {
                $builder->where('name', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%")
                    ->orWhere('contact_number', 'like', "%{$search}%")
                    ->orWhere('whatsapp_number', 'like', "%{$search}%");
            });
        }

        $customers = $query
            ->orderByDesc('created_at')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return UserResource::collection($customers);
    }

    public function sales(Request $request): AnonymousResourceCollection
    {
        $employeeId = $this->resolveEmployeeId($request);

        $query = SalesOrder::query()
            ->with(['customer', 'agent.user', 'branch']);

        if ($employeeId) {
            $query->where(function (Builder $builder) use ($employeeId) {
                $builder->where('employee_id', $employeeId)
                    ->orWhere('source_me_id', $employeeId);
            });
        }

        if ($request->filled('status')) {
            $query->whereIn('status', Arr::wrap($request->input('status')));
        }

        if ($request->filled('from_date')) {
            $fromDate = Carbon::parse($request->input('from_date'))->startOfDay();
            $query->where('created_at', '>=', $fromDate);
        }

        if ($request->filled('to_date')) {
            $toDate = Carbon::parse($request->input('to_date'))->endOfDay();
            $query->where('created_at', '<=', $toDate);
        }

        $orders = $query
            ->orderByDesc('created_at')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return SalesOrderResource::collection($orders);
    }

    public function commissions(Request $request): AnonymousResourceCollection
    {
        $employeeId = $this->resolveEmployeeId($request);

        $query = Commission::query()
            ->with(['rule', 'payment', 'salesOrder.customer', 'salesOrder.agent.user', 'salesOrder.branch'])
            ->where('recipient_type', Employee::class);

        if ($employeeId) {
            $query->where('recipient_id', $employeeId);
        }

        if ($request->filled('status')) {
            $query->whereIn('status', Arr::wrap($request->input('status')));
        }

        if ($request->filled('from_date')) {
            $fromDate = Carbon::parse($request->input('from_date'))->startOfDay();
            $query->where('created_at', '>=', $fromDate);
        }

        if ($request->filled('to_date')) {
            $toDate = Carbon::parse($request->input('to_date'))->endOfDay();
            $query->where('created_at', '<=', $toDate);
        }

        $commissions = $query
            ->orderByDesc('created_at')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return CommissionResource::collection($commissions);
    }

    public function serviceCommissions(Request $request): JsonResponse
    {
        $employeeId = $this->resolveEmployeeId($request);

        if (! $employeeId) {
            abort(422, 'An employee context is required to view service commissions.');
        }

        $query = Commission::query()
            ->with(['payment', 'salesOrder.items.itemable'])
            ->where('category', 'service')
            ->where('recipient_type', Employee::class)
            ->where('recipient_id', $employeeId);

        if ($request->filled('status')) {
            $query->whereIn('status', Arr::wrap($request->input('status')));
        }

        $commissions = $query
            ->orderByDesc('paid_at')
            ->orderByDesc('id')
            ->get();

        $payload = $commissions->map(function (Commission $commission) {
            $service = $commission->salesOrder?->items?->first(function ($item) {
                return $item->itemable instanceof \App\Models\Service;
            });

            return [
                'payment_date' => optional($commission->payment?->paid_at)->toDateString(),
                'amount' => (float) $commission->amount,
                'commission_percentage' => $commission->meta['commission_percentage'] ?? null,
                'status' => $commission->status,
                'service_name' => $service?->itemable?->name,
            ];
        });

        return response()->json($payload);
    }

    public function wallet(Request $request): EmployeeWalletResource
    {
        $employeeId = $this->resolveEmployeeId($request);

        if (! $employeeId) {
            abort(422, 'An employee context is required to view a wallet.');
        }

        $wallet = EmployeeWallet::query()
            ->with(['employee.user'])
            ->firstWhere('employee_id', $employeeId);

        if (! $wallet) {
            $wallet = EmployeeWallet::create([
                'employee_id' => $employeeId,
                'balance' => 0,
            ]);

            $wallet->load(['employee.user']);
        }

        return new EmployeeWalletResource($wallet);
    }

    public function walletStatement(Request $request): JsonResponse
    {
        $employeeId = $this->resolveEmployeeId($request);

        if (! $employeeId) {
            abort(422, 'An employee context is required to view a wallet statement.');
        }

        $wallet = EmployeeWallet::query()->firstOrCreate(
            ['employee_id' => $employeeId],
            ['balance' => 0]
        );

        $creditFromCommissions = Commission::query()
            ->where('recipient_type', Employee::class)
            ->where('recipient_id', $employeeId)
            ->where('status', 'paid')
            ->get()
            ->map(fn (Commission $commission) => [
                'date' => $commission->paid_at ?? $commission->created_at,
                'type' => 'credit',
                'amount' => (float) $commission->amount,
                'source' => 'commission',
                'reference' => 'commission:'.$commission->id,
                'note' => 'Commission credited to wallet',
            ]);

        $creditFromIncentives = MonthlyIncentive::query()
            ->where('employee_id', $employeeId)
            ->where('status', MonthlyIncentive::STATUS_PAID)
            ->get()
            ->map(fn (MonthlyIncentive $incentive) => [
                'date' => $incentive->processed_at ?? $incentive->updated_at,
                'type' => 'credit',
                'amount' => (float) $incentive->amount,
                'source' => 'monthly_incentive',
                'reference' => 'monthly_incentive:'.$incentive->id,
                'note' => 'Monthly incentive credited to wallet',
            ]);

        $creditFromRewards = EmployeeWalletTransaction::query()
            ->where('employee_id', $employeeId)
            ->get()
            ->map(fn (EmployeeWalletTransaction $transaction) => [
                'date' => $transaction->created_at,
                'type' => 'credit',
                'amount' => (float) $transaction->amount,
                'source' => $transaction->type,
                'reference' => 'employee_wallet_transaction:'.$transaction->id,
                'note' => $transaction->narration ?: 'Wallet transaction credited',
            ]);

        $debitEntries = WalletWithdrawRequest::query()
            ->where('user_type', WalletWithdrawRequest::USER_TYPE_EMPLOYEE)
            ->where('user_id', $employeeId)
            ->where('status', WalletWithdrawRequest::STATUS_APPROVED)
            ->get()
            ->map(fn (WalletWithdrawRequest $withdrawal) => [
                'date' => $withdrawal->reviewed_at ?? $withdrawal->created_at,
                'type' => 'debit',
                'amount' => (float) $withdrawal->amount,
                'source' => 'withdrawal',
                'reference' => 'withdrawal:'.$withdrawal->id,
                'note' => 'Wallet withdrawal approved',
            ]);

        $statement = $this->buildStatement(
            (float) $wallet->balance,
            $creditFromCommissions
                ->merge($creditFromIncentives)
                ->merge($creditFromRewards)
                ->merge($debitEntries)
        );

        return response()->json($statement);
    }

    public function activities(Request $request): AnonymousResourceCollection
    {
        $employeeId = $this->resolveEmployeeId($request);

        $query = EmployeeActivity::query()
            ->with([
                'employee.user',
                'customer',
                'salesOrder.customer',
                'salesOrder.agent.user',
                'salesOrder.branch',
                'creator',
            ]);

        if ($employeeId) {
            $query->where('employee_id', $employeeId);
        } elseif ($request->filled('employee_id')) {
            $query->where('employee_id', $request->integer('employee_id'));
        }

        if ($request->filled('from_date')) {
            $fromDate = Carbon::parse($request->input('from_date'))->toDateString();
            $query->whereDate('activity_date', '>=', $fromDate);
        }

        if ($request->filled('to_date')) {
            $toDate = Carbon::parse($request->input('to_date'))->toDateString();
            $query->whereDate('activity_date', '<=', $toDate);
        }

        $activities = $query
            ->orderByDesc('activity_date')
            ->orderByDesc('id')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return EmployeeActivityResource::collection($activities);
    }

    public function storeActivity(Request $request): EmployeeActivityResource
    {
        $user = $request->user();
        $employee = $this->resolveEmployeeModelForWrite($request);

        if (! $employee) {
            abort(422, 'An employee context is required to record activities.');
        }

        $data = $request->validate([
            'activity_date' => ['required', 'date'],
            'title' => ['required', 'string', 'max:255'],
            'location' => ['nullable', 'string', 'max:255'],
            'customer_id' => ['nullable', 'integer', Rule::exists('users', 'id')->where('role', User::ROLE_CUSTOMER)],
            'sales_order_id' => ['nullable', 'integer', Rule::exists('sales_orders', 'id')],
            'notes' => ['nullable', 'string'],
            'meta' => ['nullable', 'array'],
        ]);

        $activity = EmployeeActivity::create([
            'employee_id' => $employee->id,
            'created_by' => $user->id,
            'activity_date' => Carbon::parse($data['activity_date'])->toDateString(),
            'title' => $data['title'],
            'location' => $data['location'] ?? null,
            'customer_id' => $data['customer_id'] ?? null,
            'sales_order_id' => $data['sales_order_id'] ?? null,
            'notes' => $data['notes'] ?? null,
            'meta' => $data['meta'] ?? null,
        ]);

        return new EmployeeActivityResource(
            $activity->load([
                'employee.user',
                'customer',
                'salesOrder.customer',
                'salesOrder.agent.user',
                'salesOrder.branch',
                'creator',
            ])
        );
    }

    public function updateActivity(Request $request, EmployeeActivity $activity): EmployeeActivityResource
    {
        $this->authorizeActivity($request, $activity);

        $data = $request->validate([
            'activity_date' => ['sometimes', 'date'],
            'title' => ['sometimes', 'string', 'max:255'],
            'location' => ['nullable', 'string', 'max:255'],
            'customer_id' => ['nullable', 'integer', Rule::exists('users', 'id')->where('role', User::ROLE_CUSTOMER)],
            'sales_order_id' => ['nullable', 'integer', Rule::exists('sales_orders', 'id')],
            'notes' => ['nullable', 'string'],
            'meta' => ['nullable', 'array'],
        ]);

        if (array_key_exists('activity_date', $data)) {
            $data['activity_date'] = Carbon::parse($data['activity_date'])->toDateString();
        }

        $activity->fill($data);

        $activity->save();

        return new EmployeeActivityResource(
            $activity->load([
                'employee.user',
                'customer',
                'salesOrder.customer',
                'salesOrder.agent.user',
                'salesOrder.branch',
                'creator',
            ])
        );
    }

    public function destroyActivity(Request $request, EmployeeActivity $activity): JsonResponse
    {
        $this->authorizeActivity($request, $activity);

        $activity->delete();

        return response()->json(['message' => 'Activity deleted successfully.']);
    }

    private function resolveEmployeeId(Request $request): ?int
    {
        $user = $request->user();

        if ($user && $user->role === User::ROLE_EMPLOYEE) {
            return $user->employee?->id;
        }

        if ($request->filled('employee_id')) {
            return $request->integer('employee_id');
        }

        return null;
    }

    private function resolveEmployeeModelForWrite(Request $request): ?Employee
    {
        $user = $request->user();

        if ($user && $user->role === User::ROLE_EMPLOYEE) {
            return $user->employee;
        }

        if ($request->filled('employee_id')) {
            return Employee::find($request->integer('employee_id'));
        }

        return null;
    }

    private function authorizeActivity(Request $request, EmployeeActivity $activity): void
    {
        $user = $request->user();

        if (! $user) {
            abort(401);
        }

        if (in_array($user->role, [
            User::ROLE_ADMIN,
            User::ROLE_OWNER,
            User::ROLE_DIRECTOR,
            User::ROLE_BRANCH_ADMIN,
        ], true)) {
            return;
        }

        if ($user->role === User::ROLE_EMPLOYEE && $user->employee && $activity->employee_id === $user->employee->id) {
            return;
        }

        abort(403, 'You are not authorised to manage this activity.');
    }

    private function buildStatement(float $currentBalance, Collection $entries): array
    {
        $ordered = $entries
            ->sortBy(fn (array $entry) => [
                Carbon::parse($entry['date'])->timestamp,
                $entry['type'] === 'credit' ? 0 : 1,
                $entry['reference'],
            ])
            ->values();

        $totalCredit = $ordered
            ->where('type', 'credit')
            ->sum('amount');

        $totalDebit = $ordered
            ->where('type', 'debit')
            ->sum('amount');

        $openingBalance = round((float) $currentBalance - (float) $totalCredit + (float) $totalDebit, 2);
        $runningBalance = $openingBalance;

        $rows = $ordered->map(function (array $entry) use (&$runningBalance) {
            $isCredit = $entry['type'] === 'credit';
            $runningBalance += $isCredit ? (float) $entry['amount'] : -1 * (float) $entry['amount'];

            return [
                'date' => Carbon::parse($entry['date'])->toDateTimeString(),
                'source' => $entry['source'],
                'reference' => $entry['reference'],
                'note' => $entry['note'],
                'debit' => $isCredit ? 0.0 : round((float) $entry['amount'], 2),
                'credit' => $isCredit ? round((float) $entry['amount'], 2) : 0.0,
                'balance' => round($runningBalance, 2),
            ];
        });

        return [
            'data' => [
                'opening_balance' => $openingBalance,
                'total_debit' => round((float) $totalDebit, 2),
                'total_credit' => round((float) $totalCredit, 2),
                'closing_balance' => round((float) $currentBalance, 2),
                'transactions' => $rows,
            ],
        ];
    }
}
