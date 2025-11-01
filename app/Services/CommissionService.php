<?php

namespace App\Services;

use App\Models\Agent;
use App\Models\Branch;
use App\Models\Commission;
use App\Models\CommissionCalculationUnit;
use App\Models\CommissionSetting;
use App\Models\Employee;
use App\Models\EmployeeWallet;
use App\Models\Payment;
use App\Models\SalesOrder;
use App\Services\Accounting\LedgerService;
use Carbon\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;

class CommissionService
{
    public function __construct(private LedgerService $ledgerService)
    {
    }

    public function handlePayment(Payment $payment, bool $persist = false): Collection
    {
        $payment->loadMissing(
            'salesOrder.agent',
            'salesOrder.branch',
            'salesOrder.sourceMe.superior'
        );

        if (! $payment->salesOrder) {
            return collect();
        }

        $commissions = collect();

        if ($this->isServiceOrder($payment->salesOrder)) {
            $serviceCommission = $this->createServiceCommissionPayload($payment);

            if ($serviceCommission) {
                $commissions->push($serviceCommission);
            }
        } else {
            $commissions = $commissions->merge($this->createDevelopmentGapCommissions($payment));
        }

        $commissions = $commissions->filter()->values();

        if (! $persist) {
            return $commissions;
        }

        $unit = $this->storeCalculationUnitFromPayloads($payment, $commissions);

        return $unit->items;
    }

    protected function createServiceCommissionPayload(Payment $payment): ?array
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

        return [
            'recipient_type' => $recipient['type'],
            'recipient_id' => $recipient['id'],
            'amount' => $amount,
            'meta' => [
                'category' => 'service_sales',
                'payment_type' => $payment->type,
                'order_created_by' => $order->created_by,
            ],
        ];
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

    protected function createDevelopmentGapCommissions(Payment $payment): Collection
    {
        $order = $payment->salesOrder;
        $source = $order->sourceMe;

        if (! $source) {
            return collect();
        }

        $chain = $this->buildSuperiorChain($source)
            ->filter(fn (Employee $employee) => $this->employeeEligibleForCommission($employee));

        if ($chain->isEmpty()) {
            return collect();
        }

        $percentageKey = $payment->type === Payment::TYPE_INSTALLMENT ? 'installment' : 'down_payment';
        $definitions = $this->getArraySetting('development_bonus');

        if (empty($definitions)) {
            return collect();
        }

        $commissions = collect();
        $previousPercent = 0.0;

        foreach ($chain as $employee) {
            $rank = $employee->rank;
            $config = $definitions[$rank] ?? null;

            if (! $config || ! array_key_exists($percentageKey, $config)) {
                continue;
            }

            $targetPercent = (float) $config[$percentageKey];

            if ($targetPercent <= $previousPercent) {
                continue;
            }

            $percentage = $targetPercent - $previousPercent;
            $previousPercent = $targetPercent;

            $amount = $this->calculatePercentageAmount($percentage, $payment->commissionable_amount);

            if ($amount <= 0) {
                continue;
            }

            $commissions->push([
                'recipient_type' => Employee::class,
                'recipient_id' => $employee->getKey(),
                'amount' => $amount,
                'percentage' => $percentage,
                'meta' => [
                    'category' => 'development_bonus',
                    'rank' => $employee->rank,
                    'payment_type' => $payment->type,
                ],
            ]);
        }

        return $commissions;
    }

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

    public function processPendingCommissions(?Carbon $upTo = null): Collection
    {
        $query = CommissionCalculationUnit::query()
            ->where('status', 'draft')
            ->with(['payment.salesOrder.agent', 'payment.salesOrder.branch', 'payment.salesOrder.sourceMe.superior', 'items']);

        if ($upTo) {
            $query->whereHas('payment', function ($paymentQuery) use ($upTo) {
                $paymentQuery->whereDate('paid_at', '<=', $upTo->toDateString());
            });
        }

        $units = $query->get();
        $created = collect();

        foreach ($units as $unit) {
            $payment = $unit->payment;

            if (! $payment || ! $payment->salesOrder) {
                $unit->delete();
                continue;
            }

            DB::transaction(function () use (&$created, $payment, $unit) {
                $processedAt = now();

                foreach ($unit->items as $item) {
                    $payload = [
                        'recipient_type' => $item->recipient_type,
                        'recipient_id' => $item->recipient_id,
                        'amount' => (float) $item->amount,
                        'status' => 'paid',
                        'paid_at' => $processedAt,
                        'meta' => array_merge($item->meta ?? [], [
                            'calculation_unit_id' => $unit->id,
                            'calculation_item_id' => $item->id,
                        ]),
                    ];

                    if ($item->percentage !== null) {
                        $payload['percentage'] = (float) $item->percentage;
                    }

                    $commission = $this->storeCommissionFromPayload($payment, $payload);
                    $created->push($commission);
                }

                $unit->forceFill([
                    'status' => 'paid',
                    'processed_at' => $processedAt,
                ])->save();

                $payment->forceFill([
                    'commission_processed_at' => $processedAt,
                ])->save();
            });
        }

        return $created;
    }

