<?php

namespace App\Http\Resources;

use App\Models\Agent;
use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\CommissionCalculationItem
 */
class CommissionCalculationItemResource extends JsonResource
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
            'commission_calculation_unit_id' => $this->commission_calculation_unit_id,
            'recipient_type' => $this->recipient_type,
            'recipient_id' => $this->recipient_id,
            'amount' => (float) $this->amount,
            'percentage' => $this->percentage !== null ? (float) $this->percentage : null,
            'meta' => $this->meta,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'recipient' => $this->whenLoaded('recipient', function () {
                $recipient = $this->recipient;

                if ($recipient instanceof Employee) {
                    return [
                        'id' => $recipient->id,
                        'rank' => $recipient->rank,
                        'name' => $recipient->relationLoaded('user') ? $recipient->user?->name : null,
                        'branch_id' => $recipient->branch_id,
                    ];
                }

                if ($recipient instanceof Agent) {
                    return [
                        'id' => $recipient->id,
                        'agent_code' => $recipient->agent_code,
                        'name' => $recipient->relationLoaded('user') ? $recipient->user?->name : null,
                        'branch_id' => $recipient->branch_id,
                    ];
                }

                return $recipient;
            }),
        ];
    }
}
