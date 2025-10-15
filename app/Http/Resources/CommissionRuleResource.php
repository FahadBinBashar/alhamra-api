<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\CommissionRule
 */
class CommissionRuleResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'scope' => $this->scope,
            'trigger' => $this->trigger,
            'recipient_type' => $this->recipient_type,
            'recipient_id' => $this->recipient_id,
            'percentage' => $this->percentage,
            'flat_amount' => $this->flat_amount,
            'active' => $this->active,
            'meta' => $this->meta,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'commissions_count' => $this->whenCounted('commissions'),
        ];
    }
}
