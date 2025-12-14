<?php

namespace App\Http\Controllers;

use App\Http\Resources\WalletWithdrawRequestResource;
use App\Models\WalletWithdrawRequest;
use App\Services\WalletWithdrawalService;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Validation\Rule;
use InvalidArgumentException;

class AdminWalletWithdrawRequestController extends Controller
{
    public function __construct(private WalletWithdrawalService $walletWithdrawalService)
    {
    }

    public function index(Request $request): AnonymousResourceCollection
    {
        $data = $request->validate([
            'status' => ['nullable', Rule::in([
                WalletWithdrawRequest::STATUS_PENDING,
                WalletWithdrawRequest::STATUS_APPROVED,
                WalletWithdrawRequest::STATUS_REJECTED,
            ])],
        ]);

        $query = WalletWithdrawRequest::query()
            ->with(['agent.user', 'employee.user', 'reviewer'])
            ->orderByDesc('created_at');

        if (! empty($data['status'])) {
            $query->where('status', $data['status']);
        }

        $requests = $query
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return WalletWithdrawRequestResource::collection($requests);
    }

    public function approve(WalletWithdrawRequest $withdrawRequest, Request $request): WalletWithdrawRequestResource
    {
        try {
            $this->walletWithdrawalService->approve($withdrawRequest, $request->user());
        } catch (InvalidArgumentException $e) {
            abort(422, $e->getMessage());
        }

        return new WalletWithdrawRequestResource($withdrawRequest->fresh(['agent.user', 'employee.user', 'reviewer']));
    }

    public function reject(WalletWithdrawRequest $withdrawRequest, Request $request): WalletWithdrawRequestResource
    {
        $data = $request->validate([
            'reason' => ['required', 'string'],
        ]);

        try {
            $this->walletWithdrawalService->reject($withdrawRequest, $request->user(), $data['reason']);
        } catch (InvalidArgumentException $e) {
            abort(422, $e->getMessage());
        }

        return new WalletWithdrawRequestResource($withdrawRequest->fresh(['agent.user', 'employee.user', 'reviewer']));
    }
}
