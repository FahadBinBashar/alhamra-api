<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\AgentWallet
 */
class AgentWalletResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $agent = $this->whenLoaded('agent');
        $agentUser = $agent && $agent->relationLoaded('user') ? $agent->user : null;

        return [
            'id' => $this->id,
            'agent_id' => $this->agent_id,
            'agent_name' => $agentUser?->name ?? $agent?->name,
            'balance' => (float) $this->balance,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
