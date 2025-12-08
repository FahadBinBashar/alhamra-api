<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PdSpecialSelection extends Model
{
    use HasFactory;

    protected $fillable = [
        'employee_id',
        'month',
        'percentage',
        'selected_by',
        'meta',
    ];

    protected $casts = [
        'percentage' => 'decimal:2',
        'meta' => 'array',
    ];
}
