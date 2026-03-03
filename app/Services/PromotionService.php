<?php

namespace App\Services;

use App\Models\Employee;
use App\Models\EmployeeWallet;
use App\Models\EmployeeWalletTransaction;
use App\Models\Payment;
use App\Models\PromotionAward;
use App\Models\PromotionEligibility;
use App\Models\PromotionRule;
use App\Models\PromotionSession;
use Carbon\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class PromotionService
{
    public function calculateEligibility(PromotionSession $session): array
    {
        $session->load('rules');

        $eligibleCount = 0;
        $totalEmployees = 0;

        foreach ($session->rules as $rule) {
            $employees = Employee::query()->select('id', 'superior_id')->get();

            foreach ($employees as $employee) {
                [$downPaymentCount, $salesCount] = $this->resolveCounts($session, $rule, $employee, $employees);

                $status = ($downPaymentCount >= (int) $session->target_value && $salesCount >= (int) $session->min_product_or_share_sales)
                    ? PromotionEligibility::STATUS_ELIGIBLE
                    : PromotionEligibility::STATUS_NOT_ELIGIBLE;

                PromotionEligibility::updateOrCreate(
                    [
                        'session_id' => $session->id,
                        'rule_id' => $rule->id,
                        'employee_id' => $employee->id,
                    ],
                    [
                        'current_down_payment_count' => $downPaymentCount,
                        'current_sales_count' => $salesCount,
                        'eligibility_status' => $status,
                        'calculated_at' => now(),
                    ]
                );

                $totalEmployees++;
                if ($status === PromotionEligibility::STATUS_ELIGIBLE) {
                    $eligibleCount++;
                }
            }
        }

        return [
            'total_records' => $totalEmployees,
            'eligible_records' => $eligibleCount,
        ];
    }

    public function generateAwards(PromotionSession $session, int $adminUserId): int
    {
        $eligibleRows = PromotionEligibility::query()
            ->with('rule')
            ->where('session_id', $session->id)
            ->where('eligibility_status', PromotionEligibility::STATUS_ELIGIBLE)
            ->get();

        $generated = 0;

        foreach ($eligibleRows as $row) {
            $award = PromotionAward::firstOrNew([
                'session_id' => $row->session_id,
                'rule_id' => $row->rule_id,
                'employee_id' => $row->employee_id,
            ]);

            if ($award->exists) {
                continue;
            }

            $award->fill([
                'award_status' => PromotionAward::STATUS_GENERATED,
                'generated_by' => $adminUserId,
                'generated_at' => now(),
            ])->save();

            $generated++;
        }

        return $generated;
    }

    public function processAwards(PromotionSession $session, int $adminUserId): array
    {
        $awards = PromotionAward::query()
            ->with('rule')
            ->where('session_id', $session->id)
            ->where('award_status', PromotionAward::STATUS_GENERATED)
            ->get();

        $processed = 0;
        $walletCredited = 0;

        foreach ($awards as $award) {
            DB::transaction(function () use ($award, $adminUserId, $session, &$processed, &$walletCredited): void {
                $lockedAward = PromotionAward::query()->lockForUpdate()->findOrFail($award->id);

                if ($lockedAward->award_status === PromotionAward::STATUS_PROCESSED) {
                    return;
                }

                $walletTransactionId = null;

                if ($award->rule && $award->rule->incentive_type === PromotionRule::INCENTIVE_FUND) {
                    $walletTransactionId = $this->creditWalletForFundAward($award, $session);
                    $walletCredited++;
                }

                $lockedAward->forceFill([
                    'award_status' => PromotionAward::STATUS_PROCESSED,
                    'processed_by' => $adminUserId,
                    'processed_at' => now(),
                    'wallet_transaction_id' => $walletTransactionId,
                ])->save();

                $processed++;
            });
        }

        return [
            'processed' => $processed,
            'wallet_credited' => $walletCredited,
        ];
    }

    private function creditWalletForFundAward(PromotionAward $award, PromotionSession $session): int
    {
        $amount = (float) ($award->rule?->fund_amount ?? 0);

        if ($amount <= 0) {
            return 0;
        }

        $wallet = EmployeeWallet::query()
            ->where('employee_id', $award->employee_id)
            ->lockForUpdate()
            ->first();

        if (! $wallet) {
            $wallet = EmployeeWallet::create([
                'employee_id' => $award->employee_id,
                'balance' => 0,
            ]);
            $wallet->refresh();
        }

        $wallet->balance = (float) $wallet->balance + $amount;
        $wallet->save();

        $transaction = EmployeeWalletTransaction::create([
            'employee_wallet_id' => $wallet->id,
            'employee_id' => $award->employee_id,
            'type' => EmployeeWalletTransaction::TYPE_PROMOTION_REWARD,
            'amount' => $amount,
            'currency' => $award->rule?->currency ?? 'BDT',
            'reference_type' => 'promotion_award',
            'reference_id' => $award->id,
            'narration' => sprintf('%s Promotion Reward - %.2f %s', $session->name, $amount, $award->rule?->currency ?? 'BDT'),
            'meta' => [
                'session_id' => $session->id,
                'slot_no' => $award->rule?->slot_no,
                'incentive_type' => $award->rule?->incentive_type,
            ],
        ]);

        return (int) $transaction->id;
    }

    private function resolveCounts(PromotionSession $session, PromotionRule $rule, Employee $employee, Collection $employees): array
    {
        $startDate = Carbon::parse($session->start_date)->startOfDay();
        $endDate = Carbon::parse($session->end_date)->endOfDay();

        $employeeIds = match ($rule->eligibility_basis) {
            PromotionRule::BASIS_PERSONAL => [$employee->id],
            PromotionRule::BASIS_FIRST_STEP => $employees->where('superior_id', $employee->id)->pluck('id')->values()->all(),
            PromotionRule::BASIS_COMBINED => $this->resolveFirstSecondStepIds($employee, $employees),
            default => [],
        };

        if (empty($employeeIds)) {
            return [0, 0];
        }

        $paymentsQuery = Payment::query()
            ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
            ->whereIn('sales_orders.source_me_id', $employeeIds)
            ->whereIn('sales_orders.sales_type', [\App\Models\SalesOrder::TYPE_ORDER, \App\Models\SalesOrder::TYPE_SHARE])
            ->where('payments.type', Payment::TYPE_DOWN_PAYMENT)
            ->whereBetween('payments.paid_at', [$startDate->toDateString(), $endDate->toDateString()]);

        // Intentionally not filtering by payments.meta finance verification flags.
        // Business requested to exclude payment meta-based filtering from eligibility.

        $downPaymentCount = (clone $paymentsQuery)->count();
        $salesCount = (clone $paymentsQuery)->distinct('payments.sales_order_id')->count('payments.sales_order_id');

        return [$downPaymentCount, $salesCount];
    }

    private function resolveFirstSecondStepIds(Employee $employee, Collection $employees): array
    {
        $firstStepIds = $employees->where('superior_id', $employee->id)->pluck('id')->values();

        if ($firstStepIds->isEmpty()) {
            return [];
        }

        $secondStepIds = $employees->whereIn('superior_id', $firstStepIds->all())->pluck('id')->values();

        return $firstStepIds->merge($secondStepIds)->unique()->values()->all();
    }
}
