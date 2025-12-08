<?php

namespace App\Http\Controllers;

use App\Models\PdSpecialBonus;
use App\Services\PdSpecialBonusService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class PdSpecialBonusController extends Controller
{
    public function __construct(private PdSpecialBonusService $service)
    {
    }

    public function select(Request $request): JsonResponse
    {
        if ($request->has('selections')) {
            $validated = $request->validate([
                'selections' => ['required', 'array', 'min:1'],
                'selections.*.employee_id' => ['required', 'integer', 'exists:employees,id'],
                'selections.*.percentage' => ['sometimes', 'numeric', 'min:0'],
                'selections.*.month' => ['required', 'date_format:Y-m'],
                'selections.*.meta' => ['sometimes', 'array'],
            ]);

            $selectedBy = (int) $request->user()->id;

            $selections = collect($validated['selections'])->map(fn (array $selection) => $this->service->select(
                (int) $selection['employee_id'],
                $selection['month'],
                isset($selection['percentage']) ? (float) $selection['percentage'] : 4.0,
                $selectedBy,
                $selection['meta'] ?? []
            ));

            return response()->json(['data' => $selections]);
        }

        $validated = $request->validate([
            'employee_id' => ['required', 'integer', 'exists:employees,id'],
            'percentage' => ['sometimes', 'numeric', 'min:0'],
            'month' => ['required', 'date_format:Y-m'],
            'meta' => ['sometimes', 'array'],
        ]);

        $percentage = isset($validated['percentage']) ? (float) $validated['percentage'] : 4.0;

        $selection = $this->service->select(
            (int) $validated['employee_id'],
            $validated['month'],
            $percentage,
            (int) $request->user()->id,
            $validated['meta'] ?? []
        );

        return response()->json(['data' => $selection]);
    }

    public function calculate(Request $request): JsonResponse
    {
        $month = $this->validatedMonth($request);

        $bonuses = $this->service->calculate($month);

        return response()->json(['data' => $bonuses]);
    }

    public function process(Request $request): JsonResponse
    {
        $month = $this->validatedMonth($request);

        $bonuses = $this->service->process($month);

        return response()->json(['data' => $bonuses]);
    }

    public function monthBonuses(Request $request): JsonResponse
    {
        $month = $this->validatedMonth($request);

        $bonuses = $this->service->monthBonuses($month);

        return response()->json([
            'data' => $bonuses->map(fn (PdSpecialBonus $bonus) => [
                'employee_id' => $bonus->employee_id,
                'period' => $bonus->month,
                'total_dp' => (float) $bonus->total_dp,
                'percentage' => (float) $bonus->percentage,
                'amount' => (float) $bonus->amount,
                'status' => $bonus->status,
                'processed_at' => $bonus->processed_at,
                'meta' => $bonus->meta,
            ])->values(),
        ]);
    }

    public function employeeBonus(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'employee_id' => ['required', 'integer', 'exists:employees,id'],
            'month' => ['sometimes', 'date_format:Y-m'],
        ]);

        $month = $validated['month'] ?? now()->format('Y-m');

        /** @var PdSpecialBonus|null $bonus */
        $bonus = $this->service->employeeBonus((int) $validated['employee_id'], $month);

        if (! $bonus) {
            return response()->json(['data' => null]);
        }

        return response()->json([
            'data' => [
                'period' => $bonus->month,
                'total_dp' => (float) $bonus->total_dp,
                'percentage' => (float) $bonus->percentage,
                'amount' => (float) $bonus->amount,
                'status' => $bonus->status,
                'processed_at' => $bonus->processed_at,
                'meta' => $bonus->meta,
            ],
        ]);
    }

    protected function validatedMonth(Request $request): string
    {
        $validated = $request->validate([
            'month' => ['required', 'date_format:Y-m'],
        ]);

        return $validated['month'];
    }
}
