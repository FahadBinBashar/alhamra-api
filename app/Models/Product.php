<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Product extends Model
{
    use HasFactory;

    /**
     * @var array<int, string>
     */
    protected $fillable = [
        'category_id',
        'name',
        'product_type',
        'price',
        'attributes',
    ];

    /**
     * @var array<string, string>
     */
    protected $casts = [
        'attributes' => 'array',
        'price' => 'decimal:2',
    ];

    /**
     * The category the product belongs to.
     */
    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }
}
