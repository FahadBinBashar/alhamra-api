<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;

class User extends Authenticatable
{
    use HasApiTokens;
    use HasFactory;
    use Notifiable;
    use HasRoles;

    public const ROLE_ADMIN = 'admin';
    public const ROLE_BRANCH_ADMIN = 'branch_admin';
    public const ROLE_AGENT = 'agent';
    public const ROLE_AGENT_ADMIN = 'agent_admin';
    public const ROLE_EMPLOYEE = 'employee';
    public const ROLE_OWNER = 'owner';
    public const ROLE_DIRECTOR = 'director';
    public const ROLE_CUSTOMER = 'customer';

    public const ROLES = [
        self::ROLE_ADMIN,
        self::ROLE_BRANCH_ADMIN,
        self::ROLE_AGENT,
        self::ROLE_AGENT_ADMIN,
        self::ROLE_EMPLOYEE,
        self::ROLE_OWNER,
        self::ROLE_DIRECTOR,
        self::ROLE_CUSTOMER,
    ];

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'role',
        'father_name',
        'mother_name',
        'marital_status',
        'spouse_name',
        'profession',
        'permanent_address',
        'present_address',
        'contact_number',
        'residence_phone',
        'whatsapp_number',
        'national_id',
        'passport_number',
        'nationality',
        'religion',
        'date_of_birth',
        'blood_group',
        'nominee_name',
        'nominee_relation',
        'nominee_phone',
        'authorized_person_name',
        'authorized_person_address',
        'joint_applicants',
        'added_by_role',
        'added_by_branch_id',
        'added_by_agent_id',
        'source_me_id',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
        'date_of_birth' => 'date',
    ];

    public function employee(): HasOne
    {
        return $this->hasOne(Employee::class);
    }

    public function agent(): HasOne
    {
        return $this->hasOne(Agent::class);
    }

    public function sourceMe(): BelongsTo
    {
        return $this->belongsTo(Employee::class, 'source_me_id');
    }
}
