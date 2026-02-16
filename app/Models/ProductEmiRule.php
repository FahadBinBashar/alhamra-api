<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProductEmiRule extends Model
{
    use HasFactory;

    protected $fillable = [
        'product_id',
        'tenure_months',
        'rule_month',
        'rule_type',
        'percent',
        'flat_amount',
        'is_active',
        'meta',
    ];

    protected $casts = [
        'percent' => 'decimal:3',
        'flat_amount' => 'decimal:2',
        'is_active' => 'boolean',
        'meta' => 'array',
    ];

    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }
}
