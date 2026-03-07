<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreGalleryRequest;
use App\Http\Requests\UpdateGalleryRequest;
use App\Http\Resources\GalleryResource;
use App\Models\Gallery;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\Storage;

class GalleryController extends Controller
{
    public function index(Request $request): AnonymousResourceCollection
    {
        $galleries = Gallery::query()
            ->latest()
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return GalleryResource::collection($galleries);
    }

    public function store(StoreGalleryRequest $request): AnonymousResourceCollection|GalleryResource
    {
        $disk = 'public';

        if ($request->hasFile('image')) {
            $item = Gallery::create([
                'title' => $request->string('title')->toString(),
                'image_path' => $request->file('image')->store('gallery/images', $disk),
                'image_disk' => $disk,
            ]);

            return new GalleryResource($item);
        }

        $images = $request->file('images', []);
        $globalTitle = $request->input('title');
        $titles = $request->input('titles', []);

        $created = [];

        foreach ($images as $index => $image) {
            $title = $titles[$index] ?? $globalTitle;

            $created[] = Gallery::create([
                'title' => $title,
                'image_path' => $image->store('gallery/images', $disk),
                'image_disk' => $disk,
            ]);
        }

        return GalleryResource::collection(collect($created));
    }

    public function show(Gallery $gallery): GalleryResource
    {
        return new GalleryResource($gallery);
    }

    public function update(UpdateGalleryRequest $request, Gallery $gallery): GalleryResource
    {
        $data = $request->validated();

        if ($request->hasFile('image')) {
            if ($gallery->image_path && $gallery->image_disk) {
                Storage::disk($gallery->image_disk)->delete($gallery->image_path);
            }

            $disk = 'public';
            $data['image_path'] = $request->file('image')->store('gallery/images', $disk);
            $data['image_disk'] = $disk;
        }

        unset($data['image']);

        $gallery->update($data);

        return new GalleryResource($gallery);
    }

    public function destroy(Gallery $gallery): JsonResponse
    {
        if ($gallery->image_path && $gallery->image_disk) {
            Storage::disk($gallery->image_disk)->delete($gallery->image_path);
        }

        $gallery->delete();

        return response()->json(null, 204);
    }
}
