<?php

namespace App\Http\Controllers;

use App\Http\Resources\WalletWithdrawRequestResource;
use App\Models\AgentWallet;
use App\Models\EmployeeWallet;
use App\Models\User;
use App\Models\WalletWithdrawRequest;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class WalletWithdrawRequestController extends Controller
{
    public function store(Request $request): WalletWithdrawRequestResource
    {
        [$userType, $userId] = $this->resolveUserContext($request);

        if (! $userType || ! $userId) {
            abort(422, 'Only agents or employees can submit withdrawal requests.');
        }

        $data = $request->validate([
            'wallet_type' => ['required', 'string', 'max:100'],
            'amount' => ['required', 'numeric', 'min:0.01'],
            'method' => ['required', Rule::in([
                WalletWithdrawRequest::METHOD_BKASH,
                WalletWithdrawRequest::METHOD_NAGAD,
                WalletWithdrawRequest::METHOD_BANK,
                WalletWithdrawRequest::METHOD_CASH,
            ])],
            'method_details' => ['nullable', 'array'],
        ]);

        $withdrawRequest = null;

        DB::transaction(function () use (&$withdrawRequest, $userType, $userId, $data) {
            $wallet = $this->ensureWallet($userType, $userId);

            if ((float) $data['amount'] > (float) $wallet->balance) {
                abort(422, 'Insufficient wallet balance.');
            }

            $withdrawRequest = WalletWithdrawRequest::create([
                'user_type' => $userType,
                'user_id' => $userId,
                'wallet_type' => $data['wallet_type'],
                'amount' => $data['amount'],
                'method' => $data['method'],
                'method_details' => $data['method_details'] ?? null,
                'status' => WalletWithdrawRequest::STATUS_PENDING,
            ]);
        });

        $withdrawRequest->load(['agent.user', 'employee.user', 'reviewer']);

        return new WalletWithdrawRequestResource($withdrawRequest);
    }

    public function history(Request $request): AnonymousResourceCollection
    {
        [$userType, $userId] = $this->resolveUserContext($request);

        if (! $userType || ! $userId) {
            abort(422, 'Only agents or employees can view withdrawal history.');
        }

        $withdrawals = WalletWithdrawRequest::query()
            ->with(['agent.user', 'employee.user', 'reviewer'])
            ->where('user_type', $userType)
            ->where('user_id', $userId)
            ->orderByDesc('created_at')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return WalletWithdrawRequestResource::collection($withdrawals);
    }

    private function ensureWallet(string $userType, int $userId): AgentWallet|EmployeeWallet
    {
        if ($userType === WalletWithdrawRequest::USER_TYPE_AGENT) {
            $wallet = AgentWallet::firstOrCreate(
                ['agent_id' => $userId],
                ['balance' => 0]
            );

            return $wallet;
        }

        if ($userType === WalletWithdrawRequest::USER_TYPE_EMPLOYEE) {
            $wallet = EmployeeWallet::firstOrCreate(
                ['employee_id' => $userId],
                ['balance' => 0]
            );

            return $wallet;
        }

        abort(422, 'Unsupported user type.');
    }

    private function resolveUserContext(Request $request): array
    {
        $user = $request->user();

        if ($user && $user->role === User::ROLE_AGENT) {
            $agentId = $user->agent?->id;

            if ($agentId) {
                return [WalletWithdrawRequest::USER_TYPE_AGENT, $agentId];
            }
        }

        if ($user && $user->role === User::ROLE_EMPLOYEE) {
            $employeeId = $user->employee?->id;

            if ($employeeId) {
                return [WalletWithdrawRequest::USER_TYPE_EMPLOYEE, $employeeId];
            }
        }

        return [null, null];
    }
}
