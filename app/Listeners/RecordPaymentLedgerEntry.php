<?php

namespace App\Listeners;

use App\Events\PaymentRecorded;
use App\Services\Accounting\LedgerService;
use Illuminate\Support\Str;

class RecordPaymentLedgerEntry
{
    public function __construct(private LedgerService $ledgerService)
    {
    }

    public function handle(PaymentRecorded $event): void
    {
        $payment = $event->payment->loadMissing('salesOrder');

        $method = $payment->method ?? 'cash';
        $cashAccount = $method === 'bank'
            ? config('accounting.accounts.bank.code')
            : config('accounting.accounts.cash.code');

        $txId = 'PMT-' . $payment->id;
        $occurredAt = $payment->paid_at ?? now();
        $meta = [
            'payment_id' => $payment->id,
            'sales_order_id' => $payment->sales_order_id,
            'method' => $method,
        ];

        $this->ledgerService->record($txId, $occurredAt, [
            [
                'account_code' => $cashAccount,
                'account_name' => Str::title($method) . ' Account',
                'account_type' => 'asset',
                'debit' => $payment->amount,
                'credit' => 0,
            ],
            [
                'account_code' => config('accounting.accounts.accounts_receivable.code'),
                'account_name' => config('accounting.accounts.accounts_receivable.name'),
                'account_type' => 'asset',
                'debit' => 0,
                'credit' => $payment->amount,
            ],
        ], $meta);
    }
}
