<?php

namespace App\Services;

use App\Models\Agent;
use App\Models\Branch;
use App\Models\Commission;
use App\Models\CommissionRule;
use App\Models\Payment;
use App\Models\User;
use App\Services\Accounting\LedgerService;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class CommissionService
{
    public function __construct(private LedgerService $ledgerService)
    {
    }

    public function handlePayment(Payment $payment): Collection
    {
        $payment->loadMissing('salesOrder.agent', 'salesOrder.branch');

        $scopes = [$payment->type, CommissionRule::SCOPE_GLOBAL];

        $rank = $payment->salesOrder?->rank;

        if ($rank) {
            $scopes[] = 'rank:' . $rank;
        }

        $rules = CommissionRule::active()
            ->where('trigger', CommissionRule::TRIGGER_ON_PAYMENT)
            ->whereIn('scope', $scopes)
            ->get()
            ->filter(fn (CommissionRule $rule) => $this->shouldApplyRuleToPayment($rule, $payment));

        return DB::transaction(function () use ($payment, $rules) {
            return $rules->map(function (CommissionRule $rule, int $index) use ($payment) {
                $recipient = $this->resolveRecipient($rule, $payment);

                if (! $recipient) {
                    return null;
                }

                $commissionableAmount = $this->resolveCommissionableAmount($rule, $payment);

                $amount = $this->calculateAmount($rule, $commissionableAmount);

                if ($amount <= 0) {
                    return null;
                }

                $commission = Commission::create([
                    'commission_rule_id' => $rule->id,
                    'payment_id' => $payment->id,
                    'sales_order_id' => $payment->sales_order_id,
                    'recipient_type' => $recipient['type'],
                    'recipient_id' => $recipient['id'],
                    'amount' => $amount,
                    'status' => 'unpaid',
                    'meta' => [
                        'payment_type' => $payment->type,
                        'rule_scope' => $rule->scope,
                    ],
                ]);

                $this->recordCommissionLiability($commission);

                return $commission;
            })->filter();
        });
    }

    protected function resolveRecipient(CommissionRule $rule, Payment $payment): ?array
    {
        return match ($rule->recipient_type) {
            'agent' => $payment->salesOrder?->agent ? [
                'type' => Agent::class,
                'id' => $payment->salesOrder->agent->getKey(),
            ] : null,
            'branch' => $payment->salesOrder?->branch ? [
                'type' => Branch::class,
                'id' => $payment->salesOrder->branch->getKey(),
            ] : null,
            'owner', 'director' => $rule->recipient_id ? [
                'type' => User::class,
                'id' => $rule->recipient_id,
            ] : null,
            default => $rule->recipient_id ? [
                'type' => $rule->recipient_type,
                'id' => $rule->recipient_id,
            ] : null,
        };
    }

    protected function calculateAmount(CommissionRule $rule, $paymentAmount): float
    {
        $percentage = (float) ($rule->percentage ?? 0);
        $flat = (float) ($rule->flat_amount ?? 0);

        if ($percentage > 0) {
            return round($paymentAmount * $percentage / 100, 2);
        }

        return round($flat, 2);
    }

    protected function resolveCommissionableAmount(CommissionRule $rule, Payment $payment): float
    {
        $meta = $rule->meta ?? [];

        $base = null;

        if (is_array($meta) && array_key_exists('commission_base', $meta)) {
            $base = $meta['commission_base'];
        }

        return match ($base) {
            'amount' => (float) $payment->amount,
            default => $payment->commissionable_amount,
        };
    }

    protected function shouldApplyRuleToPayment(CommissionRule $rule, Payment $payment): bool
    {
        $meta = $rule->meta ?? [];

        if (! is_array($meta) || ! array_key_exists('applies_to', $meta)) {
            return true;
        }

        $targets = $meta['applies_to'];

        if (is_string($targets)) {
            $targets = [$targets];
        }

        if (! is_array($targets)) {
            return true;
        }

        return in_array($payment->type, $targets, true);
    }

    protected function recordCommissionLiability(Commission $commission): void
    {
        $txId = 'CMS-' . $commission->id;

        $this->ledgerService->record($txId, now(), [
            [
                'account_code' => config('accounting.accounts.commission_expense.code'),
                'account_name' => config('accounting.accounts.commission_expense.name'),
                'account_type' => 'expense',
                'debit' => $commission->amount,
                'credit' => 0,
            ],
            [
                'account_code' => config('accounting.accounts.commission_payable.code'),
                'account_name' => config('accounting.accounts.commission_payable.name'),
                'account_type' => 'liability',
                'debit' => 0,
                'credit' => $commission->amount,
            ],
        ], [
            'commission_id' => $commission->id,
            'recipient_type' => $commission->recipient_type,
            'recipient_id' => $commission->recipient_id,
        ]);
    }
}
