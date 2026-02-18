<?php

namespace App\Http\Controllers;

use App\Http\Resources\MonthlyIncentiveResource;
use App\Models\Employee;
use App\Models\MonthlyIncentive;
use App\Services\MonthlyIncentiveService;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Validation\Rule;

class MonthlyIncentiveController extends Controller
{
    public function __construct(private MonthlyIncentiveService $monthlyIncentiveService)
    {
    }

    public function index(Request $request): AnonymousResourceCollection
    {
        $validated = $request->validate([
            'employee_id' => ['sometimes', 'integer', 'exists:employees,id'],
            'status' => ['sometimes', Rule::in(MonthlyIncentive::STATUSES)],
            'month' => ['sometimes', 'date_format:Y-m'],
            'week' => ['sometimes', 'date_format:Y-m-d'],
            'frequency' => ['sometimes', Rule::in(['monthly', 'weekly'])],
            'per_page' => ['sometimes', 'integer', 'min:1', 'max:100'],
        ]);

        $query = MonthlyIncentive::query()
            ->with(['employee.user', 'reviewer'])
            ->orderByDesc('period_start');

        if (isset($validated['employee_id'])) {
            $query->where('employee_id', $validated['employee_id']);
        }

        if (isset($validated['status'])) {
            $query->where('status', $validated['status']);
        }

        if (isset($validated['month'])) {
            $month = Carbon::createFromFormat('Y-m', $validated['month']);
            $query->whereDate('period_start', '>=', $month->copy()->startOfMonth())
                ->whereDate('period_start', '<=', $month->copy()->endOfMonth());
        }

        if (isset($validated['week'])) {
            $weekStart = Carbon::parse($validated['week'])->startOfWeek(Carbon::MONDAY);
            $query->whereDate('period_start', '>=', $weekStart)
                ->whereDate('period_start', '<=', $weekStart->copy()->endOfWeek(Carbon::SUNDAY));
        }

        if (isset($validated['frequency'])) {
            $frequency = $validated['frequency'];

            if ($frequency === 'monthly') {
                $query->where(function ($q) {
                    $q->whereNull('meta->frequency')
                        ->orWhere('meta->frequency', 'monthly');
                });
            } else {
                $query->where('meta->frequency', 'weekly');
            }
        }

        $incentives = $query
            ->paginate($validated['per_page'] ?? 15)
            ->appends($request->query());

        return MonthlyIncentiveResource::collection($incentives);
    }

