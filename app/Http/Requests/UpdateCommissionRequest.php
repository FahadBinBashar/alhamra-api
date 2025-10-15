<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateCommissionRequest extends FormRequest
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
            'commission_rule_id' => ['sometimes', 'nullable', 'integer', 'exists:commission_rules,id'],
            'payment_id' => ['sometimes', 'nullable', 'integer', 'exists:payments,id'],
            'sales_order_id' => ['sometimes', 'nullable', 'integer', 'exists:sales_orders,id'],
            'recipient_type' => ['sometimes', 'string', 'max:255'],
            'recipient_id' => ['sometimes', 'nullable', 'integer'],
            'amount' => ['sometimes', 'numeric', 'min:0'],
            'status' => ['sometimes', 'string', Rule::in(['unpaid', 'paid'])],
            'paid_at' => ['sometimes', 'nullable', 'date'],
            'meta' => ['sometimes', 'nullable', 'array'],
        ];
    }

    protected function prepareForValidation(): void
    {
        foreach (['commission_rule_id', 'payment_id', 'sales_order_id', 'recipient_id'] as $field) {
            if ($this->exists($field) && $this->input($field) === '') {
                $this->merge([$field => null]);
            }
        }

        if ($this->exists('meta') && is_string($this->input('meta'))) {
            $decoded = json_decode($this->input('meta'), true);

            if (json_last_error() === JSON_ERROR_NONE) {
                $this->merge(['meta' => $decoded]);
            }
        }
    }
}
