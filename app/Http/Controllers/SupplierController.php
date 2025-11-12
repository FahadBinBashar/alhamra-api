<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Requests\StoreSupplierRequest;
use App\Http\Requests\UpdateSupplierRequest;
use App\Http\Resources\SupplierResource;
use App\Models\Supplier;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class SupplierController extends Controller
{
    use ResolvesIncludes;

    public function index(Request $request): AnonymousResourceCollection
    {
        $includes = $this->resolveIncludes($request, ['products']);

        $query = Supplier::query()->with($includes);

        if ($request->filled('search')) {
            $search = trim((string) $request->query('search'));
            $query->where(function ($builder) use ($search) {
                $builder->where('name', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%")
                    ->orWhere('phone', 'like', "%{$search}%");
            });
        }

        $suppliers = $query->paginate($request->integer('per_page', 15))->appends($request->query());

        return SupplierResource::collection($suppliers);
    }

    public function store(StoreSupplierRequest $request): SupplierResource
    {
        $supplier = Supplier::create($request->validated());

        $includes = $this->resolveIncludes($request, ['products']);
        $supplier->load($includes);

        return new SupplierResource($supplier);
    }

    public function show(Request $request, Supplier $supplier): SupplierResource
    {
        $includes = $this->resolveIncludes($request, ['products']);
        $supplier->load($includes);

        return new SupplierResource($supplier);
    }

    public function update(UpdateSupplierRequest $request, Supplier $supplier): SupplierResource
    {
        $supplier->update($request->validated());

        $includes = $this->resolveIncludes($request, ['products']);
        $supplier->load($includes);

        return new SupplierResource($supplier);
    }

    public function destroy(Supplier $supplier): JsonResponse
    {
        $supplier->delete();

        return response()->json(null, 204);
    }
}
