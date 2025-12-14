<?php

namespace App\Services;

use App\Models\AgentWallet;
use App\Models\EmployeeWallet;
use App\Models\LedgerAccount;
use App\Models\User;
use App\Models\WalletWithdrawRequest;
use App\Services\Accounting\LedgerService;
use Illuminate\Support\Facades\DB;
use InvalidArgumentException;

class WalletWithdrawalService
{
    public function __construct(private LedgerService $ledgerService)
    {
    }

    public function approve(WalletWithdrawRequest $withdrawRequest, User $reviewer): WalletWithdrawRequest
    {
        if ($withdrawRequest->status !== WalletWithdrawRequest::STATUS_PENDING) {
            throw new InvalidArgumentException('Only pending requests can be approved.');
        }

        DB::transaction(function () use ($withdrawRequest, $reviewer) {
            $wallet = $this->lockWallet($withdrawRequest);

            if ((float) $withdrawRequest->amount > (float) $wallet->balance) {
                throw new InvalidArgumentException('Insufficient wallet balance for withdrawal.');
            }

            $wallet->balance = (float) $wallet->balance - (float) $withdrawRequest->amount;
            $wallet->save();

            $withdrawRequest->status = WalletWithdrawRequest::STATUS_APPROVED;
            $withdrawRequest->reviewed_by = $reviewer->id;
            $withdrawRequest->reviewed_at = now();
            $withdrawRequest->reject_reason = null;

            $this->recordLedger($withdrawRequest);

            $withdrawRequest->save();
        });

        return $withdrawRequest;
    }

    public function reject(WalletWithdrawRequest $withdrawRequest, User $reviewer, string $reason): WalletWithdrawRequest
    {
        if ($withdrawRequest->status !== WalletWithdrawRequest::STATUS_PENDING) {
            throw new InvalidArgumentException('Only pending requests can be rejected.');
        }

        $withdrawRequest->status = WalletWithdrawRequest::STATUS_REJECTED;
        $withdrawRequest->reviewed_by = $reviewer->id;
        $withdrawRequest->reviewed_at = now();
        $withdrawRequest->reject_reason = $reason;
        $withdrawRequest->save();

        return $withdrawRequest;
    }

    private function lockWallet(WalletWithdrawRequest $withdrawRequest): AgentWallet|EmployeeWallet
    {
        return match ($withdrawRequest->user_type) {
            WalletWithdrawRequest::USER_TYPE_AGENT => $this->lockAgentWallet($withdrawRequest->user_id),
            WalletWithdrawRequest::USER_TYPE_EMPLOYEE => $this->lockEmployeeWallet($withdrawRequest->user_id),
            default => throw new InvalidArgumentException('Unsupported user type for wallet withdrawal.'),
        };
    }

    private function lockAgentWallet(int $agentId): AgentWallet
    {
        $wallet = AgentWallet::query()
            ->where('agent_id', $agentId)
            ->lockForUpdate()
            ->first();

        if (! $wallet) {
            throw new InvalidArgumentException('Agent wallet not found.');
        }

        return $wallet;
    }

    private function lockEmployeeWallet(int $employeeId): EmployeeWallet
    {
        $wallet = EmployeeWallet::query()
            ->where('employee_id', $employeeId)
            ->lockForUpdate()
            ->first();

        if (! $wallet) {
            throw new InvalidArgumentException('Employee wallet not found.');
        }

        return $wallet;
    }

    private function recordLedger(WalletWithdrawRequest $withdrawRequest): void
    {
        $txId = 'wallet_withdrawal_'.$withdrawRequest->id;
        $occurredAt = $withdrawRequest->reviewed_at ?? now();
        $amount = (float) $withdrawRequest->amount;

        $walletAccount = $this->resolveWalletAccount($withdrawRequest);
        $payoutAccount = $this->resolvePayoutAccount($withdrawRequest->method);

        $this->ledgerService->record($txId, $occurredAt, [
            [
                'account_id' => $walletAccount->id,
                'debit' => $amount,
            ],
            [
                'account_id' => $payoutAccount->id,
                'credit' => $amount,
            ],
        ], [
            'withdraw_request_id' => $withdrawRequest->id,
            'user_type' => $withdrawRequest->user_type,
            'user_id' => $withdrawRequest->user_id,
            'method' => $withdrawRequest->method,
        ]);
    }

    private function resolveWalletAccount(WalletWithdrawRequest $withdrawRequest): LedgerAccount
    {
        $code = match ($withdrawRequest->user_type) {
            WalletWithdrawRequest::USER_TYPE_AGENT => 'agent_wallet',
            WalletWithdrawRequest::USER_TYPE_EMPLOYEE => 'employee_wallet',
            default => throw new InvalidArgumentException('Unsupported user type for wallet withdrawal.'),
        };

        $name = match ($withdrawRequest->user_type) {
            WalletWithdrawRequest::USER_TYPE_AGENT => 'Agent Wallet Payable',
            WalletWithdrawRequest::USER_TYPE_EMPLOYEE => 'Employee Wallet Payable',
        };

        return $this->ledgerService->ensureAccount($code, $name, 'liability');
    }

    private function resolvePayoutAccount(string $method): LedgerAccount
    {
        $name = ucfirst($method).' Payout';

        return $this->ledgerService->ensureAccount($method, $name, 'asset');
    }
}
