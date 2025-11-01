<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\EmployeeWallet
 */
class EmployeeWalletResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $employee = $this->whenLoaded('employee');
        $employeeUser = $employee && $employee->relationLoaded('user') ? $employee->user : null;

        return [
            'id' => $this->id,
            'employee_id' => $this->employee_id,
            'employee_name' => $employeeUser?->name ?? $employee?->full_name_en,
            'balance' => (float) $this->balance,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