    protected function storeCommissionFromPayload(Payment $payment, array $payload): Commission
    {
        $meta = $payload['meta'] ?? [];

        if (isset($payload['percentage'])) {
            $meta['percentage'] = $payload['percentage'];
        }

        $status = $payload['status'] ?? 'unpaid';
        $paidAt = $payload['paid_at'] ?? null;

        if ($paidAt && ! $paidAt instanceof Carbon) {
            $paidAt = Carbon::parse($paidAt);
        }

        $commission = $this->storeCommission(
            $payment,
            $payload['recipient_type'],
            (int) $payload['recipient_id'],
            (float) $payload['amount'],
            $meta,
            $status,
            $paidAt
        );

        if ($status === 'paid' && $commission->recipient_type === Employee::class) {
            $this->creditEmployeeWallet((int) $commission->recipient_id, (float) $commission->amount);
        }

        return $commission;
    }

    protected function storeCalculationUnitFromPayloads(Payment $payment, Collection $payloads): CommissionCalculationUnit
    {
        return DB::transaction(function () use ($payment, $payloads) {
            /** @var CommissionCalculationUnit $unit */
            $unit = CommissionCalculationUnit::query()->firstOrNew([
                'payment_id' => $payment->id,
            ]);

            $meta = array_merge($unit->meta ?? [], [
                'commissionable_amount' => $payment->commissionable_amount,
                'payment_type' => $payment->type,
                'order_created_by' => $payment->salesOrder?->created_by,
            ]);

            $unit->fill([
                'sales_order_id' => $payment->sales_order_id,
                'status' => $unit->status === 'paid' ? 'paid' : 'draft',
                'calculated_at' => now(),
                'meta' => $meta,
            ]);

            if ($unit->status !== 'paid') {
                $unit->status = 'draft';
            }

            $unit->save();

            if ($unit->status === 'draft') {
                $unit->items()->delete();

                foreach ($payloads as $payload) {
                    $itemMeta = $payload['meta'] ?? [];

                    if (isset($payload['percentage'])) {
                        $itemMeta['percentage'] = $payload['percentage'];
                    }

                    $unit->items()->create([
                        'recipient_type' => $payload['recipient_type'],
                        'recipient_id' => $payload['recipient_id'],
                        'amount' => $payload['amount'],
                        'percentage' => $payload['percentage'] ?? null,
                        'meta' => $itemMeta,
                    ]);
                }
            }

            return $unit->load('items');
        });
    }

    protected function creditEmployeeWallet(int $employeeId, float $amount): void
    {
        $wallet = EmployeeWallet::query()
            ->where('employee_id', $employeeId)
            ->lockForUpdate()
            ->first();

        if (! $wallet) {
            $wallet = new EmployeeWallet([
                'employee_id' => $employeeId,
                'balance' => 0,
            ]);
        }

        $wallet->balance = (float) $wallet->balance + $amount;
        $wallet->employee_id = $employeeId;
        $wallet->save();
    }

    protected function storeCommission(
        Payment $payment,
        string $recipientType,
        int $recipientId,
        float $amount,
        array $meta = [],
        string $status = 'unpaid',
        ?Carbon $paidAt = null
    ): Commission
    {
        $commission = Commission::create([
            'payment_id' => $payment->id,
            'sales_order_id' => $payment->sales_order_id,
            'recipient_type' => $recipientType,
            'recipient_id' => $recipientId,
            'amount' => $amount,
            'status' => $status,
            'paid_at' => $paidAt,
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
