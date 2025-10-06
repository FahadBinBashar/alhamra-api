<?php

namespace App\Http\Controllers;

use App\Models\Document;
use Illuminate\Http\Request;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Auth;

class DocumentController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'file' => ['required', 'file', 'max:10240'],
            'category' => ['required', 'string'],
            'documentable_type' => ['required', 'string'],
            'documentable_id' => ['required', 'integer'],
            'disk' => ['nullable', 'string'],
        ]);

        /** @var UploadedFile $file */
        $file = $validated['file'];
        $disk = $validated['disk'] ?? config('filesystems.default');
        $path = $file->store('documents/' . $validated['category'], $disk);

        $document = Document::create([
            'documentable_type' => $validated['documentable_type'],
            'documentable_id' => $validated['documentable_id'],
            'category' => $validated['category'],
            'disk' => $disk,
            'path' => $path,
            'original_name' => $file->getClientOriginalName(),
            'mime_type' => $file->getClientMimeType(),
            'size' => $file->getSize(),
            'uploaded_by' => Auth::id(),
        ]);

        return response()->json([
            'data' => $document,
        ], 201);
    }
}
