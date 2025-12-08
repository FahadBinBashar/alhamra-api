<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PdSpecialBonus extends Model
{
    use HasFactory;

    public const STATUS_DRAFT = 'draft';
    public const STATUS_PAID = 'paid';

    protected $fillable = [
        'employee_id',
        'month',
        'total_dp',
        'percentage',
        'amount',
        'status',
        'processed_at',
        'meta',
    ];

    protected $casts = [
        'total_dp' => 'decimal:2',
        'percentage' => 'decimal:2',
        'amount' => 'decimal:2',
        'processed_at' => 'datetime',
        'meta' => 'array',
    ];

    public function employee(): BelongsTo
    {
        return $this->belongsTo(Employee::class);
    }
}
