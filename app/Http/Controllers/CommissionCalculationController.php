<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Resources\CommissionCalculationUnitResource;
use App\Models\CommissionCalculationItem;
use App\Models\CommissionCalculationUnit;
use App\Services\CommissionService;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class CommissionCalculationController extends Controller
{
    use ResolvesIncludes;

    public function __construct(private CommissionService $commissionService)
    {
    }

    public function index(Request $request): AnonymousResourceCollection
    {
        $allowedIncludes = [
            'payment',
            'payment.salesOrder',
            'payment.salesOrder.customer',
            'payment.salesOrder.agent.user',
            'payment.salesOrder.branch',
            'items',
            'items.recipient',
        ];

        $includes = $this->resolveIncludes($request, $allowedIncludes);

        $query = CommissionCalculationUnit::query();

        if (empty($includes)) {
            $includes = ['items', 'payment.salesOrder'];
        }

        if (! empty($includes)) {
            $query->with($includes);
        }

        $this->applyFilters($request, $query);

        $perPage = max(1, (int) $request->integer('per_page', 15));

        $units = $query
            ->orderByDesc('calculated_at')
            ->orderByDesc('id')
            ->paginate($perPage)
            ->appends($request->query());

        $summary = $this->buildSummary($request);

        return CommissionCalculationUnitResource::collection($units)
            ->additional(['summary' => $summary]);
    }

    public function show(Request $request, CommissionCalculationUnit $commissionCalculation): CommissionCalculationUnitResource
    {
        $allowedIncludes = [
            'payment',
            'payment.salesOrder',
            'payment.salesOrder.customer',
            'payment.salesOrder.agent.user',
            'payment.salesOrder.branch',
            'items',
            'items.recipient',
        ];

        $includes = $this->resolveIncludes($request, $allowedIncludes);

        if (empty($includes)) {
            $includes = ['items', 'payment.salesOrder'];
        }

        if (! empty($includes)) {
            $commissionCalculation->load($includes);
        }

        return new CommissionCalculationUnitResource($commissionCalculation);
    }

    public function process(Request $request): JsonResponse
    {
        $dateInput = $request->input('date') ?? $request->input('up_to');
        $upTo = $dateInput ? Carbon::parse($dateInput) : null;

        $commissions = $this->commissionService->processPendingCommissions($upTo);

        return response()->json([
            'processed' => $commissions->count(),
            'total_amount' => (float) $commissions->sum('amount'),
            'cutoff_date' => $upTo?->toDateString(),
        ]);
    }

    protected function applyFilters(Request $request, Builder $query): void
    {
        if ($request->filled('status')) {
            $statuses = $this->parseCsv($request, 'status');

            if (! in_array('all', $statuses, true)) {
                $query->whereIn('status', $statuses);
            }
        } else {
            $query->where('status', 'draft');
        }

        if ($request->filled('payment_id')) {
            $query->whereIn('payment_id', array_map('intval', $this->parseCsv($request, 'payment_id')));
        }

        if ($request->filled('sales_order_id')) {
            $query->whereIn('sales_order_id', array_map('intval', $this->parseCsv($request, 'sales_order_id')));
        }

        if ($request->filled('from') || $request->filled('to')) {
            $query->whereHas('payment', function (Builder $paymentQuery) use ($request) {
                if ($request->filled('from')) {
                    $paymentQuery->whereDate('paid_at', '>=', $request->date('from')->toDateString());
                }

                if ($request->filled('to')) {
                    $paymentQuery->whereDate('paid_at', '<=', $request->date('to')->toDateString());
                }
            });
        }

        if ($request->filled('branch_id')) {
            $branchIds = array_map('intval', $this->parseCsv($request, 'branch_id'));
            $query->whereHas('payment.salesOrder', fn (Builder $builder) => $builder->whereIn('branch_id', $branchIds));
        }

        if ($request->filled('agent_id')) {
            $agentIds = array_map('intval', $this->parseCsv($request, 'agent_id'));
            $query->whereHas('payment.salesOrder', fn (Builder $builder) => $builder->whereIn('agent_id', $agentIds));
        }

        if ($request->filled('recipient_type') || $request->filled('recipient_id')) {
            $types = $request->filled('recipient_type') ? $this->parseCsv($request, 'recipient_type') : null;
            $ids = $request->filled('recipient_id') ? array_map('intval', $this->parseCsv($request, 'recipient_id')) : null;

            $query->whereHas('items', function (Builder $itemQuery) use ($types, $ids) {
                if ($types) {
                    $itemQuery->whereIn('recipient_type', $types);
                }

                if ($ids) {
                    $itemQuery->whereIn('recipient_id', $ids);
                }
            });
        }
    }

    protected function buildSummary(Request $request): array
    {
        $unitQuery = CommissionCalculationUnit::query();
        $this->applyFilters($request, $unitQuery);

        $itemQuery = CommissionCalculationItem::query()
            ->whereHas('unit', function (Builder $builder) use ($request) {
                $this->applyFilters($request, $builder);
            });

        return [
            'units' => (int) $unitQuery->count(),
            'items' => (int) $itemQuery->count(),
            'total_amount' => (float) $itemQuery->sum('amount'),
        ];
    }

    protected function parseCsv(Request $request, string $key): array
    {
        $value = $request->input($key);

        if (is_array($value)) {
            return array_values(array_filter(array_map('strval', $value), fn ($part) => $part !== ''));
        }

        return array_values(array_filter(array_map('trim', explode(',', (string) $value)), fn ($part) => $part !== ''));
    }
}
