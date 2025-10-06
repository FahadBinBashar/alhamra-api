<?php

use Illuminate\Http\Request;
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
    Route::get('reports/receivables', [ReportController::class,'receivables']);
  });
});

