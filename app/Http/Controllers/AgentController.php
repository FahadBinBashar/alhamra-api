<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Requests\StoreAgentRequest;
use App\Http\Requests\UpdateAgentRequest;
use App\Http\Resources\AgentResource;
use App\Models\Agent;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class AgentController extends Controller
{
    use ResolvesIncludes;

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $allowedIncludes = ['user', 'branch', 'rankMemberships', 'activeRank'];
        $includes = $this->resolveIncludes($request, $allowedIncludes);

        if (empty($includes)) {
            $includes = ['user', 'branch'];
        }

        $query = Agent::query()->withCount(['salesOrders']);

        if (! empty($includes)) {
            $query->with($includes);
        }

        if ($request->filled('branch_id')) {
            $query->where('branch_id', $request->integer('branch_id'));
        }

        if ($request->filled('user_id')) {
            $query->where('user_id', $request->integer('user_id'));
        }

        if ($request->filled('search')) {
            $search = $request->string('search')->toString();

            $query->where(function ($query) use ($search) {
                $query->where('agent_code', 'like', "%{$search}%")
                    ->orWhereHas('user', function ($userQuery) use ($search) {
                        $userQuery->where('name', 'like', "%{$search}%")
                            ->orWhere('email', 'like', "%{$search}%");
                    });
            });
        }

        $agents = $query
            ->orderBy('agent_code')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return AgentResource::collection($agents);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreAgentRequest $request): AgentResource
    {
        $agent = Agent::create($request->validated());

        $agent->loadCount(['salesOrders']);

        $includes = $this->resolveIncludes($request, ['user', 'branch', 'rankMemberships', 'activeRank']);

        if (empty($includes)) {
            $includes = ['user', 'branch'];
        }

        if (! empty($includes)) {
            $agent->load($includes);
        }

        return new AgentResource($agent);
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request, Agent $agent): AgentResource
    {
        $agent->loadCount(['salesOrders']);

        $includes = $this->resolveIncludes($request, ['user', 'branch', 'rankMemberships', 'activeRank']);

        if (empty($includes)) {
            $includes = ['user', 'branch'];
        }

        if (! empty($includes)) {
            $agent->load($includes);
        }

        return new AgentResource($agent);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateAgentRequest $request, Agent $agent): AgentResource
    {
        $agent->update($request->validated());
        $agent->loadCount(['salesOrders']);

        $includes = $this->resolveIncludes($request, ['user', 'branch', 'rankMemberships', 'activeRank']);

        if (empty($includes)) {
            $includes = ['user', 'branch'];
        }

        if (! empty($includes)) {
            $agent->load($includes);
        }

        return new AgentResource($agent);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Agent $agent): JsonResponse
    {
        if ($agent->salesOrders()->exists()) {
            return response()->json([
                'message' => 'Agent cannot be deleted while sales orders are attached.',
            ], 422);
        }

        $agent->delete();

        return response()->json(null, 204);
    }
}
