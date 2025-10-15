<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Commission
 */
class CommissionResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'commission_rule_id' => $this->commission_rule_id,
            'payment_id' => $this->payment_id,
            'sales_order_id' => $this->sales_order_id,
            'recipient_type' => $this->recipient_type,
            'recipient_id' => $this->recipient_id,
            'amount' => $this->amount,
            'status' => $this->status,
            'paid_at' => $this->paid_at,
            'meta' => $this->meta,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'rule' => $this->whenLoaded('rule', fn () => new CommissionRuleResource($this->rule)),
            'payment' => $this->whenLoaded('payment', function () {
                return [
                    'id' => $this->payment->id,
                    'sales_order_id' => $this->payment->sales_order_id,
                    'paid_at' => $this->payment->paid_at,
                    'amount' => $this->payment->amount,
                    'type' => $this->payment->type,
                    'method' => $this->payment->method,
                ];
            }),
            'sales_order' => $this->whenLoaded('salesOrder', function () {
                return [
                    'id' => $this->salesOrder->id,
                    'customer_id' => $this->salesOrder->customer_id,
                    'agent_id' => $this->salesOrder->agent_id,
                    'branch_id' => $this->salesOrder->branch_id,
                    'total' => $this->salesOrder->total,
                    'status' => $this->salesOrder->status,
                ];
            }),
        ];
    }
}
