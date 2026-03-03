<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class EmployeeWalletTransaction extends Model
{
    use HasFactory;

    public const TYPE_PROMOTION_REWARD = 'promotion_reward';

    protected $fillable = [
        'employee_wallet_id',
        'employee_id',
        'type',
        'amount',
        'currency',
        'reference_type',
        'reference_id',
        'narration',
        'meta',
    ];

    protected $casts = [
        'amount' => 'decimal:2',
        'meta' => 'array',
    ];

    public function wallet(): BelongsTo
    {
        return $this->belongsTo(EmployeeWallet::class, 'employee_wallet_id');
    }

    public function employee(): BelongsTo
    {
        return $this->belongsTo(Employee::class, 'employee_id');
    }
}
