<?php

namespace App\Policies;

use App\Models\User;
use App\Models\WorkSummary;

class WorkSummaryPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->role === User::ROLE_EMPLOYEE && (bool) $user->employee;
    }

    public function view(User $user, WorkSummary $workSummary): bool
    {
        return $user->role === User::ROLE_EMPLOYEE
            && $user->employee
            && $workSummary->employee_id === $user->employee->id;
    }

    public function create(User $user): bool
    {
        return $user->role === User::ROLE_EMPLOYEE && (bool) $user->employee;
    }

    public function viewAdmin(User $user): bool
    {
        return $user->role === User::ROLE_ADMIN;
    }
}
