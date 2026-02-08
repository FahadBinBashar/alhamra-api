<?php

namespace App\Http\Controllers;

use App\Models\Commission;
use App\Models\CommissionCalculationItem;
use App\Models\Employee;
use App\Models\Payment;
use App\Models\Rank;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Collection;

class EmployeeTreeController extends Controller
{
    public function tree(Request $request): JsonResponse
    {
        if ($this->shouldShowRankRoots($request)) {
            return $this->rankRoots($request);
        }

        $rootId = $this->resolveRootEmployeeId($request);
        [$month, $start, $end] = $this->resolveMonthPeriod($request);

        $employees = Employee::query()
            ->with('user')
            ->get()
            ->keyBy('id');

        $childMap = $this->buildChildMap($employees->values());
        $children = $childMap[$rootId] ?? [];

        $paymentTotals = $this->collectPaymentTotals($start, $end);
        $commissionTotals = $this->collectCommissionTotals($start, $end);

        $nodes = collect($children)->map(function (int $employeeId) use ($employees, $childMap, $paymentTotals, $commissionTotals) {
            $employee = $employees->get($employeeId);
            $subtreeIds = $this->collectSubtree($employeeId, $childMap);

            return [
                'node_type' => 'employee',
                'id' => $employee?->id,
                'name' => $employee?->user?->name ?? $employee?->full_name_en,
                'rank' => $employee?->rank,
                'step' => 1,
                'has_children' => ! empty($childMap[$employeeId]),
                'stats' => [
                    'own_sales' => (float) ($paymentTotals[$employeeId] ?? 0),
                    'own_commission' => (float) ($commissionTotals[$employeeId] ?? 0),
                    'team_sales' => $this->sumTotalsFor($subtreeIds, $paymentTotals),
                    'team_commission' => $this->sumTotalsFor($subtreeIds, $commissionTotals),
                ],
            ];
        })->values();

        return response()->json([
            'root_employee_id' => $rootId,
            'month' => $month,
            'nodes' => $nodes,
        ]);
    }

    public function nodeDetails(Request $request, Employee $employee): JsonResponse
    {
        [$month, $start, $end] = $this->resolveMonthPeriod($request);
        $employee->loadMissing('user', 'branch');

        $employees = Employee::query()->select('id', 'superior_id')->get();
        $childMap = $this->buildChildMap($employees);
        $subtreeIds = $this->collectSubtree($employee->id, $childMap);

        $paymentTotals = $this->collectPaymentTotals($start, $end);
        $commissionTotals = $this->collectCommissionTotals($start, $end);

        $ownPaymentTotals = Payment::query()
            ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
            ->where('sales_orders.source_me_id', $employee->id)
            ->whereBetween('payments.paid_at', [$start->toDateString(), $end->toDateString()])
            ->selectRaw(
                'SUM(payments.amount) as total, '
                . "SUM(CASE WHEN payments.type = ? THEN payments.amount ELSE 0 END) as down_payment, "
                . "SUM(CASE WHEN payments.type = ? THEN payments.amount ELSE 0 END) as installment",
                [Payment::TYPE_DOWN_PAYMENT, Payment::TYPE_INSTALLMENT]
            )
            ->first();

        $ownCommissionPaid = $this->commissionSumForEmployee($employee->id, 'paid', $start, $end);
        $ownCommissionUnpaid = $this->commissionSumForEmployee($employee->id, 'unpaid', $start, $end);
        $ownCommissionDraft = $this->draftCommissionSumForEmployee($employee->id, $start, $end);

        $recentSales = Payment::query()
            ->with('salesOrder')
            ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
            ->where('sales_orders.source_me_id', $employee->id)
            ->whereBetween('payments.paid_at', [$start->toDateString(), $end->toDateString()])
            ->orderByDesc('payments.paid_at')
            ->take(5)
            ->get()
            ->map(function (Payment $payment) {
                return [
                    'order_no' => $payment->salesOrder ? 'SO-' . $payment->salesOrder->id : null,
                    'amount' => (float) $payment->amount,
                    'type' => $payment->type,
                    'date' => $payment->paid_at?->toDateString(),
                ];
            });

        $recentCommissions = $this->recentCommissionEntries($employee->id, $start, $end);

        return response()->json([
            'employee' => [
                'id' => $employee->id,
                'name' => $employee->user?->name ?? $employee->full_name_en,
                'rank' => $employee->rank,
                'branch' => $employee->branch?->name,
                'mobile' => $employee->mobile,
                'superior_id' => $employee->superior_id,
            ],
            'month' => $month,
            'stats' => [
                'own_sales' => (float) ($ownPaymentTotals?->total ?? 0),
                'own_down_payment' => (float) ($ownPaymentTotals?->down_payment ?? 0),
                'own_installment' => (float) ($ownPaymentTotals?->installment ?? 0),
                'own_commission_paid' => $ownCommissionPaid,
                'own_commission_pending' => $ownCommissionUnpaid + $ownCommissionDraft,
                'team_sales' => $this->sumTotalsFor($subtreeIds, $paymentTotals),
                'team_commission_total' => $this->sumTotalsFor($subtreeIds, $commissionTotals),
            ],
            'recent_sales' => $recentSales,
            'recent_commissions' => $recentCommissions,
        ]);
    }

