<?php

namespace App\Http\Controllers;

use App\Models\SalesOrder;
use Illuminate\Http\JsonResponse;

class PublicInvoiceController extends Controller
{
    public function show(SalesOrder $salesOrder): JsonResponse
    {
        $salesOrder->load([
            'items.itemable',
            'customer',
            'agent.user',
            'branch',
        ]);

        return response()->json([
            'data' => [
                'id' => $salesOrder->id,
                'order_no' => 'SO-' . $salesOrder->id,
                'sales_type' => $salesOrder->sales_type,
                'status' => $salesOrder->status,
                'total' => $salesOrder->total,
                'down_payment' => $salesOrder->down_payment,
                'customer' => [
                    'id' => $salesOrder->customer?->id,
                    'name' => $salesOrder->customer?->name,
                    'email' => $salesOrder->customer?->email,
                    'contact_number' => $salesOrder->customer?->contact_number,
                ],
                'agent' => [
                    'id' => $salesOrder->agent?->id,
                    'agent_code' => $salesOrder->agent?->agent_code,
                    'name' => $salesOrder->agent?->user?->name,
                ],
                'branch' => [
                    'id' => $salesOrder->branch?->id,
                    'name' => $salesOrder->branch?->name,
                    'code' => $salesOrder->branch?->code,
                ],
                'items' => $salesOrder->items->map(function ($item) {
                    return [
                        'id' => $item->id,
                        'type' => class_basename($item->itemable_type),
                        'name' => $item->itemable?->name,
                        'qty' => $item->qty,
                        'unit_price' => $item->unit_price,
                        'line_total' => $item->line_total,
                    ];
                })->values(),
                'created_at' => $salesOrder->created_at,
            ],
        ]);
    }
}

