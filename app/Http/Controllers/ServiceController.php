<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Requests\StoreServiceRequest;
use App\Http\Requests\UpdateServiceRequest;
use App\Http\Resources\ServiceResource;
use App\Models\Service;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class ServiceController extends Controller
{
    use ResolvesIncludes;

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $includes = $this->resolveIncludes($request, ['category']);

        if (empty($includes)) {
            $includes = ['category'];
        }

        $query = Service::query()->with($includes);

        if ($request->filled('category_id')) {
            $query->where('category_id', $request->integer('category_id'));
        }

        $services = $query->paginate($request->integer('per_page', 15))->appends($request->query());

        return ServiceResource::collection($services);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreServiceRequest $request): ServiceResource
    {
        $service = Service::create($request->validated());

        $includes = $this->resolveIncludes($request, ['category']);

        if (empty($includes)) {
            $includes = ['category'];
        }

        $service->load($includes);

        return new ServiceResource($service);
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request, Service $service): ServiceResource
    {
        $includes = $this->resolveIncludes($request, ['category']);

        if (empty($includes)) {
            $includes = ['category'];
        }

        $service->load($includes);

        return new ServiceResource($service);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateServiceRequest $request, Service $service): ServiceResource
    {
        $service->update($request->validated());

        $includes = $this->resolveIncludes($request, ['category']);

        if (empty($includes)) {
            $includes = ['category'];
        }

        $service->load($includes);

        return new ServiceResource($service);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Service $service): JsonResponse
    {
        $service->delete();

        return response()->json(null, 204);
    }
}