    protected function rankRoots(Request $request): JsonResponse
    {
        [$month, $start, $end] = $this->resolveMonthPeriod($request);
        $rankCode = $request->input('rank');

        $paymentTotals = $this->collectPaymentTotals($start, $end);
        $commissionTotals = $this->collectCommissionTotals($start, $end);

        if ($rankCode) {
            $employees = Employee::query()
                ->with('user')
                ->where('rank', $rankCode)
                ->get()
                ->keyBy('id');

            $childMap = $this->buildChildMap(Employee::query()->select('id', 'superior_id')->get());

            $nodes = $employees->keys()->map(function (int $employeeId) use ($employees, $childMap, $paymentTotals, $commissionTotals) {
                $employee = $employees->get($employeeId);
                $subtreeIds = $this->collectSubtree($employeeId, $childMap);

                return [
                    'node_type' => 'employee',
                    'id' => $employee?->id,
                    'name' => $employee?->user?->name ?? $employee?->full_name_en,
                    'rank' => $employee?->rank,
                    'step' => 1,
                    'has_children' => ! empty($childMap[$employeeId]),
                    'stats' => [
                        'own_sales' => (float) ($paymentTotals[$employeeId] ?? 0),
                        'own_commission' => (float) ($commissionTotals[$employeeId] ?? 0),
                        'team_sales' => $this->sumTotalsFor($subtreeIds, $paymentTotals),
                        'team_commission' => $this->sumTotalsFor($subtreeIds, $commissionTotals),
                    ],
                ];
            })->values();

            return response()->json([
                'rank' => $rankCode,
                'month' => $month,
                'nodes' => $nodes,
            ]);
        }

        $ranks = Rank::query()
            ->orderByDesc('sort_order')
            ->get();

        $rankEmployeeIds = Employee::query()
            ->select('id', 'rank')
            ->get()
            ->groupBy('rank');

        $nodes = $ranks->map(function (Rank $rank) use ($rankEmployeeIds, $paymentTotals, $commissionTotals) {
            $employeeIds = $rankEmployeeIds->get($rank->code)?->pluck('id')->all() ?? [];

            return [
                'node_type' => 'rank',
                'rank' => $rank->code,
                'name' => $rank->name,
                'has_children' => ! empty($employeeIds),
                'stats' => [
                    'own_sales' => $this->sumTotalsFor($employeeIds, $paymentTotals),
                    'own_commission' => $this->sumTotalsFor($employeeIds, $commissionTotals),
                    'team_sales' => $this->sumTotalsFor($employeeIds, $paymentTotals),
                    'team_commission' => $this->sumTotalsFor($employeeIds, $commissionTotals),
                ],
            ];
        })->values();

        return response()->json([
            'month' => $month,
            'nodes' => $nodes,
        ]);
    }

    protected function resolveRootEmployeeId(Request $request): ?int
    {
        if ($request->filled('root_employee_id')) {
            return $request->integer('root_employee_id');
        }

        $user = $request->user();

        if ($user && $user->role === \App\Models\User::ROLE_EMPLOYEE && $user->employee) {
            return $user->employee->id;
        }

        if ($user && in_array($user->role, [
            \App\Models\User::ROLE_ADMIN,
            \App\Models\User::ROLE_OWNER,
            \App\Models\User::ROLE_DIRECTOR,
            \App\Models\User::ROLE_BRANCH_ADMIN,
        ], true)) {
            return null;
        }

        abort(422, 'A root_employee_id is required.');
    }

    protected function shouldShowRankRoots(Request $request): bool
    {
        if ($request->filled('rank')) {
            return true;
        }

        $user = $request->user();

        return ! $request->filled('root_employee_id')
            && $user
            && in_array($user->role, [
                \App\Models\User::ROLE_ADMIN,
                \App\Models\User::ROLE_OWNER,
                \App\Models\User::ROLE_DIRECTOR,
                \App\Models\User::ROLE_BRANCH_ADMIN,
            ], true);
    }

    protected function resolveMonthPeriod(Request $request): array
    {
        $month = $request->input('month');

        if (! $month) {
            $month = now()->format('Y-m');
        }

        $start = Carbon::createFromFormat('Y-m', $month)->startOfMonth();
        $end = $start->copy()->endOfMonth();

        return [$month, $start, $end];
    }

    protected function buildChildMap(Collection $employees): array
    {
        $map = [];

        foreach ($employees as $employee) {
            $map[$employee->superior_id][] = $employee->id;
        }

        return $map;
    }

    protected function collectSubtree(int $employeeId, array $childMap): array
    {
        $subtree = [];
        $queue = [$employeeId];

        while (! empty($queue)) {
            $current = array_shift($queue);

            if (in_array($current, $subtree, true)) {
                continue;
            }

            $subtree[] = $current;

            if (! empty($childMap[$current])) {
                foreach ($childMap[$current] as $child) {
                    if (! in_array($child, $subtree, true)) {
                        $queue[] = $child;
                    }
                }
            }
        }

        return array_values($subtree);
    }

