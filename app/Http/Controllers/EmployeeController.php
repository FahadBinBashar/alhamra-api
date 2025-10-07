<?php

namespace App\Http\Controllers;

use App\Models\Agent;
use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;

class EmployeeController extends Controller
{
    public function index(Request $request)
    {
        $employees = Employee::with(['user', 'branch', 'agent.user'])
            ->when($request->query('rank'), function ($query, $rank) {
                if (in_array($rank, Employee::RANKS, true)) {
                    $query->where('rank', $rank);
                }
            })
            ->when($request->query('branch_id'), function ($query, $branchId) {
                $query->where('branch_id', $branchId);
            })
            ->orderBy('id')
            ->paginate((int) $request->query('per_page', 15));

        return response()->json($employees);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'user_id' => ['required', 'integer', 'exists:users,id', 'unique:employees,user_id'],
            'branch_id' => ['nullable', 'integer', 'exists:branches,id'],
            'agent_id' => ['nullable', 'integer', 'exists:agents,id'],
            'rank' => ['nullable', 'string', Rule::in(Employee::RANKS)],
        ]);

        $data = $this->resolveAgentContext($data);

        $employee = Employee::create($data);

        return response()->json([
            'data' => $employee->load(['user', 'branch', 'agent.user']),
        ], 201);
    }

    public function show(Employee $employee)
    {
        return response()->json([
            'data' => $employee->load(['user', 'branch', 'agent.user']),
        ]);
    }

    public function update(Request $request, Employee $employee)
    {
        $data = $request->validate([
            'user_id' => ['sometimes', 'integer', 'exists:users,id', Rule::unique('employees', 'user_id')->ignore($employee->id)],
            'branch_id' => ['sometimes', 'nullable', 'integer', 'exists:branches,id'],
            'agent_id' => ['sometimes', 'nullable', 'integer', 'exists:agents,id'],
            'rank' => ['sometimes', 'nullable', 'string', Rule::in(Employee::RANKS)],
        ]);

        $resolved = $this->resolveAgentContext(array_merge(
            $employee->only(['user_id', 'branch_id', 'agent_id', 'rank']),
            $data
        ));

        $employee->fill($resolved);
        $employee->save();

        return response()->json([
            'data' => $employee->load(['user', 'branch', 'agent.user']),
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

        if (($data['user_id'] ?? null) && $agent->user_id !== (int) $data['user_id']) {
            throw ValidationException::withMessages([
                'agent_id' => 'The selected agent is not linked to the provided user.',
            ]);
        }

        $data['branch_id'] = $agent->branch_id;

        return $data;
    }
}
