<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProductEmiPlan extends Model
{
    use HasFactory;

    protected $fillable = [
        'product_id',
        'tenure_months',
        'extra_type',
        'extra_value',
        'is_active',
        'meta',
    ];

    protected $casts = [
        'extra_value' => 'decimal:2',
        'is_active' => 'boolean',
        'meta' => 'array',
    ];

    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }
}
