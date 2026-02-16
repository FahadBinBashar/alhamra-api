<?php

namespace Tests\Feature;

use App\Models\Employee;
use App\Models\EmployeeWallet;
use App\Models\User;
use App\Models\WalletWithdrawRequest;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class WalletWithdrawRequestTest extends TestCase
{
    use RefreshDatabase;

    public function test_admin_approval_deducts_employee_wallet_balance(): void
    {
        $employeeUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $employee = Employee::create([
            'user_id' => $employeeUser->id,
            'employee_code' => 'EMP-1001',
            'rank' => Employee::RANK_ME,
            'full_name_en' => 'Wallet Employee',
            'mobile' => '01710000000',
        ]);

        EmployeeWallet::create([
            'employee_id' => $employee->id,
            'balance' => 1000,
        ]);

        $request = WalletWithdrawRequest::create([
            'user_type' => WalletWithdrawRequest::USER_TYPE_EMPLOYEE,
            'user_id' => $employee->id,
            'wallet_type' => 'commission',
            'amount' => 250,
            'method' => WalletWithdrawRequest::METHOD_BKASH,
            'status' => WalletWithdrawRequest::STATUS_PENDING,
        ]);

        $admin = User::factory()->create(['role' => User::ROLE_ADMIN]);
        Sanctum::actingAs($admin);

        $this->postJson('/api/v1/admin/withdraw-requests/'.$request->id.'/approve')
            ->assertOk()
            ->assertJsonPath('data.status', WalletWithdrawRequest::STATUS_APPROVED);

        $this->assertDatabaseHas('employee_wallets', [
            'employee_id' => $employee->id,
            'balance' => '750.00',
        ]);

        $this->assertDatabaseHas('wallet_withdraw_requests', [
            'id' => $request->id,
            'status' => WalletWithdrawRequest::STATUS_APPROVED,
            'reviewed_by' => $admin->id,
        ]);
    }
}
