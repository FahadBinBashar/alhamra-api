<?php

namespace App\Models;

use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PaymentAllocation extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    protected $fillable = [
        'payment_id',
        'customer_installment_id',
        'allocated',
    ];

    protected $casts = [
        'allocated' => 'decimal:2',
    ];

    public function payment(): BelongsTo
    {
        return $this->belongsTo(Payment::class);
    }

    public function installment(): BelongsTo
    {
        return $this->belongsTo(CustomerInstallment::class, 'customer_installment_id');
    }
}
