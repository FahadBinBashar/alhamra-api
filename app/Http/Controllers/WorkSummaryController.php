<?php

namespace App\Http\Controllers;

use App\Http\Resources\WorkSummaryResource;
use App\Models\WorkSummary;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Carbon;
use Illuminate\Validation\Rule;

class WorkSummaryController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        $this->authorize('create', WorkSummary::class);

        $employeeId = $request->user()->employee->id;
        $data = $this->validatePayload($request, $employeeId);

        $summary = WorkSummary::create([
            'employee_id' => $employeeId,
            'type' => $data['type'],
            'report_date' => $data['report_date'] ?? null,
            'week_start' => $data['week_start'] ?? null,
            'week_end' => $data['week_end'] ?? null,
            'today_sales_amount' => $data['today_sales_amount'] ?? 0,
            'remarks' => $data['remarks'] ?? null,
            'sections' => $data['sections'] ?? [],
            'submitted_at' => now(),
        ]);

        return (new WorkSummaryResource($summary))
            ->response()
            ->setStatusCode(201);
    }

    public function index(Request $request): AnonymousResourceCollection
    {
        $this->authorize('viewAny', WorkSummary::class);

        $data = $request->validate([
            'type' => ['nullable', 'string', Rule::in(WorkSummary::TYPES)],
            'from' => ['nullable', 'date'],
            'to' => ['nullable', 'date'],
            'per_page' => ['nullable', 'integer', 'min:1'],
        ]);

        $employeeId = $request->user()->employee->id;

        $query = WorkSummary::query()
            ->where('employee_id', $employeeId)
            ->orderByDesc('submitted_at')
            ->orderByDesc('id');

        if (! empty($data['type'])) {
            $query->where('type', $data['type']);
        }

        $this->applyDateFilters($query, $data['from'] ?? null, $data['to'] ?? null, $data['type'] ?? null);

        $summaries = $query
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return WorkSummaryResource::collection($summaries);
    }

    /**
     * @return array<string, mixed>
     */
    private function validatePayload(Request $request, int $employeeId): array
    {
        $rules = [
            'type' => ['required', 'string', Rule::in(WorkSummary::TYPES)],
            'report_date' => ['nullable', 'date'],
            'week_start' => ['nullable', 'date'],
            'week_end' => ['nullable', 'date', 'after_or_equal:week_start'],
            'today_sales_amount' => ['nullable', 'numeric'],
            'remarks' => ['nullable', 'string'],
            'sections' => ['nullable', 'array'],
            'sections.products_discussion' => ['nullable', 'array', 'max:5'],
            'sections.office_visit' => ['nullable', 'array', 'max:5'],
            'sections.project_visit' => ['nullable', 'array', 'max:5'],
            'sections.business_meeting' => ['nullable', 'array', 'max:3'],
        ];

        if ($request->input('type') === WorkSummary::TYPE_DAILY) {
            $rules['report_date'] = [
                'required',
                'date',
                Rule::unique('work_summaries', 'report_date')
                    ->where('employee_id', $employeeId)
                    ->where('type', WorkSummary::TYPE_DAILY),
            ];
        }

        if ($request->input('type') === WorkSummary::TYPE_WEEKLY) {
            $rules['week_start'] = [
                'required',
                'date',
                Rule::unique('work_summaries', 'week_start')
                    ->where('employee_id', $employeeId)
                    ->where('type', WorkSummary::TYPE_WEEKLY),
            ];
            $rules['week_end'] = ['required', 'date', 'after_or_equal:week_start'];
        }

        return $request->validate($rules);
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
