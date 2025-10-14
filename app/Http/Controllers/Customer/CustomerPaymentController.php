<?php

namespace App\Http\Controllers\Customer;

use App\Http\Controllers\Controller;
use App\Models\CustomerInstallment;
use App\Models\Payment;
use App\Models\PaymentAllocation;
use App\Models\PaymentIntent;
use App\Models\SalesOrder;
use App\Services\Payments\SSLCommerzGateway;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;

class CustomerPaymentController extends Controller
{
    public function __construct(private SSLCommerzGateway $gateway)
    {
    }

    public function history(Request $request)
    {
        $payments = Payment::with([
            'salesOrder' => fn ($query) => $query->select('id', 'customer_id', 'total', 'down_payment'),
        ])
            ->whereHas('salesOrder', fn ($query) => $query->where('customer_id', $request->user()->id))
            ->orderByDesc('paid_at')
            ->orderByDesc('id')
            ->paginate((int) $request->query('per_page', 15));

        return response()->json($payments);
    }

    public function initiate(Request $request, SalesOrder $order)
    {
        if ($order->customer_id !== $request->user()->id) {
            abort(404);
        }

        $data = $request->validate([
            'type' => ['required', Rule::in(PaymentIntent::TYPES)],
            'amount' => ['sometimes', 'numeric', 'min:0.01'],
            'installment_id' => ['sometimes', 'integer', 'exists:customer_installments,id'],
        ]);

        [$amount, $meta, $installmentId] = $this->resolveAmountAndMeta($order, $data);

        $intent = PaymentIntent::create([
            'sales_order_id' => $order->id,
            'customer_id' => $request->user()->id,
            'customer_installment_id' => $installmentId,
            'amount' => $amount,
            'currency' => config('services.sslcommerz.currency', 'BDT'),
            'type' => $data['type'],
            'status' => PaymentIntent::STATUS_PENDING,
            'gateway' => 'sslcommerz',
            'meta' => array_merge($meta, [
                'initiated_by' => 'customer',
                'requested_amount' => $data['amount'] ?? null,
                'callback_url' => route('customer.payments.callback'),
            ]),
        ]);

        $gateway = $this->gateway->initiate($intent);

        return response()->json([
            'data' => [
                'intent' => $intent->fresh(),
                'gateway' => $gateway,
            ],
        ], 201);
    }

    public function callback(Request $request)
    {
        $data = $request->validate([
            'tran_id' => ['required', 'string'],
            'status' => ['required', 'string'],
            'amount' => ['sometimes', 'numeric', 'min:0'],
            'currency' => ['sometimes', 'string'],
            'card_type' => ['sometimes', 'string'],
            'val_id' => ['sometimes', 'string'],
        ]);

        $intent = PaymentIntent::where('gateway_transaction_id', $data['tran_id'])->first();

        if (! $intent) {
            return response()->json([
                'message' => 'Payment intent not found.',
            ], 404);
        }

        if ($intent->status === PaymentIntent::STATUS_PAID) {
            return response()->json([
                'message' => 'Payment already processed.',
                'intent' => $intent,
            ]);
        }

        $normalizedStatus = strtolower($data['status']);
        $successfulStatuses = ['valid', 'success', 'successful', 'completed'];

        $meta = array_merge($intent->meta ?? [], [
            'callback' => $data,
        ]);

        if (! in_array($normalizedStatus, $successfulStatuses, true)) {
            $intent->status = PaymentIntent::STATUS_FAILED;
            $intent->meta = $meta;
            $intent->save();

            return response()->json([
                'message' => 'Payment marked as failed.',
                'intent' => $intent,
            ]);
        }

        DB::transaction(function () use ($intent, $data, $meta) {
            $intent->status = PaymentIntent::STATUS_PAID;
            $intent->paid_at = now();
            $intent->meta = $meta;
            $intent->save();

            $amount = $data['amount'] ?? (float) $intent->amount;
            if ($amount <= 0) {
                $amount = (float) $intent->amount;
            }

            $order = $intent->salesOrder()->lockForUpdate()->first();
            if (! $order) {
                return;
            }

            $payment = Payment::create([
                'sales_order_id' => $order->id,
                'paid_at' => now(),
                'amount' => $amount,
                'type' => Payment::resolveTypeFromIntent($intent->type),
                'intent_type' => $intent->type,
                'method' => 'sslcommerz',
                'meta' => [
                    'payment_intent_id' => $intent->id,
                    'gateway_transaction_id' => $intent->gateway_transaction_id,
                    'gateway_response' => $data,
                ],
            ]);

            if ($intent->customer_installment_id) {
                /** @var CustomerInstallment|null $installment */
                $installment = CustomerInstallment::lockForUpdate()->find($intent->customer_installment_id);

                if ($installment) {
                    $outstanding = max((float) $installment->amount - (float) $installment->paid, 0.0);
                    $allocated = min($amount, $outstanding);

                    PaymentAllocation::create([
                        'payment_id' => $payment->id,
                        'customer_installment_id' => $installment->id,
                        'allocated' => $allocated,
                    ]);

                    $installment->paid += $allocated;
                    if ($installment->paid >= $installment->amount) {
                        $installment->status = 'paid';
                    } elseif ($installment->paid > 0) {
                        $installment->status = 'partial';
                    }

                    $installment->save();
                }
            }
        });

        return response()->json([
            'message' => 'Payment recorded successfully.',
            'intent' => $intent->fresh(),
        ]);
    }

