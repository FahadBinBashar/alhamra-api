<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Requests\StoreProductRequest;
use App\Http\Requests\UpdateProductRequest;
use App\Http\Resources\ProductResource;
use App\Models\Product;
use App\Models\ProductEmiRule;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    use ResolvesIncludes;

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $includes = $this->resolveIncludes($request, ['category', 'supplier', 'emiRules']);

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

        $products = $query
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return ProductResource::collection($products);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreProductRequest $request): ProductResource
    {
        $data = $request->validated();
        $emiRules = $data['emi_rules'] ?? null;
        unset($data['emi_rules']);

        $product = DB::transaction(function () use ($data, $emiRules) {
            $product = Product::create($data);

            if (! empty($emiRules)) {
                $this->syncEmiRules($product, $emiRules);
            }

            return $product;
        });

        // Always store product images on PUBLIC disk so it becomes accessible via /storage after storage:link
        $uploadedImages = [];

        if ($request->hasFile('image')) {
            $uploadedImages[] = $request->file('image');
        }

        if ($request->hasFile('images')) {
            $uploadedImages = array_merge($uploadedImages, $request->file('images', []));
        }

        if ($uploadedImages !== []) {
            $disk = 'public';
            $paths = [];

            foreach ($uploadedImages as $uploadedImage) {
                $paths[] = $uploadedImage->store('products/images', $disk);
            }

            $product->forceFill([
                'image_path' => $paths[0] ?? null,
                'image_paths' => $paths,
                'image_disk' => $disk,
            ])->save();
        }

        $includes = $this->resolveIncludes($request, ['category', 'supplier', 'emiRules']);
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
        $includes = $this->resolveIncludes($request, ['category', 'supplier', 'emiRules']);
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
        $data = $request->validated();
        $emiRules = $data['emi_rules'] ?? null;
        unset($data['emi_rules']);

        DB::transaction(function () use ($product, $data, $emiRules) {
            $product->update($data);

            if ($emiRules !== null) {
                $this->syncEmiRules($product, $emiRules);
            }
        });

        $uploadedImages = [];

        if ($request->hasFile('image')) {
            $uploadedImages[] = $request->file('image');
        }

        if ($request->hasFile('images')) {
            $uploadedImages = array_merge($uploadedImages, $request->file('images', []));
        }

        if ($uploadedImages !== []) {
            $pathsToDelete = $product->image_paths ?? [];

            if (empty($pathsToDelete) && $product->image_path) {
                $pathsToDelete = [$product->image_path];
            }

            if ($product->image_disk) {
                foreach ($pathsToDelete as $pathToDelete) {
                    if ($pathToDelete) {
                        Storage::disk($product->image_disk)->delete($pathToDelete);
                    }
                }
            }

            // Always store new images on PUBLIC disk
            $disk = 'public';
            $paths = [];

            foreach ($uploadedImages as $uploadedImage) {
                $paths[] = $uploadedImage->store('products/images', $disk);
            }

            $product->forceFill([
                'image_path' => $paths[0] ?? null,
                'image_paths' => $paths,
                'image_disk' => $disk,
            ])->save();
        }

        $includes = $this->resolveIncludes($request, ['category', 'supplier', 'emiRules']);
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
        $pathsToDelete = $product->image_paths ?? [];

        if (empty($pathsToDelete) && $product->image_path) {
            $pathsToDelete = [$product->image_path];
        }

        if ($product->image_disk) {
            foreach ($pathsToDelete as $pathToDelete) {
                if ($pathToDelete) {
                    Storage::disk($product->image_disk)->delete($pathToDelete);
                }
            }
        }

        $product->delete();

        return response()->json(null, 204);
    }

    private function syncEmiRules(Product $product, array $emiRules): void
    {
        $now = now();

        foreach ($emiRules as $plan) {
            $tenureMonths = (int) ($plan['tenure_months'] ?? 0);
            $rules = $plan['rules'] ?? [];

            ProductEmiRule::query()
                ->where('product_id', $product->id)
                ->where('tenure_months', $tenureMonths)
                ->delete();

            $payload = [];

            foreach ($rules as $rule) {
                $payload[] = [
                    'product_id' => $product->id,
                    'tenure_months' => $tenureMonths,
                    'rule_month' => (int) $rule['month'],
                    'rule_type' => $rule['type'],
                    'percent' => $rule['type'] === 'percent' ? (float) $rule['percent'] : null,
                    'flat_amount' => $rule['type'] === 'flat' ? (float) $rule['flat_amount'] : null,
                    'is_active' => true,
                    'meta' => $rule['meta'] ?? null,
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }

            if ($payload !== []) {
                ProductEmiRule::insert($payload);
            }
        }
    }
}
