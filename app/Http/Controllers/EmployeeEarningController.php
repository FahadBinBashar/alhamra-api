<?php

namespace App\Http\Controllers;

use App\Models\DirectorFund;
use App\Models\Employee;
use App\Models\MonthlyIncentive;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class EmployeeEarningController extends Controller
{
    public function incentives(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'employee_id' => ['required', 'integer', 'exists:employees,id'],
        ]);

        $incentives = MonthlyIncentive::query()
            ->where('employee_id', $validated['employee_id'])
            ->orderByDesc('period_start')
            ->get();

        $subordinateMap = $this->loadSubordinateNames($incentives->pluck('meta')->map(fn ($meta) => array_keys($meta['subordinate_steps'] ?? []))->flatten()->unique()->values());

        $data = $incentives->map(function (MonthlyIncentive $incentive) use ($subordinateMap) {
            $meta = $incentive->meta ?? [];
            $subordinateSteps = $meta['subordinate_steps'] ?? [];
            $subordinates = [];

            foreach ($subordinateSteps as $id => $step) {
                $subordinates[] = [
                    'id' => (int) $id,
                    'name' => $subordinateMap[$id] ?? null,
                    'step' => (int) $step,
                ];
            }

            return [
                'period_start' => $incentive->period_start,
                'period_end' => $incentive->period_end,
                'status' => $incentive->status,
                'amount' => (float) $incentive->amount,
                'type' => 'monthly',
                'ccu_base_sales' => (float) $incentive->total_commissionable_sales,
                'subordinate_breakdown' => [
                    'max_levels' => $meta['max_levels'] ?? null,
                    'step_counts' => $meta['step_counts'] ?? [],
                    'step_sales' => $meta['step_sales'] ?? [],
                    'subordinates' => $subordinates,
                ],
                'paid_at' => $incentive->processed_at,
            ];
        });

        return response()->json(['data' => $data]);
    }

    public function directorFunds(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'employee_id' => ['required', 'integer', 'exists:employees,id'],
        ]);

        $funds = DirectorFund::query()
            ->where('employee_id', $validated['employee_id'])
            ->orderByDesc('period_start')
            ->get();

        $data = $funds->map(function (DirectorFund $fund) {
            $meta = $fund->meta ?? [];
            $type = $meta['frequency'] ?? match ($fund->type) {
                DirectorFund::TYPE_AMD => 'quarterly',
                DirectorFund::TYPE_DMD => 'yearly',
                default => 'monthly',
            };

            return [
                'period_start' => $fund->period_start,
                'period_end' => $fund->period_end,
                'status' => $fund->status,
                'amount' => (float) $fund->per_person_amount,
                'type' => $type,
                'ccu_base_sales' => isset($meta['total_sales']) ? (float) $meta['total_sales'] : null,
                'paid_at' => $fund->processed_at,
            ];
        });

        return response()->json(['data' => $data]);
    }

    protected function loadSubordinateNames($ids): array
    {
        $idList = collect($ids)->filter()->map(fn ($id) => (int) $id)->unique()->values();

        if ($idList->isEmpty()) {
            return [];
        }

        return Employee::query()
            ->whereIn('id', $idList)
            ->with('user')
            ->get()
            ->mapWithKeys(fn (Employee $employee) => [
                $employee->id => $employee->user?->name ?? $employee->full_name_en,
            ])->toArray();
    }
}
