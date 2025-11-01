<?php

namespace App\Listeners;

use App\Events\PaymentRecorded;
use App\Models\Employee;
use App\Models\Payment;
use App\Services\CommissionService;
use App\Services\RankPromotionService;

class ProcessPaymentCommissions
{
    public function __construct(
        private CommissionService $commissionService,
        private RankPromotionService $rankPromotionService,
    )
    {
    }

    public function handle(PaymentRecorded $event): void
    {
        $payment = $event->payment;

        $this->promoteMarketingExecutiveIfEligible($payment);
        $this->evaluateRankProgress($payment);

        $this->commissionService->handlePayment($payment, true);
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

        if ((float) $payment->amount < 50000) {
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
