<?php

namespace App\Http\Controllers;

use App\Models\Agent;
use App\Models\Employee;
use App\Models\User;
use App\Notifications\EmployeeCredentialNotification;
use Illuminate\Http\Request;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;
use Spatie\Permission\Models\Role;

class EmployeeController extends Controller
{
    public function index(Request $request)
    {
        $employees = Employee::with([
            'user',
            'branch',
            'agent.user',
            'superior.user',
            'educations',
            'nominees',
            'photo',
            'signature',
            'rankDefinition',
        ])
            ->when($request->query('rank'), function ($query, $rank) {
                $query->where('rank', $rank);
            })
            ->when($request->query('branch_id'), function ($query, $branchId) {
                $query->where('branch_id', $branchId);
            })
            ->orderBy('id')
            ->paginate((int) $request->query('per_page', 15));

        return response()->json($employees);
    }

    // public function store(Request $request)
    // {
    //     $data = $request->validate([
    //         'employee_code' => ['required', 'string', 'max:255', 'unique:employees,employee_code'],
    //         'branch_id' => ['nullable', 'integer', 'exists:branches,id'],
    //         'agent_id' => ['nullable', 'integer', 'exists:agents,id'],
    //         'superior_id' => ['nullable', 'integer', 'exists:employees,id'],
    //         'rank' => ['nullable', 'string', Rule::in(Employee::RANKS)],
    //         'full_name_en' => ['required', 'string', 'max:255'],
    //         'full_name_bn' => ['nullable', 'string', 'max:255'],
    //         'father_name' => ['nullable', 'string', 'max:255'],
    //         'mother_name' => ['nullable', 'string', 'max:255'],
    //         'email' => ['required', 'string', 'email', 'max:255', 'unique:users,email'],
    //         'mobile' => ['required', 'string', 'max:50'],
    //         'national_id' => ['nullable', 'string', 'max:100', 'unique:employees,national_id'],
    //         'date_of_birth' => ['nullable', 'date'],
    //         'marital_status' => ['nullable', 'string', 'max:100'],
    //         'religion' => ['nullable', 'string', 'max:100'],
    //         'gender' => ['nullable', 'string', 'max:50'],
    //         'nationality' => ['nullable', 'string', 'max:100'],
    //         'district' => ['nullable', 'string', 'max:100'],
    //         'upazila' => ['nullable', 'string', 'max:100'],
    //         'present_address' => ['nullable', 'string'],
    //         'permanent_address' => ['nullable', 'string'],
    //         'post_code' => ['nullable', 'string', 'max:20'],
    //         'educations' => ['nullable', 'array'],
    //         'educations.*.level' => ['required_with:educations', 'string', 'max:255'],
    //         'educations.*.institution' => ['nullable', 'string', 'max:255'],
    //         'educations.*.subject' => ['nullable', 'string', 'max:255'],
    //         'educations.*.result' => ['nullable', 'string', 'max:255'],
    //         'educations.*.passing_year' => ['nullable', 'string', 'max:10'],
    //         'nominees' => ['nullable', 'array'],
    //         'nominees.*.name' => ['required_with:nominees', 'string', 'max:255'],
    //         'nominees.*.relation' => ['nullable', 'string', 'max:255'],
    //         'nominees.*.phone' => ['nullable', 'string', 'max:50'],
    //         'nominees.*.email' => ['nullable', 'email', 'max:255'],
    //         'nominees.*.address' => ['nullable', 'string'],
    //         'photo' => ['nullable', 'image', 'max:10240'],
    //         'signature' => ['nullable', 'file', 'mimes:jpg,jpeg,png,pdf', 'max:10240'],
    //     ]);

    //     $educations = Arr::pull($data, 'educations', []);
    //     $nominees = Arr::pull($data, 'nominees', []);
    //     $email = Arr::pull($data, 'email');

    //     $password = Str::random(12);

