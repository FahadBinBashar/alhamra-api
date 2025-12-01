<?php

namespace App\Services;

use App\Models\Agent;
use App\Models\AgentWallet;
use App\Models\Commission;
use App\Models\Employee;
use App\Models\EmployeeWallet;
use App\Models\Payment;
use App\Models\SalesOrder;
use App\Models\Service;
use App\Services\Accounting\LedgerService;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class ServiceCommissionService
{
    public function __construct(private LedgerService $ledgerService)
    {
    }

    public function handlePayment(Payment $payment): ?Commission
    {
        $order = $payment->salesOrder;

        if (! $order || $order->sales_type !== SalesOrder::TYPE_SERVICE) {
            return null;
        }

        $service = $this->resolveServiceFromOrder($order);
        $percentage = $service ? (float) $service->commission_percentage : 0.0;

        if ($percentage <= 0) {
            return null;
        }

        $recipient = $this->resolveRecipient($order);

        if (! $recipient) {
            return null;
        }

        $amount = round((float) $payment->amount * ($percentage / 100), 2);

        if ($amount <= 0) {
            return null;
        }

        $status = $recipient['type'] === Agent::class ? 'paid' : 'unpaid';
        $paidAt = $status === 'paid' ? now() : null;

        $meta = array_filter([
            'payment_amount' => (float) $payment->amount,
            'commission_percentage' => $percentage,
            'service_id' => $service?->id,
        ]);

        return DB::transaction(function () use ($payment, $recipient, $amount, $status, $paidAt, $meta) {
            /** @var Commission $commission */
            $commission = Commission::create([
                'payment_id' => $payment->id,
                'sales_order_id' => $payment->sales_order_id,
                'category' => 'service',
                'recipient_type' => $recipient['type'],
                'recipient_id' => $recipient['id'],
                'amount' => $amount,
                'status' => $status,
                'paid_at' => $paidAt,
                'meta' => $meta,
            ]);

            if ($status === 'paid') {
                $this->creditWallet($recipient['type'], (int) $recipient['id'], $amount);
                $this->recordLedger($commission);
            }

            return $commission;
        });
    }

    public function processUnpaidForMonth(Carbon $month): array
    {
        $start = $month->copy()->startOfMonth();
        $end = $month->copy()->endOfMonth();

        $commissions = Commission::query()
            ->where('category', 'service')
            ->where('status', 'unpaid')
            ->whereHas('payment', function ($query) use ($start, $end) {
                $query->whereBetween('paid_at', [$start, $end]);
            })
            ->with(['payment', 'salesOrder'])
            ->lockForUpdate()
            ->get();

        $processed = 0;
        $totalAmount = 0.0;

        foreach ($commissions as $commission) {
            $processed++;
            $totalAmount += (float) $commission->amount;

            DB::transaction(function () use ($commission) {
                $commission->forceFill([
                    'status' => 'paid',
                    'paid_at' => now(),
                ])->save();

                $this->creditWallet($commission->recipient_type, (int) $commission->recipient_id, (float) $commission->amount);
                $this->recordLedger($commission);
            });
        }

        return [
            'processed' => $processed,
            'total_amount' => round($totalAmount, 2),
            'month' => $month->format('Y-m'),
        ];
    }

    protected function resolveRecipient(SalesOrder $order): ?array
    {
        if ($order->agent_id) {
            return ['type' => Agent::class, 'id' => (int) $order->agent_id];
        }

        if ($order->source_me_id) {
            return ['type' => Employee::class, 'id' => (int) $order->source_me_id];
        }

        return null;
    }

    protected function resolveServiceFromOrder(SalesOrder $order): ?Service
    {
        $order->loadMissing('items.itemable');

        $serviceItem = $order->items->first(function ($item) {
            return $item->itemable instanceof Service;
        });

        return $serviceItem?->itemable;
    }

    protected function creditWallet(string $recipientType, int $recipientId, float $amount): void
    {
        if ($recipientType === Employee::class) {
            $wallet = EmployeeWallet::query()->where('employee_id', $recipientId)->lockForUpdate()->first();

            if (! $wallet) {
                $wallet = new EmployeeWallet([
                    'employee_id' => $recipientId,
                    'balance' => 0,
                ]);
            }

            $wallet->balance = (float) $wallet->balance + $amount;
            $wallet->employee_id = $recipientId;
            $wallet->save();
        } elseif ($recipientType === Agent::class) {
            $wallet = AgentWallet::query()->where('agent_id', $recipientId)->lockForUpdate()->first();

            if (! $wallet) {
                $wallet = new AgentWallet([
                    'agent_id' => $recipientId,
                    'balance' => 0,
                ]);
            }

            $wallet->balance = (float) $wallet->balance + $amount;
            $wallet->agent_id = $recipientId;
            $wallet->save();
        }
    }

    protected function recordLedger(Commission $commission): void
    {
        $occurredAt = $commission->paid_at ?? now();
        $txId = 'SVC-CMS-' . $commission->id;

        $this->ledgerService->record($txId, $occurredAt, [
            [
                'account_code' => config('accounting.accounts.commission_expense.code'),
                'account_name' => config('accounting.accounts.commission_expense.name'),
                'account_type' => 'expense',
                'debit' => $commission->amount,
                'credit' => 0,
            ],
            [
                'account_code' => config('accounting.accounts.commission_payable.code'),
                'account_name' => config('accounting.accounts.commission_payable.name'),
                'account_type' => 'liability',
                'debit' => 0,
                'credit' => $commission->amount,
            ],
        ], [
            'commission_id' => $commission->id,
            'category' => 'service',
            'recipient_type' => $commission->recipient_type,
            'recipient_id' => $commission->recipient_id,
            'sales_order_id' => $commission->sales_order_id,
            'payment_id' => $commission->payment_id,
        ]);
    }
}