    protected function resolveAmountAndMeta(SalesOrder $order, array $data): array
    {
        $order->loadMissing(['payments', 'installments']);

        $type = $data['type'];
        $amount = $data['amount'] ?? null;
        $meta = [
            'order_reference' => 'SO-' . $order->id,
            'intent_type' => $type,
        ];
        $installmentId = null;

        $payments = $order->payments ?? collect();
        $intentResolver = fn (Payment $payment) => $payment->intent_type ?? $payment->type;

        if ($type === PaymentIntent::TYPE_INSTALLMENT) {
            $installmentId = $data['installment_id'] ?? null;
            if (! $installmentId) {
                throw ValidationException::withMessages([
                    'installment_id' => 'An installment must be selected for installment payments.',
                ]);
            }

            $installment = $order->installments->firstWhere('id', (int) $installmentId);
            if (! $installment) {
                throw ValidationException::withMessages([
                    'installment_id' => 'The selected installment does not belong to this order.',
                ]);
            }

            $due = max((float) $installment->amount - (float) $installment->paid, 0.0);
            if ($due <= 0) {
                throw ValidationException::withMessages([
                    'installment_id' => 'This installment is already paid.',
                ]);
            }

            $meta['installment_id'] = $installment->id;
            $meta['due_amount'] = $due;

            if ($amount === null) {
                $amount = $due;
            } elseif ($amount > $due) {
                throw ValidationException::withMessages([
                    'amount' => 'The requested amount exceeds the installment due.',
                ]);
            }
        } elseif ($type === PaymentIntent::TYPE_DOWN_PAYMENT) {
            $downPaid = $payments->filter(fn ($payment) => $intentResolver($payment) === Payment::INTENT_DOWN_PAYMENT || $payment->type === Payment::TYPE_DOWN_PAYMENT)->sum('amount');
            $due = max((float) $order->down_payment - (float) $downPaid, 0.0);

            if ($due <= 0) {
                throw ValidationException::withMessages([
                    'type' => 'Down payment has already been settled for this order.',
                ]);
            }

            $meta['due_amount'] = $due;

            if ($amount === null) {
                $amount = $due;
            } elseif ($amount > $due) {
                throw ValidationException::withMessages([
                    'amount' => 'The requested amount exceeds the remaining down payment.',
                ]);
            }
        } elseif ($type === PaymentIntent::TYPE_DUE) {
            $totalPaid = $payments->sum('amount');
            $due = max((float) $order->total - (float) $totalPaid, 0.0);

            if ($due <= 0) {
                throw ValidationException::withMessages([
                    'type' => 'There is no outstanding balance for this order.',
                ]);
            }

            $meta['due_amount'] = $due;

            if ($amount === null) {
                $amount = $due;
            } elseif ($amount > $due) {
                throw ValidationException::withMessages([
                    'amount' => 'The requested amount exceeds the outstanding balance.',
                ]);
            }
        } else {
            if ($amount === null) {
                throw ValidationException::withMessages([
                    'amount' => 'An amount is required for booking payments.',
                ]);
            }
        }

        if ($amount === null || $amount <= 0) {
            throw ValidationException::withMessages([
                'amount' => 'A valid payment amount is required.',
            ]);
        }

        $meta['amount'] = $amount;

        return [$amount, $meta, $installmentId];
    }
}
