<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\Branch;
use App\Models\Category;
use App\Models\Payment;
use App\Models\SalesOrder;
use App\Models\Service;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class PaymentControllerTest extends TestCase
{
    use RefreshDatabase;

    public function test_service_payment_defaults_full_payment_when_type_missing(): void
    {
        $branch = Branch::create(['name' => 'Dhaka', 'code' => 'DHK', 'address' => 'Dhaka']);
        $admin = User::factory()->create(['role' => User::ROLE_ADMIN]);
        $agentUser = User::factory()->create(['role' => User::ROLE_AGENT]);
        $agent = Agent::create([
            'user_id' => $agentUser->id,
            'branch_id' => $branch->id,
            'agent_code' => 'AG-1',
        ]);
        $customer = User::factory()->create(['role' => User::ROLE_CUSTOMER]);
        $category = Category::create(['name' => 'Services', 'type' => 'service']);
        $service = Service::create([
            'name' => 'Umrah Package',
            'category_id' => $category->id,
            'price' => 50000,
            'commission_percentage' => 5,
        ]);

        $order = SalesOrder::create([
            'customer_id' => $customer->id,
            'agent_id' => $agent->id,
            'branch_id' => $branch->id,
            'sales_type' => SalesOrder::TYPE_SERVICE,
            'status' => SalesOrder::STATUS_ACTIVE,
            'down_payment' => null,
            'total' => $service->price,
            'created_by' => SalesOrder::CREATED_BY_AGENT,
        ]);

        $order->items()->create([
            'itemable_type' => Service::class,
            'itemable_id' => $service->id,
            'qty' => 1,
            'unit_price' => $service->price,
            'line_total' => $service->price,
        ]);

        Sanctum::actingAs($admin);

        $response = $this->postJson("/api/v1/sales-orders/{$order->id}/payments", [
            'paid_at' => now()->toDateString(),
            'amount' => 25000,
        ]);

        $response->assertCreated();

        $this->assertDatabaseHas('payments', [
            'sales_order_id' => $order->id,
            'type' => Payment::TYPE_FULL_PAYMENT,
            'intent_type' => Payment::INTENT_DUE,
            'amount' => 25000,
        ]);
    }
}
