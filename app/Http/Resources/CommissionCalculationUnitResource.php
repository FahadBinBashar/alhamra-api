<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\CommissionCalculationUnit
 */
class CommissionCalculationUnitResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'payment_id' => $this->payment_id,
            'sales_order_id' => $this->sales_order_id,
            'status' => $this->status,
            'calculated_at' => $this->calculated_at,
            'processed_at' => $this->processed_at,
            'meta' => $this->meta,
            'commissionable_amount' => $this->meta['commissionable_amount'] ?? null,
            'total_items' => $this->whenLoaded('items', fn () => $this->items->count()),
            'total_amount' => $this->whenLoaded('items', fn () => (float) $this->items->sum('amount')),
            'payment' => $this->whenLoaded('payment', fn () => new PaymentResource($this->payment)),
            'items' => CommissionCalculationItemResource::collection($this->whenLoaded('items')),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
