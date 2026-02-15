<?php

namespace App\Models;

use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class SalesOrder extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    public const TYPE_LAND = 'land';
    public const TYPE_ORDER = 'order';
    public const TYPE_SERVICE = 'service';
    public const TYPE_SHARE = 'share';

    public const STATUS_DRAFT = 'draft';
    public const STATUS_ACTIVE = 'active';
    public const STATUS_COMPLETED = 'completed';
    public const STATUS_CANCELLED = 'cancelled';

    public const SALES_TYPES = [
        self::TYPE_LAND,
        self::TYPE_ORDER,
        self::TYPE_SERVICE,
        self::TYPE_SHARE,
    ];

    public const STATUSES = [
        self::STATUS_DRAFT,
        self::STATUS_ACTIVE,
        self::STATUS_COMPLETED,
        self::STATUS_CANCELLED,
    ];

    public const CREATED_BY_ADMIN = 'admin';
    public const CREATED_BY_BRANCH_ADMIN = 'branch_admin';
    public const CREATED_BY_AGENT = 'agent';
    public const CREATED_BY_CUSTOMER = 'customer';
    public const CREATED_BY_SYSTEM = 'system';

    public const CREATED_BY_OPTIONS = [
        self::CREATED_BY_ADMIN,
        self::CREATED_BY_BRANCH_ADMIN,
        self::CREATED_BY_AGENT,
        self::CREATED_BY_CUSTOMER,
        self::CREATED_BY_SYSTEM,
    ];

    protected $fillable = [
        'customer_id',
        'employee_id',
        'source_me_id',
        'agent_id',
        'branch_id',
        'sales_type',
        'rank',
        'introducer_id',
        'down_payment',
        'installment_tenure_months',
        'total',
        'status',
        'created_by',
    ];

    protected $casts = [
        'down_payment' => 'decimal:2',
        'total' => 'decimal:2',
        'installment_tenure_months' => 'integer',
    ];

    public function items(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }

    public function agent(): BelongsTo
    {
        return $this->belongsTo(Agent::class);
    }

    public function employee(): BelongsTo
    {
        return $this->belongsTo(Employee::class);
    }

    public function sourceMe(): BelongsTo
    {
        return $this->belongsTo(Employee::class, 'source_me_id');
    }

    public function branch(): BelongsTo
    {
        return $this->belongsTo(Branch::class);
    }

    public function customer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'customer_id');
    }

    public function introducer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'introducer_id');
    }

    public function installments(): HasMany
    {
        return $this->hasMany(CustomerInstallment::class);
    }

    public function payments(): HasMany
    {
        return $this->hasMany(Payment::class);
    }

    public function commissions(): HasMany
    {
        return $this->hasMany(Commission::class);
    }

    public function rankDefinition(): BelongsTo
    {
        return $this->belongsTo(Rank::class, 'rank', 'code');
    }

    public function calculateCommissionableBaseFor(float $amount): float
    {
        $ratio = $this->calculateCommissionableRatio();

        return round(max($amount, 0.0) * $ratio, 2);
    }

    public function calculateCommissionableRatio(): float
    {
        $this->loadMissing('items.itemable');

        $items = $this->items ?? collect();

        if ($items->isEmpty()) {
            return 1.0;
        }

        $commissionableTotal = 0.0;
        $lineTotal = 0.0;

        foreach ($items as $item) {
            $lineAmount = (float) $item->line_total;
            $lineTotal += $lineAmount;

            $itemable = $item->itemable;
            $ccu = 0.0;

            if ($itemable instanceof Product) {
                $ccu = (float) ($itemable->ccu_percentage ?? 0);
            }

            $ratio = max(min(100 - $ccu, 100), 0) / 100;

            $commissionableTotal += $lineAmount * $ratio;
        }

        $orderTotal = (float) $this->total;

        if ($orderTotal > 0) {
            return $this->clampCommissionRatio($commissionableTotal / $orderTotal);
        }

        if ($lineTotal > 0) {
            return $this->clampCommissionRatio($commissionableTotal / $lineTotal);
        }

        return 1.0;
    }

    protected function clampCommissionRatio(float $value): float
    {
        $ratio = round($value, 8);

        if ($ratio < 0) {
            return 0.0;
        }

        if ($ratio > 1) {
            return 1.0;
        }

        return $ratio;
    }
}
