<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PromotionEligibility extends Model
{
    use HasFactory;

    public const STATUS_NOT_ELIGIBLE = 'not_eligible';
    public const STATUS_ELIGIBLE = 'eligible';

    public const STATUSES = [
        self::STATUS_NOT_ELIGIBLE,
        self::STATUS_ELIGIBLE,
    ];

    protected $fillable = [
        'session_id',
        'rule_id',
        'employee_id',
        'current_down_payment_count',
        'current_sales_count',
        'eligibility_status',
        'calculated_at',
    ];

    protected $casts = [
        'calculated_at' => 'datetime',
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
}
