<?php

namespace App\Services;

use App\Models\Employee;
use App\Models\EmployeeWallet;
use App\Models\PdSpecialBonus;
use App\Models\PdSpecialMonthLock;
use App\Models\PdSpecialSelection;
use App\Models\Payment;
use App\Services\Accounting\LedgerService;
use Carbon\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class PdSpecialBonusService
{
    public function __construct(private LedgerService $ledgerService)
    {
    }

    public function isLocked(string $month): bool
    {
        return PdSpecialMonthLock::query()->where('month', $month)->exists();
    }

    public function ensureUnlocked(string $month): void
    {
        if ($this->isLocked($month)) {
            abort(422, 'The requested month is locked.');
        }
    }

    public function select(int $employeeId, string $month, float $percentage, int $selectedBy, array $meta = []): PdSpecialSelection
    {
        $this->ensureUnlocked($month);

        return PdSpecialSelection::updateOrCreate(
            [
                'employee_id' => $employeeId,
                'month' => $month,
            ],
            [
                'percentage' => $percentage,
                'selected_by' => $selectedBy,
                'meta' => $meta,
            ]
        );
    }

    public function calculate(string $month): Collection
    {
        $this->ensureUnlocked($month);

        [$periodStart, $periodEnd] = $this->resolvePeriod($month);

        $selections = PdSpecialSelection::query()->where('month', $month)->get();

        if ($selections->isEmpty()) {
            return collect();
        }

        $employees = Employee::query()->select('id', 'superior_id')->get();
        $childMap = $this->buildChildMap($employees);
        $paymentTotals = $this->collectPaymentTotals($periodStart, $periodEnd);

        $bonuses = collect();

        foreach ($selections as $selection) {
            $subtreeIds = $this->collectSubtree($selection->employee_id, $childMap);
            $totalDp = $this->sumTotalsFor($subtreeIds, $paymentTotals);
            $amount = round($totalDp * ((float) $selection->percentage / 100), 2);

            $existing = PdSpecialBonus::query()
                ->where('employee_id', $selection->employee_id)
                ->where('month', $month)
                ->first();

            if ($existing && $existing->status === PdSpecialBonus::STATUS_PAID) {
                continue;
            }

            $status = $existing?->status ?? PdSpecialBonus::STATUS_DRAFT;

            $bonus = PdSpecialBonus::updateOrCreate(
                [
                    'employee_id' => $selection->employee_id,
                    'month' => $month,
                ],
                [
                    'total_dp' => $totalDp,
                    'percentage' => $selection->percentage,
                    'amount' => $amount,
                    'status' => $status,
                    'meta' => [
                        'subtree_employee_ids' => $subtreeIds,
                    ],
                ]
            );

            $bonuses->push($bonus);
        }

        return $bonuses;
    }

    public function process(string $month): Collection
    {
        $this->ensureUnlocked($month);

        $bonuses = PdSpecialBonus::query()
            ->where('month', $month)
            ->where('status', PdSpecialBonus::STATUS_DRAFT)
            ->get();

        if ($bonuses->isEmpty()) {
            $this->calculate($month);

            $bonuses = PdSpecialBonus::query()
                ->where('month', $month)
                ->where('status', PdSpecialBonus::STATUS_DRAFT)
                ->get();
        }

        $processed = collect();

        foreach ($bonuses as $bonus) {
            DB::transaction(function () use ($bonus, &$processed) {
                $this->creditEmployeeWallet($bonus->employee_id, (float) $bonus->amount);
                $this->recordBonusLiability($bonus);

                $bonus->forceFill([
                    'status' => PdSpecialBonus::STATUS_PAID,
                    'processed_at' => now(),
                ])->save();

                $processed->push($bonus);
            });
        }

        PdSpecialMonthLock::firstOrCreate([
            'month' => $month,
        ], [
            'locked_at' => now(),
            'locked_by' => auth()->id(),
        ]);

        return $processed;
    }

    public function employeeBonus(int $employeeId, string $month): ?PdSpecialBonus
    {
        return PdSpecialBonus::query()
            ->with(['employee', 'employee.rankDefinition'])
            ->where('employee_id', $employeeId)
            ->where('month', $month)
            ->first();
    }

    public function monthBonuses(string $month): Collection
    {
        return PdSpecialBonus::query()
            ->with(['employee', 'employee.rankDefinition'])
            ->where('month', $month)
            ->orderBy('employee_id')
            ->get();
    }

    protected function resolvePeriod(string $month): array
    {
        $start = Carbon::createFromFormat('Y-m', $month)->startOfMonth();
        $end = $start->copy()->endOfMonth();

        return [$start, $end];
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

    protected function collectPaymentTotals(Carbon $periodStart, Carbon $periodEnd): array
    {
        return Payment::query()
            ->selectRaw('sales_orders.source_me_id as employee_id, SUM(payments.amount) as total')
            ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
            ->where('payments.type', Payment::TYPE_DOWN_PAYMENT)
            ->whereNotNull('sales_orders.source_me_id')
            ->whereBetween('payments.paid_at', [$periodStart->toDateString(), $periodEnd->toDateString()])
            ->groupBy('sales_orders.source_me_id')
            ->pluck('total', 'employee_id')
            ->map(fn ($total) => (float) $total)
            ->toArray();
    }

    protected function sumTotalsFor(array $employeeIds, array $paymentTotals): float
    {
        $total = 0.0;

        foreach ($employeeIds as $id) {
            $total += $paymentTotals[$id] ?? 0.0;
        }

        return round($total, 2);
    }

    protected function creditEmployeeWallet(int $employeeId, float $amount): void
    {
        $wallet = EmployeeWallet::query()
            ->where('employee_id', $employeeId)
            ->lockForUpdate()
            ->first();

        if (! $wallet) {
            $wallet = new EmployeeWallet([
                'employee_id' => $employeeId,
                'balance' => 0,
            ]);
        }

        $wallet->balance = (float) $wallet->balance + $amount;
        $wallet->employee_id = $employeeId;
        $wallet->save();
    }

    protected function recordBonusLiability(PdSpecialBonus $bonus): void
    {
        $txId = 'PDSB-' . $bonus->id;

        $this->ledgerService->record($txId, now(), [
            [
                'account_code' => config('accounting.accounts.commission_expense.code'),
                'account_name' => config('accounting.accounts.commission_expense.name'),
                'account_type' => 'expense',
                'debit' => $bonus->amount,
                'credit' => 0,
            ],
            [
                'account_code' => config('accounting.accounts.incentive_fund.code'),
                'account_name' => config('accounting.accounts.incentive_fund.name'),
                'account_type' => 'liability',
                'debit' => 0,
                'credit' => $bonus->amount,
            ],
        ], [
            'employee_id' => $bonus->employee_id,
            'month' => $bonus->month,
        ]);
    }
}
