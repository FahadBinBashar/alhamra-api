<?php

namespace App\Services;

use App\Models\Agent;
use App\Models\Employee;
use App\Models\User;
use App\Notifications\EmployeeCredentialNotification;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;
use Spatie\Permission\Models\Role;

class EmployeeCreationService
{
    public function createEmployee(array $data): Employee
    {
        $educations = Arr::pull($data, 'educations', []);
        $nominees = Arr::pull($data, 'nominees', []);
        $email = Arr::pull($data, 'email');
        $rank = $data['rank'] ?? Employee::RANK_ME;

        $employeeCode = $data['employee_code'] ?? $this->generateEmployeeCode();

        $password = Str::random(12);

        $user = null;

        $employee = DB::transaction(function () use (
            $data,
            $educations,
            $nominees,
            $email,
            $rank,
            $employeeCode,
            $password,
            &$user
        ) {
            $user = User::create([
                'name' => $data['full_name_en'],
                'email' => $email,
                'password' => $password,
                'role' => User::ROLE_EMPLOYEE,
            ]);

            if (method_exists($user, 'assignRole')) {
                Role::findOrCreate(User::ROLE_EMPLOYEE, 'web');
                $user->assignRole(User::ROLE_EMPLOYEE);
            }

            $employeeData = Arr::only($data, [
                'branch_id',
                'agent_id',
                'superior_id',
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
            ]);

            $employeeData['employee_code'] = $employeeCode;
            $employeeData['rank'] = $rank;
            $employeeData['user_id'] = $user->id;

            $employeeData = $this->resolveAgentContext($employeeData);

            $employee = Employee::create($employeeData);

            if (! empty($educations)) {
                $this->syncEducations($employee, $educations);
            }

            if (! empty($nominees)) {
                $this->syncNominees($employee, $nominees);
            }

            return $employee;
        });

        if ($user) {
            DB::afterCommit(function () use ($user, $password) {
                $user->notify(new EmployeeCredentialNotification($user->email, $password));
            });
        }

        return $employee;
    }

    protected function generateEmployeeCode(): string
    {
        do {
            $code = sprintf('EMP-%s', strtoupper(Str::random(6)));
        } while (Employee::where('employee_code', $code)->exists());

        return $code;
    }

    protected function resolveAgentContext(array $data): array
    {
        $agentId = $data['agent_id'] ?? null;

        if (! $agentId) {
            return $data;
        }

        /** @var Agent|null $agent */
        $agent = Agent::find($agentId);

        if (! $agent) {
            return $data;
        }

        $branchId = $data['branch_id'] ?? null;

        if ($branchId && $agent->branch_id !== (int) $branchId) {
            throw ValidationException::withMessages([
                'agent_id' => 'The selected agent does not belong to the specified branch.',
            ]);
        }

        $data['branch_id'] = $agent->branch_id;

        return $data;
    }

    protected function syncEducations(Employee $employee, array $educations): void
    {
        $employee->educations()->delete();

        foreach ($educations as $education) {
            $employee->educations()->create([
                'level' => $education['level'],
                'institution' => $education['institution'] ?? null,
                'subject' => $education['subject'] ?? null,
                'result' => $education['result'] ?? null,
                'passing_year' => $education['passing_year'] ?? null,
            ]);
        }
    }

    protected function syncNominees(Employee $employee, array $nominees): void
    {
        $employee->nominees()->delete();

        foreach ($nominees as $nominee) {
            $employee->nominees()->create([
                'name' => $nominee['name'],
                'relation' => $nominee['relation'] ?? null,
                'phone' => $nominee['phone'] ?? null,
                'email' => $nominee['email'] ?? null,
                'address' => $nominee['address'] ?? null,
            ]);
        }
    }
}