    public function generate(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'month' => ['sometimes', 'date_format:Y-m'],
            'week' => ['sometimes', 'date_format:Y-m-d'],
            'frequency' => ['sometimes', Rule::in(['monthly', 'weekly'])],
        ]);

        $frequency = $validated['frequency'] ?? 'monthly';
        $month = $frequency === 'monthly' ? ($validated['month'] ?? null) : null;
        $week = $frequency === 'weekly' ? ($validated['week'] ?? null) : null;

        [$periodStart, $periodEnd] = $this->monthlyIncentiveService->resolvePeriod($month, $week, $frequency);

        $incentives = $this->monthlyIncentiveService->calculate($month, $frequency, $week);

        return response()->json([
            'generated' => $incentives->count(),
            'total_amount' => (float) $incentives->sum('amount'),
            'frequency' => $frequency,
            'period_start' => $periodStart->toDateString(),
            'period_end' => $periodEnd->toDateString(),
        ]);
    }

    public function process(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'month' => ['sometimes', 'date_format:Y-m'],
            'week' => ['sometimes', 'date_format:Y-m-d'],
            'frequency' => ['sometimes', Rule::in(['monthly', 'weekly'])],
        ]);

        $frequency = $validated['frequency'] ?? 'monthly';
        $month = $frequency === 'monthly' ? ($validated['month'] ?? null) : null;
        $week = $frequency === 'weekly' ? ($validated['week'] ?? null) : null;

        [$periodStart, $periodEnd] = $this->monthlyIncentiveService->resolvePeriod($month, $week, $frequency);
        $processed = $this->monthlyIncentiveService->process(
            $month,
            $frequency,
            $week,
            $request->user()?->id,
            true
        );

        return response()->json([
            'processed' => $processed->count(),
            'total_amount' => (float) $processed->sum('amount'),
            'frequency' => $frequency,
            'period_start' => $periodStart->toDateString(),
            'period_end' => $periodEnd->toDateString(),
        ]);
    }

    public function approve(Request $request, MonthlyIncentive $monthlyIncentive): MonthlyIncentiveResource|JsonResponse
    {
        $validated = $request->validate([
            'note' => ['sometimes', 'string', 'max:500'],
        ]);

        if ($monthlyIncentive->status === MonthlyIncentive::STATUS_PAID) {
            return response()->json([
                'message' => 'This incentive has already been paid and cannot be approved.',
            ], 422);
        }

        $monthlyIncentive->forceFill([
            'status' => MonthlyIncentive::STATUS_APPROVED,
            'reviewed_by' => $request->user()?->id,
            'reviewed_at' => now(),
            'review_note' => $validated['note'] ?? null,
        ])->save();

        return new MonthlyIncentiveResource($monthlyIncentive->fresh(['employee.user', 'reviewer']));
    }

    public function reject(Request $request, MonthlyIncentive $monthlyIncentive): MonthlyIncentiveResource|JsonResponse
    {
        $validated = $request->validate([
            'note' => ['sometimes', 'string', 'max:500'],
        ]);

        if ($monthlyIncentive->status === MonthlyIncentive::STATUS_PAID) {
            return response()->json([
                'message' => 'This incentive has already been paid and cannot be rejected.',
            ], 422);
        }

        $monthlyIncentive->forceFill([
            'status' => MonthlyIncentive::STATUS_REJECTED,
            'reviewed_by' => $request->user()?->id,
            'reviewed_at' => now(),
            'review_note' => $validated['note'] ?? null,
        ])->save();

        return new MonthlyIncentiveResource($monthlyIncentive->fresh(['employee.user', 'reviewer']));
    }

    public function employeeIncentives(Request $request): JsonResponse
    {
        $request->validate([
            'month' => ['sometimes', 'date_format:Y-m'],
            'week' => ['sometimes', 'date_format:Y-m-d'],
            'frequency' => ['sometimes', Rule::in(['monthly', 'weekly'])],
        ]);

        $employee = $request->user()?->employee;

        if (! $employee) {
            abort(404, 'Employee profile not found.');
        }

        $frequency = $request->get('frequency');
        $month = $frequency === 'weekly' ? null : $request->get('month');
        $week = $frequency === 'weekly' ? $request->get('week') : null;

        $incentive = MonthlyIncentive::where('employee_id', $employee->id)
            ->when($month, fn ($q) => $q->whereDate('period_start', Carbon::parse($month)->startOfMonth()))
            ->when($week, function ($q) use ($week) {
                $weekStart = Carbon::parse($week)->startOfWeek(Carbon::MONDAY);
                $q->whereDate('period_start', $weekStart);
            })
            ->when($frequency === 'monthly', function ($q) {
                $q->where(function ($inner) {
                    $inner->whereNull('meta->frequency')
                        ->orWhere('meta->frequency', 'monthly');
                });
            })
            ->when($frequency === 'weekly', fn ($q) => $q->where('meta->frequency', 'weekly'))
            ->with('employee')
            ->orderByDesc('period_start')
            ->firstOrFail();

        $meta = $incentive->meta ?? [];
        $subordinateSteps = $meta['subordinate_steps'] ?? [];
        $subordinates = [];

        if (! empty($subordinateSteps)) {
            $subordinateModels = Employee::query()
                ->select('id', 'name')
                ->whereIn('id', array_keys($subordinateSteps))
                ->get()
                ->keyBy('id');

            foreach ($subordinateSteps as $id => $step) {
                $employeeModel = $subordinateModels->get((int) $id);

                $subordinates[] = [
                    'id' => (int) $id,
                    'name' => $employeeModel?->name,
                    'step' => (int) $step,
                ];
            }
        }

        return response()->json([
            'employee_id' => $employee->id,
            'period_start' => $incentive->period_start,
            'period_end' => $incentive->period_end,
            'status' => $incentive->status,
            'incentive_rate' => $incentive->incentive_rate,
            'total_commissionable_sales' => $incentive->total_commissionable_sales,
            'amount' => $incentive->amount,
            'frequency' => $meta['frequency'] ?? 'monthly',
            'breakdown' => [
                'max_levels' => $meta['max_levels'] ?? null,
                'step_counts' => $meta['step_counts'] ?? [],
                'step_sales' => $meta['step_sales'] ?? [],
                'total_subordinates_counted' => $meta['subordinate_count'] ?? 0,
            ],
            'paid_at' => $incentive->processed_at,
            'subordinates' => $subordinates,
        ]);
    }
}
