<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\Branch;
use App\Models\Category;
use App\Models\CommissionSetting;
use App\Models\Employee;
use App\Models\Payment;
use App\Models\Product;
use App\Models\SalesOrder;
use App\Models\User;
use App\Services\CommissionService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class CommissionServiceTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        $this->seedCommissionSettings();
    }

    public function test_handle_payment_returns_gap_commissions_without_persisting(): void
    {
        $payment = $this->createPaymentWithChain();

        $this->assertSame(42000.0, (float) $payment->commission_base_amount);

        $commissions = app(CommissionService::class)->handlePayment($payment);

        $this->assertCount(4, $commissions);
        $this->assertSame(6300.0, $commissions[0]['amount']);
        $this->assertSame(2100.0, $commissions[1]['amount']);
        $this->assertSame(2100.0, $commissions[2]['amount']);
        $this->assertSame(2100.0, $commissions[3]['amount']);
        $this->assertDatabaseCount('commissions', 0);
    }

    public function test_handle_payment_persists_when_requested(): void
    {
        $payment = $this->createPaymentWithChain();

        $items = app(CommissionService::class)->handlePayment($payment, true);

        $payment->refresh();
        $unitId = $payment->commissionCalculationUnit->id;

        $this->assertCount(4, $items);
        $this->assertDatabaseHas('commission_calculation_units', [
            'payment_id' => $payment->id,
            'status' => 'draft',
        ]);
        $this->assertDatabaseHas('commission_calculation_items', [
            'commission_calculation_unit_id' => $unitId,
            'amount' => '6300.00',
        ]);
        $this->assertDatabaseCount('commissions', 0);
    }

    public function test_process_pending_commissions_marks_payment_and_updates_wallet(): void
    {
        $payment = $this->createPaymentWithChain();

        app(CommissionService::class)->handlePayment($payment, true);

        app(CommissionService::class)->processPendingCommissions();

        $payment->refresh();

        $this->assertNotNull($payment->commission_processed_at);
        $this->assertDatabaseHas('commissions', [
            'payment_id' => $payment->id,
            'status' => 'paid',
        ]);
        $this->assertDatabaseHas('commission_calculation_units', [
            'payment_id' => $payment->id,
            'status' => 'paid',
        ]);

        $mm = Employee::where('rank', Employee::RANK_MM)->first();
        $agm = Employee::where('rank', Employee::RANK_AGM)->first();
        $dgm = Employee::where('rank', Employee::RANK_DGM)->first();
        $gm = Employee::where('rank', Employee::RANK_GM)->first();

        $this->assertSame(6300.0, (float) $mm->wallet->balance);
        $this->assertSame(2100.0, (float) $agm->wallet->balance);
        $this->assertSame(2100.0, (float) $dgm->wallet->balance);
        $this->assertSame(2100.0, (float) $gm->wallet->balance);
    }

    public function test_process_pending_commissions_updates_agent_wallet(): void
    {
        $payment = $this->createPaymentWithAgent();

        app(CommissionService::class)->handlePayment($payment, true);

        app(CommissionService::class)->processPendingCommissions();

        $agent = $payment->salesOrder->agent;

        $this->assertDatabaseHas('commissions', [
            'recipient_type' => Agent::class,
            'recipient_id' => $agent->id,
            'status' => 'paid',
        ]);

        $this->assertSame(2100.0, (float) $agent->wallet->balance);
    }

    protected function createPaymentWithChain(): Payment
    {
        $branch = Branch::create([
            'name' => 'Dhaka',
            'code' => 'DHK',
            'address' => 'Dhaka',
        ]);

        $gmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $dgmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $agmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $mmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);

        $gm = Employee::create([
            'user_id' => $gmUser->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_GM,
            'employee_code' => 'EMP-'.uniqid(),
            'full_name_en' => 'General Manager',
        ]);

        $dgm = Employee::create([
            'user_id' => $dgmUser->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_DGM,
            'superior_id' => $gm->id,
            'employee_code' => 'EMP-'.uniqid(),
            'full_name_en' => 'Deputy General Manager',
        ]);

        $agm = Employee::create([
            'user_id' => $agmUser->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_AGM,
            'superior_id' => $dgm->id,
            'employee_code' => 'EMP-'.uniqid(),
            'full_name_en' => 'Assistant General Manager',
        ]);

        $mm = Employee::create([
            'user_id' => $mmUser->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_MM,
            'superior_id' => $agm->id,
            'employee_code' => 'EMP-'.uniqid(),
            'full_name_en' => 'Marketing Executive',
        ]);

        $customer = User::factory()->create();

        $category = Category::create([
            'name' => 'Land',
            'type' => 'product',
        ]);

        $product = Product::create([
            'category_id' => $category->id,
            'name' => 'Test Plot',
            'product_type' => 'land',
            'price' => 200000,
            'ccu_percentage' => 30,
            'is_stock_managed' => false,
        ]);

        $order = SalesOrder::create([
            'customer_id' => $customer->id,
            'source_me_id' => $mm->id,
            'branch_id' => $branch->id,
            'sales_type' => SalesOrder::TYPE_LAND,
            'status' => SalesOrder::STATUS_ACTIVE,
            'down_payment' => 60000,
            'total' => 200000,
        ]);

        $order->items()->create([
            'itemable_type' => Product::class,
            'itemable_id' => $product->id,
            'qty' => 1,
            'unit_price' => 200000,
            'line_total' => 200000,
        ]);

        return Payment::create([
            'sales_order_id' => $order->id,
            'paid_at' => now(),
            'amount' => 60000,
            'type' => Payment::TYPE_DOWN_PAYMENT,
        ]);
    }

    protected function createPaymentWithAgent(): Payment
    {
        $branch = Branch::create([
            'name' => 'Chattogram',
            'code' => 'CTG',
            'address' => 'Chattogram',
        ]);

        $agentUser = User::factory()->create(['role' => User::ROLE_AGENT]);

        $agent = Agent::create([
            'user_id' => $agentUser->id,
            'branch_id' => $branch->id,
            'agent_code' => 'AGT-'.uniqid(),
            'mobile' => '+8801000000000',
            'address' => 'Chattogram',
        ]);

        $customer = User::factory()->create();

        $category = Category::create([
            'name' => 'Apartment',
            'type' => 'product',
        ]);

        $product = Product::create([
            'category_id' => $category->id,
            'name' => 'Test Apartment',
            'product_type' => 'big',
            'price' => 200000,
            'ccu_percentage' => 30,
            'is_stock_managed' => false,
        ]);

        $order = SalesOrder::create([
            'customer_id' => $customer->id,
            'agent_id' => $agent->id,
            'branch_id' => $branch->id,
            'sales_type' => SalesOrder::TYPE_LAND,
            'status' => SalesOrder::STATUS_ACTIVE,
            'down_payment' => 60000,
            'total' => 200000,
        ]);

        $order->items()->create([
            'itemable_type' => Product::class,
            'itemable_id' => $product->id,
            'qty' => 1,
            'unit_price' => 200000,
            'line_total' => 200000,
        ]);

        return Payment::create([
            'sales_order_id' => $order->id,
            'paid_at' => now(),
            'amount' => 60000,
            'type' => Payment::TYPE_DOWN_PAYMENT,
        ]);
    }

    protected function seedCommissionSettings(): void
    {
        CommissionSetting::updateOrCreate([
            'key' => 'development_bonus',
        ], [
            'value' => [
                Employee::RANK_MM => ['down_payment' => 15],
                Employee::RANK_AGM => ['down_payment' => 20],
                Employee::RANK_DGM => ['down_payment' => 25],
                Employee::RANK_GM => ['down_payment' => 30],
            ],
        ]);

        CommissionSetting::updateOrCreate([
            'key' => 'agent_rates',
        ], [
            'value' => [
                'down_payment' => 5,
                'installment' => 1,
            ],
        ]);
    }
}
