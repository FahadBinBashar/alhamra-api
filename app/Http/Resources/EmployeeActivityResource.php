<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\EmployeeActivity
 */
class EmployeeActivityResource extends JsonResource
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
            'activity_date' => $this->activity_date,
            'title' => $this->title,
            'location' => $this->location,
            'customer' => $this->whenLoaded('customer', fn () => new UserResource($this->customer)),
            'sales_order' => $this->whenLoaded('salesOrder', fn () => new SalesOrderResource($this->salesOrder)),
            'notes' => $this->notes,
            'meta' => $this->meta,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'creator' => $this->whenLoaded('creator', fn () => new UserResource($this->creator)),
        ];
    }
}
