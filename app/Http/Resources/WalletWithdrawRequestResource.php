<?php

namespace App\Http\Resources;

use App\Models\Agent;
use App\Models\Employee;
use App\Models\WalletWithdrawRequest;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin WalletWithdrawRequest
 */
class WalletWithdrawRequestResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'user_type' => $this->user_type,
            'user_id' => $this->user_id,
            'user_name' => $this->resolveUserName(),
            'wallet_type' => $this->wallet_type,
            'amount' => (float) $this->amount,
            'method' => $this->method,
            'method_details' => $this->method_details,
            'status' => $this->status,
            'reviewed_by' => $this->reviewed_by,
            'reviewed_at' => $this->reviewed_at,
            'reject_reason' => $this->reject_reason,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }

    private function resolveUserName(): ?string
    {
        if ($this->user_type === WalletWithdrawRequest::USER_TYPE_AGENT) {
            $agent = $this->whenLoaded('agent');

            if ($agent) {
                return $agent->user?->name ?? $agent->name;
            }

            $agent = Agent::query()->with('user')->find($this->user_id);

            return $agent?->user?->name ?? $agent?->name;
        }

        if ($this->user_type === WalletWithdrawRequest::USER_TYPE_EMPLOYEE) {
            $employee = $this->whenLoaded('employee');

            if ($employee) {
                return $employee->user?->name ?? $employee->name;
            }

            $employee = Employee::query()->with('user')->find($this->user_id);

            return $employee?->user?->name ?? $employee?->name;
        }

        return null;
    }
}
