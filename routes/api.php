<?php

use App\Http\Controllers\AdminReportController;
use App\Http\Controllers\AdminWorkSummaryController;
use App\Http\Controllers\AccountingReportController;
use App\Http\Controllers\AgentController;
use App\Http\Controllers\AgentDashboardController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BranchController;
use App\Http\Controllers\ChartOfAccountsController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CommissionCalculationController;
use App\Http\Controllers\CommissionController;
use App\Http\Controllers\CommissionRuleController;
use App\Http\Controllers\CommissionSettingController;
use App\Http\Controllers\MonthlyIncentiveController;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\EmployeeRecruitRequestController;
use App\Http\Controllers\EmployeeDashboardController;
use App\Http\Controllers\EmployeeEarningController;
use App\Http\Controllers\EmployeeTreeController;
use App\Http\Controllers\ServiceCommissionController;
use App\Http\Controllers\InstallmentController;
use App\Http\Controllers\JournalController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\RankController;
use App\Http\Controllers\RankRequirementController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\PdSpecialBonusController;
use App\Http\Controllers\SupplierController;
use App\Http\Controllers\SupplierPayableController;
use App\Http\Controllers\SalesOrderController;
use App\Http\Controllers\StockMovementController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\WalletWithdrawRequestController;
use App\Http\Controllers\AdminWalletWithdrawRequestController;
use App\Http\Controllers\Customer\CustomerAuthController;
use App\Http\Controllers\Customer\CustomerInstallmentController;
use App\Http\Controllers\Customer\CustomerPaymentController;
use App\Http\Controllers\Customer\CustomerProfileController;
use App\Http\Controllers\Customer\CustomerSalesOrderController;
use App\Http\Controllers\DirectorFundController;
use App\Http\Controllers\WorkSummaryController;
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
  Route::apiResource('categories', CategoryController::class);
  Route::apiResource('products', ProductController::class);
  Route::middleware('auth:sanctum')->group(function () {
    Route::post('/auth/logout', [AuthController::class,'logout']);
    Route::post('/change-password', [AuthController::class, 'changePassword']);
    Route::apiResource('branches', BranchController::class);
    Route::apiResource('agents', AgentController::class);
    Route::prefix('agents/dashboard')->group(function () {
      Route::get('commissions', [AgentDashboardController::class, 'commissions']);
      Route::get('wallet', [AgentDashboardController::class, 'wallet']);
      Route::get('wallet/withdrawals', [WalletWithdrawRequestController::class, 'history']);
      Route::get('sales', [AgentDashboardController::class, 'salesSummary']);
      Route::get('sales/detail', [AgentDashboardController::class, 'salesDetail']);
    });
    Route::get('employees/superiors', [EmployeeController::class,'superiors']);
    Route::get('employees/tree', [EmployeeTreeController::class, 'tree']);
    Route::get('employees/tree/node/{employee}', [EmployeeTreeController::class, 'nodeDetails']);
    Route::apiResource('employees', EmployeeController::class);
    Route::prefix('employees/dashboard')->group(function () {
      Route::get('customers', [EmployeeDashboardController::class, 'customers']);
      Route::get('sales', [EmployeeDashboardController::class, 'sales']);
      Route::get('commissions', [EmployeeDashboardController::class, 'commissions']);
      Route::get('service-commissions', [EmployeeDashboardController::class, 'serviceCommissions']);
      Route::get('wallet', [EmployeeDashboardController::class, 'wallet']);
      Route::get('wallet/withdrawals', [WalletWithdrawRequestController::class, 'history']);
      Route::get('activities', [EmployeeDashboardController::class, 'activities']);
      Route::post('activities', [EmployeeDashboardController::class, 'storeActivity']);
      Route::match(['put', 'patch'], 'activities/{activity}', [EmployeeDashboardController::class, 'updateActivity']);
      Route::delete('activities/{activity}', [EmployeeDashboardController::class, 'destroyActivity']);
    });
    Route::get('work-summaries', [WorkSummaryController::class, 'index']);
    Route::post('work-summaries', [WorkSummaryController::class, 'store']);
    Route::get('admin/work-summaries', [AdminWorkSummaryController::class, 'index']);
    Route::get('employee/incentives', [EmployeeEarningController::class, 'incentives']);
    Route::get('employee/director-funds', [EmployeeEarningController::class, 'directorFunds']);
    Route::apiResource('suppliers', SupplierController::class);
    Route::apiResource('accounting/accounts', ChartOfAccountsController::class)->except(['show']);
    Route::apiResource('accounting/journals', JournalController::class)->only(['index', 'store']);
    Route::get('supplier-payables', [SupplierPayableController::class, 'index']);
    Route::post('supplier-payables/process', [SupplierPayableController::class, 'process']);
    Route::apiResource('services', ServiceController::class);
    Route::apiResource('customers', CustomerController::class)->only(['index', 'store', 'show']);
    Route::apiResource('sales-orders', SalesOrderController::class);
    Route::apiResource('commission-rules', CommissionRuleController::class);
    Route::apiResource('commission-settings', CommissionSettingController::class);
    Route::apiResource('commissions', CommissionController::class);
    Route::get('commission-calculations', [CommissionCalculationController::class, 'index']);
    Route::get('commission-calculations/{commissionCalculation}', [CommissionCalculationController::class, 'show']);
    Route::post('commission-calculations/process', [CommissionCalculationController::class, 'process']);
    Route::get('commission-calculations/process-history', [CommissionCalculationController::class, 'processHistory']);
    Route::get('director-funds', [DirectorFundController::class, 'index']);
    Route::post('director-funds/calculate', [DirectorFundController::class, 'calculate']);
    Route::post('director-funds/process', [DirectorFundController::class, 'process']);
    Route::post('monthly-incentives/generate', [MonthlyIncentiveController::class, 'generate']);
    Route::post('monthly-incentives/process', [MonthlyIncentiveController::class, 'process']);
    Route::get('monthly-incentives', [MonthlyIncentiveController::class, 'index']);
    Route::post('monthly-incentives/{monthlyIncentive}/approve', [MonthlyIncentiveController::class, 'approve']);
    Route::post('monthly-incentives/{monthlyIncentive}/reject', [MonthlyIncentiveController::class, 'reject']);
    Route::post('pd-special/select', [PdSpecialBonusController::class, 'select']);
    Route::post('pd-special/calculate', [PdSpecialBonusController::class, 'calculate']);
    Route::post('pd-special/process', [PdSpecialBonusController::class, 'process']);
    Route::get('pd-special-bonus', [PdSpecialBonusController::class, 'monthBonuses']);
    Route::get('employee/pd-special-bonus', [PdSpecialBonusController::class, 'employeeBonus']);
    Route::get('service-commissions/pending', [ServiceCommissionController::class, 'pending']);
    Route::post('service-commissions/process', [ServiceCommissionController::class, 'process']);
    Route::apiResource('installments', InstallmentController::class);
    Route::apiResource('stock-movements', StockMovementController::class)->only(['index', 'store']);
    Route::apiResource('ranks', RankController::class);
    Route::post('sales-orders/{order}/installments/generate', [InstallmentController::class,'generate']);
    Route::get('payments', [PaymentController::class,'index']);
    Route::post('sales-orders/{order}/payments', [PaymentController::class,'store']);
    Route::post('documents', [DocumentController::class,'store']);
    Route::apiResource('rank-requirements', RankRequirementController::class);
    Route::get('reports/receivables', [ReportController::class,'receivables']);
    Route::get('reports/payables', [ReportController::class,'payables']);
    Route::get('reports/supplier-payables', [ReportController::class,'supplierPayables']);
    Route::get('reports/commissions', [ReportController::class,'commissions']);
    Route::get('reports/rank-funds', [ReportController::class,'rankFunds']);
    Route::get('reports/agent-performance', [ReportController::class,'agentPerformance']);
    Route::get('reports/stock/current', [ReportController::class,'currentStock']);
    Route::get('reports/stock/low', [ReportController::class,'lowStock']);
    Route::get('reports/stock/movements', [ReportController::class,'stockMovements']);
    Route::get('reports/sales-commissions/summary', [ReportController::class,'salesCommissionSummary']);
    Route::get('reports/sales-commissions/detail', [ReportController::class,'salesCommissionDetail']);
    Route::get('reports/commissions/detail', [AdminReportController::class,'commissionReport']);
    Route::get('reports/sales/detail', [AdminReportController::class,'salesReport']);
    Route::get('reports/stock/detail', [AdminReportController::class,'stockReport']);
    Route::get('reports/employee-performance', [AdminReportController::class,'employeePerformance']);
    Route::get('reports/incomes', [AdminReportController::class,'incomeReport']);
    Route::get('reports/ledger/customer', [AdminReportController::class,'customerLedger']);
    Route::get('reports/ledger/supplier', [AdminReportController::class,'supplierLedger']);
    Route::get('reports/ledger/account', [AdminReportController::class,'accountStatement']);
    Route::prefix('accounting')->group(function () {
      Route::get('trial-balance', [AccountingReportController::class, 'trialBalance']);
      Route::get('profit-loss', [AccountingReportController::class, 'profitAndLoss']);
      Route::get('balance-sheet', [AccountingReportController::class, 'balanceSheet']);
      Route::get('ledger', [AccountingReportController::class, 'ledger']);
    });
    Route::post('wallet/withdraw-request', [WalletWithdrawRequestController::class, 'store']);
    Route::get('wallet/withdraw-requests', [WalletWithdrawRequestController::class, 'history']);
    Route::get('admin/withdraw-requests', [AdminWalletWithdrawRequestController::class, 'index']);
    Route::post('admin/withdraw-requests/{withdrawRequest}/approve', [AdminWalletWithdrawRequestController::class, 'approve']);
    Route::post('admin/withdraw-requests/{withdrawRequest}/reject', [AdminWalletWithdrawRequestController::class, 'reject']);
    Route::get('employee-recruit-requests', [EmployeeRecruitRequestController::class, 'index']);
    Route::post('employee-recruit-requests', [EmployeeRecruitRequestController::class, 'store']);
    Route::post('employee-recruit-requests/{recruitRequest}/approve', [EmployeeRecruitRequestController::class, 'approve']);
    Route::post('employee-recruit-requests/{recruitRequest}/reject', [EmployeeRecruitRequestController::class, 'reject']);
    Route::get('dashboard', [ReportController::class,'dashboard']);
  });
});
