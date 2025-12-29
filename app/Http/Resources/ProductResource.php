<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Storage;

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
            'supplier_id' => $this->supplier_id,
            'supplier_percentage' => $this->supplier_percentage,
            'supplier' => new SupplierResource($this->whenLoaded('supplier')),
            'product_type' => $this->product_type,
            'price' => $this->price,
            'down_payment' => $this->down_payment,
            'ccu_percentage' => $this->ccu_percentage,
            'attributes' => $this->getAttribute('attributes') ?? [],
            'image_path' => $this->image_path,
            'image_disk' => $this->image_disk,
            'image_url' => $this->image_path && $this->image_disk
                ? Storage::disk($this->image_disk)->url($this->image_path)
                : null,
            'stock_qty' => $this->stock_qty,
            'min_stock_alert' => $this->min_stock_alert,
            'is_stock_managed' => $this->is_stock_managed,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
