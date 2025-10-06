<?php

namespace App\Models;

use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Employee extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    public const RANK_ME = 'ME';
    public const RANK_MM = 'MM';
    public const RANK_DGM = 'DGM';
    public const RANK_GM = 'GM';
    public const RANK_PD = 'PD';
    public const RANK_ED = 'ED';
    public const RANK_DMD = 'DMD';
    public const RANK_HD = 'HD';

    public const RANKS = [
        self::RANK_ME,
        self::RANK_MM,
        self::RANK_DGM,
        self::RANK_GM,
        self::RANK_PD,
        self::RANK_ED,
        self::RANK_DMD,
        self::RANK_HD,
    ];

    /**
     * @var array<int, string>
     */
    protected $fillable = [
        'user_id',
        'branch_id',
        'agent_id',
        'rank',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function branch(): BelongsTo
    {
        return $this->belongsTo(Branch::class);
    }

    public function agent(): BelongsTo
    {
        return $this->belongsTo(Agent::class);
    }
}
