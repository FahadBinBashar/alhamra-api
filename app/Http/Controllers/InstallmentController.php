<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Requests\StoreInstallmentRequest;
use App\Http\Requests\UpdateInstallmentRequest;
use App\Http\Resources\InstallmentResource;
use App\Models\CustomerInstallment;
use App\Models\SalesOrder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class InstallmentController extends Controller
{
    use ResolvesIncludes;

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $includes = $this->resolveIncludes($request, ['salesOrder', 'allocations']);

        $query = CustomerInstallment::query();

        if (! empty($includes)) {
            $query->with($includes);
        }

        if ($request->filled('sales_order_id')) {
            $query->where('sales_order_id', $request->integer('sales_order_id'));
        }

        if ($request->filled('status')) {
            $statuses = collect(explode(',', $request->string('status')))
                ->map(static fn (string $status): string => trim($status))
                ->filter()
                ->values()
                ->all();

            if (! empty($statuses)) {
                $query->whereIn('status', $statuses);
            }
        }

        $installments = $query
            ->orderBy('due_date')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return InstallmentResource::collection($installments);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreInstallmentRequest $request): JsonResponse
    {
        $data = $request->validated();

        if (! array_key_exists('status', $data) || empty($data['status'])) {
            $data['status'] = 'due';
        }

        if (! array_key_exists('paid', $data) || $data['paid'] === null) {
            $data['paid'] = 0;
        }

        $installment = CustomerInstallment::create($data);

        $includes = $this->resolveIncludes($request, ['salesOrder', 'allocations']);

        if (! empty($includes)) {
            $installment->load($includes);
        }

        return (new InstallmentResource($installment))
            ->response()
            ->setStatusCode(201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request, CustomerInstallment $installment): InstallmentResource
    {
        $includes = $this->resolveIncludes($request, ['salesOrder', 'allocations']);

        if (! empty($includes)) {
            $installment->load($includes);
        }

        return new InstallmentResource($installment);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateInstallmentRequest $request, CustomerInstallment $installment): InstallmentResource
    {
        $data = $request->validated();

        $installment->update($data);

        $includes = $this->resolveIncludes($request, ['salesOrder', 'allocations']);

        if (! empty($includes)) {
            $installment->load($includes);
        }

        return new InstallmentResource($installment);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(CustomerInstallment $installment): JsonResponse
    {
        if ($installment->paid > 0 || $installment->allocations()->exists()) {
            return response()->json([
                'message' => 'Installment cannot be deleted once payments have been recorded.',
            ], 422);
        }

        $installment->delete();

        return response()->json(null, 204);
    }

    public function generate(Request $request, SalesOrder $order): JsonResponse
    {
        return response()->json([
            'message' => 'Installment schedule generation is not implemented yet.',
        ], 501);
    }
}
