<?php

namespace App\Models;

use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Rank extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    protected $fillable = [
        'name',
        'code',
        'description',
        'sort_order',
    ];

    protected $casts = [
        'sort_order' => 'integer',
    ];

    public function employees(): HasMany
    {
        return $this->hasMany(Employee::class, 'rank', 'code');
    }

    public function requirements(): HasMany
    {
        return $this->hasMany(RankRequirement::class, 'rank', 'code');
    }

    public function memberships(): HasMany
    {
        return $this->hasMany(RankMembership::class, 'rank', 'code');
    }
}
