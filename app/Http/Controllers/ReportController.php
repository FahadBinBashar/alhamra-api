<?php

namespace App\Http\Controllers;

use App\Http\Resources\ProductResource;
use App\Http\Resources\StockMovementResource;
use App\Http\Resources\UserResource;
use App\Models\Agent;
use App\Models\Commission;
use App\Models\CommissionCalculationItem;
use App\Models\CustomerInstallment;
use App\Models\LedgerEntry;
use App\Models\Payment;
use App\Models\Product;
use App\Models\SalesOrder;
use App\Models\StockMovement;
use App\Models\Supplier;
use App\Models\SupplierPayable;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Carbon;

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

    public function supplierPayables(Request $request)
    {
        $validated = $request->validate([
            'supplier_id' => ['sometimes', 'integer', 'exists:suppliers,id'],
            'status' => ['sometimes', 'string'],
            'from' => ['sometimes', 'date'],
            'to' => ['sometimes', 'date'],
        ]);

        $query = SupplierPayable::query();

        if (! empty($validated['supplier_id'])) {
            $query->where('supplier_id', (int) $validated['supplier_id']);
        }

        if (! empty($validated['status'])) {
            $statuses = collect(explode(',', (string) $validated['status']))
                ->map(fn ($status) => trim($status))
                ->filter(fn ($status) => in_array($status, [SupplierPayable::STATUS_UNPAID, SupplierPayable::STATUS_PAID], true))
                ->values();

            if ($statuses->isNotEmpty()) {
                $query->whereIn('status', $statuses);
            }
        }

        if (! empty($validated['from'])) {
            $query->whereDate('created_at', '>=', $request->date('from'));
        }

        if (! empty($validated['to'])) {
            $query->whereDate('created_at', '<=', $request->date('to'));
        }

        $aggregates = $query
            ->selectRaw(
                'supplier_id, '
                . 'SUM(amount) as total_amount, '
                . "SUM(CASE WHEN status = ? THEN amount ELSE 0 END) as unpaid_amount, "
                . "SUM(CASE WHEN status = ? THEN amount ELSE 0 END) as paid_amount",
                [SupplierPayable::STATUS_UNPAID, SupplierPayable::STATUS_PAID]
            )
            ->groupBy('supplier_id')
            ->get();

        $supplierIds = $aggregates->pluck('supplier_id')->filter()->unique()->all();
        $suppliers = Supplier::whereIn('id', $supplierIds)->get()->keyBy('id');

        $data = $aggregates->map(function ($row) use ($suppliers) {
            $supplier = $suppliers->get($row->supplier_id);

            return [
                'supplier_id' => $row->supplier_id,
                'supplier' => $supplier ? [
                    'id' => $supplier->id,
                    'name' => $supplier->name,
                    'email' => $supplier->email,
                    'phone' => $supplier->phone,
                ] : null,
                'total_payable' => (float) $row->total_amount,
                'paid' => (float) $row->paid_amount,
                'unpaid' => (float) $row->unpaid_amount,
            ];
        })->values();

        $summary = [
            'total_payable' => $data->sum(fn ($item) => $item['total_payable']),
            'total_paid' => $data->sum(fn ($item) => $item['paid']),
            'total_unpaid' => $data->sum(fn ($item) => $item['unpaid']),
        ];

        return response()->json([
            'data' => $data,
            'summary' => $summary,
        ]);
    }

    public function commissions()
    {
        return response()->json($this->commissionSummary());
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
        $commissionSummary = $this->commissionSummary();
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
            $agent = $authUser->agent;

            if (! $agent) {
                $customerQuery->whereRaw('0 = 1');
            } else {
                $customerQuery->whereIn('id', function ($subQuery) use ($agent) {
                    $subQuery->select('customer_id')
                        ->from('sales_orders')
                        ->where('agent_id', $agent->id);
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

    protected function commissionSummary(): array
    {
        $pendingTotal = CommissionCalculationItem::query()
            ->whereHas('unit', fn ($query) => $query->where('status', 'draft'))
            ->sum('amount');

        $paidTotal = Commission::where('status', 'paid')->sum('amount');

        return [
            'total' => $paidTotal + $pendingTotal,
            'paid' => $paidTotal,
            'pending' => $pendingTotal,
            'unpaid' => 0.0,
        ];
    }

    public function salesCommissionSummary(Request $request)
    {
        [$start, $end] = $this->resolveReportPeriod($request);
        $groupBy = $request->string('group_by', 'month')->toString();
        $groupColumn = $this->resolveSalesGroupColumn($groupBy);

        $paymentQuery = Payment::query()
            ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
            ->selectRaw(
                "{$groupColumn} as period,\n"
                . 'SUM(payments.amount) as sales_total, '
                . "SUM(CASE WHEN payments.type = ? THEN payments.amount ELSE 0 END) as down_payment_total, "
                . "SUM(CASE WHEN payments.type = ? THEN payments.amount ELSE 0 END) as installment_total, "
                . "SUM(CASE WHEN payments.type IN (?, ?) THEN payments.amount ELSE 0 END) as emi_extra_total",
                [
                    Payment::TYPE_DOWN_PAYMENT,
                    Payment::TYPE_INSTALLMENT,
                    Payment::TYPE_FULL_PAYMENT,
                    Payment::TYPE_PARTIAL_PAYMENT,
                ]
            )
            ->whereNotNull('payments.paid_at')
            ->groupBy('period');

        $this->applySalesFilters($paymentQuery, $request, $start, $end);

        $paymentTotals = $paymentQuery->get()->keyBy('period');

        $paidTotals = $this->commissionTotalsByStatus($request, $start, $end, $groupBy, 'paid');
        $unpaidTotals = $this->commissionTotalsByStatus($request, $start, $end, $groupBy, 'unpaid');
        $draftTotals = $this->commissionTotalsByStatus($request, $start, $end, $groupBy, 'draft');

        $periods = collect()
            ->merge($paymentTotals->keys())
            ->merge($paidTotals->keys())
            ->merge($unpaidTotals->keys())
            ->merge($draftTotals->keys())
            ->unique()
            ->values();

        $commissionStatus = $request->string('commission_status', 'all')->toString();

        $data = $periods->map(function ($period) use ($paymentTotals, $paidTotals, $unpaidTotals, $draftTotals, $commissionStatus) {
            $payments = $paymentTotals->get($period);
            $paid = (float) ($paidTotals[$period] ?? 0);
            $unpaid = (float) ($unpaidTotals[$period] ?? 0);
            $draft = (float) ($draftTotals[$period] ?? 0);

            [$commissionTotal, $commissionPaid, $commissionUnpaid] = $this->resolveCommissionTotalsByStatus(
                $commissionStatus,
                $paid,
                $unpaid,
                $draft
            );

            return [
                'period' => $period,
                'sales_total' => (float) ($payments->sales_total ?? 0),
                'down_payment_total' => (float) ($payments->down_payment_total ?? 0),
                'installment_total' => (float) ($payments->installment_total ?? 0),
                'emi_extra_total' => (float) ($payments->emi_extra_total ?? 0),
                'commission_total' => $commissionTotal,
                'commission_paid' => $commissionPaid,
                'commission_unpaid' => $commissionUnpaid,
            ];
        });

        return response()->json(['data' => $data]);
    }

    public function salesCommissionDetail(Request $request)
    {
        [$start, $end] = $this->resolveReportPeriod($request);
        $commissionStatus = $request->string('commission_status', 'all')->toString();

        $rows = collect();

        if (in_array($commissionStatus, ['paid', 'unpaid', 'all'], true)) {
            $statuses = $commissionStatus === 'all' ? ['paid', 'unpaid'] : [$commissionStatus];

            $commissions = Commission::query()
                ->with(['payment.salesOrder.customer', 'payment.salesOrder.agent.user', 'payment.salesOrder.branch', 'recipient'])
                ->whereIn('status', $statuses);

            $this->applyCommissionFilters($commissions, $request, $start, $end);

            $rows = $rows->merge($commissions->get()->map(fn (Commission $commission) => $this->formatCommissionRow($commission)));
        }

        if (in_array($commissionStatus, ['draft', 'all'], true)) {
            $drafts = CommissionCalculationItem::query()
                ->with(['unit.payment.salesOrder.customer', 'unit.payment.salesOrder.agent.user', 'unit.payment.salesOrder.branch', 'recipient'])
                ->whereHas('unit', fn ($query) => $query->where('status', 'draft'));

            $this->applyCommissionItemFilters($drafts, $request, $start, $end);

            $rows = $rows->merge($drafts->get()->map(fn (CommissionCalculationItem $item) => $this->formatDraftCommissionRow($item)));
        }

        $rows = $rows->sortByDesc('date')->values();

        $perPage = max(1, (int) $request->integer('per_page', 50));
        $page = max(1, (int) $request->integer('page', 1));
        $paginated = new LengthAwarePaginator(
            $rows->slice(($page - 1) * $perPage, $perPage)->values(),
            $rows->count(),
            $perPage,
            $page,
            ['path' => $request->url(), 'query' => $request->query()]
        );

        $summary = $this->buildSalesCommissionSummary($request, $start, $end, $commissionStatus);

        return response()->json([
            'data' => $paginated->items(),
            'summary' => $summary,
            'pagination' => [
                'total' => $paginated->total(),
                'per_page' => $paginated->perPage(),
                'current_page' => $paginated->currentPage(),
                'last_page' => $paginated->lastPage(),
            ],
        ]);
    }

    protected function resolveReportPeriod(Request $request): array
    {
        $start = null;
        $end = null;

        if ($request->filled('month')) {
            $month = $request->string('month')->toString();
            $start = Carbon::createFromFormat('Y-m', $month)->startOfMonth();
            $end = $start->copy()->endOfMonth();
        } else {
            if ($request->filled('from')) {
                $start = Carbon::parse($request->input('from'))->startOfDay();
            }

            if ($request->filled('to')) {
                $end = Carbon::parse($request->input('to'))->endOfDay();
            }
        }

        return [$start, $end];
    }

    protected function resolveSalesGroupColumn(string $groupBy): string
    {
        return match ($groupBy) {
            'day' => "DATE(payments.paid_at)",
            'employee' => 'sales_orders.employee_id',
            'agent' => 'sales_orders.agent_id',
            'branch' => 'sales_orders.branch_id',
            default => "DATE_FORMAT(payments.paid_at, '%Y-%m')",
        };
    }

    protected function applySalesFilters($query, Request $request, ?Carbon $start, ?Carbon $end): void
    {
        if ($start) {
            $query->whereDate('payments.paid_at', '>=', $start->toDateString());
        }

        if ($end) {
            $query->whereDate('payments.paid_at', '<=', $end->toDateString());
        }

        if ($request->filled('employee_id')) {
            $employeeIds = $this->parseIds($request, 'employee_id');
            $query->where(function ($builder) use ($employeeIds) {
                $builder->whereIn('sales_orders.employee_id', $employeeIds)
                    ->orWhereIn('sales_orders.source_me_id', $employeeIds);
            });
        }

        if ($request->filled('agent_id')) {
            $query->whereIn('sales_orders.agent_id', $this->parseIds($request, 'agent_id'));
        }

        if ($request->filled('customer_id')) {
            $query->whereIn('sales_orders.customer_id', $this->parseIds($request, 'customer_id'));
        }

        if ($request->filled('branch_id')) {
            $query->whereIn('sales_orders.branch_id', $this->parseIds($request, 'branch_id'));
        }

        if ($request->filled('sales_type')) {
            $query->whereIn('sales_orders.sales_type', $this->parseStrings($request, 'sales_type'));
        }
    }

    protected function applyCommissionFilters($query, Request $request, ?Carbon $start, ?Carbon $end): void
    {
        $query->whereHas('payment', function ($paymentQuery) use ($request, $start, $end) {
            if ($start) {
                $paymentQuery->whereDate('paid_at', '>=', $start->toDateString());
            }

            if ($end) {
                $paymentQuery->whereDate('paid_at', '<=', $end->toDateString());
            }

            $paymentQuery->whereHas('salesOrder', function ($salesOrderQuery) use ($request) {
                $this->applySalesOrderFilters($salesOrderQuery, $request);
            });
        });
    }

    protected function applyCommissionItemFilters($query, Request $request, ?Carbon $start, ?Carbon $end): void
    {
        $query->whereHas('unit.payment', function ($paymentQuery) use ($request, $start, $end) {
            if ($start) {
                $paymentQuery->whereDate('paid_at', '>=', $start->toDateString());
            }

            if ($end) {
                $paymentQuery->whereDate('paid_at', '<=', $end->toDateString());
            }

            $paymentQuery->whereHas('salesOrder', function ($salesOrderQuery) use ($request) {
                $this->applySalesOrderFilters($salesOrderQuery, $request);
            });
        });
    }

    protected function applySalesOrderFilters($query, Request $request): void
    {
        if ($request->filled('employee_id')) {
            $employeeIds = $this->parseIds($request, 'employee_id');
            $query->where(function ($builder) use ($employeeIds) {
                $builder->whereIn('employee_id', $employeeIds)
                    ->orWhereIn('source_me_id', $employeeIds);
            });
        }

        if ($request->filled('agent_id')) {
            $query->whereIn('agent_id', $this->parseIds($request, 'agent_id'));
        }

        if ($request->filled('customer_id')) {
            $query->whereIn('customer_id', $this->parseIds($request, 'customer_id'));
        }

        if ($request->filled('branch_id')) {
            $query->whereIn('branch_id', $this->parseIds($request, 'branch_id'));
        }

        if ($request->filled('sales_type')) {
            $query->whereIn('sales_type', $this->parseStrings($request, 'sales_type'));
        }
    }

    protected function commissionTotalsByStatus(Request $request, ?Carbon $start, ?Carbon $end, string $groupBy, string $status)
    {
        $groupColumn = $this->resolveSalesGroupColumn($groupBy);

        if ($status === 'draft') {
            $query = CommissionCalculationItem::query()
                ->join('commission_calculation_units', 'commission_calculation_units.id', '=', 'commission_calculation_items.commission_calculation_unit_id')
                ->join('payments', 'payments.id', '=', 'commission_calculation_units.payment_id')
                ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
                ->where('commission_calculation_units.status', 'draft')
                ->selectRaw("{$groupColumn} as period, SUM(commission_calculation_items.amount) as total")
                ->groupBy('period');
        } else {
            $query = Commission::query()
                ->join('payments', 'payments.id', '=', 'commissions.payment_id')
                ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
                ->where('commissions.status', $status)
                ->selectRaw("{$groupColumn} as period, SUM(commissions.amount) as total")
                ->groupBy('period');
        }

        $this->applySalesFilters($query, $request, $start, $end);

        return $query->pluck('total', 'period');
    }

    protected function resolveCommissionTotalsByStatus(string $status, float $paid, float $unpaid, float $draft): array
    {
        return match ($status) {
            'paid' => [$paid, $paid, 0.0],
            'unpaid' => [$unpaid, 0.0, $unpaid],
            'draft' => [$draft, 0.0, $draft],
            default => [$paid + $unpaid + $draft, $paid, $unpaid + $draft],
        };
    }

    protected function formatCommissionRow(Commission $commission): array
    {
        $payment = $commission->payment;
        $salesOrder = $payment?->salesOrder;

        return [
            'date' => $payment?->paid_at?->toDateString(),
            'order_no' => $salesOrder ? 'SO-' . $salesOrder->id : null,
            'customer' => $salesOrder?->customer ? [
                'id' => $salesOrder->customer->id,
                'name' => $salesOrder->customer->name,
            ] : null,
            'sales_type' => $salesOrder?->sales_type,
            'payment_type' => $payment?->type,
            'payment_amount' => (float) ($payment?->amount ?? 0),
            'commission_base_amount' => (float) ($payment?->commissionable_amount ?? 0),
            'commission_amount' => (float) $commission->amount,
            'commission_status' => $commission->status,
            'recipient' => $this->formatRecipient($commission->recipient_type, $commission->recipient),
            'agent' => $salesOrder?->agent ? [
                'id' => $salesOrder->agent->id,
                'name' => $salesOrder->agent->user?->name,
            ] : null,
            'branch' => $salesOrder?->branch?->name,
        ];
    }

    protected function formatDraftCommissionRow(CommissionCalculationItem $item): array
    {
        $payment = $item->unit?->payment;
        $salesOrder = $payment?->salesOrder;

        return [
            'date' => $payment?->paid_at?->toDateString(),
            'order_no' => $salesOrder ? 'SO-' . $salesOrder->id : null,
            'customer' => $salesOrder?->customer ? [
                'id' => $salesOrder->customer->id,
                'name' => $salesOrder->customer->name,
            ] : null,
            'sales_type' => $salesOrder?->sales_type,
            'payment_type' => $payment?->type,
            'payment_amount' => (float) ($payment?->amount ?? 0),
            'commission_base_amount' => (float) ($payment?->commissionable_amount ?? 0),
            'commission_amount' => (float) $item->amount,
            'commission_status' => 'draft',
            'recipient' => $this->formatRecipient($item->recipient_type, $item->recipient),
            'agent' => $salesOrder?->agent ? [
                'id' => $salesOrder->agent->id,
                'name' => $salesOrder->agent->user?->name,
            ] : null,
            'branch' => $salesOrder?->branch?->name,
        ];
    }

    protected function formatRecipient(string $type, $recipient): ?array
    {
        if (! $recipient) {
            return null;
        }

        $name = null;

        if (method_exists($recipient, 'user')) {
            $recipient->loadMissing('user');
            $name = $recipient->user?->name;
        }

        if (! $name && ! empty($recipient->name)) {
            $name = $recipient->name;
        }

        if (! $name && ! empty($recipient->full_name_en)) {
            $name = $recipient->full_name_en;
        }

        return [
            'type' => class_basename($type),
            'id' => $recipient->id,
            'name' => $name,
        ];
    }

    protected function buildSalesCommissionSummary(Request $request, ?Carbon $start, ?Carbon $end, string $commissionStatus): array
    {
        $paymentQuery = Payment::query()
            ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
            ->whereNotNull('payments.paid_at');

        $this->applySalesFilters($paymentQuery, $request, $start, $end);

        $salesTotal = (float) $paymentQuery->sum('payments.amount');

        $paidTotal = (float) $this->commissionTotalsByStatus($request, $start, $end, 'month', 'paid')->sum();
        $unpaidTotal = (float) $this->commissionTotalsByStatus($request, $start, $end, 'month', 'unpaid')->sum();
        $draftTotal = (float) $this->commissionTotalsByStatus($request, $start, $end, 'month', 'draft')->sum();

        [$commissionTotal] = $this->resolveCommissionTotalsByStatus($commissionStatus, $paidTotal, $unpaidTotal, $draftTotal);

        return [
            'sales_total' => $salesTotal,
            'commission_total' => $commissionTotal,
        ];
    }

    protected function parseIds(Request $request, string $key): array
    {
        $value = $request->input($key);

        if (is_array($value)) {
            return array_values(array_filter(array_map('intval', $value)));
        }

        return array_values(array_filter(array_map('intval', array_map('trim', explode(',', (string) $value)))));
    }

    protected function parseStrings(Request $request, string $key): array
    {
        $value = $request->input($key);

        if (is_array($value)) {
            return array_values(array_filter(array_map('strval', $value)));
        }

        return array_values(array_filter(array_map('trim', explode(',', (string) $value))));
    }
}
