<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateProductRequest extends FormRequest
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
            'category_id' => ['sometimes', 'required', 'integer', 'exists:categories,id'],
            'name' => ['sometimes', 'required', 'string', 'max:255'],
            'supplier_id' => ['sometimes', 'nullable', 'integer', 'exists:suppliers,id'],
            'supplier_percentage' => ['sometimes', 'nullable', 'integer', 'min:0', 'max:100'],
            'supplier_down_payment_percentage' => ['sometimes', 'nullable', 'integer', 'min:0', 'max:100'],
            'product_type' => ['sometimes', 'required', 'in:consumer,flat,land,share,other'],
            'price' => ['sometimes', 'nullable', 'numeric', 'min:0'],
            'description' => ['sometimes', 'nullable', 'string'],
            'down_payment' => ['sometimes', 'nullable', 'numeric', 'min:0'],
            'ccu_percentage' => ['sometimes', 'numeric', 'min:0', 'max:100'],
            'attributes' => ['sometimes', 'nullable', 'array'],
            'image' => ['sometimes', 'nullable', 'image', 'max:10240'],
            'images' => ['sometimes', 'nullable', 'array', 'max:10'],
            'images.*' => ['image', 'max:10240'],
            'stock_qty' => ['sometimes', 'numeric', 'min:0'],
            'min_stock_alert' => ['sometimes', 'numeric', 'min:0'],
            'is_stock_managed' => ['sometimes', 'boolean'],
            'emi_rules' => ['sometimes', 'array'],
            'emi_rules.*.tenure_months' => ['required_with:emi_rules', 'integer', 'min:1'],
            'emi_rules.*.rules' => ['required_with:emi_rules', 'array', 'min:1'],
            'emi_rules.*.rules.*.month' => ['required_with:emi_rules.*.rules', 'integer', 'min:1'],
            'emi_rules.*.rules.*.type' => ['required_with:emi_rules.*.rules', 'string', 'in:percent,flat'],
            'emi_rules.*.rules.*.percent' => ['nullable', 'numeric', 'min:0', 'max:100'],
            'emi_rules.*.rules.*.flat_amount' => ['nullable', 'numeric', 'min:0'],
            'emi_rules.*.rules.*.meta' => ['nullable', 'array'],
            'emi_plans' => ['sometimes', 'array'],
            'emi_plans.*.tenure_months' => ['required_with:emi_plans', 'integer', 'min:1'],
            'emi_plans.*.extra_type' => ['required_with:emi_plans', 'string', 'in:percent,flat'],
            'emi_plans.*.extra_value' => ['required_with:emi_plans', 'numeric', 'min:0'],
            'emi_plans.*.meta' => ['nullable', 'array'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator) {
            $emiRules = $this->input('emi_rules');

            if (is_array($emiRules)) {
                foreach ($emiRules as $planIndex => $plan) {
                    $tenureMonths = (int) ($plan['tenure_months'] ?? 0);
                    $rules = $plan['rules'] ?? [];

                    foreach ($rules as $ruleIndex => $rule) {
                        $month = (int) ($rule['month'] ?? 0);
                        $type = $rule['type'] ?? null;

                        if ($tenureMonths > 0 && $month > $tenureMonths) {
                            $validator->errors()->add("emi_rules.$planIndex.rules.$ruleIndex.month", 'The month must be within tenure months.');
                        }

                        if ($type === 'percent' && ! array_key_exists('percent', $rule)) {
                            $validator->errors()->add("emi_rules.$planIndex.rules.$ruleIndex.percent", 'Percent is required for percent rules.');
                        }

                        if ($type === 'flat' && ! array_key_exists('flat_amount', $rule)) {
                            $validator->errors()->add("emi_rules.$planIndex.rules.$ruleIndex.flat_amount", 'Flat amount is required for flat rules.');
                        }
                    }
                }
            }

            $emiPlans = $this->input('emi_plans');

            if (is_array($emiPlans)) {
                foreach ($emiPlans as $planIndex => $plan) {
                    $type = $plan['extra_type'] ?? null;
                    $value = (float) ($plan['extra_value'] ?? -1);

                    if ($type === 'percent' && ($value < 0 || $value > 100)) {
                        $validator->errors()->add("emi_plans.$planIndex.extra_value", 'Percentage extra must be between 0 and 100.');
                    }

                    if ($type === 'flat' && $value < 0) {
                        $validator->errors()->add("emi_plans.$planIndex.extra_value", 'Flat extra must be a positive number.');
                    }
                }
            }
        });
    }
}
