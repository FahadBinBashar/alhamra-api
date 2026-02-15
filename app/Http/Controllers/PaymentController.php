<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\ResolvesIncludes;
use App\Http\Resources\PaymentResource;
use App\Models\CustomerInstallment;
use App\Models\Payment;
use App\Models\PaymentAllocation;
use App\Models\SalesOrder;
use App\Services\EmiExtraService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;

class PaymentController extends Controller
{
    use ResolvesIncludes;

    public function index(Request $request)
    {
        $allowedIncludes = [
            'salesOrder',
            'salesOrder.customer',
            'salesOrder.agent',
            'salesOrder.agent.user',
            'salesOrder.branch',
            'allocations',
            'allocations.installment',
        ];

        $includes = $this->resolveIncludes($request, $allowedIncludes);

        if (empty($includes)) {
            $includes = [
                'salesOrder.customer',
                'salesOrder.agent.user',
                'salesOrder.branch',
            ];
        }

        $query = Payment::query()->with($includes);

        if ($request->filled('type')) {
            $types = array_filter(explode(',', (string) $request->query('type')));
            $query->whereIn('type', $types);
        }

        if ($request->filled('intent_type')) {
            $intents = array_filter(explode(',', (string) $request->query('intent_type')));
            $query->whereIn('intent_type', $intents);
        }

        if ($request->filled('method')) {
            $methods = array_filter(explode(',', (string) $request->query('method')));
            $query->whereIn('method', $methods);
        }

        if ($request->filled('from')) {
            $query->whereDate('paid_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('paid_at', '<=', $request->date('to'));
        }

        if ($request->filled('customer_id')) {
            $query->whereHas('salesOrder', fn ($q) => $q->where('customer_id', $request->integer('customer_id')));
        }

        if ($request->filled('agent_id')) {
            $query->whereHas('salesOrder', fn ($q) => $q->where('agent_id', $request->integer('agent_id')));
        }

        if ($request->filled('branch_id')) {
            $query->whereHas('salesOrder', fn ($q) => $q->where('branch_id', $request->integer('branch_id')));
        }

        if ($request->filled('sales_type')) {
            $salesTypes = array_filter(explode(',', (string) $request->query('sales_type')));
            $query->whereHas('salesOrder', fn ($q) => $q->whereIn('sales_type', $salesTypes));
        }

        if ($request->filled('status')) {
            $statuses = array_filter(explode(',', (string) $request->query('status')));
            $query->whereHas('salesOrder', fn ($q) => $q->whereIn('status', $statuses));
        }

        if ($request->filled('search')) {
            $search = trim((string) $request->query('search'));
            $query->where(function ($builder) use ($search) {
                $builder
                    ->where('id', (int) $search)
                    ->orWhere('sales_order_id', (int) $search)
                    ->orWhereHas('salesOrder.customer', fn ($q) => $q->where('name', 'like', '%' . $search . '%'))
                    ->orWhereHas('salesOrder.agent.user', fn ($q) => $q->where('name', 'like', '%' . $search . '%'))
                    ->orWhereHas('salesOrder.branch', fn ($q) => $q->where('name', 'like', '%' . $search . '%'));
            });
        }

        $orderedQuery = (clone $query)->orderByDesc('paid_at')->orderByDesc('id');

        if (strtolower((string) $request->query('export')) === 'excel') {
            $payments = $orderedQuery->get();

            return $this->exportPayments($payments);
        }

        if ($request->boolean('print') || strtolower((string) $request->query('format')) === 'print') {
            $payments = $orderedQuery->get();

            return response()->json([
                'data' => PaymentResource::collection($payments)->resolve(),
                'summary' => $this->summarizePayments($payments),
            ]);
        }

        $summary = $this->summarizePayments((clone $query)->get());

        $perPage = max(1, (int) $request->query('per_page', 15));
        $payments = $orderedQuery
            ->paginate($perPage)
            ->appends($request->query());

        return PaymentResource::collection($payments)
            ->additional(['summary' => $summary]);
    }

    public function store(Request $request, SalesOrder $order)
    {
        $data = $request->validate([
            'paid_at' => ['required', 'date'],
            'amount' => ['required', 'numeric', 'min:0.01'],
            'type' => ['sometimes', Rule::in(Payment::BASE_TYPES)],
            'intent_type' => ['sometimes', 'string', Rule::in(Payment::INTENT_TYPES)],
            'method' => ['nullable', 'string'],
            'meta' => ['nullable', 'array'],
            'allocations' => ['sometimes', 'array'],
            'allocations.*.installment_id' => ['required_with:allocations', 'integer', 'exists:customer_installments,id'],
            'allocations.*.amount' => ['required_with:allocations', 'numeric', 'min:0'],
        ]);

        $payment = DB::transaction(function () use ($order, $data) {
            if ($order->sales_type === SalesOrder::TYPE_SERVICE) {
                $requestedType = $data['type'] ?? null;

                $allowedServiceTypes = [
                    Payment::TYPE_FULL_PAYMENT,
                    Payment::TYPE_PARTIAL_PAYMENT,
                ];

                if ($requestedType && ! in_array($requestedType, $allowedServiceTypes, true)) {
                    throw ValidationException::withMessages([
                        'type' => ['Only full_payment or partial_payment are allowed for service payments.'],
                    ]);
                }
            }

            $type = $data['type']
                ?? ($data['intent_type'] ?? null
                    ? Payment::resolveTypeFromIntent($data['intent_type'])
                    : Payment::TYPE_FULL_PAYMENT);

            $intentType = $data['intent_type'] ?? Payment::resolveIntentFromType($type);

            $meta = $data['meta'] ?? [];
            $baseAmount = (float) $data['amount'];
            $emiExtraAmount = 0.0;
            $emiBreakdown = [];

            if (! empty($data['allocations'])) {
                $emiService = app(EmiExtraService::class);
                $baseAmount = 0.0;

                foreach ($data['allocations'] as $allocation) {
                    /** @var CustomerInstallment $installment */
                    $installment = CustomerInstallment::lockForUpdate()->find($allocation['installment_id']);

                    if (! $installment) {
                        continue;
                    }

                    $dueAmount = round((float) $installment->amount - (float) $installment->paid, 2);

                    if ($dueAmount <= 0) {
                        throw ValidationException::withMessages([
                            'allocations' => ['The selected installment is already paid.'],
                        ]);
                    }

                    $requestedAmount = round((float) $allocation['amount'], 2);

                    if ($requestedAmount !== $dueAmount) {
                        throw ValidationException::withMessages([
                            'allocations' => ['Installment payments must cover the full base amount due.'],
                        ]);
                    }

                    $emiExtra = $emiService->calculateExtra($installment, $dueAmount);
                    $installmentNo = $emiService->resolveInstallmentIndex($installment);

                    $emiBreakdown[] = [
                        'installment_id' => $installment->id,
                        'installment_no' => $installmentNo,
                        'base_amount' => $dueAmount,
                        'emi_extra_amount' => $emiExtra,
                    ];

                    $baseAmount += $dueAmount;
                    $emiExtraAmount += $emiExtra;
                }

                $expectedTotal = round($baseAmount + $emiExtraAmount, 2);
                $requestedTotal = round((float) $data['amount'], 2);

                if ($expectedTotal !== $requestedTotal) {
                    throw ValidationException::withMessages([
                        'amount' => ['The payment amount must match the installment total due.'],
                    ]);
                }

                $meta = array_merge($meta, [
                    'base_amount' => $baseAmount,
                    'emi_extra_amount' => $emiExtraAmount,
                    'emi_breakdown' => $emiBreakdown,
                ]);
            }

            $payment = Payment::create([
                'sales_order_id' => $order->id,
                'paid_at' => $data['paid_at'],
                'amount' => round($baseAmount + $emiExtraAmount, 2),
                'base_amount' => round($baseAmount, 2),
                'emi_extra_amount' => round($emiExtraAmount, 2),
                'type' => $type,
                'intent_type' => $intentType,
                'method' => $data['method'] ?? null,
                'meta' => $meta ?: null,
            ]);

            if (! empty($data['allocations'])) {
                foreach ($data['allocations'] as $allocation) {
                    /** @var CustomerInstallment $installment */
                    $installment = CustomerInstallment::lockForUpdate()->find($allocation['installment_id']);

                    if (! $installment) {
                        continue;
                    }

                    $allocated = round((float) $allocation['amount'], 2);
                    PaymentAllocation::create([
                        'payment_id' => $payment->id,
                        'customer_installment_id' => $installment->id,
                        'allocated' => $allocated,
                    ]);

                    $installment->paid = round(((float) $installment->paid) + $allocated, 2);

                    $dueAmount = round((float) $installment->amount, 2);
                    $installment->status = $installment->paid >= $dueAmount ? 'paid' : 'partial';
                    $installment->save();
                }
            }

            return $payment;
        });

        return response()->json([
            'data' => $payment->load('allocations'),
        ], 201);
    }

    protected function exportPayments($payments)
    {
        $columns = [
            'Payment ID',
            'Sales Order',
            'Customer',
            'Agent',
            'Branch',
            'Amount',
            'Type',
            'Intent',
            'Method',
            'Paid At',
            'Created At',
        ];

        $summary = $this->summarizePayments($payments);
        $filename = 'payments_report_' . now()->format('Ymd_His') . '.csv';

        return response()->streamDownload(function () use ($payments, $columns, $summary) {
            $handle = fopen('php://output', 'w');

            fputcsv($handle, $columns);

            foreach ($payments as $payment) {
                $salesOrder = $payment->salesOrder;
                $customer = $salesOrder?->customer;
                $agent = $salesOrder?->agent?->user;
                $branch = $salesOrder?->branch;

                fputcsv($handle, [
                    $payment->id,
                    $payment->sales_order_id,
                    $customer?->name ?? '',
                    $agent?->name ?? '',
                    $branch?->name ?? '',
                    (float) $payment->amount,
                    $payment->type,
                    $payment->intent_type,
                    $payment->method,
                    optional($payment->paid_at)->toDateString(),
                    optional($payment->created_at)->toDateTimeString(),
                ]);
            }

            fputcsv($handle, []);
            fputcsv($handle, ['Total Amount', $summary['total_amount']]);
            fputcsv($handle, ['Payment Count', $summary['count']]);

            fclose($handle);
        }, $filename, [
            'Content-Type' => 'text/csv',
        ]);
    }

    protected function summarizePayments($payments): array
    {
        $totalAmount = $payments->sum(fn ($payment) => (float) $payment->amount);

        return [
            'total_amount' => round($totalAmount, 2),
            'count' => $payments->count(),
        ];
    }
}
