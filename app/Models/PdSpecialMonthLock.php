<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PdSpecialMonthLock extends Model
{
    use HasFactory;

    protected $fillable = [
        'month',
        'locked_at',
        'locked_by',
    ];

    protected $casts = [
        'locked_at' => 'datetime',
    ];
}
