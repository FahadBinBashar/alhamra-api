<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreProductRequest extends FormRequest
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
            'category_id' => ['required', 'integer', 'exists:categories,id'],
            'name' => ['required', 'string', 'max:255'],
            'product_type' => ['required', 'in:small,big,land,share,other'],
            'price' => ['nullable', 'numeric', 'min:0'],
            'ccu_percentage' => ['sometimes', 'numeric', 'min:0', 'max:100'],
            'attributes' => ['nullable', 'array'],
            'stock_qty' => ['sometimes', 'numeric', 'min:0'],
            'min_stock_alert' => ['sometimes', 'numeric', 'min:0'],
            'is_stock_managed' => ['sometimes', 'boolean'],
        ];
    }
}
