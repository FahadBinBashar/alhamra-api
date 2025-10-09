<?php

namespace App\Models;

use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class RankRequirement extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    protected $fillable = [
        'rank',
        'sequence',
        'personal_sales_target',
        'bonus_down_payment',
        'bonus_installment',
        'direct_required',
        'meta',
    ];

    protected $casts = [
        'personal_sales_target' => 'decimal:2',
        'bonus_down_payment' => 'decimal:2',
        'bonus_installment' => 'decimal:2',
        'meta' => 'array',
    ];

    public function rankDefinition(): BelongsTo
    {
        return $this->belongsTo(Rank::class, 'rank', 'code');
    }
}
