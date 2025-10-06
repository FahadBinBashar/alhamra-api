<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateProductRequest extends FormRequest
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
            'product_type' => ['sometimes', 'required', 'in:small,big,land,share,other'],
            'price' => ['sometimes', 'nullable', 'numeric', 'min:0'],
            'attributes' => ['sometimes', 'nullable', 'array'],
            'stock_qty' => ['sometimes', 'numeric', 'min:0'],
            'min_stock_alert' => ['sometimes', 'numeric', 'min:0'],
            'is_stock_managed' => ['sometimes', 'boolean'],
        ];
    }
}
