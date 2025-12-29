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
    public function toArray(Request $request): array
    {
        // Your site base includes /alhamra-backend/public
        // So Storage::disk('public')->url(...) alone will produce /storage/...
        // We prepend the base path so the final URL becomes:
        // https://alhamarahomesbd.com/alhamra-backend/public/storage/...
        $base = rtrim(config('app.url'), '/') . '/public';

        $imageUrl = $this->resolveImageUrl($base, $this->image_disk, $this->image_path);

        $imageUrls = $this->productImages
            ->map(fn ($image) => $this->resolveImageUrl($base, $image->image_disk, $image->image_path))
            ->filter()
            ->values()
            ->all();

        if (empty($imageUrls) && $imageUrl) {
            $imageUrls = [$imageUrl];
        }

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
            'description' => $this->description,
            'down_payment' => $this->down_payment,
            'ccu_percentage' => $this->ccu_percentage,
            'attributes' => $this->getAttribute('attributes') ?? [],
            'image_path' => $this->image_path,
            'image_disk' => $this->image_disk,
            'image_url' => $imageUrl,
            'image_urls' => $imageUrls,
            'stock_qty' => $this->stock_qty,
            'min_stock_alert' => $this->min_stock_alert,
            'is_stock_managed' => $this->is_stock_managed,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }

    private function resolveImageUrl(string $base, ?string $disk, ?string $path): ?string
    {
        if (!$disk || !$path) {
            return null;
        }

        $diskUrl = Storage::disk($disk)->url($path); // e.g. /storage/products/images/xxx.jpg

        if (str_starts_with($diskUrl, 'http://') || str_starts_with($diskUrl, 'https://')) {
            return $diskUrl;
        }

        return $base . $diskUrl; // base + /storage/...
    }
}
