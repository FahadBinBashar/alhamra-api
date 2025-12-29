<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Requests\StoreProductRequest;
use App\Http\Requests\UpdateProductRequest;
use App\Http\Resources\ProductResource;
use App\Models\Product;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    use ResolvesIncludes;

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $includes = $this->resolveIncludes($request, ['category', 'supplier']);

        if (empty($includes)) {
            $includes = ['category'];
        }

        $query = Product::query()->with($includes);

        if ($request->filled('category_id')) {
            $query->where('category_id', $request->integer('category_id'));
        }

        if ($request->filled('product_type')) {
            $query->where('product_type', $request->string('product_type'));
        }

        $products = $query->paginate($request->integer('per_page', 15))->appends($request->query());

        return ProductResource::collection($products);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreProductRequest $request): ProductResource
    {
        $product = Product::create($request->validated());

        if ($request->file('image')) {
            $disk = config('filesystems.default');
            $path = $request->file('image')->store('products/images', $disk);
            $product->forceFill([
                'image_path' => $path,
                'image_disk' => $disk,
            ])->save();
        }

        $includes = $this->resolveIncludes($request, ['category', 'supplier']);

        if (empty($includes)) {
            $includes = ['category'];
        }

        $product->load($includes);

        return new ProductResource($product);
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request, Product $product): ProductResource
    {
        $includes = $this->resolveIncludes($request, ['category', 'supplier']);

        if (empty($includes)) {
            $includes = ['category'];
        }

        $product->load($includes);

        return new ProductResource($product);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateProductRequest $request, Product $product): ProductResource
    {
        $product->update($request->validated());

        if ($request->file('image')) {
            if ($product->image_path && $product->image_disk) {
                Storage::disk($product->image_disk)->delete($product->image_path);
            }

            $disk = config('filesystems.default');
            $path = $request->file('image')->store('products/images', $disk);
            $product->forceFill([
                'image_path' => $path,
                'image_disk' => $disk,
            ])->save();
        }

        $includes = $this->resolveIncludes($request, ['category', 'supplier']);

        if (empty($includes)) {
            $includes = ['category'];
        }

        $product->load($includes);

        return new ProductResource($product);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Product $product): JsonResponse
    {
        if ($product->image_path && $product->image_disk) {
            Storage::disk($product->image_disk)->delete($product->image_path);
        }

        $product->delete();

        return response()->json(null, 204);
    }
}
