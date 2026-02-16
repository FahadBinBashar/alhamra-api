<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Payment
 */
class PaymentResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $salesOrder = $this->whenLoaded('salesOrder');
        $customer = $salesOrder?->customer;
        $agent = $salesOrder?->agent;
        $branch = $salesOrder?->branch;

        return [
            'id' => $this->id,
            'sales_order_id' => $this->sales_order_id,
            'sales_order' => $this->when($salesOrder, function () use ($salesOrder) {
                return [
                    'id' => $salesOrder->id,
                    'order_no' => 'SO-' . $salesOrder->id,
                    'sales_type' => $salesOrder->sales_type,
                    'status' => $salesOrder->status,
                    'total' => $salesOrder->total,
                    'down_payment' => $salesOrder->down_payment,
                    'created_at' => $salesOrder->created_at,
                ];
            }),
            'customer' => $this->when($customer, fn () => new UserResource($customer)),
            'agent' => $this->when($agent, function () use ($agent) {
                $user = $agent->relationLoaded('user') ? $agent->user : null;

                return [
                    'id' => $agent->id,
                    'agent_code' => $agent->agent_code,
                    'branch_id' => $agent->branch_id,
                    'user' => $user ? new UserResource($user) : null,
                ];
            }),
            'branch' => $this->when($branch, fn () => [
                'id' => $branch->id,
                'name' => $branch->name,
                'code' => $branch->code,
            ]),
            'amount' => $this->amount,
            'base_amount' => $this->base_amount,
            'emi_extra_amount' => $this->emi_extra_amount,
            'type' => $this->type,
            'intent_type' => $this->intent_type,
            'method' => $this->method,
            'commission_base_amount' => $this->commission_base_amount,
            'commission_processed_at' => $this->commission_processed_at,
            'meta' => $this->meta,
            'paid_at' => $this->paid_at,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'allocations' => $this->whenLoaded('allocations', fn () => $this->allocations->map(function ($allocation) {
                $installment = $allocation->relationLoaded('installment') ? $allocation->installment : null;

                return [
                    'id' => $allocation->id,
                    'allocated' => $allocation->allocated,
                    'customer_installment_id' => $allocation->customer_installment_id,
                    'installment' => $installment ? [
                        'id' => $installment->id,
                        'due_date' => $installment->due_date,
                        'amount' => $installment->amount,
                        'paid' => $installment->paid,
                        'status' => $installment->status,
                    ] : null,
                ];
            })),
        ];
    }
}
