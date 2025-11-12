<?php

namespace App\Listeners;

use App\Events\PaymentRecorded;
use App\Models\Employee;
use App\Models\SalesOrder;
use App\Models\RankRequirement;
use App\Models\Payment;
use App\Services\CommissionService;
use App\Services\RankPromotionService;
use App\Services\SupplierPayableService;

class ProcessPaymentCommissions
{
    public function __construct(
        private CommissionService $commissionService,
        private RankPromotionService $rankPromotionService,
        private SupplierPayableService $supplierPayableService,
    )
    {
    }

    public function handle(PaymentRecorded $event): void
    {
        $payment = $event->payment;

        $this->promoteMarketingExecutiveIfEligible($payment);
        $this->evaluateRankProgress($payment);

        $this->commissionService->handlePayment($payment, true);
        $this->supplierPayableService->handlePayment($payment);
    }

    protected function promoteMarketingExecutiveIfEligible(Payment $payment): void
    {
        $payment->loadMissing('salesOrder.sourceMe');

        $sourceEmployee = $payment->salesOrder?->sourceMe;

        if (! $sourceEmployee || $sourceEmployee->rank !== Employee::RANK_ME) {
            return;
        }

        if ($payment->type !== Payment::TYPE_DOWN_PAYMENT) {
            return;
        }

        $promotionThreshold = (float) RankRequirement::query()
            ->where('rank', Employee::RANK_MM)
            ->value('personal_sales_target') ?: 50000;

        $totalPaidDownPayment = (float) Payment::query()
            ->where('type', Payment::TYPE_DOWN_PAYMENT)
            ->whereHas('salesOrder', function ($query) use ($sourceEmployee) {
                $query->where('source_me_id', $sourceEmployee->id)
                    ->where('status', '!=', SalesOrder::STATUS_CANCELLED);
            })->sum('amount');

        if ($totalPaidDownPayment < $promotionThreshold) {
            return;
        }

        $promoted = $this->rankPromotionService->promoteToMarketingOfficer($sourceEmployee);

        if (! $promoted) {
            return;
        }

        $sourceEmployee->refresh()->loadMissing('superior');

        if ($payment->relationLoaded('salesOrder')) {
            $payment->salesOrder->setRelation('sourceMe', $sourceEmployee);
        }
    }

    protected function evaluateRankProgress(Payment $payment): void
    {
        $payment->loadMissing('salesOrder.sourceMe.superior');

        $employee = $payment->salesOrder?->sourceMe;

        while ($employee) {
            $this->rankPromotionService->evaluateEmployee($employee);

            $employee->loadMissing('superior');
            $employee = $employee->superior;
        }
    }
}
