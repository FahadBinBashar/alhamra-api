<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Requests\StoreCommissionRuleRequest;
use App\Http\Requests\UpdateCommissionRuleRequest;
use App\Http\Resources\CommissionRuleResource;
use App\Models\CommissionRule;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class CommissionRuleController extends Controller
{
    use ResolvesIncludes;

    public function index(Request $request): AnonymousResourceCollection
    {
        $includes = $this->resolveIncludes($request, ['commissions']);

        $query = CommissionRule::query()->withCount('commissions');

        if (! empty($includes)) {
            $query->with($includes);
        }

        if ($request->filled('active')) {
            $active = filter_var($request->input('active'), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);
            if ($active !== null) {
                $query->where('active', $active);
            }
        }

        if ($request->filled('scope')) {
            $query->where('scope', $request->string('scope'));
        }

        if ($request->filled('trigger')) {
            $query->where('trigger', $request->string('trigger'));
        }

        if ($request->filled('search')) {
            $search = $request->string('search')->toString();
            $query->where('name', 'like', "%{$search}%");
        }

        $rules = $query
            ->orderBy('name')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return CommissionRuleResource::collection($rules);
    }

    public function store(StoreCommissionRuleRequest $request): CommissionRuleResource
    {
        $rule = CommissionRule::create($request->validated());

        $rule->loadCount('commissions');

        $includes = $this->resolveIncludes($request, ['commissions']);

        if (! empty($includes)) {
            $rule->load($includes);
        }

        return new CommissionRuleResource($rule);
    }

    public function show(Request $request, CommissionRule $commissionRule): CommissionRuleResource
    {
        $commissionRule->loadCount('commissions');

        $includes = $this->resolveIncludes($request, ['commissions']);

        if (! empty($includes)) {
            $commissionRule->load($includes);
        }

        return new CommissionRuleResource($commissionRule);
    }

    public function update(UpdateCommissionRuleRequest $request, CommissionRule $commissionRule): CommissionRuleResource
    {
        $commissionRule->update($request->validated());

        $commissionRule->loadCount('commissions');

        $includes = $this->resolveIncludes($request, ['commissions']);

        if (! empty($includes)) {
            $commissionRule->load($includes);
        }

        return new CommissionRuleResource($commissionRule);
    }

    public function destroy(CommissionRule $commissionRule): JsonResponse
    {
        if ($commissionRule->commissions()->exists()) {
            return response()->json([
                'message' => 'Commission rule cannot be deleted while commissions are attached.',
            ], 422);
        }

        $commissionRule->delete();

        return response()->json(null, 204);
    }
}
