<?php

namespace App\Models;

use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class CustomerInstallment extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    protected $fillable = [
        'sales_order_id',
        'due_date',
        'amount',
        'paid',
        'status',
    ];

    protected $casts = [
        'due_date' => 'date',
        'amount' => 'decimal:2',
        'paid' => 'decimal:2',
    ];

    public function salesOrder(): BelongsTo
    {
        return $this->belongsTo(SalesOrder::class);
    }

    public function allocations(): HasMany
    {
        return $this->hasMany(PaymentAllocation::class, 'customer_installment_id');
    }
}
