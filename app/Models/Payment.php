<?php

namespace App\Models;

use App\Events\PaymentRecorded;
use App\Models\CommissionCalculationUnit;
use App\Models\SupplierPayable;
use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasManyThrough;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Payment extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    public const TYPE_DOWN_PAYMENT = 'down_payment';
    public const TYPE_INSTALLMENT = 'installment';
    public const TYPE_FULL_PAYMENT = 'full_payment';
    public const TYPE_PARTIAL_PAYMENT = 'partial_payment';

    public const BASE_TYPES = [
        self::TYPE_DOWN_PAYMENT,
        self::TYPE_INSTALLMENT,
        self::TYPE_FULL_PAYMENT,
        self::TYPE_PARTIAL_PAYMENT,
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
        'commission_processed_at',
        'type',
        'intent_type',
        'method',
        'meta',
    ];

    protected $casts = [
        'paid_at' => 'date',
        'amount' => 'decimal:2',
        'commission_base_amount' => 'decimal:2',
        'commission_processed_at' => 'datetime',
        'meta' => 'array',
    ];

    protected $dispatchesEvents = [
        'created' => PaymentRecorded::class,
    ];

    protected static function booted(): void
    {
        static::saving(function (Payment $payment): void {
            if (! $payment->sales_order_id || $payment->amount === null) {
                return;
            }

            $payment->commission_base_amount = $payment->calculateCommissionBaseAmount();
        });
    }

    public static function resolveTypeFromIntent(string $intent): string
    {
        return match ($intent) {
            self::INTENT_DOWN_PAYMENT => self::TYPE_DOWN_PAYMENT,
            self::INTENT_INSTALLMENT => self::TYPE_INSTALLMENT,
            self::INTENT_DUE => self::TYPE_PARTIAL_PAYMENT,
            default => self::TYPE_FULL_PAYMENT,
        };
    }

    public static function resolveIntentFromType(string $type): string
    {
        return match ($type) {
            self::TYPE_DOWN_PAYMENT => self::INTENT_DOWN_PAYMENT,
            self::TYPE_INSTALLMENT => self::INTENT_INSTALLMENT,
            self::TYPE_PARTIAL_PAYMENT => self::INTENT_DUE,
            default => self::INTENT_DUE,
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

    public function supplierPayables(): HasMany
    {
        return $this->hasMany(SupplierPayable::class);
    }

    public function commissionCalculationUnit(): HasOne
    {
        return $this->hasOne(CommissionCalculationUnit::class);
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

    public function calculateCommissionBaseAmount(?float $amount = null): float
    {
        $amount ??= (float) $this->amount;

        if (! $this->sales_order_id || $amount <= 0) {
            return round(max($amount, 0.0), 2);
        }

        $order = $this->relationLoaded('salesOrder')
            ? $this->salesOrder
            : $this->salesOrder()->with('items.itemable')->first();

        if (! $order) {
            return round(max($amount, 0.0), 2);
        }

        if (! $order->relationLoaded('items')) {
            $order->loadMissing('items.itemable');
        }

        if (method_exists($order, 'calculateCommissionableBaseFor')) {
            return $order->calculateCommissionableBaseFor($amount);
        }

        return round(max($amount, 0.0), 2);
    }
}
