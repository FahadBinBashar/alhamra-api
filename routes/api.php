<?php

use App\Http\Controllers\AgentController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BranchController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\InstallmentController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\SalesOrderController;
use App\Http\Controllers\ServiceController;
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
  Route::middleware('auth:sanctum')->group(function () {
    Route::post('/auth/logout', [AuthController::class,'logout']);
    Route::apiResource('branches', BranchController::class);
    Route::apiResource('agents', AgentController::class);
    Route::apiResource('categories', CategoryController::class);
    Route::apiResource('products', ProductController::class);
    Route::apiResource('services', ServiceController::class);
    Route::apiResource('sales-orders', SalesOrderController::class);
    Route::post('sales-orders/{order}/installments/generate', [InstallmentController::class,'generate']);
    Route::post('sales-orders/{order}/payments', [PaymentController::class,'store']);
    Route::post('documents', [DocumentController::class,'store']);
    Route::get('reports/receivables', [ReportController::class,'receivables']);
    Route::get('reports/payables', [ReportController::class,'payables']);
    Route::get('reports/commissions', [ReportController::class,'commissions']);
    Route::get('reports/rank-funds', [ReportController::class,'rankFunds']);
    Route::get('reports/agent-performance', [ReportController::class,'agentPerformance']);
    Route::get('dashboard', [ReportController::class,'dashboard']);
  });
});

