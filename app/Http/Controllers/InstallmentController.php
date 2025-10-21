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
        ]);

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
        $count = (int) $data['count'];
        $startDate = Carbon::parse($data['start_date']);
        $graceDays = (int) ($data['grace_days'] ?? 0);

        $installments = DB::transaction(function () use ($order, $includes, $principal, $frequency, $count, $startDate, $graceDays) {
            $order->installments()->delete();

            $perInstallment = round($principal / $count, 2);
            $allocated = 0.0;
            $payload = [];

            for ($index = 0; $index < $count; $index++) {
                $amount = $index === $count - 1
                    ? round($principal - $allocated, 2)
                    : $perInstallment;

                $allocated += $amount;

                $dueDate = $this->resolveDueDate($startDate, $frequency, $index, $graceDays);

                if ($amount < 0) {
                    $amount = 0.0;
                }

                $payload[] = [
                    'due_date' => $dueDate->toDateString(),
                    'amount' => $amount,
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
