<?php

namespace App\Services;

use App\Models\Employee;
use App\Models\EmployeeWallet;
use App\Models\MonthlyIncentive;
use App\Models\Payment;
use App\Models\CommissionSetting;
use App\Services\Accounting\LedgerService;
use Carbon\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class MonthlyIncentiveService
{
    public function __construct(private LedgerService $ledgerService)
    {
    }

    /**
     * Calculate monthly incentives for the provided month (defaults to previous month).
     */
    public function calculate(?string $month = null): Collection
    {
        [$periodStart, $periodEnd] = $this->resolvePeriod($month);
        [$maxLevels, $rate] = $this->getConfig();

        $employees = Employee::query()->select('id', 'superior_id')->get();
        $childMap = $this->buildChildMap($employees);
        $paymentTotals = $this->collectPaymentTotals($periodStart, $periodEnd);
        $incentives = collect();

        foreach ($employees as $employee) {
            $subordinateIds = $this->collectSubordinateIds($employee->id, $childMap, $maxLevels);
            $commissionableTotal = $this->sumTotalsFor($subordinateIds, $paymentTotals);

            if ($commissionableTotal <= 0) {
                continue;
            }

            /** @var MonthlyIncentive $existing */
            $existing = MonthlyIncentive::query()
                ->where('employee_id', $employee->id)
                ->whereDate('period_start', $periodStart->toDateString())
                ->first();

            if ($existing && $existing->status === MonthlyIncentive::STATUS_PAID) {
                continue;
            }

            $payload = [
                'period_end' => $periodEnd->toDateString(),
                'total_commissionable_sales' => $commissionableTotal,
                'incentive_rate' => $rate,
                'amount' => $this->calculateIncentiveAmount($commissionableTotal, $rate),
                'status' => MonthlyIncentive::STATUS_DRAFT,
                'meta' => [
                    'subordinate_ids' => $subordinateIds,
                    'subordinate_count' => count($subordinateIds),
                    'max_levels' => $maxLevels,
                ],
            ];

            $incentive = MonthlyIncentive::updateOrCreate([
                'employee_id' => $employee->id,
                'period_start' => $periodStart->toDateString(),
            ], $payload);

            $incentives->push($incentive);
        }

        return $incentives;
    }

    /**
     * Mark draft incentives as paid for the target month and credit employee wallets.
     */
    public function process(?string $month = null): Collection
    {
        [$periodStart] = $this->resolvePeriod($month);

        $incentives = MonthlyIncentive::query()
            ->whereDate('period_start', $periodStart->toDateString())
            ->where('status', MonthlyIncentive::STATUS_DRAFT)
            ->with('employee')
            ->get();

        $processed = collect();

        foreach ($incentives as $incentive) {
            DB::transaction(function () use ($incentive, &$processed) {
                $this->creditEmployeeWallet($incentive->employee_id, (float) $incentive->amount);
                $this->recordIncentiveLiability($incentive);

                $incentive->forceFill([
                    'status' => MonthlyIncentive::STATUS_PAID,
                    'processed_at' => now(),
                ])->save();

                $processed->push($incentive);
            });
        }

        return $processed;
    }

    protected function resolvePeriod(?string $month): array
    {
        if ($month) {
            $start = Carbon::createFromFormat('Y-m', $month)->startOfMonth();
        } else {
            $start = now()->subMonthNoOverflow()->startOfMonth();
        }

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

    protected function collectSubordinateIds(int $employeeId, array $childMap, int $maxDepth): array
    {
        $currentLevel = $childMap[$employeeId] ?? [];
        $collected = $currentLevel;

        for ($depth = 2; $depth <= $maxDepth; $depth++) {
            $nextLevel = [];

            foreach ($currentLevel as $childId) {
                $nextLevel = array_merge($nextLevel, $childMap[$childId] ?? []);
            }

            $currentLevel = $nextLevel;
            $collected = array_merge($collected, $currentLevel);

            if (empty($currentLevel)) {
                break;
            }
        }

        return array_values(array_unique($collected));
    }

    protected function collectPaymentTotals(Carbon $periodStart, Carbon $periodEnd): array
    {
        return Payment::query()
            ->selectRaw('sales_orders.source_me_id as employee_id, SUM(payments.commission_base_amount) as total')
            ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
            ->whereNotNull('sales_orders.source_me_id')
            ->whereBetween('payments.paid_at', [$periodStart->toDateString(), $periodEnd->toDateString()])
            ->groupBy('sales_orders.source_me_id')
            ->pluck('total', 'employee_id')
            ->map(fn ($total) => (float) $total)
            ->toArray();
    }

    protected function sumTotalsFor(array $employeeIds, array $totals): float
    {
        $sum = 0.0;

        foreach ($employeeIds as $id) {
            $sum += $totals[$id] ?? 0.0;
        }

        return round($sum, 2);
    }

    protected function calculateIncentiveAmount(float $total, float $rate): float
    {
        return round($total * ($rate / 100), 2);
    }

    /**
     * Resolve admin-configurable settings for monthly incentives.
     */
    protected function getConfig(): array
    {
        $config = CommissionSetting::value('monthly_incentive_settings', []);

        $rate = isset($config['percentage']) ? (float) $config['percentage'] : 1.0;
        $maxLevels = isset($config['max_levels']) ? (int) $config['max_levels'] : 4;

        $rate = $rate >= 0 ? $rate : 0;
        $maxLevels = $maxLevels >= 1 ? $maxLevels : 1;

        return [$maxLevels, $rate];
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

    protected function recordIncentiveLiability(MonthlyIncentive $incentive): void
    {
        $txId = 'INC-' . $incentive->id;

        $this->ledgerService->record($txId, now(), [
            [
                'account_code' => config('accounting.accounts.commission_expense.code'),
                'account_name' => config('accounting.accounts.commission_expense.name'),
                'account_type' => 'expense',
                'debit' => $incentive->amount,
                'credit' => 0,
            ],
            [
                'account_code' => config('accounting.accounts.incentive_fund.code'),
                'account_name' => config('accounting.accounts.incentive_fund.name'),
                'account_type' => 'liability',
                'debit' => 0,
                'credit' => $incentive->amount,
            ],
        ], [
            'employee_id' => $incentive->employee_id,
            'period_start' => $incentive->period_start?->toDateString(),
            'period_end' => $incentive->period_end?->toDateString(),
        ]);
    }
}
