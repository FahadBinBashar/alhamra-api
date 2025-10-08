<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreAgentRequest extends FormRequest
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
        return [
            'user_id' => ['required', 'integer', 'exists:users,id', 'unique:agents,user_id'],
            'branch_id' => ['nullable', 'integer', 'exists:branches,id'],
            'agent_code' => ['required', 'string', 'max:255', 'unique:agents,agent_code'],
        ];
    }
}
