<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Requests\StoreInstallmentRequest;
use App\Http\Requests\UpdateInstallmentRequest;
use App\Http\Resources\InstallmentResource;
use App\Models\CustomerInstallment;
use App\Models\Product;
use App\Models\ProductEmiRule;
use App\Models\SalesOrder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class InstallmentController extends Controller
{
    use ResolvesIncludes;

    private const SUPPORTED_FREQUENCIES = [
        'daily',
        'weekly',
        'biweekly',
        'monthly',
        'quarterly',
        'yearly',
    ];

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
        $data = $request->validate([
            'frequency' => ['required', 'string', Rule::in(self::SUPPORTED_FREQUENCIES)],
            'count' => ['required', 'integer', 'min:1', 'max:360'],
            'start_date' => ['required', 'date'],
            'grace_days' => ['sometimes', 'nullable', 'integer', 'min:0', 'max:365'],
            'installment_tenure_months' => ['sometimes', 'nullable', 'integer', 'min:1', 'max:360'],
        ]);

        if ($order->sales_type === SalesOrder::TYPE_SERVICE) {
            return response()->json([
                'message' => 'Installments are not available for service sales.',
            ], 422);
        }

        $count = (int) $data['count'];
        $tenureMonths = (int) ($data['installment_tenure_months'] ?? $order->installment_tenure_months ?? $count);

        if ($tenureMonths <= 0) {
            return response()->json([
                'message' => 'Installment tenure months are required to generate installments.',
            ], 422);
        }

        $order->loadMissing('items.itemable');
        $productIds = $order->items
            ->filter(fn ($item) => $item->itemable instanceof Product)
            ->map(fn ($item) => $item->itemable->id)
            ->unique()
            ->values();

        if ($productIds->isNotEmpty()) {
            $missingRules = $productIds->reject(fn ($productId) => ProductEmiRule::query()
                ->where('product_id', $productId)
                ->where('tenure_months', $tenureMonths)
                ->where('is_active', true)
                ->exists());

            if ($missingRules->isNotEmpty()) {
                return response()->json([
                    'message' => 'The selected tenure does not have EMI rules configured for this product.',
                ], 422);
            }
        }

        $existingWithPayments = $order->installments()
            ->where(function ($query) {
                $query->where('paid', '>', 0)
                    ->orWhereIn('status', ['partial', 'paid']);
            })
            ->exists();

        if ($existingWithPayments) {
            return response()->json([
                'message' => 'Installments with recorded payments cannot be regenerated.',
            ], 422);
        }

        $principal = round((float) $order->total - (float) $order->down_payment, 2);

        if ($principal <= 0) {
            return response()->json([
                'message' => 'The sales order does not have an outstanding balance to schedule.',
            ], 422);
        }

        $includes = $this->resolveIncludes($request, ['salesOrder', 'allocations']);
        $frequency = $data['frequency'];
        $startDate = Carbon::parse($data['start_date']);
        $graceDays = (int) ($data['grace_days'] ?? 0);
        $totalCents = (int) round($principal * 100);

        if ($totalCents === 0 && $principal > 0) {
            $totalCents = 1;
        }

        $installments = DB::transaction(function () use ($order, $includes, $frequency, $count, $startDate, $graceDays, $totalCents, $tenureMonths) {
            if ((int) $order->installment_tenure_months !== $tenureMonths) {
                $order->installment_tenure_months = $tenureMonths;
                $order->save();
            }

            $order->installments()->delete();

            $baseAmountCents = $count > 0 ? intdiv($totalCents, $count) : 0;
            $remainder = $count > 0 ? $totalCents % $count : 0;
            $payload = [];

            for ($index = 0; $index < $count; $index++) {
                $amountCents = $baseAmountCents;

                if ($index < $remainder) {
                    $amountCents += 1;
                }

                $dueDate = $this->resolveDueDate($startDate, $frequency, $index, $graceDays);

                if ($amountCents < 0) {
                    $amountCents = 0;
                }

                $payload[] = [
                    'due_date' => $dueDate->toDateString(),
                    'amount' => number_format($amountCents / 100, 2, '.', ''),
                    'paid' => 0,
                    'status' => 'due',
                ];
            }

            $order->installments()->createMany($payload);

            $query = CustomerInstallment::query()
                ->where('sales_order_id', $order->id)
                ->orderBy('due_date');

            if (! empty($includes)) {
                $query->with($includes);
            }

            return $query->get();
        });

        return InstallmentResource::collection($installments)
            ->response()
            ->setStatusCode(201);
    }

    private function resolveDueDate(Carbon $startDate, string $frequency, int $index, int $graceDays): Carbon
    {
        $dueDate = $startDate->copy();

        if ($index > 0) {
            switch ($frequency) {
                case 'daily':
                    $dueDate->addDays($index);
                    break;
                case 'weekly':
                    $dueDate->addWeeks($index);
                    break;
                case 'biweekly':
                    $dueDate->addWeeks($index * 2);
                    break;
                case 'monthly':
                    $dueDate->addMonthsNoOverflow($index);
                    break;
                case 'quarterly':
                    $dueDate->addMonthsNoOverflow($index * 3);
                    break;
                case 'yearly':
                    $dueDate->addYears($index);
                    break;
            }
        }

        if ($graceDays > 0) {
            $dueDate->addDays($graceDays);
        }

        return $dueDate;
    }
}
