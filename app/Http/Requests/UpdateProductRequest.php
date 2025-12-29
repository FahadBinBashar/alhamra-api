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
            'supplier_id' => ['sometimes', 'nullable', 'integer', 'exists:suppliers,id'],
            'supplier_percentage' => ['sometimes', 'nullable', 'numeric', 'min:0', 'max:100'],
            'product_type' => ['sometimes', 'required', 'in:consumer,flat,land,share,other'],
            'price' => ['sometimes', 'nullable', 'numeric', 'min:0'],
            'description' => ['sometimes', 'nullable', 'string'],
            'down_payment' => ['sometimes', 'nullable', 'numeric', 'min:0'],
            'ccu_percentage' => ['sometimes', 'numeric', 'min:0', 'max:100'],
            'attributes' => ['sometimes', 'nullable', 'array'],
            'image' => ['sometimes', 'nullable', 'image', 'max:10240'],
            'images' => ['sometimes', 'nullable', 'array', 'max:10'],
            'images.*' => ['image', 'max:10240'],
            'stock_qty' => ['sometimes', 'numeric', 'min:0'],
            'min_stock_alert' => ['sometimes', 'numeric', 'min:0'],
            'is_stock_managed' => ['sometimes', 'boolean'],
        ];
    }
}
