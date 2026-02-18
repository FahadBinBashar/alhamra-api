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
     * Calculate incentives for the provided period.
     * Defaults to previous month for monthly frequency or previous week for weekly frequency.
     */
    public function calculate(?string $month = null, string $frequency = 'monthly', ?string $week = null): Collection
    {
        [$periodStart, $periodEnd, $frequency] = $this->resolvePeriod($month, $week, $frequency);
        [$maxLevels, $rate] = $this->getConfig();

        $employees = Employee::query()->select('id', 'superior_id')->get();
        $childMap = $this->buildChildMap($employees);
        $paymentTotals = $this->collectPaymentTotals($periodStart, $periodEnd);
        $incentives = collect();

        foreach ($employees as $employee) {
            $levels = $this->collectSubordinateLevels($employee->id, $childMap, $maxLevels);
            $subordinateIds = $this->flattenLevelIds($levels);
            $stepCounts = $this->calculateStepCounts($levels, $maxLevels);
            $stepSales = $this->calculateStepSales($levels, $paymentTotals, $maxLevels);
            $commissionableTotal = array_sum($stepSales);

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

            $status = $existing?->status ?? MonthlyIncentive::STATUS_DRAFT;

            $payload = [
                'period_end' => $periodEnd->toDateString(),
                'total_commissionable_sales' => $commissionableTotal,
                'incentive_rate' => $rate,
                'amount' => $this->calculateIncentiveAmount($commissionableTotal, $rate),
                'status' => $status,
                'reviewed_by' => $status === MonthlyIncentive::STATUS_DRAFT ? null : $existing?->reviewed_by,
                'reviewed_at' => $status === MonthlyIncentive::STATUS_DRAFT ? null : $existing?->reviewed_at,
                'review_note' => $status === MonthlyIncentive::STATUS_DRAFT ? null : $existing?->review_note,
                'meta' => [
                    'frequency' => $frequency,
                    'period_label' => $frequency === 'weekly'
                        ? $periodStart->format('Y-m-d').' to '.$periodEnd->format('Y-m-d')
                        : $periodStart->format('Y-m'),
                    'subordinate_ids' => $subordinateIds,
                    'subordinate_steps' => $this->mapSubordinateSteps($levels),
                    'subordinate_count' => count($subordinateIds),
                    'max_levels' => $maxLevels,
                    'step_counts' => $stepCounts,
                    'step_sales' => $stepSales,
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
     * Mark incentives as paid for the target period and credit employee wallets.
     */
    public function process(?string $month = null, string $frequency = 'monthly', ?string $week = null, ?int $reviewerId = null, bool $autoApprove = true): Collection
    {
        [$periodStart] = $this->resolvePeriod($month, $week, $frequency);

        $eligibleStatuses = $autoApprove
            ? [MonthlyIncentive::STATUS_DRAFT, MonthlyIncentive::STATUS_APPROVED]
            : [MonthlyIncentive::STATUS_APPROVED];

        $incentives = MonthlyIncentive::query()
            ->whereDate('period_start', $periodStart->toDateString())
            ->whereIn('status', $eligibleStatuses)
            ->with('employee')
            ->get();

        $processed = collect();

        foreach ($incentives as $incentive) {
            DB::transaction(function () use ($incentive, &$processed, $reviewerId, $autoApprove) {
                if ($autoApprove && $incentive->status === MonthlyIncentive::STATUS_DRAFT) {
                    $incentive->forceFill([
                        'status' => MonthlyIncentive::STATUS_APPROVED,
                        'reviewed_by' => $incentive->reviewed_by ?? $reviewerId,
                        'reviewed_at' => $incentive->reviewed_at ?? now(),
                    ])->save();
                }

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

    public function resolvePeriod(?string $month, ?string $week = null, string $frequency = 'monthly'): array
    {
        $normalizedFrequency = in_array($frequency, ['weekly', 'monthly'], true) ? $frequency : 'monthly';

        if ($normalizedFrequency === 'weekly') {
            if ($week) {
                $start = Carbon::parse($week)->startOfWeek(Carbon::MONDAY);
            } else {
                $start = now()->subWeek()->startOfWeek(Carbon::MONDAY);
            }

            $end = $start->copy()->endOfWeek(Carbon::SUNDAY);

            return [$start, $end, $normalizedFrequency];
        }

        if ($month) {
            $start = Carbon::createFromFormat('Y-m', $month)->startOfMonth();
        } else {
            $start = now()->subMonthNoOverflow()->startOfMonth();
        }

        $end = $start->copy()->endOfMonth();

        return [$start, $end, $normalizedFrequency];
    }

    protected function buildChildMap(Collection $employees): array
    {
        $map = [];

        foreach ($employees as $employee) {
            $map[$employee->superior_id][] = $employee->id;
        }

        return $map;
    }

    protected function collectSubordinateLevels(int $employeeId, array $childMap, int $maxDepth): array
    {
        $levels = [];
        $currentLevel = $childMap[$employeeId] ?? [];

        if (! empty($currentLevel)) {
            $levels[1] = $currentLevel;
        }

        for ($depth = 2; $depth <= $maxDepth; $depth++) {
            $nextLevel = [];

            foreach ($currentLevel as $childId) {
                $nextLevel = array_merge($nextLevel, $childMap[$childId] ?? []);
            }

            if (empty($nextLevel)) {
                break;
            }

            $levels[$depth] = $nextLevel;
            $currentLevel = $nextLevel;
        }

        return $levels;
    }

    protected function flattenLevelIds(array $levels): array
    {
        $all = [];

        foreach ($levels as $ids) {
            $all = array_merge($all, $ids);
        }

        return array_values(array_unique($all));
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

    protected function calculateStepCounts(array $levels, int $maxLevels): array
    {
        $counts = [];

        for ($level = 1; $level <= $maxLevels; $level++) {
            $counts[$level] = isset($levels[$level]) ? count(array_unique($levels[$level])) : 0;
        }

        return $counts;
    }

    protected function calculateStepSales(array $levels, array $paymentTotals, int $maxLevels): array
    {
        $stepSales = [];

        for ($level = 1; $level <= $maxLevels; $level++) {
            $stepSales[$level] = 0.0;

            foreach (array_unique($levels[$level] ?? []) as $employeeId) {
                $stepSales[$level] += $paymentTotals[$employeeId] ?? 0.0;
            }

            $stepSales[$level] = round($stepSales[$level], 2);
        }

        return $stepSales;
    }

    protected function mapSubordinateSteps(array $levels): array
    {
        $map = [];

        foreach ($levels as $level => $ids) {
            foreach (array_unique($ids) as $id) {
                $map[$id] = $level;
            }
        }

        return $map;
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
