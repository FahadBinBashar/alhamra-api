<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Branch
 */
class BranchResource extends JsonResource
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
            'name' => $this->name,
            'code' => $this->code,
            'address' => $this->address,
            'agents_count' => $this->whenCounted('agents'),
            'sales_orders_count' => $this->whenCounted('salesOrders'),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'agents' => $this->whenLoaded('agents', fn () => AgentResource::collection($this->agents)),
        ];
    }
}
