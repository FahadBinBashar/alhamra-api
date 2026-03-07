<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreGalleryRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        return [
            'title' => ['nullable', 'string', 'max:255'],
            'titles' => ['nullable', 'array'],
            'titles.*' => ['required_with:titles', 'string', 'max:255'],
            'image' => ['nullable', 'image', 'max:10240'],
            'images' => ['nullable', 'array', 'min:1'],
            'images.*' => ['image', 'max:10240'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator) {
            $singleImage = $this->file('image');
            $multipleImages = $this->file('images', []);
            $title = $this->input('title');
            $titles = $this->input('titles');

            if (! $singleImage && empty($multipleImages)) {
                $validator->errors()->add('image', 'Either image or images is required.');
            }

            if ($singleImage && ! $title) {
                $validator->errors()->add('title', 'Title is required when uploading a single image.');
            }

            if (! empty($multipleImages)) {
                if (! $title && ! is_array($titles)) {
                    $validator->errors()->add('title', 'Provide title or titles when uploading multiple images.');
                }

                if (is_array($titles) && count($titles) !== count($multipleImages)) {
                    $validator->errors()->add('titles', 'The titles count must match the images count.');
                }
            }
        });
    }
}
