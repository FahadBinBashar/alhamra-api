<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Announcement extends Model
{
    use HasFactory;

    public const TARGET_ALL = 'all';
    public const TARGET_RANK_WISE = 'rank_wise';

    protected $fillable = [
        'title',
        'message',
        'image_url',
        'target_type',
        'target_ranks',
        'created_by',
    ];

    protected $casts = [
        'target_ranks' => 'array',
    ];

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function users(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'announcement_user')
            ->withPivot(['is_read', 'read_at'])
            ->withTimestamps();
    }
}
