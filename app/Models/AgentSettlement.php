<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AgentSettlement extends Model
{
    use HasFactory;

    public const STATUS_PENDING = 'pending';
    public const STATUS_APPROVED = 'approved';
    public const STATUS_REJECTED = 'rejected';

    public const PAYMENT_METHOD_CASH = 'cash';
    public const PAYMENT_METHOD_BANK = 'bank';
    public const PAYMENT_METHOD_CHECK = 'check';

    protected $fillable = [
        'agent_id',
        'amount',
        'payment_method',
        'reference_no',
        'attachment_url',
        'status',
        'note',
        'admin_note',
        'approved_by',
        'approved_at',
        'rejected_at',
    ];

    protected $casts = [
        'amount' => 'decimal:2',
        'approved_at' => 'datetime',
        'rejected_at' => 'datetime',
    ];

    public function agent(): BelongsTo
    {
        return $this->belongsTo(Agent::class);
    }

    public function approver(): BelongsTo
    {
        return $this->belongsTo(User::class, 'approved_by');
    }
}
