<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreBlogPostRequest;
use App\Http\Requests\UpdateBlogPostRequest;
use App\Http\Resources\BlogPostResource;
use App\Models\BlogPost;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\Storage;

class BlogPostController extends Controller
{
    public function index(Request $request): AnonymousResourceCollection
    {
        $posts = BlogPost::query()
            ->latest()
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return BlogPostResource::collection($posts);
    }

    public function store(StoreBlogPostRequest $request): BlogPostResource
    {
        $data = $request->validated();
        $disk = 'public';
        $path = $request->file('image')->store('blogs/images', $disk);

        $post = BlogPost::create([
            'title' => $data['title'],
            'description' => $data['description'],
            'image_path' => $path,
            'image_disk' => $disk,
        ]);

        return new BlogPostResource($post);
    }

    public function show(BlogPost $blog): BlogPostResource
    {
        return new BlogPostResource($blog);
    }

    public function update(UpdateBlogPostRequest $request, BlogPost $blog): BlogPostResource
    {
        $data = $request->validated();

        if ($request->hasFile('image')) {
            if ($blog->image_path && $blog->image_disk) {
                Storage::disk($blog->image_disk)->delete($blog->image_path);
            }

            $disk = 'public';
            $data['image_path'] = $request->file('image')->store('blogs/images', $disk);
            $data['image_disk'] = $disk;
        }

        unset($data['image']);

        $blog->update($data);

        return new BlogPostResource($blog);
    }

    public function destroy(BlogPost $blog): JsonResponse
    {
        if ($blog->image_path && $blog->image_disk) {
            Storage::disk($blog->image_disk)->delete($blog->image_path);
        }

        $blog->delete();

        return response()->json(null, 204);
    }
}
