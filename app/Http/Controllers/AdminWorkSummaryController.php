<?php

namespace App\Http\Controllers;

use App\Http\Resources\WorkSummaryResource;
use App\Models\WorkSummary;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Carbon;
use Illuminate\Validation\Rule;

class AdminWorkSummaryController extends Controller
{
    public function index(Request $request): AnonymousResourceCollection
    {
        $this->authorize('viewAdmin', WorkSummary::class);

        $data = $request->validate([
            'employee_id' => ['nullable', 'integer', 'exists:employees,id'],
            'type' => ['nullable', 'string', Rule::in(WorkSummary::TYPES)],
            'from' => ['nullable', 'date'],
            'to' => ['nullable', 'date'],
            'per_page' => ['nullable', 'integer', 'min:1'],
        ]);

        $query = WorkSummary::query()
            ->with(['employee.user'])
            ->orderByDesc('submitted_at')
            ->orderByDesc('id');

        if (! empty($data['employee_id'])) {
            $query->where('employee_id', $data['employee_id']);
        }

        if (! empty($data['type'])) {
            $query->where('type', $data['type']);
        }

        $this->applyDateFilters($query, $data['from'] ?? null, $data['to'] ?? null, $data['type'] ?? null);

        $summaries = $query
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return WorkSummaryResource::collection($summaries);
    }

    private function applyDateFilters(Builder $query, ?string $from, ?string $to, ?string $type): void
    {
        if (! $from && ! $to) {
            return;
        }

        $fromDate = $from ? Carbon::parse($from)->toDateString() : null;
        $toDate = $to ? Carbon::parse($to)->toDateString() : null;

        if ($type === WorkSummary::TYPE_DAILY) {
            $this->applyDateRange($query, 'report_date', $fromDate, $toDate);

            return;
        }

        if ($type === WorkSummary::TYPE_WEEKLY) {
            $this->applyDateRange($query, 'week_start', $fromDate, $toDate);

            return;
        }

        $query->where(function (Builder $builder) use ($fromDate, $toDate) {
            $builder->where(function (Builder $daily) use ($fromDate, $toDate) {
                $daily->where('type', WorkSummary::TYPE_DAILY);
                $this->applyDateRange($daily, 'report_date', $fromDate, $toDate);
            })->orWhere(function (Builder $weekly) use ($fromDate, $toDate) {
                $weekly->where('type', WorkSummary::TYPE_WEEKLY);
                $this->applyDateRange($weekly, 'week_start', $fromDate, $toDate);
            });
        });
    }

    private function applyDateRange(Builder $query, string $column, ?string $from, ?string $to): void
    {
        if ($from) {
            $query->whereDate($column, '>=', $from);
        }

        if ($to) {
            $query->whereDate($column, '<=', $to);
        }
    }
}
