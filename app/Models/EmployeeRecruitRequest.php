<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class EmployeeRecruitRequest extends Model
{
    use HasFactory;

    public const STATUS_PENDING = 'pending';
    public const STATUS_APPROVED = 'approved';
    public const STATUS_REJECTED = 'rejected';

    protected $fillable = [
        'requested_by_employee_id',
        'data',
        'status',
        'reviewed_by_user_id',
        'created_employee_id',
    ];

    protected $casts = [
        'data' => 'array',
    ];

    public function requester(): BelongsTo
    {
        return $this->belongsTo(Employee::class, 'requested_by_employee_id');
    }

    public function reviewer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'reviewed_by_user_id');
    }

    public function createdEmployee(): BelongsTo
    {
        return $this->belongsTo(Employee::class, 'created_employee_id');
    }
}
