<?php

namespace App\Http\Controllers;

use App\Models\Agent;
use App\Models\Commission;
use App\Models\CustomerInstallment;
use App\Models\LedgerEntry;
use App\Models\SalesOrder;

class ReportController extends Controller
{
    public function receivables()
    {
        $installments = CustomerInstallment::selectRaw('status, SUM(amount - paid) as outstanding')
            ->whereColumn('amount', '>', 'paid')
            ->groupBy('status')
            ->get();

        $total = $installments->sum('outstanding');

        return response()->json([
            'total_outstanding' => $total,
            'breakdown' => $installments,
        ]);
    }

    public function payables()
    {
        $liabilities = LedgerEntry::with('account')
            ->whereHas('account', fn ($q) => $q->where('type', 'liability'))
            ->get()
            ->groupBy('account.code')
            ->map(fn ($entries) => [
                'account' => $entries->first()->account->name,
                'balance' => $entries->sum(fn ($entry) => $entry->credit - $entry->debit),
            ])
            ->values();

        $total = $liabilities->sum('balance');

        return response()->json([
            'total_payable' => $total,
            'breakdown' => $liabilities,
        ]);
    }

    public function commissions()
    {
        $summary = [
            'total' => Commission::sum('amount'),
            'unpaid' => Commission::where('status', 'unpaid')->sum('amount'),
            'paid' => Commission::where('status', 'paid')->sum('amount'),
        ];

        return response()->json($summary);
    }

    public function rankFunds()
    {
        $fundAccount = config('accounting.accounts.incentive_fund.code');

        $entries = LedgerEntry::with('account')
            ->whereHas('account', fn ($q) => $q->where('code', $fundAccount))
            ->get();

        $balance = $entries->sum(fn ($entry) => $entry->credit - $entry->debit);

        return response()->json([
            'account' => $entries->first()->account->name ?? 'Incentive Fund Payable',
            'balance' => $balance,
        ]);
    }

    public function agentPerformance()
    {
        $agents = Agent::withSum('salesOrders as sales_total', 'total')
            ->withCount('salesOrders')
            ->orderByDesc('sales_total')
            ->take(10)
            ->get();

        return response()->json([
            'top_agents' => $agents,
        ]);
    }

    public function dashboard()
    {
        $salesTotal = SalesOrder::sum('total');
        $collectionTotal = LedgerEntry::whereHas('account', fn ($q) => $q->whereIn('code', [
            config('accounting.accounts.cash.code'),
            config('accounting.accounts.bank.code'),
        ]))->sum('debit');
        $receivables = CustomerInstallment::whereColumn('amount', '>', 'paid')
            ->get()
            ->sum(fn ($installment) => $installment->amount - $installment->paid);
        $commissionSummary = [
            'total' => Commission::sum('amount'),
            'unpaid' => Commission::where('status', 'unpaid')->sum('amount'),
        ];
        $rankFund = LedgerEntry::whereHas('account', fn ($q) => $q->where('code', config('accounting.accounts.incentive_fund.code')))
            ->get()
            ->sum(fn ($entry) => $entry->credit - $entry->debit);

        return response()->json([
            'sales_total' => $salesTotal,
            'collection_total' => $collectionTotal,
            'receivables' => $receivables,
            'commissions' => $commissionSummary,
            'rank_fund_balance' => $rankFund,
        ]);
    }
}
