<?php

namespace App\Services;

use App\Models\Agent;
use App\Models\Branch;
use App\Models\Commission;
use App\Models\CommissionSetting;
use App\Models\Employee;
use App\Models\Payment;
use App\Models\SalesOrder;
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
        $payment->loadMissing(
            'salesOrder.agent',
            'salesOrder.branch',
            'salesOrder.sourceMe.superior'
        );

        if (! $payment->salesOrder) {
            return collect();
        }

        return DB::transaction(function () use ($payment) {
            $commissions = collect();

            if ($this->isServiceOrder($payment->salesOrder)) {
                $serviceCommission = $this->createServiceCommission($payment);

                if ($serviceCommission) {
                    $commissions->push($serviceCommission);
                }

                return $commissions;
            }

            $commissions = $commissions->merge($this->createAgentAndBranchCommissions($payment));
            $commissions = $commissions->merge($this->createDevelopmentBonuses($payment));

            return $commissions->filter();
        });
    }

    protected function createServiceCommission(Payment $payment): ?Commission
    {
        $order = $payment->salesOrder;
        $serviceConfig = CommissionSetting::value('service_sales', null);

        if (is_array($serviceConfig)) {
            $percentage = (float) ($serviceConfig['percentage'] ?? 15);
        } elseif ($serviceConfig !== null) {
            $percentage = (float) $serviceConfig;
        } else {
            $percentage = 15.0;
        }

        if ($percentage <= 0) {
            return null;
        }

        $recipient = $this->resolveServiceRecipient($order);

        if (! $recipient) {
            return null;
        }

        $amount = $this->calculatePercentageAmount($percentage, $payment->commissionable_amount);

        if ($amount <= 0) {
            return null;
        }

        return $this->storeCommission($payment, $recipient['type'], $recipient['id'], $amount, [
            'category' => 'service_sales',
            'payment_type' => $payment->type,
            'order_created_by' => $order->created_by,
        ]);
    }

    protected function resolveServiceRecipient(SalesOrder $order): ?array
    {
        if ($order->agent) {
            return [
                'type' => Agent::class,
                'id' => $order->agent->getKey(),
            ];
        }

        $source = $order->sourceMe;

        if ($source && $this->employeeEligibleForCommission($source)) {
            return [
                'type' => Employee::class,
                'id' => $source->getKey(),
            ];
        }

        if ($order->branch) {
            return [
                'type' => Branch::class,
                'id' => $order->branch->getKey(),
            ];
        }

        return null;
    }

    // protected function createAgentAndBranchCommissions(Payment $payment): Collection
    // {
    //     $order = $payment->salesOrder;
    //     $commissions = collect();
    //     $percentageKey = $payment->type === Payment::TYPE_INSTALLMENT ? 'installment' : 'down_payment';

    //     $agentRates = $this->getArraySetting('agent_rates');
    //     $branchRates = $this->getArraySetting('branch_rates');

    //     if ($order->created_by === SalesOrder::CREATED_BY_AGENT && $order->agent) {
    //         $percentage = (float) ($agentRates[$percentageKey] ?? 0);

    //         if ($percentage > 0) {
    //             $amount = $this->calculatePercentageAmount($percentage, $payment->commissionable_amount);

    //             if ($amount > 0) {
    //                 $commissions->push($this->storeCommission($payment, Agent::class, $order->agent->getKey(), $amount, [
    //                     'category' => 'agent',
    //                     'payment_type' => $payment->type,
    //                 ]));
    //             }
    //         }

    //         return $commissions;
    //     }

    //     if ($order->branch) {
    //         $percentage = (float) ($branchRates[$percentageKey] ?? 0);

    //         if ($percentage > 0) {
    //             $amount = $this->calculatePercentageAmount($percentage, $payment->commissionable_amount);

    //             if ($amount > 0) {
    //                 $commissions->push($this->storeCommission($payment, Branch::class, $order->branch->getKey(), $amount, [
    //                     'category' => 'branch',
    //                     'payment_type' => $payment->type,
    //                 ]));
    //             }
    //         }
    //     }

    //     if ($order->agent) {
    //         $percentage = (float) ($agentRates[$percentageKey] ?? 0);

    //         if ($percentage > 0) {
    //             $amount = $this->calculatePercentageAmount($percentage, $payment->commissionable_amount);

    //             if ($amount > 0) {
    //                 $commissions->push($this->storeCommission($payment, Agent::class, $order->agent->getKey(), $amount, [
    //                     'category' => 'agent',
    //                     'payment_type' => $payment->type,
    //                 ]));
    //             }
    //         }
    //     }

    //     return $commissions;
    // }

    // protected function createDevelopmentBonuses(Payment $payment): Collection
    // {
    //     $order = $payment->salesOrder;
    //     $source = $order->sourceMe;

    //     if (! $source) {
    //         return collect();
    //     }

    //     $chain = $this->buildSuperiorChain($source);

    //     if ($chain->isEmpty()) {
    //         return collect();
    //     }

    //     $percentageKey = $payment->type === Payment::TYPE_INSTALLMENT ? 'installment' : 'down_payment';
    //     $definitions = $this->getArraySetting('development_bonus');

    //     if (empty($definitions)) {
    //         return collect();
    //     }

    //     $commissions = collect();
    //     $previousPercent = 0.0;

    //     foreach ($definitions as $rank => $config) {
    //         $recipient = $chain->first(fn (Employee $employee) => $employee->rank === $rank);

    //         if (! $recipient || ! $this->employeeEligibleForCommission($recipient)) {
    //             continue;
    //         }

    //         $targetPercent = (float) ($config[$percentageKey] ?? 0);

    //         if ($targetPercent <= $previousPercent) {
    //             continue;
    //         }

    //         $percentage = $targetPercent - $previousPercent;
    //         $previousPercent = $targetPercent;

    //         $amount = $this->calculatePercentageAmount($percentage, $payment->commissionable_amount);

    //         if ($amount <= 0) {
    //             continue;
    //         }

    //         $commissions->push($this->storeCommission($payment, Employee::class, $recipient->getKey(), $amount, [
    //             'category' => 'development_bonus',
    //             'rank' => $recipient->rank,
    //             'payment_type' => $payment->type,
    //         ]));
    //     }

    //     return $commissions;
    // }

    protected function buildSuperiorChain(Employee $employee): Collection
    {
        $chain = collect();
        $current = $employee;

        while ($current) {
            $chain->push($current);
            $current->loadMissing('superior');
            $current = $current->superior;
        }

        return $chain;
    }

    protected function employeeEligibleForCommission(Employee $employee): bool
    {
        $eligibleRanks = array_keys($this->getArraySetting('development_bonus'));

        return in_array($employee->rank, $eligibleRanks, true);
    }

    protected function isServiceOrder(SalesOrder $order): bool
    {
        return $order->sales_type === SalesOrder::TYPE_SERVICE;
    }

    protected function calculatePercentageAmount(float $percentage, float $baseAmount): float
    {
        return round($baseAmount * $percentage / 100, 2);
    }

    protected function getArraySetting(string $key): array
    {
        $value = CommissionSetting::value($key, []);

        return is_array($value) ? $value : [];
    }

    protected function storeCommission(Payment $payment, string $recipientType, int $recipientId, float $amount, array $meta = []): Commission
    {
        $commission = Commission::create([
            'payment_id' => $payment->id,
            'sales_order_id' => $payment->sales_order_id,
            'recipient_type' => $recipientType,
            'recipient_id' => $recipientId,
            'amount' => $amount,
            'status' => 'unpaid',
            'meta' => array_filter(array_merge($meta, [
                'payment_type' => $payment->type,
                'order_created_by' => $payment->salesOrder?->created_by,
                'source_me_id' => $payment->salesOrder?->source_me_id,
            ])),
        ]);

        $this->recordCommissionLiability($commission);

        return $commission;
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
