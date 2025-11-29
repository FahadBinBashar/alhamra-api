<?php

namespace App\Services;

use App\Models\CommissionSetting;
use App\Models\DirectorFund;
use App\Models\Employee;
use App\Models\EmployeeWallet;
use App\Models\Payment;
use App\Services\Accounting\LedgerService;
use Carbon\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class DirectorFundService
{
    public function __construct(private LedgerService $ledgerService)
    {
    }

    public function calculate(string $type, ?string $month = null): Collection
    {
        $type = strtolower($type);
        $config = $this->getFundConfig($type);
        $frequency = $config['frequency'];
        [$periodStart, $periodEnd] = $this->resolvePeriod($frequency, $month);

        $totalSales = $this->collectSalesTotal($periodStart, $periodEnd);
        $percentage = (float) ($config['percentage'] ?? 0);
        $totalFund = $this->calculateFundAmount($totalSales, $percentage);

        $recipients = $this->resolveRecipients($type);
        $recipientCount = $recipients->count();
        $perPerson = $recipientCount > 0 ? $this->roundAmount($totalFund / $recipientCount) : 0.0;

        $entries = collect();

        foreach ($recipients as $employee) {
            /** @var DirectorFund|null $existing */
            $existing = DirectorFund::query()
                ->where('employee_id', $employee->id)
                ->where('type', $type)
                ->whereDate('period_start', $periodStart->toDateString())
                ->first();

            if ($existing && $existing->status === DirectorFund::STATUS_PAID) {
                continue;
            }

            $payload = [
                'period_end' => $periodEnd->toDateString(),
                'percentage_used' => $percentage,
                'total_fund' => $totalFund,
                'per_person_amount' => $perPerson,
                'status' => DirectorFund::STATUS_DRAFT,
                'meta' => [
                    'frequency' => $frequency,
                    'total_sales' => $totalSales,
                    'recipient_count' => $recipientCount,
                ],
            ];

            $fund = DirectorFund::updateOrCreate([
                'employee_id' => $employee->id,
                'type' => $type,
                'period_start' => $periodStart->toDateString(),
            ], $payload);

            $entries->push($fund);
        }

        return $entries;
    }

    public function process(string $type, ?string $month = null): Collection
    {
        $type = strtolower($type);
        $config = $this->getFundConfig($type);
        $frequency = $config['frequency'];
        [$periodStart] = $this->resolvePeriod($frequency, $month);

        $funds = DirectorFund::query()
            ->where('type', $type)
            ->whereDate('period_start', $periodStart->toDateString())
            ->where('status', DirectorFund::STATUS_DRAFT)
            ->with('employee')
            ->get();

        if ($funds->isEmpty()) {
            $funds = $this->calculate($type, $month);
        }

        $processed = collect();

        foreach ($funds as $fund) {
            DB::transaction(function () use (&$processed, $fund) {
                $this->creditEmployeeWallet($fund->employee_id, (float) $fund->per_person_amount);
                $this->recordFundLiability($fund);

                $fund->forceFill([
                    'status' => DirectorFund::STATUS_PAID,
                    'processed_at' => now(),
                ])->save();

                $processed->push($fund);
            });
        }

        return $processed;
    }

    public function resolvePeriod(string $type, ?string $requestedMonth = null): array
    {
        $type = strtolower($type);
        $anchor = $requestedMonth
            ? Carbon::createFromFormat('Y-m', $requestedMonth)->startOfMonth()
            : now()->startOfMonth();

        return match ($type) {
            'yearly' => [$anchor->copy()->startOfYear(), $anchor->copy()->endOfYear()],
            'quarterly' => [
                $anchor->copy()->startOfQuarter(),
                $anchor->copy()->endOfQuarter(),
            ],
            default => [$anchor->copy()->startOfMonth(), $anchor->copy()->endOfMonth()],
        };
    }

    protected function collectSalesTotal(Carbon $start, Carbon $end): float
    {
        return (float) Payment::query()
            ->whereBetween('paid_at', [$start->toDateString(), $end->toDateString()])
            ->sum('commission_base_amount');
    }

    protected function resolveRecipients(string $type): Collection
    {
        $rank = match ($type) {
            DirectorFund::TYPE_ED => Employee::RANK_ED,
            DirectorFund::TYPE_AMD => Employee::RANK_AMD,
            default => Employee::RANK_DMD,
        };

        return Employee::query()
            ->where('rank', $rank)
            ->get();
    }

    protected function calculateFundAmount(float $totalSales, float $percentage): float
    {
        return $this->roundAmount($totalSales * ($percentage / 100));
    }

    protected function roundAmount(float $amount): float
    {
        return round($amount, 2);
    }

    protected function getFundConfig(string $type): array
    {
        $defaults = [
            DirectorFund::TYPE_ED => ['percentage' => 4, 'frequency' => 'monthly'],
            DirectorFund::TYPE_AMD => ['percentage' => 2, 'frequency' => 'quarterly'],
            DirectorFund::TYPE_DMD => ['percentage' => 10, 'frequency' => 'yearly'],
        ];

        $key = match ($type) {
            DirectorFund::TYPE_ED => 'ed_fund_settings',
            DirectorFund::TYPE_AMD => 'amd_fund_settings',
            default => 'dmd_fund_settings',
        };

        $config = CommissionSetting::value($key, []);

        if (! is_array($config)) {
            $config = [];
        }

        $merged = array_merge($defaults[$type] ?? [], $config);

        if (! in_array($merged['frequency'] ?? null, ['monthly', 'quarterly', 'yearly'], true)) {
            $merged['frequency'] = $defaults[$type]['frequency'];
        }

        $merged['percentage'] = isset($merged['percentage']) ? (float) $merged['percentage'] : (float) $defaults[$type]['percentage'];

        return $merged;
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

    protected function recordFundLiability(DirectorFund $fund): void
    {
        $txId = 'DIRF-' . $fund->id;

        $this->ledgerService->record($txId, now(), [
            [
                'account_code' => config('accounting.accounts.commission_expense.code'),
                'account_name' => config('accounting.accounts.commission_expense.name'),
                'account_type' => 'expense',
                'debit' => $fund->per_person_amount,
                'credit' => 0,
            ],
            [
                'account_code' => config('accounting.accounts.incentive_fund.code'),
                'account_name' => config('accounting.accounts.incentive_fund.name'),
                'account_type' => 'liability',
                'debit' => 0,
                'credit' => $fund->per_person_amount,
            ],
        ], [
            'employee_id' => $fund->employee_id,
            'type' => $fund->type,
            'period_start' => $fund->period_start?->toDateString(),
            'period_end' => $fund->period_end?->toDateString(),
            'percentage_used' => $fund->percentage_used,
        ]);
    }
}
