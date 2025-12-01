<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\AgentWallet;
use App\Models\Branch;
use App\Models\Category;
use App\Models\Employee;
use App\Models\EmployeeWallet;
use App\Models\Payment;
use App\Models\SalesOrder;
use App\Models\Service;
use App\Models\User;
use App\Services\ServiceCommissionService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ServiceCommissionFeatureTest extends TestCase
{
    use RefreshDatabase;

    public function test_agent_service_payment_is_paid_immediately(): void
    {
        $branch = Branch::create(['name' => 'Dhaka', 'code' => 'DHK', 'address' => 'Dhaka']);
        $agentUser = User::factory()->create(['role' => User::ROLE_AGENT]);
        $agent = Agent::create([
            'user_id' => $agentUser->id,
            'branch_id' => $branch->id,
            'agent_code' => 'AG-1',
        ]);
        $customer = User::factory()->create(['role' => User::ROLE_CUSTOMER]);
        $category = Category::create(['name' => 'Services']);
        $service = Service::create([
            'name' => 'Umrah Package',
            'category_id' => $category->id,
            'price' => 300000,
            'commission_percentage' => 5,
        ]);

        $order = SalesOrder::create([
            'customer_id' => $customer->id,
            'agent_id' => $agent->id,
            'branch_id' => $branch->id,
            'sales_type' => SalesOrder::TYPE_SERVICE,
            'down_payment' => null,
            'total' => 300000,
            'status' => SalesOrder::STATUS_ACTIVE,
            'created_by' => SalesOrder::CREATED_BY_AGENT,
        ]);

        $order->items()->create([
            'itemable_type' => Service::class,
            'itemable_id' => $service->id,
            'qty' => 1,
            'unit_price' => 300000,
            'line_total' => 300000,
        ]);

        $payment = Payment::create([
            'sales_order_id' => $order->id,
            'paid_at' => now()->toDateString(),
            'amount' => 200000,
            'type' => Payment::TYPE_FULL_PAYMENT,
        ]);

        $this->assertDatabaseHas('commissions', [
            'payment_id' => $payment->id,
            'category' => 'service',
            'recipient_type' => Agent::class,
            'recipient_id' => $agent->id,
            'status' => 'paid',
            'amount' => 10000.00,
        ]);

        $wallet = AgentWallet::firstWhere('agent_id', $agent->id);
        $this->assertNotNull($wallet);
        $this->assertEquals(10000.00, (float) $wallet->balance);
    }

    public function test_employee_service_payment_is_processed_monthly(): void
    {
        $branch = Branch::create(['name' => 'Dhaka', 'code' => 'DHK', 'address' => 'Dhaka']);
        $employeeUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $employee = Employee::create([
            'user_id' => $employeeUser->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_ME,
        ]);
        $customer = User::factory()->create(['role' => User::ROLE_CUSTOMER]);
        $category = Category::create(['name' => 'Services']);
        $service = Service::create([
            'name' => 'Umrah Package',
            'category_id' => $category->id,
            'price' => 300000,
            'commission_percentage' => 5,
        ]);

        $order = SalesOrder::create([
            'customer_id' => $customer->id,
            'source_me_id' => $employee->id,
            'employee_id' => $employee->id,
            'branch_id' => $branch->id,
            'sales_type' => SalesOrder::TYPE_SERVICE,
            'down_payment' => null,
            'total' => 300000,
            'status' => SalesOrder::STATUS_ACTIVE,
            'created_by' => SalesOrder::CREATED_BY_ADMIN,
        ]);

        $order->items()->create([
            'itemable_type' => Service::class,
            'itemable_id' => $service->id,
            'qty' => 1,
            'unit_price' => 300000,
            'line_total' => 300000,
        ]);

        $payment = Payment::create([
            'sales_order_id' => $order->id,
            'paid_at' => '2025-02-15',
            'amount' => 200000,
            'type' => Payment::TYPE_FULL_PAYMENT,
        ]);

        $this->assertDatabaseHas('commissions', [
            'payment_id' => $payment->id,
            'category' => 'service',
            'recipient_type' => Employee::class,
            'recipient_id' => $employee->id,
            'status' => 'unpaid',
            'amount' => 10000.00,
        ]);

        $this->assertNull(EmployeeWallet::firstWhere('employee_id', $employee->id));

        $summary = app(ServiceCommissionService::class)->processUnpaidForMonth(now()->setDate(2025, 2, 1));

        $this->assertSame(1, $summary['processed']);
        $this->assertSame(10000.0, $summary['total_amount']);
        $this->assertDatabaseHas('commissions', [
            'payment_id' => $payment->id,
            'status' => 'paid',
        ]);

        $wallet = EmployeeWallet::firstWhere('employee_id', $employee->id);
        $this->assertNotNull($wallet);
        $this->assertEquals(10000.00, (float) $wallet->balance);
    }
}
