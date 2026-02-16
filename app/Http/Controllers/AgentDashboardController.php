<?php

namespace App\Http\Controllers;

use App\Http\Resources\AgentWalletResource;
use App\Http\Resources\CommissionResource;
use App\Models\Agent;
use App\Models\AgentWallet;
use App\Models\Commission;
use App\Models\Payment;
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

    public function salesSummary(Request $request)
    {
        $agentId = $this->resolveAgentId($request);

        if (! $agentId) {
            abort(422, 'An agent context is required to view sales.');
        }

        [$start, $end, $period] = $this->resolvePeriod($request);

        $paymentQuery = Payment::query()
            ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
            ->where('sales_orders.agent_id', $agentId);

        if ($start) {
            $paymentQuery->whereDate('payments.paid_at', '>=', $start->toDateString());
        }

        if ($end) {
            $paymentQuery->whereDate('payments.paid_at', '<=', $end->toDateString());
        }

        $totals = $paymentQuery
            ->selectRaw(
                'SUM(payments.amount) as total_sales, '
                . "SUM(CASE WHEN payments.type = ? THEN payments.amount ELSE 0 END) as down_payment, "
                . "SUM(CASE WHEN payments.type = ? THEN payments.amount ELSE 0 END) as installment, "
                . "SUM(CASE WHEN sales_orders.sales_type = ? THEN payments.amount ELSE 0 END) as service_sales",
                [Payment::TYPE_DOWN_PAYMENT, Payment::TYPE_INSTALLMENT, 'service']
            )
            ->first();

        $commissionQuery = Commission::query()
            ->where('recipient_type', Agent::class)
            ->where('recipient_id', $agentId)
            ->where('status', 'paid')
            ->whereHas('payment', function ($query) use ($start, $end) {
                if ($start) {
                    $query->whereDate('paid_at', '>=', $start->toDateString());
                }

                if ($end) {
                    $query->whereDate('paid_at', '<=', $end->toDateString());
                }
            });

        $commissionPaid = (float) $commissionQuery->sum('amount');

        return response()->json([
            'agent_id' => $agentId,
            'period' => $period,
            'summary' => [
                'total_sales' => (float) ($totals?->total_sales ?? 0),
                'down_payment' => (float) ($totals?->down_payment ?? 0),
                'installment' => (float) ($totals?->installment ?? 0),
                'service_sales' => (float) ($totals?->service_sales ?? 0),
                'commission_paid' => $commissionPaid,
            ],
        ]);
    }

    public function salesDetail(Request $request)
    {
        $agentId = $this->resolveAgentId($request);

        if (! $agentId) {
            abort(422, 'An agent context is required to view sales.');
        }

        [$start, $end] = $this->resolvePeriod($request);

        $query = Payment::query()
            ->with(['salesOrder.customer', 'salesOrder'])
            ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
            ->where('sales_orders.agent_id', $agentId);

        if ($start) {
            $query->whereDate('payments.paid_at', '>=', $start->toDateString());
        }

        if ($end) {
            $query->whereDate('payments.paid_at', '<=', $end->toDateString());
        }

        $payments = $query
            ->orderByDesc('payments.paid_at')
            ->paginate($request->integer('per_page', 50))
            ->appends($request->query());

        $data = $payments->getCollection()->map(function (Payment $payment) use ($agentId) {
            $salesOrder = $payment->salesOrder;
            $commissionEarned = $payment->commissions()
                ->where('recipient_type', Agent::class)
                ->where('recipient_id', $agentId)
                ->where('status', 'paid')
                ->sum('amount');

            return [
                'order_no' => $salesOrder ? 'SO-' . $salesOrder->id : null,
                'customer' => $salesOrder?->customer ? [
                    'id' => $salesOrder->customer->id,
                    'name' => $salesOrder->customer->name,
                ] : null,
                'payment_amount' => (float) $payment->amount,
                'payment_type' => $payment->type,
                'commission_earned' => (float) $commissionEarned,
                'date' => $payment->paid_at?->toDateString(),
            ];
        });

        return response()->json([
            'data' => $data,
            'pagination' => [
                'total' => $payments->total(),
                'per_page' => $payments->perPage(),
                'current_page' => $payments->currentPage(),
                'last_page' => $payments->lastPage(),
            ],
        ]);
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

    private function resolvePeriod(Request $request): array
    {
        if ($request->filled('month')) {
            $month = $request->string('month')->toString();
            $start = Carbon::createFromFormat('Y-m', $month)->startOfMonth();
            $end = $start->copy()->endOfMonth();

            return [$start, $end, $month];
        }

        $start = $request->filled('from') ? Carbon::parse($request->input('from'))->startOfDay() : null;
        $end = $request->filled('to') ? Carbon::parse($request->input('to'))->endOfDay() : null;

        return [$start, $end, $start && $end ? $start->toDateString() . ' to ' . $end->toDateString() : null];
    }
}
