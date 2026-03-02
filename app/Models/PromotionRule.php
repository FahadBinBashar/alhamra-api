<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PromotionRule extends Model
{
    use HasFactory;

    public const BASIS_PERSONAL = 'personal';
    public const BASIS_FIRST_STEP = 'first_step';
    public const BASIS_COMBINED = 'combined_step_1_2';

    public const BASIS_TYPES = [
        self::BASIS_PERSONAL,
        self::BASIS_FIRST_STEP,
        self::BASIS_COMBINED,
    ];

    public const INCENTIVE_NATIONAL_TOUR_SELF = 'national_tour_self';
    public const INCENTIVE_NATIONAL_TOUR_COUPLE = 'national_tour_couple';
    public const INCENTIVE_FOREIGN_TOUR_SELF = 'foreign_tour_self';
    public const INCENTIVE_FOREIGN_TOUR_COUPLE = 'foreign_tour_couple';
    public const INCENTIVE_FUND = 'fund';
    public const INCENTIVE_CAR = 'car';
    public const INCENTIVE_HOUSE = 'house';

    public const INCENTIVE_TYPES = [
        self::INCENTIVE_NATIONAL_TOUR_SELF,
        self::INCENTIVE_NATIONAL_TOUR_COUPLE,
        self::INCENTIVE_FOREIGN_TOUR_SELF,
        self::INCENTIVE_FOREIGN_TOUR_COUPLE,
        self::INCENTIVE_FUND,
        self::INCENTIVE_CAR,
        self::INCENTIVE_HOUSE,
    ];

    protected $fillable = [
        'session_id',
        'slot_no',
        'eligibility_basis',
        'finance_verified_only',
        'incentive_type',
        'fund_amount',
        'currency',
    ];

    protected $casts = [
        'finance_verified_only' => 'boolean',
        'fund_amount' => 'decimal:2',
    ];

    public function session(): BelongsTo
    {
        return $this->belongsTo(PromotionSession::class, 'session_id');
    }
}
