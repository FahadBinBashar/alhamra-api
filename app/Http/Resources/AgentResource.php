<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Agent
 */
class AgentResource extends JsonResource
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
            'user_id' => $this->user_id,
            'branch_id' => $this->branch_id,
            'agent_code' => $this->agent_code,
            'sales_orders_count' => $this->whenCounted('salesOrders'),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'user' => $this->whenLoaded('user', fn () => new UserResource($this->user)),
            'branch' => $this->whenLoaded('branch', fn () => new BranchResource($this->branch)),
            'rank_memberships' => $this->whenLoaded('rankMemberships', fn () => RankMembershipResource::collection($this->rankMemberships)),
            'active_rank' => $this->whenLoaded('activeRank', fn () => new RankMembershipResource($this->activeRank)),
        ];
    }
}
