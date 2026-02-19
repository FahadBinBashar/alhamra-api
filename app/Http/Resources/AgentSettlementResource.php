<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/** @mixin \App\Models\AgentSettlement */
class AgentSettlementResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'agent_id' => $this->agent_id,
            'amount' => $this->amount,
            'payment_method' => $this->payment_method,
            'reference_no' => $this->reference_no,
            'attachment_url' => $this->attachment_url,
            'status' => $this->status,
            'note' => $this->note,
            'admin_note' => $this->admin_note,
            'approved_at' => optional($this->approved_at)?->toDateTimeString(),
            'rejected_at' => optional($this->rejected_at)?->toDateTimeString(),
            'agent' => $this->whenLoaded('agent', fn () => [
                'id' => $this->agent?->id,
                'agent_code' => $this->agent?->agent_code,
                'name' => $this->agent?->user?->name,
            ]),
            'approver' => $this->whenLoaded('approver', fn () => [
                'id' => $this->approver?->id,
                'name' => $this->approver?->name,
                'email' => $this->approver?->email,
            ]),
            'created_at' => optional($this->created_at)?->toDateTimeString(),
            'updated_at' => optional($this->updated_at)?->toDateTimeString(),
        ];
    }
}
