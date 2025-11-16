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

        $incentives = $query
            ->paginate($validated['per_page'] ?? 15)
            ->appends($request->query());

        return MonthlyIncentiveResource::collection($incentives);
    }

    public function generate(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'month' => ['sometimes', 'date_format:Y-m'],
        ]);

        $targetMonth = $validated['month'] ?? now()->subMonthNoOverflow()->format('Y-m');
        $incentives = $this->monthlyIncentiveService->calculate($validated['month'] ?? null);

        return response()->json([
            'generated' => $incentives->count(),
            'total_amount' => (float) $incentives->sum('amount'),
            'month' => $targetMonth,
        ]);
    }

    public function process(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'month' => ['sometimes', 'date_format:Y-m'],
        ]);

        $targetMonth = $validated['month'] ?? now()->subMonthNoOverflow()->format('Y-m');
        $processed = $this->monthlyIncentiveService->process($validated['month'] ?? null);

        return response()->json([
            'processed' => $processed->count(),
            'total_amount' => (float) $processed->sum('amount'),
            'month' => $targetMonth,
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
        ]);

        $employee = $request->user()?->employee;

        if (! $employee) {
            abort(404, 'Employee profile not found.');
        }

        $month = $request->get('month');

        $incentive = MonthlyIncentive::where('employee_id', $employee->id)
            ->when($month, fn ($q) => $q->whereDate('period_start', Carbon::parse($month)->startOfMonth()))
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
