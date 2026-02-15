<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\Branch;
use App\Models\Category;
use App\Models\CommissionSetting;
use App\Models\CustomerInstallment;
use App\Models\Payment;
use App\Models\Product;
use App\Models\ProductEmiRule;
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

    protected function createOrderWithInstallments(array $rules): array
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

        foreach ($rules as $rule) {
            ProductEmiRule::create(array_merge([
                'product_id' => $product->id,
                'tenure_months' => 3,
                'is_active' => true,
            ], $rule));
        }

        $customer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        $order = SalesOrder::create([
            'customer_id' => $customer->id,
            'sales_type' => SalesOrder::TYPE_LAND,
            'status' => SalesOrder::STATUS_ACTIVE,
            'down_payment' => 0,
            'installment_tenure_months' => 3,
            'total' => 30000,
        ]);

        $order->items()->create([
            'itemable_type' => Product::class,
            'itemable_id' => $product->id,
            'qty' => 1,
            'unit_price' => 30000,
            'line_total' => 30000,
        ]);

        $installments = collect([
            CustomerInstallment::create([
                'sales_order_id' => $order->id,
                'due_date' => Carbon::now()->addMonth()->toDateString(),
                'amount' => 10000,
                'paid' => 0,
                'status' => 'due',
            ]),
            CustomerInstallment::create([
                'sales_order_id' => $order->id,
                'due_date' => Carbon::now()->addMonths(2)->toDateString(),
                'amount' => 10000,
                'paid' => 0,
                'status' => 'due',
            ]),
            CustomerInstallment::create([
                'sales_order_id' => $order->id,
                'due_date' => Carbon::now()->addMonths(3)->toDateString(),
                'amount' => 10000,
                'paid' => 0,
                'status' => 'due',
            ]),
        ]);

        return [$order, $installments];
    }

    public function test_it_applies_percent_rule_on_month_1(): void
    {
        $this->actingAsAdmin();
        [$order, $installments] = $this->createOrderWithInstallments([
            ['rule_month' => 1, 'rule_type' => 'percent', 'percent' => 2, 'flat_amount' => null],
        ]);

        $installment = $installments->first();

        $response = $this->postJson("/api/v1/sales-orders/{$order->id}/payments", [
            'paid_at' => Carbon::now()->toDateString(),
            'amount' => 10200,
            'type' => Payment::TYPE_INSTALLMENT,
            'allocations' => [
                [
                    'installment_id' => $installment->id,
                    'amount' => 10000,
                ],
            ],
        ]);

        $response->assertCreated();

        $paymentId = $response->json('data.id');

        $this->assertDatabaseHas('payments', [
            'id' => $paymentId,
            'base_amount' => 10000,
            'emi_extra_amount' => 200,
            'commission_base_amount' => 10200,
            'amount' => 10200,
        ]);
    }

    public function test_it_applies_flat_rule_on_month_3(): void
    {
        $this->actingAsAdmin();
        [$order, $installments] = $this->createOrderWithInstallments([
            ['rule_month' => 3, 'rule_type' => 'flat', 'percent' => null, 'flat_amount' => 500],
        ]);

        $installment = $installments->last();

        $response = $this->postJson("/api/v1/sales-orders/{$order->id}/payments", [
            'paid_at' => Carbon::now()->toDateString(),
            'amount' => 10500,
            'type' => Payment::TYPE_INSTALLMENT,
            'allocations' => [
                [
                    'installment_id' => $installment->id,
                    'amount' => 10000,
                ],
            ],
        ]);

        $response->assertCreated();

        $paymentId = $response->json('data.id');

        $this->assertDatabaseHas('payments', [
            'id' => $paymentId,
            'base_amount' => 10000,
            'emi_extra_amount' => 500,
            'amount' => 10500,
        ]);
    }

    public function test_it_defaults_to_zero_if_no_rule(): void
    {
        $this->actingAsAdmin();
        [$order, $installments] = $this->createOrderWithInstallments([
            ['rule_month' => 1, 'rule_type' => 'percent', 'percent' => 2, 'flat_amount' => null],
        ]);

        $installment = $installments->get(1);

        $response = $this->postJson("/api/v1/sales-orders/{$order->id}/payments", [
            'paid_at' => Carbon::now()->toDateString(),
            'amount' => 10000,
            'type' => Payment::TYPE_INSTALLMENT,
            'allocations' => [
                [
                    'installment_id' => $installment->id,
                    'amount' => 10000,
                ],
            ],
        ]);

        $response->assertCreated();

        $paymentId = $response->json('data.id');

        $this->assertDatabaseHas('payments', [
            'id' => $paymentId,
            'base_amount' => 10000,
            'emi_extra_amount' => 0,
            'amount' => 10000,
        ]);
    }

    public function test_it_does_not_affect_commission_calculation(): void
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
            'base_amount' => 10000,
            'emi_extra_amount' => 200,
            'type' => Payment::TYPE_INSTALLMENT,
        ]);

        $commissions = app(CommissionService::class)->handlePayment($payment);

        $this->assertCount(1, $commissions);
        $this->assertSame(1020.0, $commissions[0]['amount']);
    }
}
