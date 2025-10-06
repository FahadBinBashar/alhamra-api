<?php

namespace App\Models;

use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class CommissionRule extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    public const TRIGGER_ON_PAYMENT = 'on_payment';
    public const SCOPE_GLOBAL = 'any';

    protected $fillable = [
        'name',
        'scope',
        'trigger',
        'recipient_type',
        'recipient_id',
        'percentage',
        'flat_amount',
        'active',
        'meta',
    ];

    protected $casts = [
        'percentage' => 'decimal:2',
        'flat_amount' => 'decimal:2',
        'active' => 'boolean',
        'meta' => 'array',
    ];

    public function commissions(): HasMany
    {
        return $this->hasMany(Commission::class);
    }

    public function scopeActive($query)
    {
        return $query->where('active', true);
    }
}