    protected function collectPaymentTotals(Carbon $start, Carbon $end): array
    {
        return Payment::query()
            ->selectRaw('sales_orders.source_me_id as employee_id, SUM(payments.amount) as total')
            ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
            ->whereNotNull('sales_orders.source_me_id')
            ->whereBetween('payments.paid_at', [$start->toDateString(), $end->toDateString()])
            ->groupBy('sales_orders.source_me_id')
            ->pluck('total', 'employee_id')
            ->map(fn ($total) => (float) $total)
            ->toArray();
    }

    protected function collectCommissionTotals(Carbon $start, Carbon $end): array
    {
        $paidTotals = Commission::query()
            ->selectRaw('commissions.recipient_id as employee_id, SUM(commissions.amount) as total')
            ->join('payments', 'payments.id', '=', 'commissions.payment_id')
            ->where('commissions.recipient_type', Employee::class)
            ->whereBetween('payments.paid_at', [$start->toDateString(), $end->toDateString()])
            ->groupBy('commissions.recipient_id')
            ->pluck('total', 'employee_id')
            ->map(fn ($total) => (float) $total)
            ->toArray();

        $draftTotals = CommissionCalculationItem::query()
            ->selectRaw('commission_calculation_items.recipient_id as employee_id, SUM(commission_calculation_items.amount) as total')
            ->join('commission_calculation_units', 'commission_calculation_units.id', '=', 'commission_calculation_items.commission_calculation_unit_id')
            ->join('payments', 'payments.id', '=', 'commission_calculation_units.payment_id')
            ->where('commission_calculation_units.status', 'draft')
            ->where('commission_calculation_items.recipient_type', Employee::class)
            ->whereBetween('payments.paid_at', [$start->toDateString(), $end->toDateString()])
            ->groupBy('commission_calculation_items.recipient_id')
            ->pluck('total', 'employee_id')
            ->map(fn ($total) => (float) $total)
            ->toArray();

        foreach ($draftTotals as $employeeId => $total) {
            $paidTotals[$employeeId] = ($paidTotals[$employeeId] ?? 0) + $total;
        }

        return $paidTotals;
    }

    protected function sumTotalsFor(array $employeeIds, array $totals): float
    {
        $total = 0.0;

        foreach ($employeeIds as $employeeId) {
            $total += $totals[$employeeId] ?? 0.0;
        }

        return round($total, 2);
    }

    protected function commissionSumForEmployee(int $employeeId, string $status, Carbon $start, Carbon $end): float
    {
        return (float) Commission::query()
            ->where('recipient_type', Employee::class)
            ->where('recipient_id', $employeeId)
            ->where('status', $status)
            ->whereHas('payment', function ($query) use ($start, $end) {
                $query->whereBetween('paid_at', [$start->toDateString(), $end->toDateString()]);
            })
            ->sum('amount');
    }

    protected function draftCommissionSumForEmployee(int $employeeId, Carbon $start, Carbon $end): float
    {
        return (float) CommissionCalculationItem::query()
            ->where('recipient_type', Employee::class)
            ->where('recipient_id', $employeeId)
            ->whereHas('unit', function ($query) use ($start, $end) {
                $query->where('status', 'draft')
                    ->whereHas('payment', function ($paymentQuery) use ($start, $end) {
                        $paymentQuery->whereBetween('paid_at', [$start->toDateString(), $end->toDateString()]);
                    });
            })
            ->sum('amount');
    }

    protected function recentCommissionEntries(int $employeeId, Carbon $start, Carbon $end): Collection
    {
        $commissions = Commission::query()
            ->with('payment')
            ->where('recipient_type', Employee::class)
            ->where('recipient_id', $employeeId)
            ->whereHas('payment', function ($query) use ($start, $end) {
                $query->whereBetween('paid_at', [$start->toDateString(), $end->toDateString()]);
            })
            ->get()
            ->map(function (Commission $commission) {
                return [
                    'amount' => (float) $commission->amount,
                    'status' => $commission->status,
                    'date' => $commission->payment?->paid_at?->toDateString(),
                    'category' => $commission->meta['category'] ?? null,
                ];
            });

        $drafts = CommissionCalculationItem::query()
            ->with('unit.payment')
            ->where('recipient_type', Employee::class)
            ->where('recipient_id', $employeeId)
            ->whereHas('unit', function ($query) use ($start, $end) {
                $query->where('status', 'draft')
                    ->whereHas('payment', function ($paymentQuery) use ($start, $end) {
                        $paymentQuery->whereBetween('paid_at', [$start->toDateString(), $end->toDateString()]);
                    });
            })
            ->get()
            ->map(function (CommissionCalculationItem $item) {
                return [
                    'amount' => (float) $item->amount,
                    'status' => 'draft',
                    'date' => $item->unit?->payment?->paid_at?->toDateString(),
                    'category' => $item->meta['category'] ?? null,
                ];
            });

        return $commissions
            ->merge($drafts)
            ->sortByDesc('date')
            ->take(5)
            ->values();
    }
}
