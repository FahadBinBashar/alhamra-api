<?php

namespace App\Services;

use App\Models\CustomerInstallment;
use App\Models\Product;
use App\Models\ProductEmiRule;
use App\Models\SalesOrder;

class EmiExtraService
{
    public function resolveProductForOrder(SalesOrder $order): ?Product
    {
        $order->loadMissing('items.itemable');

        foreach ($order->items ?? [] as $item) {
            if ($item->itemable instanceof Product) {
                return $item->itemable;
            }
        }

        return null;
    }

    public function resolveInstallmentIndex(CustomerInstallment $installment): int
    {
        $order = $installment->relationLoaded('salesOrder')
            ? $installment->salesOrder
            : $installment->salesOrder()->first();

        if (! $order) {
            return 1;
        }

        $installments = $order->installments()
            ->orderBy('due_date')
            ->orderBy('id')
            ->get(['id']);

        foreach ($installments as $index => $item) {
            if ($item->id === $installment->id) {
                return $index + 1;
            }
        }

        return 1;
    }

    public function calculateExtra(CustomerInstallment $installment, float $baseAmount): float
    {
        $order = $installment->relationLoaded('salesOrder')
            ? $installment->salesOrder
            : $installment->salesOrder()->first();

        if (! $order || ! $order->installment_tenure_months) {
            return 0.0;
        }

        $product = $this->resolveProductForOrder($order);

        if (! $product) {
            return 0.0;
        }

        $ruleMonth = $this->resolveInstallmentIndex($installment);

        $rule = ProductEmiRule::query()
            ->where('product_id', $product->id)
            ->where('tenure_months', $order->installment_tenure_months)
            ->where('rule_month', $ruleMonth)
            ->where('is_active', true)
            ->first();

        if (! $rule) {
            return 0.0;
        }

        if ($rule->rule_type === 'percent') {
            $percent = (float) ($rule->percent ?? 0);

            return round($baseAmount * ($percent / 100), 2);
        }

        return round((float) ($rule->flat_amount ?? 0), 2);
    }
}
