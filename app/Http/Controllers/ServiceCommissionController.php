<?php

namespace App\Http\Controllers;

use App\Services\ServiceCommissionService;
use Carbon\Carbon;
use Illuminate\Http\Request;

class ServiceCommissionController extends Controller
{
    public function __construct(private ServiceCommissionService $serviceCommissionService)
    {
    }

    public function process(Request $request)
    {
        $monthParam = $request->query('month');
        $month = $monthParam ? Carbon::createFromFormat('Y-m', $monthParam) : now();

        $summary = $this->serviceCommissionService->processUnpaidForMonth($month);

        return response()->json($summary);
    }
}
