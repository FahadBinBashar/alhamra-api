<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PromotionAward extends Model
{
    use HasFactory;

    public const STATUS_GENERATED = 'generated';
    public const STATUS_PROCESSED = 'processed';

    public const STATUSES = [
        self::STATUS_GENERATED,
        self::STATUS_PROCESSED,
    ];

    protected $fillable = [
        'session_id',
        'rule_id',
        'employee_id',
        'award_status',
        'generated_by',
        'generated_at',
        'processed_by',
        'processed_at',
        'wallet_transaction_id',
        'remarks',
    ];

    protected $casts = [
        'generated_at' => 'datetime',
        'processed_at' => 'datetime',
    ];

    public function session(): BelongsTo
    {
        return $this->belongsTo(PromotionSession::class, 'session_id');
    }

    public function rule(): BelongsTo
    {
        return $this->belongsTo(PromotionRule::class, 'rule_id');
    }

    public function employee(): BelongsTo
    {
        return $this->belongsTo(Employee::class, 'employee_id');
    }

    public function walletTransaction(): BelongsTo
    {
        return $this->belongsTo(EmployeeWalletTransaction::class, 'wallet_transaction_id');
    }
}
