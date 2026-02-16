<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\Branch;
use App\Models\Category;
use App\Models\CommissionSetting;
use App\Models\Payment;
use App\Models\Product;
use App\Models\ProductEmiPlan;
use App\Models\SalesOrder;
use App\Models\User;
use App\Services\CommissionService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Carbon;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class EmiExtraPaymentTest extends TestCase
{
    use RefreshDatabase;

    protected function actingAsAdmin(): void
    {
        $admin = User::factory()->create([
            'role' => User::ROLE_ADMIN,
        ]);

        Sanctum::actingAs($admin);
    }

    protected function createOrderWithPlan(string $extraType, float $extraValue, int $tenure = 3): SalesOrder
    {
        $category = Category::create([
            'name' => 'Land',
            'type' => 'product',
        ]);

        $product = Product::create([
            'category_id' => $category->id,
            'name' => 'Plot A',
            'product_type' => 'land',
            'price' => 30000,
            'is_stock_managed' => false,
        ]);

        ProductEmiPlan::create([
            'product_id' => $product->id,
            'tenure_months' => $tenure,
            'extra_type' => $extraType,
            'extra_value' => $extraValue,
            'is_active' => true,
        ]);

        $customer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        $order = SalesOrder::create([
            'customer_id' => $customer->id,
            'sales_type' => SalesOrder::TYPE_LAND,
            'status' => SalesOrder::STATUS_ACTIVE,
            'down_payment' => 0,
            'installment_tenure_months' => $tenure,
            'total' => 30000,
        ]);

        $order->items()->create([
            'itemable_type' => Product::class,
            'itemable_id' => $product->id,
            'qty' => 1,
            'unit_price' => 30000,
            'line_total' => 30000,
        ]);

        return $order;
    }

    public function test_generate_installments_with_percent_plan_precalculates_amount(): void
    {
        $this->actingAsAdmin();
        $order = $this->createOrderWithPlan('percent', 2, 3);

        $response = $this->postJson("/api/v1/sales-orders/{$order->id}/installments/generate", [
            'frequency' => 'monthly',
            'count' => 3,
            'start_date' => Carbon::now()->toDateString(),
            'grace_days' => 0,
        ]);

        $response->assertCreated();

        $order->refresh();

        $this->assertSame(600.0, (float) $order->emi_extra_total);
        $this->assertSame(30600.0, (float) $order->total_installment_payable);

        $this->assertDatabaseHas('customer_installments', [
            'sales_order_id' => $order->id,
            'amount' => 10200.00,
        ]);
    }

    public function test_generate_installments_with_flat_plan_precalculates_amount(): void
    {
        $this->actingAsAdmin();
        $order = $this->createOrderWithPlan('flat', 900, 3);

        $response = $this->postJson("/api/v1/sales-orders/{$order->id}/installments/generate", [
            'frequency' => 'monthly',
            'count' => 3,
            'start_date' => Carbon::now()->toDateString(),
            'grace_days' => 0,
        ]);

        $response->assertCreated();

        $this->assertDatabaseHas('customer_installments', [
            'sales_order_id' => $order->id,
            'amount' => 10300.00,
        ]);
    }

    public function test_payment_uses_precalculated_installment_without_runtime_emi_extra(): void
    {
        $this->actingAsAdmin();
        $order = $this->createOrderWithPlan('percent', 2, 3);

        $this->postJson("/api/v1/sales-orders/{$order->id}/installments/generate", [
            'frequency' => 'monthly',
            'count' => 3,
            'start_date' => Carbon::now()->toDateString(),
            'grace_days' => 0,
        ])->assertCreated();

        $installmentId = $order->installments()->orderBy('id')->value('id');

        $response = $this->postJson("/api/v1/sales-orders/{$order->id}/payments", [
            'paid_at' => Carbon::now()->toDateString(),
            'amount' => 10200,
            'type' => Payment::TYPE_INSTALLMENT,
            'allocations' => [
                [
                    'installment_id' => $installmentId,
                    'amount' => 10200,
                ],
            ],
        ]);

        $response->assertCreated();
        $paymentId = $response->json('data.id');

        $this->assertDatabaseHas('payments', [
            'id' => $paymentId,
            'base_amount' => 10200,
            'emi_extra_amount' => 0,
            'commission_base_amount' => 10200,
            'amount' => 10200,
        ]);
    }

    public function test_commission_uses_full_installment_amount(): void
    {
        CommissionSetting::updateOrCreate([
            'key' => 'agent_rates',
        ], [
            'value' => [
                'installment' => 10,
            ],
        ]);

        $branch = Branch::create([
            'name' => 'Dhaka',
            'code' => 'DHK',
            'address' => 'Dhaka',
        ]);

        $agentUser = User::factory()->create(['role' => User::ROLE_AGENT]);
        $agent = Agent::create([
            'user_id' => $agentUser->id,
            'branch_id' => $branch->id,
            'agent_code' => 'AGT-'.uniqid(),
            'mobile' => '+8801000000000',
        ]);

        $category = Category::create([
            'name' => 'Land',
            'type' => 'product',
        ]);

        $product = Product::create([
            'category_id' => $category->id,
            'name' => 'Plot B',
            'product_type' => 'land',
            'price' => 10000,
            'is_stock_managed' => false,
        ]);

        $customer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        $order = SalesOrder::create([
            'customer_id' => $customer->id,
            'agent_id' => $agent->id,
            'branch_id' => $branch->id,
            'sales_type' => SalesOrder::TYPE_LAND,
            'status' => SalesOrder::STATUS_ACTIVE,
            'down_payment' => 0,
            'total' => 10000,
        ]);

        $order->items()->create([
            'itemable_type' => Product::class,
            'itemable_id' => $product->id,
            'qty' => 1,
            'unit_price' => 10000,
            'line_total' => 10000,
        ]);

        $payment = Payment::create([
            'sales_order_id' => $order->id,
            'paid_at' => Carbon::now(),
            'amount' => 10200,
            'base_amount' => 10200,
            'emi_extra_amount' => 0,
            'type' => Payment::TYPE_INSTALLMENT,
        ]);

        $commissions = app(CommissionService::class)->handlePayment($payment);

        $this->assertCount(1, $commissions);
        $this->assertSame(1020.0, $commissions[0]['amount']);
    }
}
