<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Product
 */
class ProductResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'category_id' => $this->category_id,
            'category' => new CategoryResource($this->whenLoaded('category')),
            'name' => $this->name,
            'product_type' => $this->product_type,
            'price' => $this->price,
            'attributes' => $this->getAttribute('attributes') ?? [],
            'stock_qty' => $this->stock_qty,
            'min_stock_alert' => $this->min_stock_alert,
            'is_stock_managed' => $this->is_stock_managed,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
