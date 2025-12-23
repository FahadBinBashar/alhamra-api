<?php

namespace App\Http\Resources;

use App\Models\WorkSummary;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin WorkSummary
 */
class WorkSummaryResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'employee_id' => $this->employee_id,
            'employee_name' => $this->whenLoaded('employee', function () {
                return $this->employee?->user?->name
                    ?? $this->employee?->full_name_en
                    ?? $this->employee?->full_name_bn;
            }),
            'type' => $this->type,
            'report_date' => optional($this->report_date)->toDateString(),
            'week_start' => optional($this->week_start)->toDateString(),
            'week_end' => optional($this->week_end)->toDateString(),
            'today_sales_amount' => (float) $this->today_sales_amount,
            'remarks' => $this->remarks,
            'sections' => $this->sections ?? [],
            'submitted_at' => optional($this->submitted_at)->toDateTimeString(),
            'created_at' => optional($this->created_at)->toDateTimeString(),
            'updated_at' => optional($this->updated_at)->toDateTimeString(),
        ];
    }
}
