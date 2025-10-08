<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Requests\StoreBranchRequest;
use App\Http\Requests\UpdateBranchRequest;
use App\Http\Resources\BranchResource;
use App\Models\Branch;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class BranchController extends Controller
{
    use ResolvesIncludes;

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $includes = $this->resolveIncludes($request, ['agents']);

        $query = Branch::query()->withCount(['agents', 'salesOrders']);

        if (! empty($includes)) {
            $query->with($includes);
        }

        if ($request->filled('search')) {
            $search = $request->string('search')->toString();

            $query->where(function ($query) use ($search) {
                $query->where('name', 'like', "%{$search}%")
                    ->orWhere('code', 'like', "%{$search}%");
            });
        }

        $branches = $query
            ->orderBy('name')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return BranchResource::collection($branches);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreBranchRequest $request): BranchResource
    {
        $branch = Branch::create($request->validated());

        $branch->loadCount(['agents', 'salesOrders']);

        $includes = $this->resolveIncludes($request, ['agents']);

        if (! empty($includes)) {
            $branch->load($includes);
        }

        return new BranchResource($branch);
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request, Branch $branch): BranchResource
    {
        $branch->loadCount(['agents', 'salesOrders']);

        $includes = $this->resolveIncludes($request, ['agents']);

        if (! empty($includes)) {
            $branch->load($includes);
        }

        return new BranchResource($branch);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateBranchRequest $request, Branch $branch): BranchResource
    {
        $branch->update($request->validated());
        $branch->loadCount(['agents', 'salesOrders']);

        $includes = $this->resolveIncludes($request, ['agents']);

        if (! empty($includes)) {
            $branch->load($includes);
        }

        return new BranchResource($branch);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Branch $branch): JsonResponse
    {
        if ($branch->agents()->exists() || $branch->salesOrders()->exists()) {
            return response()->json([
                'message' => 'Branch cannot be deleted while agents or sales orders are attached.',
            ], 422);
        }

        $branch->delete();

        return response()->json(null, 204);
    }
}
