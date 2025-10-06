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

    protected $fillable = [
        'sales_order_id',
        'paid_at',
        'amount',
        'type',
        'method',
        'meta',
    ];

    protected $casts = [
        'paid_at' => 'date',
        'amount' => 'decimal:2',
        'meta' => 'array',
    ];

    protected $dispatchesEvents = [
        'created' => PaymentRecorded::class,
    ];

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
}
