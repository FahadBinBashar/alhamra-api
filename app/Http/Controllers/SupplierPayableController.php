<?php

namespace App\Http\Controllers;

use App\Http\Resources\SupplierPayableResource;
use App\Models\Supplier;
use App\Models\SupplierPayable;
use App\Services\SupplierPayableService;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class SupplierPayableController extends Controller
{
    public function __construct(private SupplierPayableService $payableService)
    {
    }

    public function index(Request $request): AnonymousResourceCollection
    {
        $request->validate([
            'supplier_id' => ['nullable', 'integer', 'exists:suppliers,id'],
            'status' => ['nullable', Rule::in([SupplierPayable::STATUS_UNPAID, SupplierPayable::STATUS_PAID])],
            'from' => ['nullable', 'date'],
            'to' => ['nullable', 'date'],
        ]);

        $query = SupplierPayable::query()->with('supplier');

        if ($request->filled('supplier_id')) {
            $query->where('supplier_id', $request->integer('supplier_id'));
        }

        if ($request->filled('status')) {
            $query->where('status', $request->string('status'));
        }

        if ($request->filled('from')) {
            $query->whereDate('created_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('created_at', '<=', $request->date('to'));
        }

        $payables = $query->orderByDesc('created_at')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return SupplierPayableResource::collection($payables);
    }

    public function process(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'supplier_id' => ['required', 'integer', 'exists:suppliers,id'],
            'payable_ids' => ['sometimes', 'array'],
            'payable_ids.*' => ['integer', 'exists:supplier_payables,id'],
            'from' => ['sometimes', 'date'],
            'to' => ['sometimes', 'date'],
            'method' => ['required', Rule::in(['cash', 'bank'])],
            'paid_at' => ['sometimes', 'date'],
        ]);

        $supplier = Supplier::findOrFail($validated['supplier_id']);
        $paidAt = isset($validated['paid_at']) ? Carbon::parse($validated['paid_at']) : now();

        $query = SupplierPayable::query()
            ->where('supplier_id', $supplier->id)
            ->where('status', SupplierPayable::STATUS_UNPAID);

        if (! empty($validated['payable_ids'])) {
            $query->whereIn('id', $validated['payable_ids']);
        }

        if (! empty($validated['from'])) {
            $query->whereDate('created_at', '>=', Carbon::parse($validated['from']));
        }

        if (! empty($validated['to'])) {
            $query->whereDate('created_at', '<=', Carbon::parse($validated['to']));
        }

        $processed = DB::transaction(function () use ($query, $supplier, $paidAt, $validated) {
            $payables = $query->lockForUpdate()->get();

            if ($payables->isEmpty()) {
                return null;
            }

            $this->payableService->markAsPaid($supplier, $payables, $validated['method'], $paidAt);

            return $payables;
        });

        if (! $processed) {
            return response()->json([
                'message' => 'No unpaid supplier payables found for the provided criteria.',
            ], 422);
        }

        return response()->json([
            'message' => 'Supplier payables processed successfully.',
            'total_paid' => $processed->sum(fn (SupplierPayable $payable) => (float) $payable->amount),
            'payable_ids' => $processed->pluck('id'),
        ]);
    }
}
