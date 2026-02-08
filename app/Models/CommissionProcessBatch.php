<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use App\Models\User;

class CommissionProcessBatch extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'period_type',
        'cutoff_date',
        'month',
        'processed_units',
        'processed_items',
        'total_amount',
        'processed_by',
        'processed_at',
        'meta',
    ];

    protected $casts = [
        'cutoff_date' => 'date',
        'processed_at' => 'datetime',
        'total_amount' => 'decimal:2',
        'meta' => 'array',
    ];

    public function processor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'processed_by');
    }
}
