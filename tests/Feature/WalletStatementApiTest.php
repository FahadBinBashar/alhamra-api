<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\AgentWallet;
use App\Models\Commission;
use App\Models\Employee;
use App\Models\EmployeeWallet;
use App\Models\EmployeeWalletTransaction;
use App\Models\MonthlyIncentive;
use App\Models\User;
use App\Models\WalletWithdrawRequest;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class WalletStatementApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_agent_wallet_statement_contains_credit_debit_and_closing_balance(): void
    {
        $user = User::factory()->create(['role' => User::ROLE_AGENT]);
        $agent = Agent::create([
            'user_id' => $user->id,
            'agent_code' => 'AGT-STAT-1',
        ]);

        AgentWallet::create([
            'agent_id' => $agent->id,
            'balance' => 850,
        ]);

        Commission::create([
            'recipient_type' => Agent::class,
            'recipient_id' => $agent->id,
            'amount' => 1000,
            'status' => 'paid',
            'paid_at' => now()->subDays(2),
        ]);

        WalletWithdrawRequest::create([
            'user_type' => WalletWithdrawRequest::USER_TYPE_AGENT,
            'user_id' => $agent->id,
            'wallet_type' => 'commission',
            'amount' => 150,
            'method' => 'bank',
            'status' => WalletWithdrawRequest::STATUS_APPROVED,
            'reviewed_at' => now()->subDay(),
        ]);

        Sanctum::actingAs($user);

        $response = $this->getJson('/api/v1/agents/dashboard/wallet/statement');

        $response
            ->assertOk()
            ->assertJsonPath('data.total_credit', 1000)
            ->assertJsonPath('data.total_debit', 150)
            ->assertJsonPath('data.closing_balance', 850)
            ->assertJsonCount(2, 'data.transactions');
    }

    public function test_employee_wallet_statement_aggregates_supported_wallet_credits_and_debits(): void
    {
        $user = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $employee = Employee::create([
            'user_id' => $user->id,
            'rank' => Employee::RANK_ME,
        ]);

        $wallet = EmployeeWallet::create([
            'employee_id' => $employee->id,
            'balance' => 900,
        ]);

        Commission::create([
            'recipient_type' => Employee::class,
            'recipient_id' => $employee->id,
            'amount' => 500,
            'status' => 'paid',
            'paid_at' => now()->subDays(4),
        ]);

        MonthlyIncentive::create([
            'employee_id' => $employee->id,
            'period_start' => now()->subMonth()->startOfMonth()->toDateString(),
            'period_end' => now()->subMonth()->endOfMonth()->toDateString(),
            'total_commissionable_sales' => 10000,
            'incentive_rate' => 1,
            'amount' => 200,
            'status' => MonthlyIncentive::STATUS_PAID,
            'processed_at' => now()->subDays(3),
        ]);

        EmployeeWalletTransaction::create([
            'employee_wallet_id' => $wallet->id,
            'employee_id' => $employee->id,
            'type' => EmployeeWalletTransaction::TYPE_PROMOTION_REWARD,
            'amount' => 300,
            'narration' => 'Promotion reward',
            'created_at' => now()->subDays(2),
            'updated_at' => now()->subDays(2),
        ]);

        WalletWithdrawRequest::create([
            'user_type' => WalletWithdrawRequest::USER_TYPE_EMPLOYEE,
            'user_id' => $employee->id,
            'wallet_type' => 'commission',
            'amount' => 100,
            'method' => 'bkash',
            'status' => WalletWithdrawRequest::STATUS_APPROVED,
            'reviewed_at' => now()->subDay(),
        ]);

        Sanctum::actingAs($user);

        $response = $this->getJson('/api/v1/employees/dashboard/wallet/statement');

        $response
            ->assertOk()
            ->assertJsonPath('data.total_credit', 1000)
            ->assertJsonPath('data.total_debit', 100)
            ->assertJsonPath('data.closing_balance', 900)
            ->assertJsonCount(4, 'data.transactions');
    }
}
