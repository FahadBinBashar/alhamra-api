<?php

namespace App\Models;

use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class LedgerAccount extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    protected $fillable = [
        'code',
        'name',
        'type',
        'meta',
    ];

    protected $casts = [
        'meta' => 'array',
    ];

    public function entries(): HasMany
    {
        return $this->hasMany(LedgerEntry::class, 'account_id');
    }
}
