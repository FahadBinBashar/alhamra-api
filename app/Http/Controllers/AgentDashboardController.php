<?php

namespace App\Http\Controllers;

use App\Http\Resources\AgentWalletResource;
use App\Http\Resources\CommissionResource;
use App\Models\Agent;
use App\Models\AgentWallet;
use App\Models\Commission;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Arr;
use Illuminate\Support\Carbon;

class AgentDashboardController extends Controller
{
    public function commissions(Request $request): AnonymousResourceCollection
    {
        $agentId = $this->resolveAgentId($request);

        $query = Commission::query()
            ->with([
                'rule',
                'payment',
                'salesOrder.customer',
                'salesOrder.agent.user',
                'salesOrder.branch',
                'recipient',
            ])
            ->where('recipient_type', Agent::class);

        if ($agentId) {
            $query->where('recipient_id', $agentId);
        }

        if ($request->filled('status')) {
            $query->whereIn('status', Arr::wrap($request->input('status')));
        }

        if ($request->filled('from_date')) {
            $fromDate = Carbon::parse($request->input('from_date'))->startOfDay();
            $query->where('created_at', '>=', $fromDate);
        }

        if ($request->filled('to_date')) {
            $toDate = Carbon::parse($request->input('to_date'))->endOfDay();
            $query->where('created_at', '<=', $toDate);
        }

        $commissions = $query
            ->orderByDesc('created_at')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return CommissionResource::collection($commissions);
    }

    public function wallet(Request $request): AgentWalletResource
    {
        $agentId = $this->resolveAgentId($request);

        if (! $agentId) {
            abort(422, 'An agent context is required to view a wallet.');
        }

        $wallet = AgentWallet::query()
            ->with(['agent.user'])
            ->firstWhere('agent_id', $agentId);

        if (! $wallet) {
            $wallet = AgentWallet::create([
                'agent_id' => $agentId,
                'balance' => 0,
            ]);

            $wallet->load(['agent.user']);
        }

        return new AgentWalletResource($wallet);
    }

    private function resolveAgentId(Request $request): ?int
    {
        $user = $request->user();

        if ($user && $user->role === User::ROLE_AGENT) {
            return $user->agent?->id;
        }

        if ($request->filled('agent_id')) {
            return $request->integer('agent_id');
        }

        return null;
    }
}
