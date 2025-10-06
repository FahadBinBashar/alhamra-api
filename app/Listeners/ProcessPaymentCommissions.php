<?php

namespace App\Listeners;

use App\Events\PaymentRecorded;
use App\Services\CommissionService;

class ProcessPaymentCommissions
{
    public function __construct(private CommissionService $commissionService)
    {
    }

    public function handle(PaymentRecorded $event): void
    {
        $this->commissionService->handlePayment($event->payment);
    }
}
