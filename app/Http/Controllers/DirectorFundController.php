<?php

namespace App\Http\Controllers;

use App\Http\Resources\DirectorFundResource;
use App\Models\DirectorFund;
use App\Services\DirectorFundService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Validation\Rule;

class DirectorFundController extends Controller
{
    public function __construct(private DirectorFundService $directorFundService)
    {
    }

    public function index(Request $request): AnonymousResourceCollection
    {
        $validated = $request->validate([
            'type' => ['sometimes', Rule::in([DirectorFund::TYPE_ED, DirectorFund::TYPE_AMD, DirectorFund::TYPE_DMD])],
            'employee_id' => ['sometimes', 'integer', 'exists:employees,id'],
            'status' => ['sometimes', Rule::in([DirectorFund::STATUS_DRAFT, DirectorFund::STATUS_PAID])],
            'per_page' => ['sometimes', 'integer', 'min:1', 'max:100'],
        ]);

        $query = DirectorFund::query()
            ->with('employee.user')
            ->orderByDesc('period_start');

        if (isset($validated['type'])) {
            $query->where('type', $validated['type']);
        }

        if (isset($validated['employee_id'])) {
            $query->where('employee_id', $validated['employee_id']);
        }

        if (isset($validated['status'])) {
            $query->where('status', $validated['status']);
        }

        $funds = $query
            ->paginate($validated['per_page'] ?? 15)
            ->appends($request->query());

        return DirectorFundResource::collection($funds);
    }

    public function calculate(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'type' => ['required', Rule::in([DirectorFund::TYPE_ED, DirectorFund::TYPE_AMD, DirectorFund::TYPE_DMD])],
            'month' => ['sometimes', 'date_format:Y-m'],
        ]);

        $funds = $this->directorFundService->calculate($validated['type'], $validated['month'] ?? null);

        return response()->json([
            'generated' => $funds->count(),
            'total_fund' => (float) $funds->sum('per_person_amount'),
            'type' => $validated['type'],
            'month' => $validated['month'] ?? null,
        ]);
    }

    public function process(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'type' => ['required', Rule::in([DirectorFund::TYPE_ED, DirectorFund::TYPE_AMD, DirectorFund::TYPE_DMD])],
            'month' => ['sometimes', 'date_format:Y-m'],
        ]);

        $funds = $this->directorFundService->process($validated['type'], $validated['month'] ?? null);

        return response()->json([
            'processed' => $funds->count(),
            'total_amount' => (float) $funds->sum('per_person_amount'),
            'type' => $validated['type'],
            'month' => $validated['month'] ?? null,
        ]);
    }
}
