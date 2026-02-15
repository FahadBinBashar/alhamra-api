<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Product extends Model
{
    use HasFactory;

    /**
     * @var array<int, string>
     */
    protected $fillable = [
        'category_id',
        'name',
        'supplier_id',
        'supplier_percentage',
        'product_type',
        'price',
        'description',
        'down_payment',
        'ccu_percentage',
        'attributes',
        'image_path',
        'image_paths',
        'image_disk',
        'stock_qty',
        'min_stock_alert',
        'is_stock_managed',
    ];

    /**
     * @var array<string, string>
     */
    protected $casts = [
        'attributes' => 'array',
        'price' => 'decimal:2',
        'down_payment' => 'decimal:2',
        'ccu_percentage' => 'integer',
        'supplier_percentage' => 'integer',
        'image_paths' => 'array',
        'stock_qty' => 'decimal:2',
        'min_stock_alert' => 'decimal:2',
        'is_stock_managed' => 'boolean',
    ];

    /**
     * The category the product belongs to.
     */
    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function supplier(): BelongsTo
    {
        return $this->belongsTo(Supplier::class);
    }

    public function stockMovements(): HasMany
    {
        return $this->hasMany(StockMovement::class);
    }

    public function emiRules(): HasMany
    {
        return $this->hasMany(ProductEmiRule::class);
    }
}
