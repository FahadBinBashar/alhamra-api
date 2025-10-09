<?php

namespace App\Http\Controllers;

use App\Models\RankRequirement;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class RankRequirementController extends Controller
{
    public function index()
    {
        $requirements = RankRequirement::orderBy('sequence')->get();

        return response()->json([
            'data' => $requirements,
        ]);
    }

    public function store(Request $request)
    {
        $data = $this->validateData($request);

        $requirement = RankRequirement::create($data);

        return response()->json([
            'data' => $requirement,
        ], 201);
    }

    public function show(RankRequirement $rankRequirement)
    {
        return response()->json([
            'data' => $rankRequirement,
        ]);
    }

    public function update(Request $request, RankRequirement $rankRequirement)
    {
        $data = $this->validateData($request, $rankRequirement->id);

        $rankRequirement->fill($data);
        $rankRequirement->save();

        return response()->json([
            'data' => $rankRequirement,
        ]);
    }

    public function destroy(RankRequirement $rankRequirement)
    {
        $rankRequirement->delete();

        return response()->noContent();
    }

    protected function validateData(Request $request, ?int $ignoreId = null): array
    {
        return $request->validate([
            'rank' => ['required', 'string', Rule::exists('ranks', 'code'), Rule::unique('rank_requirements', 'rank')->ignore($ignoreId)],
            'sequence' => ['required', 'integer', 'min:0'],
            'personal_sales_target' => ['required', 'numeric', 'min:0'],
            'bonus_down_payment' => ['required', 'numeric', 'min:0'],
            'bonus_installment' => ['required', 'numeric', 'min:0'],
            'direct_required' => ['required', 'integer', 'min:0'],
            'meta' => ['nullable', 'array'],
        ]);
    }
}
