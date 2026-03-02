<?php

namespace App\Http\Controllers;

use App\Models\EmployeeWalletTransaction;
use App\Models\PromotionAward;
use App\Models\PromotionEligibility;
use App\Models\PromotionRule;
use App\Models\PromotionSession;
use App\Services\PromotionService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class PromotionController extends Controller
{
    public function __construct(private PromotionService $promotionService)
    {
    }

    public function sessions(Request $request): JsonResponse
    {
        $sessions = PromotionSession::query()
            ->with('rules')
            ->orderByDesc('id')
            ->paginate((int) $request->get('per_page', 15));

        return response()->json($sessions);
    }

    public function storeSession(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'session_type' => ['required', Rule::in(PromotionSession::TYPES)],
            'start_date' => ['required', 'date'],
            'end_date' => ['required', 'date', 'after:start_date'],
            'target_metric' => ['sometimes', 'string', 'max:100'],
            'target_value' => ['required', 'integer', 'min:1'],
            'min_product_or_share_sales' => ['sometimes', 'integer', 'min:2'],
            'rules' => ['required', 'array', 'min:1'],
            'rules.*.slot_no' => ['required', 'integer', 'min:1'],
            'rules.*.eligibility_basis' => ['required', Rule::in(PromotionRule::BASIS_TYPES)],
            'rules.*.finance_verified_only' => ['sometimes', 'boolean'],
            'rules.*.incentive_type' => ['required', Rule::in(PromotionRule::INCENTIVE_TYPES)],
            'rules.*.fund_amount' => ['nullable', 'numeric', 'min:0.01'],
            'rules.*.currency' => ['nullable', 'string', 'max:10'],
        ]);

        if ($validated['session_type'] === PromotionSession::TYPE_YEARLY) {
            foreach ($validated['rules'] as $rule) {
                if ($rule['eligibility_basis'] !== PromotionRule::BASIS_COMBINED) {
                    return response()->json([
                        'message' => 'Yearly session requires combined_step_1_2 eligibility basis.',
                    ], 422);
                }
            }
        }

        if ($validated['session_type'] === PromotionSession::TYPE_MONTHLY) {
            foreach ($validated['rules'] as $rule) {
                if (! in_array($rule['eligibility_basis'], [PromotionRule::BASIS_PERSONAL, PromotionRule::BASIS_FIRST_STEP], true)) {
                    return response()->json([
                        'message' => 'Monthly session allows only personal or first_step eligibility basis.',
                    ], 422);
                }
            }
        }

        $session = PromotionSession::create([
            'name' => $validated['name'],
            'session_type' => $validated['session_type'],
            'start_date' => $validated['start_date'],
            'end_date' => $validated['end_date'],
            'status' => PromotionSession::STATUS_DRAFT,
            'target_metric' => $validated['target_metric'] ?? 'down_payment_count',
            'target_value' => $validated['target_value'],
            'min_product_or_share_sales' => $validated['min_product_or_share_sales'] ?? 2,
            'created_by' => $request->user()?->id,
            'updated_by' => $request->user()?->id,
        ]);

        foreach ($validated['rules'] as $ruleData) {
            $session->rules()->create([
                'slot_no' => $ruleData['slot_no'],
                'eligibility_basis' => $ruleData['eligibility_basis'],
                'finance_verified_only' => $ruleData['finance_verified_only'] ?? true,
                'incentive_type' => $ruleData['incentive_type'],
                'fund_amount' => $ruleData['fund_amount'] ?? null,
                'currency' => $ruleData['currency'] ?? 'BDT',
            ]);
        }

        return response()->json($session->load('rules'), 201);
    }

    public function updateSession(Request $request, PromotionSession $session): JsonResponse
    {
        $validated = $request->validate([
            'name' => ['sometimes', 'string', 'max:255'],
            'start_date' => ['sometimes', 'date'],
            'end_date' => ['sometimes', 'date', 'after:start_date'],
            'target_metric' => ['sometimes', 'string', 'max:100'],
            'target_value' => ['sometimes', 'integer', 'min:1'],
            'min_product_or_share_sales' => ['sometimes', 'integer', 'min:2'],
            'rules' => ['sometimes', 'array', 'min:1'],
            'rules.*.slot_no' => ['required_with:rules', 'integer', 'min:1'],
            'rules.*.eligibility_basis' => ['required_with:rules', Rule::in(PromotionRule::BASIS_TYPES)],
            'rules.*.finance_verified_only' => ['sometimes', 'boolean'],
            'rules.*.incentive_type' => ['required_with:rules', Rule::in(PromotionRule::INCENTIVE_TYPES)],
            'rules.*.fund_amount' => ['nullable', 'numeric', 'min:0.01'],
            'rules.*.currency' => ['nullable', 'string', 'max:10'],
        ]);

        if (isset($validated['end_date']) && ! isset($validated['start_date'])) {
            $request->validate([
                'end_date' => ['date', 'after_or_equal:'.$session->start_date->toDateString()],
            ]);
        }

        $session->fill([
            'name' => $validated['name'] ?? $session->name,
            'start_date' => $validated['start_date'] ?? $session->start_date,
            'end_date' => $validated['end_date'] ?? $session->end_date,
            'target_metric' => $validated['target_metric'] ?? $session->target_metric,
            'target_value' => $validated['target_value'] ?? $session->target_value,
            'min_product_or_share_sales' => $validated['min_product_or_share_sales'] ?? $session->min_product_or_share_sales,
            'updated_by' => $request->user()?->id,
        ])->save();

        if (isset($validated['rules'])) {
            foreach ($validated['rules'] as $rule) {
                if ($session->session_type === PromotionSession::TYPE_YEARLY && $rule['eligibility_basis'] !== PromotionRule::BASIS_COMBINED) {
                    return response()->json([
                        'message' => 'Yearly session requires combined_step_1_2 eligibility basis.',
                    ], 422);
                }

                if ($session->session_type === PromotionSession::TYPE_MONTHLY && ! in_array($rule['eligibility_basis'], [PromotionRule::BASIS_PERSONAL, PromotionRule::BASIS_FIRST_STEP], true)) {
                    return response()->json([
                        'message' => 'Monthly session allows only personal or first_step eligibility basis.',
                    ], 422);
                }
            }

            $session->rules()->delete();
            foreach ($validated['rules'] as $ruleData) {
                $session->rules()->create([
                    'slot_no' => $ruleData['slot_no'],
                    'eligibility_basis' => $ruleData['eligibility_basis'],
                    'finance_verified_only' => $ruleData['finance_verified_only'] ?? true,
                    'incentive_type' => $ruleData['incentive_type'],
                    'fund_amount' => $ruleData['fund_amount'] ?? null,
                    'currency' => $ruleData['currency'] ?? 'BDT',
                ]);
            }
        }

        return response()->json($session->fresh('rules'));
    }

    public function deleteSession(PromotionSession $session): JsonResponse
    {
        if ($session->status === PromotionSession::STATUS_ACTIVE) {
            return response()->json([
                'message' => 'Active session cannot be deleted. Close it first.',
            ], 422);
        }

        $session->delete();

        return response()->json(['message' => 'Session deleted.']);
    }


    public function activateSession(Request $request, PromotionSession $session): JsonResponse
    {
        $session->forceFill([
            'status' => PromotionSession::STATUS_ACTIVE,
            'updated_by' => $request->user()?->id,
        ])->save();

        return response()->json(['message' => 'Session activated.']);
    }

    public function closeSession(Request $request, PromotionSession $session): JsonResponse
    {
        $session->forceFill([
            'status' => PromotionSession::STATUS_CLOSED,
            'updated_by' => $request->user()?->id,
        ])->save();

        return response()->json(['message' => 'Session closed.']);
    }

    public function calculateEligibility(PromotionSession $session): JsonResponse
    {
        $result = $this->promotionService->calculateEligibility($session);

        return response()->json($result);
    }

    public function generateAwards(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'session_id' => ['required', 'integer', 'exists:promotion_sessions,id'],
        ]);

        $session = PromotionSession::findOrFail($validated['session_id']);
        $generated = $this->promotionService->generateAwards($session, (int) $request->user()?->id);

        return response()->json(['generated' => $generated]);
    }

    public function processAwards(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'session_id' => ['required', 'integer', 'exists:promotion_sessions,id'],
        ]);

        $session = PromotionSession::findOrFail($validated['session_id']);
        $result = $this->promotionService->processAwards($session, (int) $request->user()?->id);

        return response()->json($result);
    }

    public function employeeAchievements(Request $request): JsonResponse
    {
        $employee = $request->user()?->employee;

        if (! $employee) {
            return response()->json(['message' => 'Employee profile not found.'], 404);
        }

        $awards = PromotionAward::query()
            ->with(['session:id,name', 'rule:id,slot_no,incentive_type'])
            ->where('employee_id', $employee->id)
            ->where('award_status', PromotionAward::STATUS_PROCESSED)
            ->orderByDesc('processed_at')
            ->get()
            ->map(fn (PromotionAward $award) => [
                'session_name' => $award->session?->name,
                'slot' => $award->rule?->slot_no,
                'incentive_type' => $award->rule?->incentive_type,
                'award_date' => $award->processed_at?->toDateString(),
            ]);

        return response()->json(['data' => $awards]);
    }

    public function employeeProgress(Request $request): JsonResponse
    {
        $employee = $request->user()?->employee;

        if (! $employee) {
            return response()->json(['message' => 'Employee profile not found.'], 404);
        }

        $progress = PromotionEligibility::query()
            ->with(['session:id,name,target_value,session_type,start_date,end_date', 'rule:id,slot_no,eligibility_basis'])
            ->where('employee_id', $employee->id)
            ->orderByDesc('id')
            ->get()
            ->map(fn (PromotionEligibility $row) => [
                'session_name' => $row->session?->name,
                'session_type' => $row->session?->session_type,
                'period' => [
                    'start_date' => $row->session?->start_date?->toDateString(),
                    'end_date' => $row->session?->end_date?->toDateString(),
                ],
                'slot' => $row->rule?->slot_no,
                'target' => (int) ($row->session?->target_value ?? 0),
                'current_down_payment_count' => (int) $row->current_down_payment_count,
                'remaining' => max((int) ($row->session?->target_value ?? 0) - (int) $row->current_down_payment_count, 0),
                'eligibility_type' => $row->rule?->eligibility_basis,
                'status' => $row->eligibility_status,
            ]);

        return response()->json(['data' => $progress]);
    }

    public function employeeWalletTransactions(Request $request): JsonResponse
    {
        $employee = $request->user()?->employee;

        if (! $employee) {
            return response()->json(['message' => 'Employee profile not found.'], 404);
        }

        $transactions = EmployeeWalletTransaction::query()
            ->where('employee_id', $employee->id)
            ->where('type', EmployeeWalletTransaction::TYPE_PROMOTION_REWARD)
            ->latest()
            ->paginate((int) $request->get('per_page', 15));

        return response()->json($transactions);
    }
}
