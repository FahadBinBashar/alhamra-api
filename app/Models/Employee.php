<?php

namespace App\Models;

use App\Traits\LogsActivityChanges;
use App\Models\SalesOrder;
use App\Models\WorkSummary;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\MorphMany;
use Illuminate\Database\Eloquent\Relations\MorphOne;

class Employee extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    public const RANK_ME = 'ME';
    public const RANK_MM = 'MM';
    public const RANK_AGM = 'AGM';
    public const RANK_DGM = 'DGM';
    public const RANK_GM = 'GM';
    public const RANK_PD = 'PD';
    public const RANK_AMD = 'AMD';
    public const RANK_ED = 'ED';
    public const RANK_DMD = 'DMD';
    public const RANK_DIR = 'DIR';

    public const RANKS = [
        self::RANK_ME,
        self::RANK_MM,
        self::RANK_AGM,
        self::RANK_DGM,
        self::RANK_GM,
        self::RANK_PD,
        self::RANK_AMD,
        self::RANK_ED,
        self::RANK_DMD,
        self::RANK_DIR,
    ];

    /**
     * @var array<int, string>
     */
    protected $fillable = [
        'user_id',
        'branch_id',
        'agent_id',
        'superior_id',
        'employee_code',
        'rank',
        'full_name_en',
        'full_name_bn',
        'father_name',
        'mother_name',
        'mobile',
        'national_id',
        'date_of_birth',
        'marital_status',
        'religion',
        'gender',
        'nationality',
        'district',
        'upazila',
        'present_address',
        'permanent_address',
        'post_code',
    ];

    protected $casts = [
        'date_of_birth' => 'date',
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

    public function rankDefinition(): BelongsTo
    {
        return $this->belongsTo(Rank::class, 'rank', 'code');
    }

    public function superior(): BelongsTo
    {
        return $this->belongsTo(self::class, 'superior_id');
    }

    public function subordinates(): HasMany
    {
        return $this->hasMany(self::class, 'superior_id');
    }

    public function educations(): HasMany
    {
        return $this->hasMany(EmployeeEducation::class);
    }

    public function nominees(): HasMany
    {
        return $this->hasMany(EmployeeNominee::class);
    }

    public function salesOrders(): HasMany
    {
        return $this->hasMany(SalesOrder::class, 'source_me_id');
    }

    public function wallet(): HasOne
    {
        return $this->hasOne(EmployeeWallet::class);
    }

    public function documents(): MorphMany
    {
        return $this->morphMany(Document::class, 'documentable');
    }

    public function photo(): MorphOne
    {
        return $this->morphOne(Document::class, 'documentable')->where('category', 'photo');
    }

    public function signature(): MorphOne
    {
        return $this->morphOne(Document::class, 'documentable')->where('category', 'signature');
    }

    public function workSummaries(): HasMany
    {
        return $this->hasMany(WorkSummary::class);
    }
}
