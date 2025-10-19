<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreCommissionSettingRequest extends FormRequest
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
            'key' => ['required', 'string', 'max:255', Rule::unique('commission_settings', 'key')],
            'value' => ['required'],
        ];
    }

    protected function prepareForValidation(): void
    {
        if ($this->has('value') && is_string($this->input('value'))) {
            $decoded = json_decode($this->input('value'), true);

            if (json_last_error() === JSON_ERROR_NONE) {
                $this->merge(['value' => $decoded]);
            }
        }
    }
}
