<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PromotionSession extends Model
{
    use HasFactory;

    public const TYPE_MONTHLY = 'monthly';
    public const TYPE_YEARLY = 'yearly';

    public const STATUS_DRAFT = 'draft';
    public const STATUS_ACTIVE = 'active';
    public const STATUS_CLOSED = 'closed';

    public const TYPES = [
        self::TYPE_MONTHLY,
        self::TYPE_YEARLY,
    ];

    public const STATUSES = [
        self::STATUS_DRAFT,
        self::STATUS_ACTIVE,
        self::STATUS_CLOSED,
    ];

    protected $fillable = [
        'name',
        'session_type',
        'start_date',
        'end_date',
        'status',
        'target_metric',
        'target_value',
        'min_product_or_share_sales',
        'created_by',
        'updated_by',
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
        'target_value' => 'integer',
        'min_product_or_share_sales' => 'integer',
    ];

    public function rules(): HasMany
    {
        return $this->hasMany(PromotionRule::class, 'session_id');
    }

    public function eligibilities(): HasMany
    {
        return $this->hasMany(PromotionEligibility::class, 'session_id');
    }

    public function awards(): HasMany
    {
        return $this->hasMany(PromotionAward::class, 'session_id');
    }
}
