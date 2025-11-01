<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class CommissionCalculationUnit extends Model
{
    use HasFactory;

    protected $fillable = [
        'payment_id',
        'sales_order_id',
        'status',
        'calculated_at',
        'processed_at',
        'meta',
    ];

    protected $casts = [
        'calculated_at' => 'datetime',
        'processed_at' => 'datetime',
        'meta' => 'array',
    ];

    public function payment(): BelongsTo
    {
        return $this->belongsTo(Payment::class);
    }

    public function salesOrder(): BelongsTo
    {
        return $this->belongsTo(SalesOrder::class);
    }

    public function items(): HasMany
    {
        return $this->hasMany(CommissionCalculationItem::class);
    }
}
