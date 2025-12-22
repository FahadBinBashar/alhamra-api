<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use App\Models\EmployeeRecruitRequest;
use App\Models\Rank;
use App\Models\User;
use App\Services\EmployeeCreationService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;

class EmployeeRecruitRequestController extends Controller
{
    public function __construct(private readonly EmployeeCreationService $employeeCreationService)
    {
    }

    public function store(Request $request): JsonResponse
    {
        $user = $request->user();
        $employee = $user?->employee;

        if (! $employee || ! $this->hasMinimumRank($employee, Employee::RANK_MM)) {
            abort(403, 'Only MM rank or above can submit recruitment requests.');
        }

        $data = $request->validate([
            'branch_id' => ['nullable', 'integer', 'exists:branches,id'],
            'agent_id' => ['nullable', 'integer', 'exists:agents,id'],
            'superior_id' => ['nullable', 'integer', 'exists:employees,id'],
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
        ]);

        $data['rank'] = Employee::RANK_ME;

        $recruitRequest = EmployeeRecruitRequest::create([
            'requested_by_employee_id' => $employee->id,
            'data' => $data,
            'status' => EmployeeRecruitRequest::STATUS_PENDING,
        ]);

        return response()->json([
            'data' => $recruitRequest->load(['requester.user']),
        ], 201);
    }

    public function index(Request $request): JsonResponse
    {
        $user = $request->user();

        if (! $user) {
            abort(403, 'Authentication required.');
        }

        $data = $request->validate([
            'status' => ['nullable', 'string', Rule::in([
                EmployeeRecruitRequest::STATUS_PENDING,
                EmployeeRecruitRequest::STATUS_APPROVED,
                EmployeeRecruitRequest::STATUS_REJECTED,
            ])],
            'branch_id' => ['nullable', 'integer'],
        ]);

        $query = EmployeeRecruitRequest::query()
            ->with(['requester.user', 'createdEmployee.user', 'reviewer'])
            ->orderByDesc('created_at');

        if (in_array($user->role, [User::ROLE_ADMIN, User::ROLE_BRANCH_ADMIN], true)) {
            if (! empty($data['branch_id'])) {
                $query->where('data->branch_id', (int) $data['branch_id']);
            }
        } elseif ($user->role === User::ROLE_EMPLOYEE && $user->employee) {
            $query->where('requested_by_employee_id', $user->employee->id);
        } else {
            abort(403, 'Only administrators or employees can view recruitment requests.');
        }

        if (! empty($data['status'])) {
            $query->where('status', $data['status']);
        }

        $requests = $query
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return response()->json($requests);
    }

    public function approve(Request $request, EmployeeRecruitRequest $recruitRequest): JsonResponse
    {
        $user = $request->user();

        if (! $user || ! in_array($user->role, [User::ROLE_ADMIN, User::ROLE_BRANCH_ADMIN], true)) {
            abort(403, 'Only administrators can approve recruitment requests.');
        }

        if ($recruitRequest->status !== EmployeeRecruitRequest::STATUS_PENDING) {
            throw ValidationException::withMessages([
                'status' => 'This request has already been processed.',
            ]);
        }

        $data = $recruitRequest->data;
        $data['rank'] = Employee::RANK_ME;

        if (! empty($data['email']) && User::where('email', $data['email'])->exists()) {
            throw ValidationException::withMessages([
                'email' => 'The email has already been taken.',
            ]);
        }

        if (! empty($data['national_id']) && Employee::where('national_id', $data['national_id'])->exists()) {
            throw ValidationException::withMessages([
                'national_id' => 'The national id has already been taken.',
            ]);
        }

        $employee = $this->employeeCreationService->createEmployee($data);

        $recruitRequest->forceFill([
            'status' => EmployeeRecruitRequest::STATUS_APPROVED,
            'reviewed_by_user_id' => $user->id,
            'created_employee_id' => $employee->id,
        ])->save();

        return response()->json([
            'data' => $recruitRequest->load(['createdEmployee.user', 'requester.user', 'reviewer']),
        ]);
    }

    public function reject(Request $request, EmployeeRecruitRequest $recruitRequest): JsonResponse
    {
        $user = $request->user();

        if (! $user || ! in_array($user->role, [User::ROLE_ADMIN, User::ROLE_BRANCH_ADMIN], true)) {
            abort(403, 'Only administrators can reject recruitment requests.');
        }

        $data = $request->validate([
            'rejection_reason' => ['nullable', 'string', 'max:500'],
        ]);

        if ($recruitRequest->status !== EmployeeRecruitRequest::STATUS_PENDING) {
            throw ValidationException::withMessages([
                'status' => 'This request has already been processed.',
            ]);
        }

        $recruitRequest->forceFill([
            'status' => EmployeeRecruitRequest::STATUS_REJECTED,
            'reviewed_by_user_id' => $user->id,
            'rejection_reason' => $data['rejection_reason'] ?? null,
        ])->save();

        return response()->json([
            'data' => $recruitRequest->load(['requester.user', 'reviewer']),
        ]);
    }

    protected function hasMinimumRank(Employee $employee, string $minimumRank): bool
    {
        $ranks = Rank::query()->orderBy('sort_order')->pluck('code')->values()->all();

        $currentIndex = array_search($employee->rank, $ranks, true);
        $minimumIndex = array_search($minimumRank, $ranks, true);

        if ($currentIndex === false || $minimumIndex === false) {
            $orderedRanks = [
                Employee::RANK_ME,
                Employee::RANK_MM,
                Employee::RANK_AGM,
                Employee::RANK_DGM,
                Employee::RANK_GM,
                Employee::RANK_PD,
                Employee::RANK_AMD,
                Employee::RANK_ED,
                Employee::RANK_DMD,
                Employee::RANK_DIR,
            ];

            $currentIndex = array_search($employee->rank, $orderedRanks, true);
            $minimumIndex = array_search($minimumRank, $orderedRanks, true);
        }

        if ($currentIndex === false || $minimumIndex === false) {
            return false;
        }

        return $currentIndex >= $minimumIndex;
    }
}
