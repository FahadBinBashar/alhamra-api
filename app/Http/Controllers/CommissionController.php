<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Requests\StoreCommissionRequest;
use App\Http\Requests\UpdateCommissionRequest;
use App\Http\Resources\CommissionResource;
use App\Models\Commission;
use App\Models\Payment;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class CommissionController extends Controller
{
    use ResolvesIncludes;

    public function index(Request $request): AnonymousResourceCollection
    {
        $allowedIncludes = ['rule', 'payment', 'salesOrder'];
        $includes = $this->resolveIncludes($request, $allowedIncludes);

        if (empty($includes)) {
            $includes = ['rule'];
        }

        $query = Commission::query();

        if (! empty($includes)) {
            $query->with($includes);
        }

        if ($request->filled('status')) {
            $query->where('status', $request->string('status'));
        }

        if ($request->filled('commission_rule_id')) {
            $query->where('commission_rule_id', $request->integer('commission_rule_id'));
        }

        if ($request->filled('payment_id')) {
            $query->where('payment_id', $request->integer('payment_id'));
        }

        if ($request->filled('sales_order_id')) {
            $query->where('sales_order_id', $request->integer('sales_order_id'));
        }

        if ($request->filled('recipient_type')) {
            $query->where('recipient_type', $request->string('recipient_type'));
        }

        if ($request->filled('recipient_id')) {
            $query->where('recipient_id', $request->integer('recipient_id'));
        }

        $commissions = $query
            ->orderByDesc('created_at')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return CommissionResource::collection($commissions);
    }

    public function store(StoreCommissionRequest $request): CommissionResource
    {
        $data = $request->validated();

        $this->synchronizeSalesOrderId($data);
        $this->normalizeStatusTimestamps($data);

        $commission = Commission::create($data);

        $includes = $this->resolveIncludes($request, ['rule', 'payment', 'salesOrder']);

        if (empty($includes)) {
            $includes = ['rule'];
        }

        if (! empty($includes)) {
            $commission->load($includes);
        }

        return new CommissionResource($commission);
    }

    public function show(Request $request, Commission $commission): CommissionResource
    {
        $includes = $this->resolveIncludes($request, ['rule', 'payment', 'salesOrder']);

        if (empty($includes)) {
            $includes = ['rule'];
        }

        if (! empty($includes)) {
            $commission->load($includes);
        }

        return new CommissionResource($commission);
    }

    public function update(UpdateCommissionRequest $request, Commission $commission): CommissionResource
    {
        $data = $request->validated();

        $this->synchronizeSalesOrderId($data, $commission);
        $this->normalizeStatusTimestamps($data, $commission);

        $commission->update($data);

        $includes = $this->resolveIncludes($request, ['rule', 'payment', 'salesOrder']);

        if (empty($includes)) {
            $includes = ['rule'];
        }

        if (! empty($includes)) {
            $commission->load($includes);
        }

        return new CommissionResource($commission);
    }

    public function destroy(Commission $commission): JsonResponse
    {
        $commission->delete();

        return response()->json(null, 204);
    }

    /**
     * @param  array<string, mixed>  $data
     */
    protected function synchronizeSalesOrderId(array &$data, ?Commission $commission = null): void
    {
        if (! array_key_exists('sales_order_id', $data) || $data['sales_order_id'] === null) {
            $paymentId = $data['payment_id'] ?? $commission?->payment_id;

            if ($paymentId) {
                $salesOrderId = Payment::query()->whereKey($paymentId)->value('sales_order_id');

                if ($salesOrderId) {
                    $data['sales_order_id'] = $salesOrderId;
                }
            }
        }
    }

    /**
     * @param  array<string, mixed>  $data
     */
    protected function normalizeStatusTimestamps(array &$data, ?Commission $commission = null): void
    {
        if (array_key_exists('status', $data)) {
            if ($data['status'] === 'paid') {
                if (empty($data['paid_at'])) {
                    $data['paid_at'] = now();
                }
            } elseif ($data['status'] === 'unpaid') {
                $data['paid_at'] = null;
            }
        } elseif (array_key_exists('paid_at', $data) && ($commission?->status ?? null) !== 'paid') {
            // Ensure paid_at is null when status is not paid
            $data['paid_at'] = null;
        }
    }
}
