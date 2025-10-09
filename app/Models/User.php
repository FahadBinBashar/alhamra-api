<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
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

    public const ROLES = [
        self::ROLE_ADMIN,
        self::ROLE_BRANCH_ADMIN,
        self::ROLE_AGENT,
        self::ROLE_AGENT_ADMIN,
        self::ROLE_EMPLOYEE,
        self::ROLE_OWNER,
        self::ROLE_DIRECTOR,
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
    ];

    public function employee(): HasOne
    {
        return $this->hasOne(Employee::class);
    }
}