    //     $user = User::create([
    //         'name' => $data['full_name_en'],
    //         'email' => $email,
    //         'password' => $password,
    //         'role' => User::ROLE_EMPLOYEE,
    //     ]);

    //     if (method_exists($user, 'assignRole')) {
    //         Role::findOrCreate(User::ROLE_EMPLOYEE, 'web');

    //         $user->assignRole(User::ROLE_EMPLOYEE);
    //     }

    //     $employeeData = Arr::only($data, [
    //         'employee_code',
    //         'branch_id',
    //         'agent_id',
    //         'superior_id',
    //         'rank',
    //         'full_name_en',
    //         'full_name_bn',
    //         'father_name',
    //         'mother_name',
    //         'mobile',
    //         'national_id',
    //         'date_of_birth',
    //         'marital_status',
    //         'religion',
    //         'gender',
    //         'nationality',
    //         'district',
    //         'upazila',
    //         'present_address',
    //         'permanent_address',
    //         'post_code',
    //     ]);

    //     $employeeData['user_id'] = $user->id;

    //     $employeeData = $this->resolveAgentContext($employeeData);

    //     $employee = Employee::create($employeeData);

    //     if (! empty($educations)) {
    //         $this->syncEducations($employee, $educations);
    //     }

    //     if (! empty($nominees)) {
    //         $this->syncNominees($employee, $nominees);
    //     }

    //     if ($request->file('photo')) {
    //         $this->storeEmployeeDocument($employee, $request->file('photo'), 'photo');
    //     }

    //     if ($request->file('signature')) {
    //         $this->storeEmployeeDocument($employee, $request->file('signature'), 'signature');
    //     }

    //     $user->notify(new EmployeeCredentialNotification($user->email, $password));

    //     return response()->json([
    //         'data' => $employee->load([
    //             'user',
    //             'branch',
    //             'agent.user',
    //             'superior.user',
    //             'educations',
    //             'nominees',
    //             'photo',
    //             'signature',
    //         ]),
    //     ], 201);
    // }
   public function store(Request $request)
    {
        $data = $request->validate([
            'employee_code' => ['required', 'string', 'max:255', 'unique:employees,employee_code'],
            'branch_id' => ['nullable', 'integer', 'exists:branches,id'],
            'agent_id' => ['nullable', 'integer', 'exists:agents,id'],
            'superior_id' => ['nullable', 'integer', 'exists:employees,id'],
            'rank' => ['nullable', 'string', Rule::exists('ranks', 'code')],
            'full_name_en' => ['required', 'string', 'max:255'],
            'full_name_bn' => ['nullable', 'string', 'max:255'],
            'father_name' => ['nullable', 'string', 'max:255'],
            'mother_name' => ['nullable', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users,email'],
            'mobile' => ['required', 'string', 'max:50'],
            'national_id' => ['nullable', 'string', 'max:100', 'unique:employees,national_id'],
            'date_of_birth' => ['nullable', 'date'],
            'marital_status' => ['nullable', 'string', 'max:100'],
            'religion' => ['nullable', 'string', 'max:100'],
            'gender' => ['nullable', 'string', 'max:50'],
            'nationality' => ['nullable', 'string', 'max:100'],
            'district' => ['nullable', 'string', 'max:100'],
            'upazila' => ['nullable', 'string', 'max:100'],
            'present_address' => ['nullable', 'string'],
            'permanent_address' => ['nullable', 'string'],
            'post_code' => ['nullable', 'string', 'max:20'],
            'educations' => ['nullable', 'array'],
            'educations.*.level' => ['required_with:educations', 'string', 'max:255'],
            'educations.*.institution' => ['nullable', 'string', 'max:255'],
            'educations.*.subject' => ['nullable', 'string', 'max:255'],
            'educations.*.result' => ['nullable', 'string', 'max:255'],
            'educations.*.passing_year' => ['nullable', 'string', 'max:10'],
            'nominees' => ['nullable', 'array'],
            'nominees.*.name' => ['required_with:nominees', 'string', 'max:255'],
            'nominees.*.relation' => ['nullable', 'string', 'max:255'],
            'nominees.*.phone' => ['nullable', 'string', 'max:50'],
            'nominees.*.email' => ['nullable', 'email', 'max:255'],
            'nominees.*.address' => ['nullable', 'string'],
            'photo' => ['nullable', 'image', 'max:10240'],
            'signature' => ['nullable', 'file', 'mimes:jpg,jpeg,png,pdf', 'max:10240'],
        ]);

        $educations = Arr::pull($data, 'educations', []);
        $nominees = Arr::pull($data, 'nominees', []);
        $email = Arr::pull($data, 'email');

        $password = Str::random(12);

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
            'employee_code',
            'branch_id',
            'agent_id',
            'superior_id',
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
        ]);

