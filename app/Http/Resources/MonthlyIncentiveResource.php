<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\MonthlyIncentive
 */
class MonthlyIncentiveResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $employee = $this->whenLoaded('employee');
        $employeeUser = $employee && $employee->relationLoaded('user') ? $employee->user : null;
        $reviewer = $this->whenLoaded('reviewer');

        return [
            'id' => $this->id,
            'employee_id' => $this->employee_id,
            'employee_name' => $employeeUser?->name ?? $employee?->name,
            'period_start' => $this->period_start,
            'period_end' => $this->period_end,
            'total_commissionable_sales' => $this->total_commissionable_sales,
            'incentive_rate' => $this->incentive_rate,
            'amount' => $this->amount,
            'status' => $this->status,
            'reviewed_by' => $this->reviewed_by,
            'reviewer_name' => $reviewer?->name,
            'reviewed_at' => $this->reviewed_at,
            'review_note' => $this->review_note,
            'meta' => $this->meta,
            'processed_at' => $this->processed_at,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
