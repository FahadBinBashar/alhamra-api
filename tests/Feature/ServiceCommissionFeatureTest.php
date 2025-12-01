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
use Laravel\Sanctum\Sanctum;
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

    public function test_admin_can_preview_unpaid_service_commissions_for_month(): void
    {
        $branch = Branch::create(['name' => 'Dhaka', 'code' => 'DHK', 'address' => 'Dhaka']);
        $admin = User::factory()->create(['role' => User::ROLE_ADMIN]);

        $employeeUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $employee = Employee::create([
            'user_id' => $employeeUser->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_ME,
        ]);

        $agentUser = User::factory()->create(['role' => User::ROLE_AGENT]);
        $agent = Agent::create([
            'user_id' => $agentUser->id,
            'branch_id' => $branch->id,
            'agent_code' => 'AG-3',
        ]);

        $customer = User::factory()->create(['role' => User::ROLE_CUSTOMER]);
        $category = Category::create(['name' => 'Services', 'type' => 'service']);
        $service = Service::create([
            'name' => 'Visa Processing',
            'category_id' => $category->id,
            'price' => 50000,
            'commission_percentage' => 5,
        ]);

        $employeeOrder = SalesOrder::create([
            'customer_id' => $customer->id,
            'source_me_id' => $employee->id,
            'employee_id' => $employee->id,
            'branch_id' => $branch->id,
            'sales_type' => SalesOrder::TYPE_SERVICE,
            'down_payment' => null,
            'total' => $service->price,
            'status' => SalesOrder::STATUS_ACTIVE,
            'created_by' => SalesOrder::CREATED_BY_ADMIN,
        ]);

        $employeeOrder->items()->create([
            'itemable_type' => Service::class,
            'itemable_id' => $service->id,
            'qty' => 1,
            'unit_price' => $service->price,
            'line_total' => $service->price,
        ]);

        Payment::create([
            'sales_order_id' => $employeeOrder->id,
            'paid_at' => '2025-12-10',
            'amount' => 50000,
            'type' => Payment::TYPE_FULL_PAYMENT,
        ]);

        $agentOrder = SalesOrder::create([
            'customer_id' => $customer->id,
            'agent_id' => $agent->id,
            'branch_id' => $branch->id,
            'sales_type' => SalesOrder::TYPE_SERVICE,
            'down_payment' => null,
            'total' => $service->price,
            'status' => SalesOrder::STATUS_ACTIVE,
            'created_by' => SalesOrder::CREATED_BY_AGENT,
        ]);

        $agentOrder->items()->create([
            'itemable_type' => Service::class,
            'itemable_id' => $service->id,
            'qty' => 1,
            'unit_price' => $service->price,
            'line_total' => $service->price,
        ]);

        Payment::create([
            'sales_order_id' => $agentOrder->id,
            'paid_at' => '2025-12-11',
            'amount' => 10000,
            'type' => Payment::TYPE_PARTIAL_PAYMENT,
        ]);

        Sanctum::actingAs($admin);

        $response = $this->getJson('/api/v1/service-commissions/pending?month=2025-12');

        $response->assertOk();

        $payload = $response->json();

        $this->assertSame('2025-12', $payload['month']);
        $this->assertSame(1, $payload['count']);
        $this->assertSame(2500.0, $payload['total_amount']);
        $this->assertCount(1, $payload['commissions']);

        $commission = $payload['commissions'][0];

        $this->assertSame($employeeOrder->id, $commission['sales_order_id']);
        $this->assertSame('employee', $commission['recipient_type']);
        $this->assertSame($employee->id, $commission['recipient_id']);
        $this->assertSame($employeeUser->name, $commission['recipient_name']);
        $this->assertSame($service->name, $commission['service_name']);
        $this->assertSame(50000.0, $commission['payment_amount']);
        $this->assertSame(2500.0, $commission['commission_amount']);
        $this->assertSame('unpaid', $commission['status']);
    }
}
