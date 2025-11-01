<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class CommissionCalculationItem extends Model
{
    use HasFactory;

    protected $fillable = [
        'commission_calculation_unit_id',
        'recipient_type',
        'recipient_id',
        'amount',
        'percentage',
        'meta',
    ];

    protected $casts = [
        'amount' => 'decimal:2',
        'percentage' => 'decimal:3',
        'meta' => 'array',
    ];

    public function unit(): BelongsTo
    {
        return $this->belongsTo(CommissionCalculationUnit::class, 'commission_calculation_unit_id');
    }

    public function recipient(): MorphTo
    {
        return $this->morphTo(__FUNCTION__, 'recipient_type', 'recipient_id');
    }
}
