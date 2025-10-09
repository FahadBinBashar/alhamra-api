<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreRankRequest;
use App\Http\Requests\UpdateRankRequest;
use App\Http\Resources\RankResource;
use App\Models\Rank;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class RankController extends Controller
{
    public function index(Request $request): AnonymousResourceCollection
    {
        $query = Rank::query();

        if ($request->filled('search')) {
            $search = $request->string('search')->toString();

            $query->where(function ($query) use ($search) {
                $query->where('name', 'like', "%{$search}%")
                    ->orWhere('code', 'like', "%{$search}%");
            });
        }

        $ranks = $query
            ->orderBy('sort_order')
            ->orderBy('name')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return RankResource::collection($ranks);
    }

    public function store(StoreRankRequest $request): RankResource
    {
        $rank = Rank::create($request->validated());

        return new RankResource($rank);
    }

    public function show(Rank $rank): RankResource
    {
        return new RankResource($rank);
    }

    public function update(UpdateRankRequest $request, Rank $rank): RankResource
    {
        $rank->update($request->validated());

        return new RankResource($rank);
    }

    public function destroy(Rank $rank): JsonResponse
    {
        if ($rank->employees()->exists() || $rank->requirements()->exists() || $rank->memberships()->exists()) {
            return response()->json([
                'message' => 'Rank cannot be deleted while it is in use.',
            ], 422);
        }

        $rank->delete();

        return response()->json(null, 204);
    }
}
