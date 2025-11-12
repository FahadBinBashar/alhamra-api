<?php

namespace App\Services;

use App\Models\Payment;
use App\Models\Product;
use App\Models\SalesOrder;
use App\Models\Supplier;
use App\Models\SupplierPayable;
use App\Services\Accounting\LedgerService;
use Carbon\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class SupplierPayableService
{
    public function __construct(private LedgerService $ledgerService)
    {
    }

    public function handlePayment(Payment $payment): void
    {
        $payment->loadMissing('salesOrder.items.itemable');

        $order = $payment->salesOrder;

        if (! $order) {
            return;
        }

        $eligibleItems = $this->resolveEligibleItems($order);

        if ($eligibleItems->isEmpty()) {
            return;
        }

        $totals = $eligibleItems->sum('line_total');

        if ($totals <= 0) {
            $totals = $order->total > 0 ? (float) $order->total : null;
        }

        if (! $totals) {
            $totals = $eligibleItems->count();
        }

        $supplierAmounts = [];

        foreach ($eligibleItems as $item) {
            /** @var \App\Models\Product $product */
            $product = $item->itemable;
            $percentage = max((float) $product->supplier_percentage, 0);

            if ($percentage <= 0) {
                continue;
            }

            $baseShare = $item->line_total > 0 && $totals > 0
                ? ((float) $payment->amount) * ((float) $item->line_total / $totals)
                : ((float) $payment->amount) / max($eligibleItems->count(), 1);

            $amount = round($baseShare * ($percentage / 100), 2);

            if ($amount <= 0) {
                continue;
            }

            $supplierId = (int) $product->supplier_id;

            if (! $supplierId) {
                continue;
            }

            if (! array_key_exists($supplierId, $supplierAmounts)) {
                $supplierAmounts[$supplierId] = 0.0;
            }

            $supplierAmounts[$supplierId] += $amount;
        }

        if (empty($supplierAmounts)) {
            return;
        }

        DB::transaction(function () use ($payment, $supplierAmounts, $order) {
            foreach ($supplierAmounts as $supplierId => $amount) {
                $this->createSupplierPayable($payment, $order, $supplierId, $amount);
            }
        });
    }

    public function markAsPaid(Supplier $supplier, Collection $payables, string $method, Carbon $paidAt): void
    {
        $totalAmount = $payables->sum(fn (SupplierPayable $payable) => (float) $payable->amount);

        if ($totalAmount <= 0) {
            return;
        }

        $txId = 'SUPP-PAYOUT-' . $supplier->id . '-' . Str::orderedUuid();
        $meta = [
            'supplier_id' => $supplier->id,
            'payable_ids' => $payables->pluck('id')->all(),
            'method' => $method,
        ];

        $cashAccount = $method === 'bank'
            ? config('accounting.accounts.bank.code')
            : config('accounting.accounts.cash.code');

        $this->ledgerService->record($txId, $paidAt, [
            [
                'account_code' => config('accounting.accounts.supplier_payable.code'),
                'account_name' => config('accounting.accounts.supplier_payable.name'),
                'account_type' => config('accounting.accounts.supplier_payable.type'),
                'debit' => $totalAmount,
                'credit' => 0,
            ],
            [
                'account_code' => $cashAccount,
                'account_name' => $method === 'bank' ? 'Bank Account' : 'Cash Account',
                'account_type' => 'asset',
                'debit' => 0,
                'credit' => $totalAmount,
            ],
        ], $meta);

        $payables->each(function (SupplierPayable $payable) use ($paidAt) {
            $payable->forceFill([
                'status' => SupplierPayable::STATUS_PAID,
                'paid_at' => $paidAt,
            ])->save();
        });
    }

    protected function resolveEligibleItems(SalesOrder $order): Collection
    {
        return $order->items
            ->filter(function ($item) {
                $itemable = $item->itemable;

                return $itemable instanceof Product
                    && (int) $itemable->supplier_id > 0
                    && (float) $itemable->supplier_percentage > 0;
            });
    }

    protected function createSupplierPayable(Payment $payment, SalesOrder $order, int $supplierId, float $amount): void
    {
        if ($amount <= 0) {
            return;
        }

        $payable = SupplierPayable::query()
            ->where('supplier_id', $supplierId)
            ->where('payment_id', $payment->id)
            ->first();

        if ($payable) {
            return;
        }

        SupplierPayable::create([
            'supplier_id' => $supplierId,
            'payment_id' => $payment->id,
            'sales_order_id' => $order->id,
            'amount' => $amount,
            'status' => SupplierPayable::STATUS_UNPAID,
        ]);

        $meta = [
            'payment_id' => $payment->id,
            'sales_order_id' => $order->id,
            'supplier_id' => $supplierId,
        ];

        $txId = 'SUPP-PAYABLE-' . $payment->id . '-' . $supplierId;
        $occurredAt = $payment->paid_at ?? now();

        $this->ledgerService->record($txId, $occurredAt, [
            [
                'account_code' => config('accounting.accounts.supplier_cost.code'),
                'account_name' => config('accounting.accounts.supplier_cost.name'),
                'account_type' => config('accounting.accounts.supplier_cost.type'),
                'debit' => $amount,
                'credit' => 0,
            ],
            [
                'account_code' => config('accounting.accounts.supplier_payable.code'),
                'account_name' => config('accounting.accounts.supplier_payable.name'),
                'account_type' => config('accounting.accounts.supplier_payable.type'),
                'debit' => 0,
                'credit' => $amount,
            ],
        ], $meta);
    }
}
