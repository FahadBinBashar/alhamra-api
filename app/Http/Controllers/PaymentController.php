<?php

namespace App\Http\Controllers;

use App\Models\CustomerInstallment;
use App\Models\Payment;
use App\Models\PaymentAllocation;
use App\Models\SalesOrder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PaymentController extends Controller
{
    public function store(Request $request, SalesOrder $order)
    {
        $data = $request->validate([
            'paid_at' => ['required', 'date'],
            'amount' => ['required', 'numeric', 'min:0.01'],
            'type' => ['required', 'in:down_payment,installment,full_payment'],
            'method' => ['nullable', 'string'],
            'meta' => ['nullable', 'array'],
            'allocations' => ['sometimes', 'array'],
            'allocations.*.installment_id' => ['required_with:allocations', 'integer', 'exists:customer_installments,id'],
            'allocations.*.amount' => ['required_with:allocations', 'numeric', 'min:0'],
        ]);

        $payment = DB::transaction(function () use ($order, $data) {
            $payment = Payment::create([
                'sales_order_id' => $order->id,
                'paid_at' => $data['paid_at'],
                'amount' => $data['amount'],
                'type' => $data['type'],
                'method' => $data['method'] ?? null,
                'meta' => $data['meta'] ?? null,
            ]);

            if (! empty($data['allocations'])) {
                foreach ($data['allocations'] as $allocation) {
                    /** @var CustomerInstallment $installment */
                    $installment = CustomerInstallment::lockForUpdate()->find($allocation['installment_id']);

                    if (! $installment) {
                        continue;
                    }

                    $allocated = (float) $allocation['amount'];
                    PaymentAllocation::create([
                        'payment_id' => $payment->id,
                        'customer_installment_id' => $installment->id,
                        'allocated' => $allocated,
                    ]);

                    $installment->paid += $allocated;
                    $installment->status = $installment->paid >= $installment->amount ? 'paid' : 'partial';
                    $installment->save();
                }
            }

            return $payment;
        });

        return response()->json([
            'data' => $payment->load('allocations'),
        ], 201);
    }
}
