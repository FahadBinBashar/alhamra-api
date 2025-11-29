<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class DirectorFundResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     */
    public function toArray($request): array
    {
        $meta = $this->meta ?? [];

        $employee = $this->whenLoaded('employee');
        $employeeUser = $employee && $employee->relationLoaded('user') ? $employee->user : null;

        return [
            'id' => $this->id,
            'employee_id' => $this->employee_id,
            'type' => $this->type,
            'period_start' => $this->period_start,
            'period_end' => $this->period_end,
            'percentage_used' => (float) $this->percentage_used,
            'total_fund' => (float) $this->total_fund,
            'per_person_amount' => (float) $this->per_person_amount,
            'status' => $this->status,
            'frequency' => $meta['frequency'] ?? null,
            'total_sales' => isset($meta['total_sales']) ? (float) $meta['total_sales'] : null,
            'recipient_count' => isset($meta['recipient_count']) ? (int) $meta['recipient_count'] : null,
            'processed_at' => $this->processed_at,
            'employee' => $employee ? [
                'id' => $employee->id,
                'user_id' => $employee->user_id,
                'employee_code' => $employee->employee_code,
                'rank' => $employee->rank,
                'name' => $employeeUser?->name ?? $employee->full_name_en,
            ] : null,
            'meta' => $meta,
        ];
    }
}
