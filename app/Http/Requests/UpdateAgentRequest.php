<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateAgentRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /**
     * @return array<string, mixed>
     */
    public function rules(): array
    {
        $agent = $this->route('agent');
        $agentId = is_object($agent) ? $agent->id : $agent;

        return [
            'user_id' => ['sometimes', 'integer', 'exists:users,id', Rule::unique('agents', 'user_id')->ignore($agentId)],
            'branch_id' => ['sometimes', 'nullable', 'integer', 'exists:branches,id'],
            'agent_code' => ['sometimes', 'string', 'max:255', Rule::unique('agents', 'agent_code')->ignore($agentId)],
        ];
    }
}
