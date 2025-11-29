<?php

namespace App\Models;

use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DirectorFund extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    public const TYPE_ED = 'ed';
    public const TYPE_AMD = 'amd';
    public const TYPE_DMD = 'dmd';

    public const STATUS_DRAFT = 'draft';
    public const STATUS_PAID = 'paid';

    protected $fillable = [
        'employee_id',
        'type',
        'period_start',
        'period_end',
        'percentage_used',
        'total_fund',
        'per_person_amount',
        'status',
        'meta',
        'processed_at',
    ];

    protected $casts = [
        'period_start' => 'date',
        'period_end' => 'date',
        'percentage_used' => 'decimal:2',
        'total_fund' => 'decimal:2',
        'per_person_amount' => 'decimal:2',
        'processed_at' => 'datetime',
        'meta' => 'array',
    ];

    public function employee(): BelongsTo
    {
        return $this->belongsTo(Employee::class);
    }
}