        $employeeData['user_id'] = $user->id;
        $employeeData = $this->resolveAgentContext($employeeData);

        $employee = Employee::create($employeeData);

        if (!empty($educations)) {
            $this->syncEducations($employee, $educations);
        }

        if (!empty($nominees)) {
            $this->syncNominees($employee, $nominees);
        }

        if ($request->file('photo')) {
            $this->storeEmployeeDocument($employee, $request->file('photo'), 'photo');
        }

        if ($request->file('signature')) {
            $this->storeEmployeeDocument($employee, $request->file('signature'), 'signature');
        }

        return response()->json([
            'data' => $employee->load([
                'user',
                'branch',
                'agent.user',
                'superior.user',
                'educations',
                'nominees',
                'photo',
                'signature',
            ]),
            'password' => $password, // Optional
        ], 201);
    }

    public function show(Employee $employee)
    {
        return response()->json([
            'data' => $employee->load([
                'user',
                'branch',
                'agent.user',
                'superior.user',
                'educations',
                'nominees',
                'photo',
                'signature',
                'rankDefinition',
            ]),
        ]);
    }

    public function update(Request $request, Employee $employee)
    {
        $data = $request->validate([
            'employee_code' => ['sometimes', 'string', 'max:255', Rule::unique('employees', 'employee_code')->ignore($employee->id)],
            'branch_id' => ['sometimes', 'nullable', 'integer', 'exists:branches,id'],
            'agent_id' => ['sometimes', 'nullable', 'integer', 'exists:agents,id'],
            'superior_id' => ['sometimes', 'nullable', 'integer', 'exists:employees,id'],
            'rank' => ['sometimes', 'nullable', 'string', Rule::exists('ranks', 'code')],
            'full_name_en' => ['sometimes', 'string', 'max:255'],
            'full_name_bn' => ['sometimes', 'nullable', 'string', 'max:255'],
            'father_name' => ['sometimes', 'nullable', 'string', 'max:255'],
            'mother_name' => ['sometimes', 'nullable', 'string', 'max:255'],
            'email' => ['sometimes', 'string', 'email', 'max:255', Rule::unique('users', 'email')->ignore($employee->user_id)],
            'mobile' => ['sometimes', 'string', 'max:50'],
            'national_id' => ['sometimes', 'nullable', 'string', 'max:100', Rule::unique('employees', 'national_id')->ignore($employee->id)],
            'date_of_birth' => ['sometimes', 'nullable', 'date'],
            'marital_status' => ['sometimes', 'nullable', 'string', 'max:100'],
            'religion' => ['sometimes', 'nullable', 'string', 'max:100'],
            'gender' => ['sometimes', 'nullable', 'string', 'max:50'],
            'nationality' => ['sometimes', 'nullable', 'string', 'max:100'],
            'district' => ['sometimes', 'nullable', 'string', 'max:100'],
            'upazila' => ['sometimes', 'nullable', 'string', 'max:100'],
            'present_address' => ['sometimes', 'nullable', 'string'],
            'permanent_address' => ['sometimes', 'nullable', 'string'],
            'post_code' => ['sometimes', 'nullable', 'string', 'max:20'],
            'educations' => ['sometimes', 'array'],
            'educations.*.level' => ['required_with:educations', 'string', 'max:255'],
            'educations.*.institution' => ['nullable', 'string', 'max:255'],
            'educations.*.subject' => ['nullable', 'string', 'max:255'],
            'educations.*.result' => ['nullable', 'string', 'max:255'],
            'educations.*.passing_year' => ['nullable', 'string', 'max:10'],
            'nominees' => ['sometimes', 'array'],
            'nominees.*.name' => ['required_with:nominees', 'string', 'max:255'],
            'nominees.*.relation' => ['nullable', 'string', 'max:255'],
            'nominees.*.phone' => ['nullable', 'string', 'max:50'],
            'nominees.*.email' => ['nullable', 'email', 'max:255'],
            'nominees.*.address' => ['nullable', 'string'],
            'photo' => ['sometimes', 'nullable', 'image', 'max:10240'],
            'signature' => ['sometimes', 'nullable', 'file', 'mimes:jpg,jpeg,png,pdf', 'max:10240'],
        ]);

        $educations = array_key_exists('educations', $data) ? Arr::pull($data, 'educations') : null;
        $nominees = array_key_exists('nominees', $data) ? Arr::pull($data, 'nominees') : null;
        $email = array_key_exists('email', $data) ? Arr::pull($data, 'email') : null;

        if ($email !== null || array_key_exists('full_name_en', $data)) {
            $user = $employee->user;

            if ($email !== null) {
                $user->email = $email;
            }

            if (array_key_exists('full_name_en', $data)) {
                $user->name = $data['full_name_en'];
            }

            $user->save();
        }

        $employeeData = Arr::only($data, [
            'employee_code',
            'branch_id',
            'agent_id',
            'superior_id',
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
        ]);

        $resolved = $this->resolveAgentContext(array_merge(
            $employee->only(['user_id', 'branch_id', 'agent_id', 'rank', 'superior_id']),
            $employeeData
        ));

        if (($resolved['superior_id'] ?? null) === $employee->id) {
            throw ValidationException::withMessages([
                'superior_id' => 'An employee cannot be their own superior.',
            ]);
        }

        $employee->fill($resolved);
        $employee->save();

        if (is_array($educations)) {
            $this->syncEducations($employee, $educations);
        }

        if (is_array($nominees)) {
            $this->syncNominees($employee, $nominees);
        }

        if ($request->file('photo')) {
            $this->storeEmployeeDocument($employee, $request->file('photo'), 'photo');
        }

        if ($request->file('signature')) {
            $this->storeEmployeeDocument($employee, $request->file('signature'), 'signature');
        }

        return response()->json([
            'data' => $employee->load([
                'user',
                'branch',
                'agent.user',
                'superior.user',
                'educations',
                'nominees',
                'photo',
                'signature',
                'rankDefinition',
            ]),
        ]);
    }

    public function destroy(Employee $employee)
    {
        $employee->delete();

        return response()->noContent();
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

    protected function storeEmployeeDocument(Employee $employee, UploadedFile $file, string $category): void
    {
        $existing = $employee->documents()->where('category', $category)->first();

        $disk = config('filesystems.default');
        $path = $file->store("documents/employees/{$category}", $disk);

        if ($existing) {
            if ($existing->path && $existing->disk) {
                Storage::disk($existing->disk)->delete($existing->path);
            }

            $existing->delete();
        }

        $employee->documents()->create([
            'category' => $category,
            'disk' => $disk,
            'path' => $path,
            'original_name' => $file->getClientOriginalName(),
            'mime_type' => $file->getClientMimeType(),
            'size' => $file->getSize(),
            'uploaded_by' => Auth::id(),
        ]);
    }
}
