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

        $imageUrls = [];

        $imagePaths = $this->image_paths ?? [];

        if (empty($imagePaths) && $this->image_path) {
            $imagePaths = [$this->image_path];
        }

        foreach ($imagePaths as $imagePath) {
            if (! $imagePath || ! $this->image_disk) {
                continue;
            }

            $diskUrl = Storage::disk($this->image_disk)->url($imagePath); // e.g. /storage/products/images/xxx.jpg

            // If disk url is already absolute (S3 etc.), keep it
            if (str_starts_with($diskUrl, 'http://') || str_starts_with($diskUrl, 'https://')) {
                $imageUrls[] = $diskUrl;
            } else {
                $imageUrls[] = $base . $diskUrl; // base + /storage/...
            }
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
            'image_paths' => $imagePaths,
            'image_disk' => $this->image_disk,
            'image_url' => $imageUrls,
            'stock_qty' => $this->stock_qty,
            'min_stock_alert' => $this->min_stock_alert,
            'is_stock_managed' => $this->is_stock_managed,
            'emi_rules' => $this->whenLoaded('emiRules', function () {
                return $this->emiRules
                    ->groupBy('tenure_months')
                    ->map(fn ($rules, $tenure) => [
                        'tenure_months' => (int) $tenure,
                        'rules' => $rules->sortBy('rule_month')->values()->map(fn ($rule) => [
                            'month' => (int) $rule->rule_month,
                            'type' => $rule->rule_type,
                            'percent' => $rule->percent,
                            'flat_amount' => $rule->flat_amount,
                            'is_active' => $rule->is_active,
                            'meta' => $rule->meta,
                        ]),
                    ])
                    ->values();
            }),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
