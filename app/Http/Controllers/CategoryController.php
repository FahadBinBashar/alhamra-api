<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreCategoryRequest;
use App\Http\Requests\UpdateCategoryRequest;
use App\Http\Resources\CategoryResource;
use App\Models\Category;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $query = Category::query()->withCount(['products', 'services']);

        if ($request->filled('type')) {
            $query->where('type', $request->string('type'));
        }

        $categories = $query->paginate($request->integer('per_page', 15))->appends($request->query());

        return CategoryResource::collection($categories);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreCategoryRequest $request): CategoryResource
    {
        $category = Category::create($request->validated());

        return new CategoryResource($category);
    }

    /**
     * Display the specified resource.
     */
    public function show(Category $category): CategoryResource
    {
        $category->loadCount(['products', 'services']);

        return new CategoryResource($category);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateCategoryRequest $request, Category $category): CategoryResource
    {
        $category->update($request->validated());
        $category->loadCount(['products', 'services']);

        return new CategoryResource($category);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Category $category): JsonResponse
    {
        if ($category->products()->exists() || $category->services()->exists()) {
            return response()->json([
                'message' => 'Category cannot be deleted while products or services are attached.',
            ], 422);
        }

        $category->delete();

        return response()->json(null, 204);
    }
}
