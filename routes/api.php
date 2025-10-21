<?php

use App\Http\Controllers\AgentController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BranchController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CommissionController;
use App\Http\Controllers\CommissionRuleController;
use App\Http\Controllers\CommissionSettingController;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\InstallmentController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\RankController;
use App\Http\Controllers\RankRequirementController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\SalesOrderController;
use App\Http\Controllers\StockMovementController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\Customer\CustomerAuthController;
use App\Http\Controllers\Customer\CustomerInstallmentController;
use App\Http\Controllers\Customer\CustomerPaymentController;
use App\Http\Controllers\Customer\CustomerProfileController;
use App\Http\Controllers\Customer\CustomerSalesOrderController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::prefix('v1')->group(function () {
  Route::post('/auth/login', [AuthController::class,'login']);
  Route::post('/auth/register', [AuthController::class,'register']);
  Route::prefix('customer')->group(function () {
    Route::post('auth/register', [CustomerAuthController::class,'register']);
    Route::post('auth/login', [CustomerAuthController::class,'login']);
    Route::post('payments/callback', [CustomerPaymentController::class,'callback'])->name('customer.payments.callback');

    Route::middleware(['auth:sanctum', 'role.customer'])->group(function () {
      Route::post('auth/logout', [CustomerAuthController::class,'logout']);
      Route::get('profile', [CustomerProfileController::class,'show']);
      Route::match(['put', 'patch'], 'profile', [CustomerProfileController::class,'update']);
      Route::get('sales-orders', [CustomerSalesOrderController::class,'index']);
      Route::get('sales-orders/{order}', [CustomerSalesOrderController::class,'show']);
      Route::get('payments', [CustomerPaymentController::class,'history']);
      Route::get('installments', [CustomerInstallmentController::class,'index']);
      Route::post('sales-orders/{order}/payments/initiate', [CustomerPaymentController::class,'initiate']);
    });
  });
  Route::middleware('auth:sanctum')->group(function () {
    Route::post('/auth/logout', [AuthController::class,'logout']);
    Route::apiResource('branches', BranchController::class);
    Route::apiResource('agents', AgentController::class);
    Route::get('employees/superiors', [EmployeeController::class,'superiors']);
    Route::apiResource('employees', EmployeeController::class);
    Route::apiResource('categories', CategoryController::class);
    Route::apiResource('products', ProductController::class);
    Route::apiResource('services', ServiceController::class);
    Route::apiResource('customers', CustomerController::class)->only(['index', 'store', 'show']);
    Route::apiResource('sales-orders', SalesOrderController::class);
    Route::apiResource('commission-rules', CommissionRuleController::class);
    Route::apiResource('commission-settings', CommissionSettingController::class);
    Route::apiResource('commissions', CommissionController::class);
    Route::apiResource('installments', InstallmentController::class);
    Route::apiResource('stock-movements', StockMovementController::class)->only(['index', 'store']);
    Route::apiResource('ranks', RankController::class);
    Route::post('sales-orders/{order}/installments/generate', [InstallmentController::class,'generate']);
    Route::post('sales-orders/{order}/payments', [PaymentController::class,'store']);
    Route::post('documents', [DocumentController::class,'store']);
    Route::apiResource('rank-requirements', RankRequirementController::class);
    Route::get('reports/receivables', [ReportController::class,'receivables']);
    Route::get('reports/payables', [ReportController::class,'payables']);
    Route::get('reports/commissions', [ReportController::class,'commissions']);
    Route::get('reports/rank-funds', [ReportController::class,'rankFunds']);
    Route::get('reports/agent-performance', [ReportController::class,'agentPerformance']);
    Route::get('reports/stock/current', [ReportController::class,'currentStock']);
    Route::get('reports/stock/low', [ReportController::class,'lowStock']);
    Route::get('reports/stock/movements', [ReportController::class,'stockMovements']);
    Route::get('dashboard', [ReportController::class,'dashboard']);
  });
});

