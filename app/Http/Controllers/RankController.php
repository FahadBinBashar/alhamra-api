<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreRankRequest;
use App\Http\Requests\UpdateRankRequest;
use App\Http\Resources\RankResource;
use App\Models\Rank;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Http\Response;

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

        if ($request->filled('code')) {
            $query->where('code', $request->string('code')->upper()->toString());
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
        $data = $request->validated();
        $data['code'] = strtoupper($data['code']);

        if (! array_key_exists('sort_order', $data) || $data['sort_order'] === null) {
            $data['sort_order'] = (int) Rank::max('sort_order') + 1;
        }

        $rank = Rank::create($data);

        return new RankResource($rank->fresh());
    }

    public function show(Rank $rank): RankResource
    {
        return new RankResource($rank);
    }

    public function update(UpdateRankRequest $request, Rank $rank): RankResource
    {
        $data = $request->validated();

        if (array_key_exists('code', $data)) {
            $data['code'] = strtoupper($data['code']);
        }

        $rank->update($data);

        return new RankResource($rank->fresh());
    }

    public function destroy(Rank $rank): Response
    {
        $rank->loadCount(['employees', 'requirements', 'memberships']);

        if ($rank->employees_count > 0 || $rank->requirements_count > 0 || $rank->memberships_count > 0) {
            return response()->json([
                'message' => 'Rank cannot be deleted while it is in use.',
            ], 422);
        }

        $rank->delete();

        return response()->noContent();
    }
}
