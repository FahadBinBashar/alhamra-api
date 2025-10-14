<?php

namespace App\Http\Controllers\Customer;

use App\Http\Controllers\Controller;
use App\Models\CustomerInstallment;
use Illuminate\Http\Request;

class CustomerInstallmentController extends Controller
{
    public function index(Request $request)
    {
        $installments = CustomerInstallment::with([
            'salesOrder' => fn ($query) => $query->select('id', 'customer_id', 'total', 'down_payment'),
        ])
            ->whereHas('salesOrder', fn ($query) => $query->where('customer_id', $request->user()->id))
            ->orderBy('due_date')
            ->paginate((int) $request->query('per_page', 15));

        return response()->json($installments);
    }
}
