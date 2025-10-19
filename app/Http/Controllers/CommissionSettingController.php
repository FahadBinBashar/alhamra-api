<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreCommissionSettingRequest;
use App\Http\Requests\UpdateCommissionSettingRequest;
use App\Http\Resources\CommissionSettingResource;
use App\Models\CommissionSetting;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class CommissionSettingController extends Controller
{
    public function index(Request $request): AnonymousResourceCollection
    {
        $query = CommissionSetting::query()->orderBy('key');

        if ($request->filled('search')) {
            $search = $request->string('search')->toString();
            $query->where('key', 'like', "%{$search}%");
        }

        $settings = $query
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return CommissionSettingResource::collection($settings);
    }

    public function store(StoreCommissionSettingRequest $request): CommissionSettingResource
    {
        $setting = CommissionSetting::create($request->validated());

        return new CommissionSettingResource($setting);
    }

    public function show(CommissionSetting $commissionSetting): CommissionSettingResource
    {
        return new CommissionSettingResource($commissionSetting);
    }

    public function update(UpdateCommissionSettingRequest $request, CommissionSetting $commissionSetting): CommissionSettingResource
    {
        $commissionSetting->update($request->validated());

        return new CommissionSettingResource($commissionSetting);
    }

    public function destroy(CommissionSetting $commissionSetting): JsonResponse
    {
        $commissionSetting->delete();

        return response()->json(null, 204);
    }
}
