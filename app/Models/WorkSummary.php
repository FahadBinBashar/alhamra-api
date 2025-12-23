<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class WorkSummary extends Model
{
    use HasFactory;

    public const TYPE_DAILY = 'daily';
    public const TYPE_WEEKLY = 'weekly';

    public const TYPES = [
        self::TYPE_DAILY,
        self::TYPE_WEEKLY,
    ];

    /**
     * @var array<int, string>
     */
    protected $fillable = [
        'employee_id',
        'type',
        'report_date',
        'week_start',
        'week_end',
        'today_sales_amount',
        'remarks',
        'sections',
        'submitted_at',
    ];

    /**
     * @var array<string, string>
     */
    protected $casts = [
        'report_date' => 'date',
        'week_start' => 'date',
        'week_end' => 'date',
        'submitted_at' => 'datetime',
        'sections' => 'array',
        'today_sales_amount' => 'decimal:2',
    ];

    public function employee(): BelongsTo
    {
        return $this->belongsTo(Employee::class);
    }
}
