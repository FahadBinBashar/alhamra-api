<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\Branch;
use App\Models\CommissionRule;
use App\Models\Employee;
use App\Models\Payment;
use App\Models\SalesOrder;
use App\Models\User;
use App\Services\CommissionService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Str;
use Tests\TestCase;

class CommissionServiceTest extends TestCase
{
    use RefreshDatabase;

    public function test_rank_scoped_commission_rules_are_applied(): void
    {
        $branch = Branch::create([
            'name' => 'Dhaka',
            'code' => 'DHK',
            'address' => 'Dhaka',
        ]);

        $employeeUser = User::factory()->create([
            'role' => User::ROLE_EMPLOYEE,
        ]);

        $agent = Agent::create([
            'user_id' => $employeeUser->id,
            'branch_id' => $branch->id,
            'agent_code' => Str::uuid()->toString(),
        ]);

        $employee = Employee::create([
            'user_id' => $employeeUser->id,
            'branch_id' => $branch->id,
            'agent_id' => $agent->id,
            'rank' => Employee::RANK_MM,
        ]);

        $customer = User::factory()->create();

        $salesOrder = SalesOrder::create([
            'customer_id' => $customer->id,
            'employee_id' => $employee->id,
            'agent_id' => $agent->id,
            'branch_id' => $branch->id,
            'sales_type' => SalesOrder::TYPE_LAND,
            'rank' => Employee::RANK_MM,
            'status' => SalesOrder::STATUS_ACTIVE,
            'down_payment' => 50000,
            'total' => 500000,
        ]);

        $payment = Payment::create([
            'sales_order_id' => $salesOrder->id,
            'paid_at' => now(),
            'amount' => 50000,
            'type' => 'down_payment',
        ]);

        $owner = User::factory()->create([
            'role' => User::ROLE_OWNER,
        ]);

        CommissionRule::create([
            'name' => 'MM Rank Bonus',
            'scope' => 'rank:' . Employee::RANK_MM,
            'trigger' => CommissionRule::TRIGGER_ON_PAYMENT,
            'recipient_type' => User::class,
            'recipient_id' => $owner->id,
            'percentage' => 5,
            'flat_amount' => null,
            'active' => true,
        ]);

        $commissions = app(CommissionService::class)->handlePayment($payment);

        $this->assertCount(1, $commissions);
        $this->assertSame(2500.0, (float) $commissions->first()->amount);
        $this->assertDatabaseHas('commissions', [
            'payment_id' => $payment->id,
            'recipient_id' => $owner->id,
            'amount' => 2500.0,
        ]);
    }
}
