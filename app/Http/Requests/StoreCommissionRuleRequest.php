<?php

namespace App\Http\Requests;

use App\Models\CommissionRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreCommissionRuleRequest extends FormRequest
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
            'name' => ['required', 'string', 'max:255'],
            'scope' => ['required', 'string', 'max:255'],
            'trigger' => ['required', 'string', Rule::in([CommissionRule::TRIGGER_ON_PAYMENT])],
            'recipient_type' => ['required', 'string', 'max:255'],
            'recipient_id' => ['nullable', 'integer'],
            'percentage' => ['nullable', 'numeric', 'min:0', 'max:100'],
            'flat_amount' => ['nullable', 'numeric', 'min:0'],
            'active' => ['sometimes', 'boolean'],
            'meta' => ['nullable', 'array'],
        ];
    }

    protected function prepareForValidation(): void
    {
        if ($this->has('active')) {
            $active = filter_var($this->input('active'), FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);
            if ($active !== null) {
                $this->merge(['active' => $active]);
            }
        }

        foreach (['recipient_id', 'percentage', 'flat_amount'] as $field) {
            if ($this->has($field) && $this->input($field) === '') {
                $this->merge([$field => null]);
            }
        }

        if ($this->has('meta') && is_string($this->input('meta'))) {
            $decoded = json_decode($this->input('meta'), true);

            if (json_last_error() === JSON_ERROR_NONE) {
                $this->merge(['meta' => $decoded]);
            }
        }
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator) {
            $defined = array_filter([
                $this->input('percentage'),
                $this->input('flat_amount'),
            ], static fn ($value) => $value !== null);

            if (count($defined) === 0) {
                $validator->errors()->add('percentage', 'Either percentage or flat amount must be provided.');
            }

            if (count($defined) > 1) {
                $validator->errors()->add('percentage', 'Only one of percentage or flat amount may be provided.');
            }
        });
    }
}
