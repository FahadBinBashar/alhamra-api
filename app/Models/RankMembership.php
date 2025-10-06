<?php

namespace App\Models;

use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class RankMembership extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    protected $fillable = [
        'agent_id',
        'rank',
        'achieved_at',
        'active',
        'meta',
    ];

    protected $casts = [
        'achieved_at' => 'datetime',
        'active' => 'boolean',
        'meta' => 'array',
    ];

    public function agent(): BelongsTo
    {
        return $this->belongsTo(Agent::class);
    }
}
