<?php

namespace App\Services;

use App\Models\Agent;
use App\Models\AgentSettlement;
use App\Models\Payment;
use App\Models\User;
use App\Services\Accounting\LedgerService;
use Illuminate\Support\Facades\DB;
use InvalidArgumentException;

class AgentSettlementService
{
    public function __construct(private LedgerService $ledgerService)
    {
    }

    public function availableAmount(int $agentId): float
    {
        $collected = (float) Payment::query()
            ->whereHas('salesOrder', fn ($query) => $query->where('agent_id', $agentId))
            ->sum('amount');

        $alreadyRequested = (float) AgentSettlement::query()
            ->where('agent_id', $agentId)
            ->whereIn('status', [AgentSettlement::STATUS_PENDING, AgentSettlement::STATUS_APPROVED])
            ->sum('amount');

        return max(round($collected - $alreadyRequested, 2), 0.0);
    }

    public function approve(AgentSettlement $settlement, User $admin): AgentSettlement
    {
        if ($settlement->status !== AgentSettlement::STATUS_PENDING) {
            throw new InvalidArgumentException('Only pending settlements can be approved.');
        }

        DB::transaction(function () use ($settlement, $admin) {
            $settlement->status = AgentSettlement::STATUS_APPROVED;
            $settlement->approved_by = $admin->id;
            $settlement->approved_at = now();
            $settlement->admin_note = null;
            $settlement->rejected_at = null;
            $settlement->save();

            $this->recordLedger($settlement);
        });

        return $settlement;
    }

    public function reject(AgentSettlement $settlement, User $admin, string $reason): AgentSettlement
    {
        if ($settlement->status !== AgentSettlement::STATUS_PENDING) {
            throw new InvalidArgumentException('Only pending settlements can be rejected.');
        }

        $settlement->status = AgentSettlement::STATUS_REJECTED;
        $settlement->approved_by = $admin->id;
        $settlement->approved_at = null;
        $settlement->rejected_at = now();
        $settlement->admin_note = $reason;
        $settlement->save();

        return $settlement;
    }

    private function recordLedger(AgentSettlement $settlement): void
    {
        $companyAccountCode = $settlement->payment_method === AgentSettlement::PAYMENT_METHOD_BANK
            ? config('accounting.accounts.bank.code')
            : config('accounting.accounts.cash.code');

        $companyAccountName = $settlement->payment_method === AgentSettlement::PAYMENT_METHOD_BANK
            ? config('accounting.accounts.bank.name')
            : config('accounting.accounts.cash.name');

        $agent = Agent::query()->with('user')->find($settlement->agent_id);

        $txId = 'agent_settlement_'.$settlement->id;

        $this->ledgerService->record($txId, $settlement->approved_at ?? now(), [
            [
                'account_code' => $companyAccountCode,
                'account_name' => $companyAccountName,
                'account_type' => 'asset',
                'debit' => (float) $settlement->amount,
            ],
            [
                'account_code' => 'agent_hand_cash',
                'account_name' => 'Agent Hand Cash',
                'account_type' => 'asset',
                'credit' => (float) $settlement->amount,
            ],
        ], [
            'agent_settlement_id' => $settlement->id,
            'agent_id' => $settlement->agent_id,
            'agent_name' => $agent?->user?->name,
            'payment_method' => $settlement->payment_method,
            'reference_no' => $settlement->reference_no,
        ]);
    }
}
