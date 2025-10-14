<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PaymentIntent extends Model
{
    use HasFactory;

    public const TYPE_DOWN_PAYMENT = 'down_payment';
    public const TYPE_INSTALLMENT = 'installment_payment';
    public const TYPE_DUE = 'due_payment';
    public const TYPE_BOOKING = 'booking_payment';

    public const TYPES = [
        self::TYPE_DOWN_PAYMENT,
        self::TYPE_INSTALLMENT,
        self::TYPE_DUE,
        self::TYPE_BOOKING,
    ];

    public const STATUS_PENDING = 'pending';
    public const STATUS_PAID = 'paid';
    public const STATUS_FAILED = 'failed';

    public const STATUSES = [
        self::STATUS_PENDING,
        self::STATUS_PAID,
        self::STATUS_FAILED,
    ];

    protected $fillable = [
        'sales_order_id',
        'customer_id',
        'customer_installment_id',
        'amount',
        'currency',
        'type',
        'status',
        'gateway',
        'gateway_transaction_id',
        'meta',
        'paid_at',
    ];

    protected $casts = [
        'amount' => 'decimal:2',
        'meta' => 'array',
        'paid_at' => 'datetime',
    ];

    public function salesOrder(): BelongsTo
    {
        return $this->belongsTo(SalesOrder::class);
    }

    public function customer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'customer_id');
    }

    public function installment(): BelongsTo
    {
        return $this->belongsTo(CustomerInstallment::class, 'customer_installment_id');
    }
}
