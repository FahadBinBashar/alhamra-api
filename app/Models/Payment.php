<?php

namespace App\Models;

use App\Events\PaymentRecorded;
use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasManyThrough;

class Payment extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    public const TYPE_DOWN_PAYMENT = 'down_payment';
    public const TYPE_INSTALLMENT = 'installment';
    public const TYPE_FULL_PAYMENT = 'full_payment';

    public const BASE_TYPES = [
        self::TYPE_DOWN_PAYMENT,
        self::TYPE_INSTALLMENT,
        self::TYPE_FULL_PAYMENT,
    ];

    public const INTENT_DOWN_PAYMENT = 'down_payment';
    public const INTENT_INSTALLMENT = 'installment_payment';
    public const INTENT_DUE = 'due_payment';
    public const INTENT_BOOKING = 'booking_payment';

    public const INTENT_TYPES = [
        self::INTENT_DOWN_PAYMENT,
        self::INTENT_INSTALLMENT,
        self::INTENT_DUE,
        self::INTENT_BOOKING,
    ];

    protected $fillable = [
        'sales_order_id',
        'paid_at',
        'amount',
        'commission_base_amount',
        'type',
        'intent_type',
        'method',
        'meta',
    ];

    protected $casts = [
        'paid_at' => 'date',
        'amount' => 'decimal:2',
        'commission_base_amount' => 'decimal:2',
        'meta' => 'array',
    ];

    protected $dispatchesEvents = [
        'created' => PaymentRecorded::class,
    ];

    public static function resolveTypeFromIntent(string $intent): string
    {
        return match ($intent) {
            self::INTENT_DOWN_PAYMENT => self::TYPE_DOWN_PAYMENT,
            self::INTENT_INSTALLMENT => self::TYPE_INSTALLMENT,
            default => self::TYPE_FULL_PAYMENT,
        };
    }

    public function salesOrder(): BelongsTo
    {
        return $this->belongsTo(SalesOrder::class);
    }

    public function allocations(): HasMany
    {
        return $this->hasMany(PaymentAllocation::class);
    }

    public function commissions(): HasMany
    {
        return $this->hasMany(Commission::class);
    }

    public function getCommissionableAmountAttribute(): float
    {
        $meta = $this->meta ?? [];

        $baseFromMeta = null;

        if (is_array($meta)) {
            if (array_key_exists('ccv', $meta)) {
                $baseFromMeta = (float) $meta['ccv'];
            } elseif (array_key_exists('commission_base', $meta)) {
                $baseFromMeta = (float) $meta['commission_base'];
            }
        }

        $base = $this->commission_base_amount ?? $baseFromMeta ?? $this->amount;

        return (float) $base;
    }
}
