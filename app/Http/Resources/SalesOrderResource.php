<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\SalesOrder
 */
class SalesOrderResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $customer = $this->whenLoaded('customer');
        $agent = $this->whenLoaded('agent');
        $agentUser = $agent?->relationLoaded('user') ? $agent->user : null;
        $branch = $this->whenLoaded('branch');

        return [
            'id' => $this->id,
            'order_no' => 'SO-' . $this->id,
            'sales_type' => $this->sales_type,
            'status' => $this->status,
            'total' => $this->total,
            'down_payment' => $this->down_payment,
            'customer' => $this->when($customer, fn () => new UserResource($customer)),
            'agent' => $this->when($agent, function () use ($agent, $agentUser) {
                return [
                    'id' => $agent->id,
                    'agent_code' => $agent->agent_code,
                    'user' => $agentUser ? new UserResource($agentUser) : null,
                ];
            }),
            'branch' => $this->when($branch, fn () => [
                'id' => $branch->id,
                'name' => $branch->name,
                'code' => $branch->code,
            ]),
            'employee_id' => $this->employee_id,
            'agent_id' => $this->agent_id,
            'branch_id' => $this->branch_id,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
