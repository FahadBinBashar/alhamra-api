<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateServiceRequest extends FormRequest
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
            'category_id' => ['sometimes', 'required', 'integer', 'exists:categories,id'],
            'name' => ['sometimes', 'required', 'string', 'max:255'],
            'price' => ['sometimes', 'nullable', 'numeric', 'min:0'],
            'commission_percentage' => ['sometimes', 'nullable', 'numeric', 'min:0', 'max:100'],
            'attributes' => ['sometimes', 'nullable', 'array'],
        ];
    }
}
