<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Resources\CommissionResource;
use App\Http\Resources\ProductResource;
use App\Http\Resources\SalesOrderResource;
use App\Models\Agent;
use App\Models\Branch;
use App\Models\Commission;
use App\Models\Employee;
use App\Models\LedgerAccount;
use App\Models\LedgerEntry;
use App\Models\Payment;
use App\Models\Product;
use App\Models\SalesOrder;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\MorphTo;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use Symfony\Component\HttpFoundation\StreamedResponse;

class AdminReportController extends Controller
{
    use ResolvesIncludes;

    public function commissionReport(Request $request)
    {
        $allowedIncludes = [
            'rule',
            'payment',
            'salesOrder',
            'salesOrder.customer',
            'salesOrder.agent',
            'salesOrder.agent.user',
            'salesOrder.branch',
            'recipient',
        ];

        $includes = $this->resolveIncludes($request, $allowedIncludes);

        if (empty($includes)) {
            $includes = [
                'rule',
                'salesOrder.customer',
                'salesOrder.agent.user',
                'salesOrder.branch',
                'recipient',
            ];
        }

        $query = Commission::query()->with($includes);

        if (in_array('recipient', $includes, true)) {
            $query->with(['recipient' => function (MorphTo $morphTo) {
                $morphTo->morphWith([
                    Agent::class => ['user', 'branch', 'activeRank'],
                    Employee::class => ['user', 'branch'],
                ]);
            }]);
        }

        if ($request->filled('status')) {
            $query->whereIn('status', $this->parseCsv($request, 'status'));
        }

        if ($request->filled('recipient_type')) {
            $query->whereIn('recipient_type', $this->parseCsv($request, 'recipient_type'));
        }

        if ($request->filled('recipient_id')) {
            $query->whereIn('recipient_id', array_map('intval', $this->parseCsv($request, 'recipient_id')));
        }

        if ($request->filled('payment_id')) {
            $query->whereIn('payment_id', array_map('intval', $this->parseCsv($request, 'payment_id')));
        }

        if ($request->filled('sales_order_id')) {
            $query->whereIn('sales_order_id', array_map('intval', $this->parseCsv($request, 'sales_order_id')));
        }

        if ($request->filled('agent_id')) {
            $agentIds = array_map('intval', $this->parseCsv($request, 'agent_id'));
            $query->whereHas('salesOrder', fn (Builder $builder) => $builder->whereIn('agent_id', $agentIds));
        }

        if ($request->filled('employee_id')) {
            $employeeIds = array_map('intval', $this->parseCsv($request, 'employee_id'));
            $query->whereHas('salesOrder', fn (Builder $builder) => $builder->whereIn('employee_id', $employeeIds));
        }

        if ($request->filled('branch_id')) {
            $branchIds = array_map('intval', $this->parseCsv($request, 'branch_id'));
            $query->whereHas('salesOrder', fn (Builder $builder) => $builder->whereIn('branch_id', $branchIds));
        }

        $dateField = $this->resolveDateField($request->query('date_field'), ['created_at', 'paid_at'], 'created_at');

        if ($request->filled('from')) {
            $query->whereDate($dateField, '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate($dateField, '<=', $request->date('to'));
        }

        $orderedQuery = (clone $query)->orderByDesc($dateField)->orderByDesc('id');

        if ($this->isExportRequest($request)) {
            $commissions = $orderedQuery->get();
            $commissions->loadMissing(['salesOrder.customer', 'salesOrder.agent.user', 'salesOrder.branch', 'recipient']);

            return $this->exportCommissionReport($commissions);
        }

        if ($this->isPrintRequest($request)) {
            $commissions = $orderedQuery->get();
            $commissions->loadMissing(['salesOrder.customer', 'salesOrder.agent.user', 'salesOrder.branch', 'recipient']);

            return response()->json([
                'data' => CommissionResource::collection($commissions)->resolve(),
                'summary' => $this->summarizeCommissions($commissions),
            ]);
        }

        $summary = $this->summarizeCommissions((clone $query)->get());

        $perPage = max(1, (int) $request->query('per_page', 15));
        $commissions = $orderedQuery
            ->paginate($perPage)
            ->appends($request->query());

        return CommissionResource::collection($commissions)
            ->additional(['summary' => $summary]);
    }

    public function salesReport(Request $request)
    {
        $allowedIncludes = [
            'customer',
            'agent',
            'agent.user',
            'branch',
        ];

        $includes = $this->resolveIncludes($request, $allowedIncludes);

        if (empty($includes)) {
            $includes = [
                'customer',
                'agent.user',
                'branch',
            ];
        }

        $query = SalesOrder::query()->with($includes);

        if ($request->filled('status')) {
            $query->whereIn('status', $this->parseCsv($request, 'status'));
        }

        if ($request->filled('sales_type')) {
            $query->whereIn('sales_type', $this->parseCsv($request, 'sales_type'));
        }

        if ($request->filled('agent_id')) {
            $query->whereIn('agent_id', array_map('intval', $this->parseCsv($request, 'agent_id')));
        }

        if ($request->filled('employee_id')) {
            $query->whereIn('employee_id', array_map('intval', $this->parseCsv($request, 'employee_id')));
        }

        if ($request->filled('branch_id')) {
            $query->whereIn('branch_id', array_map('intval', $this->parseCsv($request, 'branch_id')));
        }

        if ($request->filled('customer_id')) {
            $query->whereIn('customer_id', array_map('intval', $this->parseCsv($request, 'customer_id')));
        }

        if ($request->filled('from')) {
            $query->whereDate('created_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('created_at', '<=', $request->date('to'));
        }

        if ($request->filled('search')) {
            $search = trim((string) $request->query('search'));
            $query->where(function (Builder $builder) use ($search) {
                $builder->where('id', (int) $search)
                    ->orWhere('total', 'like', '%' . $search . '%')
                    ->orWhereHas('customer', fn (Builder $sub) => $sub->where('name', 'like', '%' . $search . '%'))
                    ->orWhereHas('agent.user', fn (Builder $sub) => $sub->where('name', 'like', '%' . $search . '%'));
            });
        }

        $orderedQuery = (clone $query)->orderByDesc('created_at')->orderByDesc('id');

        if ($this->isExportRequest($request)) {
            $orders = $orderedQuery->get();
            $orders->loadMissing(['customer', 'agent.user', 'branch']);

            return $this->exportSalesReport($orders);
        }

        if ($this->isPrintRequest($request)) {
            $orders = $orderedQuery->get();
            $orders->loadMissing(['customer', 'agent.user', 'branch']);

            return response()->json([
                'data' => SalesOrderResource::collection($orders)->resolve(),
                'summary' => $this->summarizeSales($orders),
            ]);
        }

        $summary = $this->summarizeSales((clone $query)->get());

        $perPage = max(1, (int) $request->query('per_page', 15));
        $orders = $orderedQuery
            ->paginate($perPage)
            ->appends($request->query());

        return SalesOrderResource::collection($orders)
            ->additional(['summary' => $summary]);
    }

    public function stockReport(Request $request)
    {
        $query = Product::query()
            ->with('category')
            ->where('is_stock_managed', true)
            ->when($request->filled('product_type'), fn ($builder) => $builder->whereIn('product_type', $this->parseCsv($request, 'product_type')))
            ->when($request->filled('category_id'), fn ($builder) => $builder->whereIn('category_id', array_map('intval', $this->parseCsv($request, 'category_id'))));

        if ($request->filled('search')) {
            $search = trim((string) $request->query('search'));
            $query->where(function (Builder $builder) use ($search) {
                $builder->where('name', 'like', '%' . $search . '%');
            });
        }

        $orderedQuery = (clone $query)->orderBy('name');

        if ($this->isExportRequest($request)) {
            $products = $orderedQuery->get();
            $products->loadMissing('category');

            return $this->exportStockReport($products);
        }

        if ($this->isPrintRequest($request)) {
            $products = $orderedQuery->get();
            $products->loadMissing('category');

            return response()->json([
                'data' => ProductResource::collection($products)->resolve(),
                'summary' => $this->summarizeStock($products),
            ]);
        }

        $summary = $this->summarizeStock((clone $query)->get());

        $perPage = max(1, (int) $request->query('per_page', 15));
        $products = $orderedQuery
            ->paginate($perPage)
            ->appends($request->query());

        return ProductResource::collection($products)
            ->additional(['summary' => $summary]);
    }

    public function incomeReport(Request $request)
    {
        $query = LedgerEntry::query()->with('account');

        if ($request->filled('account_type')) {
            $query->whereHas('account', fn (Builder $builder) => $builder->whereIn('type', $this->parseCsv($request, 'account_type')));
        } else {
            $query->whereHas('account', fn (Builder $builder) => $builder->where('type', 'income'));
        }

        if ($request->filled('account_id')) {
            $query->whereIn('account_id', array_map('intval', $this->parseCsv($request, 'account_id')));
        }

        if ($request->filled('account_code')) {
            $codes = $this->parseCsv($request, 'account_code');
            $query->whereHas('account', fn (Builder $builder) => $builder->whereIn('code', $codes));
        }

        if ($request->filled('from')) {
            $query->whereDate('occurred_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('occurred_at', '<=', $request->date('to'));
        }

        $orderedQuery = (clone $query)->orderBy('occurred_at')->orderBy('id');

        if ($this->isExportRequest($request)) {
            $entries = $orderedQuery->get();
            $entries->loadMissing('account');

            return $this->exportIncomeReport($entries);
        }

        if ($this->isPrintRequest($request)) {
            $entries = $orderedQuery->get();
            $entries->loadMissing('account');

            return response()->json([
                'data' => $this->transformLedgerEntries($entries),
                'summary' => $this->summarizeLedgerEntries($entries),
            ]);
        }

        $summary = $this->summarizeLedgerEntries((clone $query)->get());

        $perPage = max(1, (int) $request->query('per_page', 25));
        $entries = $orderedQuery
            ->paginate($perPage)
            ->appends($request->query());

        $entries->getCollection()->loadMissing('account');

        $meta = [
            'current_page' => $entries->currentPage(),
            'last_page' => $entries->lastPage(),
            'per_page' => $entries->perPage(),
            'total' => $entries->total(),
        ];

        return response()->json([
            'data' => $this->transformLedgerEntries($entries->getCollection()),
            'summary' => $summary,
            'meta' => $meta,
        ]);
    }

    public function employeePerformance(Request $request)
    {
        $paymentsSub = Payment::query()
            ->selectRaw('sales_order_id, SUM(amount) as total_collections')
            ->groupBy('sales_order_id');

        $query = SalesOrder::query()
            ->leftJoinSub($paymentsSub, 'payment_totals', 'payment_totals.sales_order_id', '=', 'sales_orders.id')
            ->leftJoin('employees', 'employees.id', '=', 'sales_orders.employee_id')
            ->leftJoin('users', 'users.id', '=', 'employees.user_id')
            ->leftJoin('branches', 'branches.id', '=', 'employees.branch_id')
            ->selectRaw(
                'sales_orders.employee_id,
                COALESCE(users.name, employees.full_name_en, employees.full_name_bn) as employee_name,
                employees.employee_code,
                employees.rank,
                branches.name as branch_name,
                COUNT(DISTINCT sales_orders.id) as orders_count,
                SUM(sales_orders.total) as total_sales,
                SUM(sales_orders.down_payment) as total_down_payment,
                SUM(COALESCE(payment_totals.total_collections, 0)) as total_collections'
            )
            ->whereNotNull('sales_orders.employee_id');

        if ($request->filled('employee_id')) {
            $query->whereIn('sales_orders.employee_id', array_map('intval', $this->parseCsv($request, 'employee_id')));
        }

        if ($request->filled('branch_id')) {
            $query->whereIn('sales_orders.branch_id', array_map('intval', $this->parseCsv($request, 'branch_id')));
        }

        if ($request->filled('agent_id')) {
            $query->whereIn('sales_orders.agent_id', array_map('intval', $this->parseCsv($request, 'agent_id')));
        }

        if ($request->filled('sales_type')) {
            $query->whereIn('sales_orders.sales_type', $this->parseCsv($request, 'sales_type'));
        }

        if ($request->filled('status')) {
            $query->whereIn('sales_orders.status', $this->parseCsv($request, 'status'));
        }

        if ($request->filled('from')) {
            $query->whereDate('sales_orders.created_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('sales_orders.created_at', '<=', $request->date('to'));
        }

        if ($request->filled('search')) {
            $search = trim((string) $request->query('search'));
            $query->where(function ($builder) use ($search) {
                $builder
                    ->where('employees.employee_code', 'like', '%' . $search . '%')
                    ->orWhere('employees.full_name_en', 'like', '%' . $search . '%')
                    ->orWhere('employees.full_name_bn', 'like', '%' . $search . '%')
                    ->orWhere('users.name', 'like', '%' . $search . '%');
            });
        }

        $query->groupBy(
            'sales_orders.employee_id',
            'users.name',
            'employees.full_name_en',
            'employees.full_name_bn',
            'employees.employee_code',
            'employees.rank',
            'branches.name'
        );

        $summaryRows = (clone $query)->get();

        $sort = $request->query('sort', 'total_sales');
        $direction = strtolower((string) $request->query('direction', 'desc')) === 'asc' ? 'asc' : 'desc';

        $sortable = [
            'employee_name',
            'orders_count',
            'total_sales',
            'total_down_payment',
            'total_collections',
        ];

        if (! in_array($sort, $sortable, true)) {
            $sort = 'total_sales';
        }

        $query->orderBy($sort, $direction);

        $perPage = max(1, (int) $request->query('per_page', 15));
        $paginated = $query
            ->paginate($perPage)
            ->appends($request->query());

        $paginated->setCollection(
            $paginated->getCollection()->map(fn ($row) => $this->transformEmployeePerformanceRow($row))
        );

        $summary = [
            'employee_count' => $summaryRows->count(),
            'orders_count' => (int) $summaryRows->sum('orders_count'),
            'total_sales' => round((float) $summaryRows->sum('total_sales'), 2),
            'total_down_payment' => round((float) $summaryRows->sum('total_down_payment'), 2),
            'total_collections' => round((float) $summaryRows->sum('total_collections'), 2),
            'average_order_value' => $summaryRows->sum('orders_count') > 0
                ? round($summaryRows->sum('total_sales') / $summaryRows->sum('orders_count'), 2)
                : 0.0,
            'collection_rate' => $summaryRows->sum('total_sales') > 0
                ? round(($summaryRows->sum('total_collections') / $summaryRows->sum('total_sales')) * 100, 2)
                : 0.0,
        ];

        return response()->json([
            'data' => $paginated->getCollection()->values()->all(),
            'summary' => $summary,
            'meta' => [
                'current_page' => $paginated->currentPage(),
                'last_page' => $paginated->lastPage(),
                'per_page' => $paginated->perPage(),
                'total' => $paginated->total(),
            ],
        ]);
    }

    public function emiExtraIncome(Request $request)
    {
        $query = Payment::query()
            ->join('sales_orders', 'sales_orders.id', '=', 'payments.sales_order_id')
            ->leftJoin('order_items', function ($join) {
                $join->on('order_items.sales_order_id', '=', 'sales_orders.id')
                    ->where('order_items.itemable_type', Product::class);
            })
            ->where('payments.emi_extra_amount', '>', 0);

        if ($request->filled('from')) {
            $query->whereDate('payments.paid_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('payments.paid_at', '<=', $request->date('to'));
        }

        if ($request->filled('branch_id')) {
            $query->whereIn('sales_orders.branch_id', array_map('intval', $this->parseCsv($request, 'branch_id')));
        }

        if ($request->filled('product_id')) {
            $query->whereIn('order_items.itemable_id', array_map('intval', $this->parseCsv($request, 'product_id')));
        }

        $rows = $query
            ->selectRaw("DATE_FORMAT(payments.paid_at, '%Y-%m') as month")
            ->selectRaw('sales_orders.branch_id as branch_id')
            ->selectRaw('order_items.itemable_id as product_id')
            ->selectRaw('SUM(payments.emi_extra_amount) as emi_extra_total')
            ->groupBy('month', 'sales_orders.branch_id', 'order_items.itemable_id')
            ->orderBy('month')
            ->get();

        $branchIds = $rows->pluck('branch_id')->filter()->unique()->all();
        $productIds = $rows->pluck('product_id')->filter()->unique()->all();

        $branches = Branch::whereIn('id', $branchIds)->get()->keyBy('id');
        $products = Product::whereIn('id', $productIds)->get()->keyBy('id');

        $data = $rows->map(function ($row) use ($branches, $products) {
            $branch = $branches->get($row->branch_id);
            $product = $products->get($row->product_id);

            return [
                'month' => $row->month,
                'branch_id' => $row->branch_id,
                'branch' => $branch ? [
                    'id' => $branch->id,
                    'name' => $branch->name,
                    'code' => $branch->code,
                ] : null,
                'product_id' => $row->product_id,
                'product' => $product ? [
                    'id' => $product->id,
                    'name' => $product->name,
                ] : null,
                'emi_extra_total' => round((float) $row->emi_extra_total, 2),
            ];
        });

        $summary = [
            'total_emi_extra' => round($data->sum('emi_extra_total'), 2),
            'count' => $data->count(),
        ];

        return response()->json([
            'data' => $data,
            'summary' => $summary,
        ]);
    }

    public function customerLedger(Request $request)
    {
        $validated = $request->validate([
            'customer_id' => ['required', 'integer', 'exists:users,id'],
            'from' => ['nullable', 'date'],
            'to' => ['nullable', 'date'],
        ]);

        $customerId = (int) $validated['customer_id'];
        $orderIds = SalesOrder::query()
            ->where('customer_id', $customerId)
            ->pluck('id');

        if ($orderIds->isEmpty()) {
            return response()->json([
                'data' => [],
                'summary' => [
                    'total_debit' => 0.0,
                    'total_credit' => 0.0,
                    'closing_balance' => 0.0,
                    'entry_count' => 0,
                ],
                'customer' => User::select('id', 'name', 'email')->find($customerId),
            ]);
        }

        $query = LedgerEntry::query()
            ->with('account')
            ->whereIn('meta->sales_order_id', $orderIds);

        if ($request->filled('from')) {
            $query->whereDate('occurred_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('occurred_at', '<=', $request->date('to'));
        }

        $orderedEntries = $query->orderBy('occurred_at')->orderBy('id')->get();
        $orderedEntries->loadMissing('account');

        if ($this->isExportRequest($request)) {
            return $this->exportLedgerEntries($orderedEntries, 'customer_ledger_' . $customerId);
        }

        $transformed = $this->transformLedgerEntriesWithBalance($orderedEntries);

        if ($this->isPrintRequest($request)) {
            return response()->json([
                'data' => $transformed['entries'],
                'summary' => $transformed['summary'],
                'customer' => User::select('id', 'name', 'email')->find($customerId),
            ]);
        }

        return response()->json([
            'data' => $transformed['entries'],
            'summary' => $transformed['summary'],
            'customer' => User::select('id', 'name', 'email')->find($customerId),
        ]);
    }

    public function supplierLedger(Request $request)
    {
        $validated = $request->validate([
            'supplier_id' => ['required', 'integer'],
            'from' => ['nullable', 'date'],
            'to' => ['nullable', 'date'],
        ]);

        $supplierId = (int) $validated['supplier_id'];

        $query = LedgerEntry::query()
            ->with('account')
            ->where('meta->supplier_id', $supplierId);

        if ($request->filled('from')) {
            $query->whereDate('occurred_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('occurred_at', '<=', $request->date('to'));
        }

        $orderedEntries = $query->orderBy('occurred_at')->orderBy('id')->get();
        $orderedEntries->loadMissing('account');

        if ($this->isExportRequest($request)) {
            return $this->exportLedgerEntries($orderedEntries, 'supplier_ledger_' . $supplierId);
        }

        $transformed = $this->transformLedgerEntriesWithBalance($orderedEntries);

        return response()->json([
            'data' => $transformed['entries'],
            'summary' => $transformed['summary'],
            'supplier' => ['id' => $supplierId],
        ]);
    }

    public function accountStatement(Request $request)
    {
        $validated = $request->validate([
            'account_id' => ['nullable', 'integer', 'exists:ledger_accounts,id'],
            'account_code' => ['nullable', 'string'],
            'from' => ['nullable', 'date'],
            'to' => ['nullable', 'date'],
        ]);

        $account = null;

        if (! empty($validated['account_id'])) {
            $account = LedgerAccount::find($validated['account_id']);
        } elseif (! empty($validated['account_code'])) {
            $account = LedgerAccount::where('code', $validated['account_code'])->first();
        }

        if (! $account) {
            return response()->json([
                'message' => 'Account not found.',
            ], 404);
        }

        $query = LedgerEntry::query()
            ->with('account')
            ->where('account_id', $account->id);

        if ($request->filled('from')) {
            $query->whereDate('occurred_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('occurred_at', '<=', $request->date('to'));
        }

        $orderedEntries = $query->orderBy('occurred_at')->orderBy('id')->get();

        if ($this->isExportRequest($request)) {
            return $this->exportLedgerEntries($orderedEntries, 'account_statement_' . $account->code);
        }

        $transformed = $this->transformLedgerEntriesWithBalance($orderedEntries);

        return response()->json([
            'account' => [
                'id' => $account->id,
                'code' => $account->code,
                'name' => $account->name,
                'type' => $account->type,
            ],
            'data' => $transformed['entries'],
            'summary' => $transformed['summary'],
        ]);
    }

    protected function parseCsv(Request $request, string $key): array
    {
        return array_values(array_filter(array_map('trim', explode(',', (string) $request->query($key)))));
    }

    protected function resolveDateField(?string $field, array $allowed, string $default): string
    {
        if (! $field) {
            return $default;
        }

        return in_array($field, $allowed, true) ? $field : $default;
    }

    protected function isExportRequest(Request $request): bool
    {
        return strtolower((string) $request->query('export')) === 'excel';
    }

    protected function isPrintRequest(Request $request): bool
    {
        return $request->boolean('print') || strtolower((string) $request->query('format')) === 'print';
    }

    protected function exportCommissionReport(Collection $commissions): StreamedResponse
    {
        $summary = $this->summarizeCommissions($commissions);
        $filename = 'commission_report_' . now()->format('Ymd_His') . '.csv';

        return $this->streamCsv($filename, [
            'Commission ID',
            'Payment ID',
            'Sales Order',
            'Recipient Type',
            'Recipient',
            'Recipient Rank',
            'Recipient Branch',
            'Agent',
            'Branch',
            'Status',
            'Amount',
            'Created At',
            'Paid At',
        ], $commissions->map(function (Commission $commission) {
            $salesOrder = $commission->salesOrder;
            $recipient = $commission->recipient;
            $recipientName = $this->resolveRecipientName($recipient);
            $recipientRank = $this->resolveRecipientRank($recipient);
            $recipientBranch = $this->resolveRecipientBranchName($recipient);
            $agentUser = $salesOrder?->agent?->user;
            $branch = $salesOrder?->branch;

            return [
                $commission->id,
                $commission->payment_id,
                $salesOrder ? 'SO-' . $salesOrder->id : $commission->sales_order_id,
                $commission->recipient_type,
                $recipientName,
                $recipientRank,
                $recipientBranch,
                $agentUser?->name ?? '',
                $branch?->name ?? '',
                $commission->status,
                (float) $commission->amount,
                optional($commission->created_at)->toDateTimeString(),
                optional($commission->paid_at)->toDateTimeString(),
            ];
        }), [
            ['Total Amount', $summary['total_amount']],
            ['Commission Count', $summary['count']],
        ]);
    }

    protected function resolveRecipientName($recipient): string
    {
        if (! $recipient) {
            return '';
        }

        if (isset($recipient->full_name_en) && $recipient->full_name_en) {
            return (string) $recipient->full_name_en;
        }

        if (isset($recipient->name) && $recipient->name) {
            return (string) $recipient->name;
        }

        if (isset($recipient->user) && $recipient->user) {
            return (string) ($recipient->user->name ?? '');
        }

        if (method_exists($recipient, 'getAttribute')) {
            $value = $recipient->getAttribute('name');

            if ($value) {
                return (string) $value;
            }
        }

        return '';
    }

    protected function resolveRecipientRank($recipient): string
    {
        if (! $recipient) {
            return '';
        }

        if ($recipient instanceof Employee && isset($recipient->rank)) {
            return (string) $recipient->rank;
        }

        if ($recipient instanceof Agent) {
            if ($recipient->relationLoaded('activeRank') && $recipient->activeRank) {
                return (string) ($recipient->activeRank->rank ?? '');
            }
        }

        return '';
    }

    protected function resolveRecipientBranchName($recipient): string
    {
        if (! $recipient) {
            return '';
        }

        if ($recipient instanceof Employee) {
            return $recipient->relationLoaded('branch') && $recipient->branch ? (string) $recipient->branch->name : '';
        }

        if ($recipient instanceof Agent) {
            return $recipient->relationLoaded('branch') && $recipient->branch ? (string) $recipient->branch->name : '';
        }

        return '';
    }

    protected function transformEmployeePerformanceRow($row): array
    {
        $ordersCount = (int) ($row->orders_count ?? 0);
        $totalSales = (float) ($row->total_sales ?? 0);
        $totalDownPayment = (float) ($row->total_down_payment ?? 0);
        $totalCollections = (float) ($row->total_collections ?? 0);

        $averageOrderValue = $ordersCount > 0 ? round($totalSales / $ordersCount, 2) : 0.0;
        $collectionRate = $totalSales > 0 ? round(($totalCollections / $totalSales) * 100, 2) : 0.0;

        return [
            'employee_id' => (int) $row->employee_id,
            'employee_code' => $row->employee_code,
            'employee_name' => $row->employee_name,
            'rank' => $row->rank,
            'branch_name' => $row->branch_name,
            'orders_count' => $ordersCount,
            'total_sales' => round($totalSales, 2),
            'total_down_payment' => round($totalDownPayment, 2),
            'total_collections' => round($totalCollections, 2),
            'average_order_value' => $averageOrderValue,
            'collection_rate' => $collectionRate,
        ];
    }

    protected function summarizeCommissions(Collection $commissions): array
    {
        $total = $commissions->sum(fn (Commission $commission) => (float) $commission->amount);

        $statusBreakdown = $commissions
            ->groupBy(fn (Commission $commission) => $commission->status ?? 'unknown')
            ->map(fn (Collection $items) => [
                'amount' => round($items->sum(fn ($item) => (float) $item->amount), 2),
                'count' => $items->count(),
            ])
            ->toArray();

        return [
            'total_amount' => round($total, 2),
            'count' => $commissions->count(),
            'status_breakdown' => $statusBreakdown,
        ];
    }

    protected function exportSalesReport(Collection $orders): StreamedResponse
    {
        $summary = $this->summarizeSales($orders);
        $filename = 'sales_report_' . now()->format('Ymd_His') . '.csv';

        return $this->streamCsv($filename, [
            'Sales Order ID',
            'Order No',
            'Customer',
            'Agent',
            'Branch',
            'Sales Type',
            'Status',
            'Total',
            'Down Payment',
            'Created At',
        ], $orders->map(function (SalesOrder $order) {
            $customer = $order->customer;
            $agent = $order->agent?->user;
            $branch = $order->branch;

            return [
                $order->id,
                'SO-' . $order->id,
                $customer?->name ?? '',
                $agent?->name ?? '',
                $branch?->name ?? '',
                $order->sales_type,
                $order->status,
                (float) $order->total,
                (float) $order->down_payment,
                optional($order->created_at)->toDateTimeString(),
            ];
        }), [
            ['Total Orders', $summary['count']],
            ['Total Value', $summary['total_value']],
            ['Total Down Payment', $summary['total_down_payment']],
        ]);
    }

    protected function summarizeSales(Collection $orders): array
    {
        $totalValue = $orders->sum(fn (SalesOrder $order) => (float) $order->total);
        $totalDownPayment = $orders->sum(fn (SalesOrder $order) => (float) $order->down_payment);

        $statusBreakdown = $orders
            ->groupBy(fn (SalesOrder $order) => $order->status ?? 'unknown')
            ->map(fn (Collection $items) => [
                'count' => $items->count(),
                'total' => round($items->sum(fn ($item) => (float) $item->total), 2),
            ])
            ->toArray();

        return [
            'total_value' => round($totalValue, 2),
            'total_down_payment' => round($totalDownPayment, 2),
            'count' => $orders->count(),
            'status_breakdown' => $statusBreakdown,
        ];
    }

    protected function exportStockReport(Collection $products): StreamedResponse
    {
        $summary = $this->summarizeStock($products);
        $filename = 'stock_report_' . now()->format('Ymd_His') . '.csv';

        return $this->streamCsv($filename, [
            'Product ID',
            'Name',
            'Category',
            'Type',
            'Price',
            'Stock Qty',
            'Min Stock Alert',
        ], $products->map(function (Product $product) {
            return [
                $product->id,
                $product->name,
                $product->category?->name ?? '',
                $product->product_type,
                (float) $product->price,
                (float) $product->stock_qty,
                (float) $product->min_stock_alert,
            ];
        }), [
            ['Total Items', $summary['total_items']],
            ['Total Quantity', $summary['total_qty']],
            ['Total Value', $summary['total_value']],
        ]);
    }

    protected function summarizeStock(Collection $products): array
    {
        return [
            'total_items' => $products->count(),
            'total_qty' => round($products->sum(fn (Product $product) => (float) $product->stock_qty), 2),
            'total_value' => round($products->sum(fn (Product $product) => (float) $product->stock_qty * (float) $product->price), 2),
        ];
    }

    protected function exportIncomeReport(Collection $entries): StreamedResponse
    {
        $summary = $this->summarizeLedgerEntries($entries);
        $filename = 'income_report_' . now()->format('Ymd_His') . '.csv';

        return $this->streamCsv($filename, [
            'TX ID',
            'Account',
            'Debit',
            'Credit',
            'Occurred At',
        ], $entries->map(function (LedgerEntry $entry) {
            return [
                $entry->tx_id,
                $entry->account?->name ?? '',
                (float) $entry->debit,
                (float) $entry->credit,
                optional($entry->occurred_at)->toDateTimeString(),
            ];
        }), [
            ['Total Debit', $summary['total_debit']],
            ['Total Credit', $summary['total_credit']],
            ['Net', $summary['net']],
        ]);
    }

    protected function transformLedgerEntries(Collection $entries): array
    {
        return $entries->map(function (LedgerEntry $entry) {
            return [
                'id' => $entry->id,
                'tx_id' => $entry->tx_id,
                'account' => $entry->account ? [
                    'id' => $entry->account->id,
                    'code' => $entry->account->code,
                    'name' => $entry->account->name,
                    'type' => $entry->account->type,
                ] : null,
                'debit' => (float) $entry->debit,
                'credit' => (float) $entry->credit,
                'occurred_at' => $entry->occurred_at,
                'meta' => $entry->meta,
            ];
        })->all();
    }

    protected function transformLedgerEntriesWithBalance(Collection $entries): array
    {
        $runningBalance = 0.0;

        $transformed = $entries->map(function (LedgerEntry $entry) use (&$runningBalance) {
            $runningBalance += (float) $entry->debit - (float) $entry->credit;

            return [
                'id' => $entry->id,
                'tx_id' => $entry->tx_id,
                'account' => $entry->account ? [
                    'id' => $entry->account->id,
                    'code' => $entry->account->code,
                    'name' => $entry->account->name,
                    'type' => $entry->account->type,
                ] : null,
                'debit' => (float) $entry->debit,
                'credit' => (float) $entry->credit,
                'occurred_at' => $entry->occurred_at,
                'balance' => round($runningBalance, 2),
                'meta' => $entry->meta,
            ];
        });

        return [
            'entries' => $transformed->all(),
            'summary' => $this->summarizeLedgerEntries($entries) + [
                'closing_balance' => round($runningBalance, 2),
            ],
        ];
    }

    protected function summarizeLedgerEntries(Collection $entries): array
    {
        $totalDebit = $entries->sum(fn (LedgerEntry $entry) => (float) $entry->debit);
        $totalCredit = $entries->sum(fn (LedgerEntry $entry) => (float) $entry->credit);

        return [
            'total_debit' => round($totalDebit, 2),
            'total_credit' => round($totalCredit, 2),
            'net' => round($totalDebit - $totalCredit, 2),
            'entry_count' => $entries->count(),
        ];
    }

    protected function exportLedgerEntries(Collection $entries, string $prefix): StreamedResponse
    {
        $summary = $this->summarizeLedgerEntries($entries);
        $filename = $prefix . '_' . now()->format('Ymd_His') . '.csv';

        return $this->streamCsv($filename, [
            'TX ID',
            'Account',
            'Debit',
            'Credit',
            'Occurred At',
        ], $entries->map(function (LedgerEntry $entry) {
            return [
                $entry->tx_id,
                $entry->account?->name ?? '',
                (float) $entry->debit,
                (float) $entry->credit,
                optional($entry->occurred_at)->toDateTimeString(),
            ];
        }), [
            ['Total Debit', $summary['total_debit']],
            ['Total Credit', $summary['total_credit']],
            ['Net', $summary['net']],
        ]);
    }

    protected function streamCsv(string $filename, array $header, iterable $rows, array $footerRows = []): StreamedResponse
    {
        return response()->streamDownload(function () use ($header, $rows, $footerRows) {
            $handle = fopen('php://output', 'w');

            if (! empty($header)) {
                fputcsv($handle, $header);
            }

            foreach ($rows as $row) {
                fputcsv($handle, is_array($row) ? $row : (array) $row);
            }

            if (! empty($footerRows)) {
                fputcsv($handle, []);

                foreach ($footerRows as $footerRow) {
                    fputcsv($handle, $footerRow);
                }
            }

            fclose($handle);
        }, $filename, [
            'Content-Type' => 'text/csv',
        ]);
    }
}
