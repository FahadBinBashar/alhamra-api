<?php

namespace App\Http\Controllers\Customer;

use App\Http\Controllers\Controller;
use App\Models\SalesOrder;
use Illuminate\Http\Request;

class CustomerSalesOrderController extends Controller
{
    public function index(Request $request)
    {
        $orders = SalesOrder::with([
            'items.itemable',
            'installments',
            'payments',
        ])
            ->where('customer_id', $request->user()->id)
            ->orderByDesc('id')
            ->paginate((int) $request->query('per_page', 15));

        return response()->json($orders);
    }

    public function show(Request $request, SalesOrder $order)
    {
        if ($order->customer_id !== $request->user()->id) {
            abort(404);
        }

        return response()->json([
            'data' => $order->load([
                'items.itemable',
                'installments',
                'payments',
            ]),
        ]);
    }
}
