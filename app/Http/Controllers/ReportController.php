<?php

namespace App\Http\Controllers;

use App\Http\Resources\ProductResource;
use App\Http\Resources\StockMovementResource;
use App\Http\Resources\UserResource;
use App\Models\Agent;
use App\Models\Commission;
use App\Models\CustomerInstallment;
use App\Models\LedgerEntry;
use App\Models\Product;
use App\Models\SalesOrder;
use App\Models\StockMovement;
use App\Models\User;
use Illuminate\Http\Request;

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

    public function dashboard(Request $request)
    {
        $authUser = $request->user();

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

        $stockQuery = Product::query()
            ->where('is_stock_managed', true)
            ->where('product_type', '!=', 'land');

        $stockSummary = [
            'total_items' => (clone $stockQuery)->count(),
            'total_qty' => (clone $stockQuery)->sum('stock_qty'),
            'low_stock_items' => (clone $stockQuery)
                ->whereColumn('stock_qty', '<', 'min_stock_alert')
                ->count(),
            'total_value' => (clone $stockQuery)
                ->selectRaw('SUM(stock_qty * price) as total_value')
                ->value('total_value') ?? 0,
        ];

        $customerQuery = User::query()->where('role', User::ROLE_CUSTOMER);

        if ($authUser && in_array($authUser->role, [User::ROLE_AGENT, User::ROLE_AGENT_ADMIN], true)) {
            $agentId = Agent::where('user_id', $authUser->id)->value('id');

            if (! $agentId) {
                $customerQuery->whereRaw('0 = 1');
            } else {
                $customerQuery->whereIn('id', function ($subQuery) use ($agentId) {
                    $subQuery->select('customer_id')
                        ->from('sales_orders')
                        ->where('agent_id', $agentId);
                });
            }
        }

        $customerSummary = [
            'total' => (clone $customerQuery)->distinct()->count('users.id'),
            'recent' => UserResource::collection(
                (clone $customerQuery)
                    ->orderByDesc('created_at')
                    ->take(5)
                    ->get()
            )->resolve(),
        ];

        return response()->json([
            'sales_total' => $salesTotal,
            'collection_total' => $collectionTotal,
            'receivables' => $receivables,
            'commissions' => $commissionSummary,
            'rank_fund_balance' => $rankFund,
            'stock_summary' => $stockSummary,
            'customers' => $customerSummary,
        ]);
    }

    public function currentStock(Request $request)
    {
        $products = Product::query()
            ->with('category')
            ->where('is_stock_managed', true)
            ->where('product_type', '!=', 'land')
            ->when($request->filled('category_id'), fn ($query) => $query->where('category_id', $request->integer('category_id')))
            ->orderBy('name')
            ->get();

        $summary = [
            'total_products' => $products->count(),
            'total_qty' => $products->sum(fn (Product $product) => (float) $product->stock_qty),
            'total_value' => $products->sum(fn (Product $product) => (float) $product->stock_qty * (float) $product->price),
        ];

        return response()->json([
            'summary' => $summary,
            'data' => ProductResource::collection($products)->resolve(),
        ]);
    }

    public function lowStock(Request $request)
    {
        $products = Product::query()
            ->with('category')
            ->where('is_stock_managed', true)
            ->where('product_type', '!=', 'land')
            ->whereColumn('stock_qty', '<', 'min_stock_alert')
            ->when($request->filled('category_id'), fn ($query) => $query->where('category_id', $request->integer('category_id')))
            ->orderBy('name')
            ->get();

        $summary = [
            'total_products' => $products->count(),
            'total_qty' => $products->sum(fn (Product $product) => (float) $product->stock_qty),
        ];

        return response()->json([
            'summary' => $summary,
            'data' => ProductResource::collection($products)->resolve(),
        ]);
    }

    public function stockMovements(Request $request)
    {
        $query = StockMovement::query()->with('product.category');

        if ($request->filled('product_id')) {
            $query->where('product_id', $request->integer('product_id'));
        }

        if ($request->filled('type')) {
            $query->where('type', $request->string('type'));
        }

        if ($request->filled('from')) {
            $query->whereDate('created_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('created_at', '<=', $request->date('to'));
        }

        $movements = $query->orderByDesc('id')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return StockMovementResource::collection($movements);
    }
}
