<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\Branch;
use App\Models\Category;
use App\Models\Employee;
use App\Models\Product;
use App\Models\SalesOrder;
use App\Models\StockMovement;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Str;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class SalesOrderTest extends TestCase
{
    use RefreshDatabase;

    public function test_admin_can_create_sales_order_with_implicit_context(): void
    {
        $branch = Branch::create([
            'name' => 'Dhaka Branch',
            'code' => 'DHK',
            'address' => 'Dhaka',
        ]);

        $admin = User::factory()->create([
            'role' => User::ROLE_ADMIN,
        ]);

        $agent = Agent::create([
            'user_id' => $admin->id,
            'branch_id' => $branch->id,
            'agent_code' => Str::uuid()->toString(),
        ]);

        Employee::create([
            'user_id' => $admin->id,
            'branch_id' => $branch->id,
            'agent_id' => $agent->id,
            'rank' => Employee::RANK_MM,
        ]);

        $customer = User::factory()->create();

        $category = Category::create([
            'name' => 'Land',
            'type' => 'product',
        ]);

        $product = Product::create([
            'category_id' => $category->id,
            'name' => 'Premium Plot',
            'product_type' => 'land',
            'price' => 500000,
            'attributes' => [],
        ]);

        Sanctum::actingAs($admin);

        $response = $this->postJson('/api/v1/sales-orders', [
            'customer_id' => $customer->id,
            'sales_type' => SalesOrder::TYPE_LAND,
            'down_payment' => 50000,
            'total' => 500000,
            'items' => [
                [
                    'item_type' => 'product',
                    'item_id' => $product->id,
                    'qty' => 1,
                ],
            ],
        ]);

        $response->assertCreated();

        $response->assertJsonPath('data.branch_id', $branch->id);
        $response->assertJsonPath('data.agent_id', $agent->id);
        $response->assertJsonPath('data.rank', Employee::RANK_MM);
        $response->assertJsonPath('data.employee_id', $admin->employee->id);
        $response->assertJsonPath('data.sales_type', SalesOrder::TYPE_LAND);
        $response->assertJsonPath('data.items.0.itemable_id', $product->id);

        $this->assertDatabaseHas('sales_orders', [
            'customer_id' => $customer->id,
            'branch_id' => $branch->id,
            'agent_id' => $agent->id,
            'rank' => Employee::RANK_MM,
            'sales_type' => SalesOrder::TYPE_LAND,
        ]);
    }

    public function test_rank_employee_cannot_create_sales_order(): void
    {
        $branch = Branch::create([
            'name' => 'Chattogram Branch',
            'code' => 'CTG',
            'address' => 'Chattogram',
        ]);

        $rankUser = User::factory()->create([
            'role' => User::ROLE_EMPLOYEE,
        ]);

        $agent = Agent::create([
            'user_id' => $rankUser->id,
            'branch_id' => $branch->id,
            'agent_code' => Str::uuid()->toString(),
        ]);

        Employee::create([
            'user_id' => $rankUser->id,
            'branch_id' => $branch->id,
            'agent_id' => $agent->id,
            'rank' => Employee::RANK_ME,
        ]);

        $customer = User::factory()->create();

        Sanctum::actingAs($rankUser);

        $response = $this->postJson('/api/v1/sales-orders', [
            'customer_id' => $customer->id,
            'sales_type' => SalesOrder::TYPE_SERVICE,
            'down_payment' => 1000,
            'total' => 2000,
        ]);

        $response->assertForbidden();
        $this->assertDatabaseCount('sales_orders', 0);
    }

    public function test_product_sales_adjust_stock_levels(): void
    {
        $branch = Branch::create([
            'name' => 'Khulna Branch',
            'code' => 'KHL',
            'address' => 'Khulna',
        ]);

        $admin = User::factory()->create([
            'role' => User::ROLE_ADMIN,
        ]);

        $agent = Agent::create([
            'user_id' => $admin->id,
            'branch_id' => $branch->id,
            'agent_code' => Str::uuid()->toString(),
        ]);

        Employee::create([
            'user_id' => $admin->id,
            'branch_id' => $branch->id,
            'agent_id' => $agent->id,
            'rank' => Employee::RANK_MM,
        ]);

        $customer = User::factory()->create();

        $category = Category::create([
            'name' => 'Electronics',
            'type' => 'product',
        ]);

        $product = Product::create([
            'category_id' => $category->id,
            'name' => 'Smartphone',
            'product_type' => 'small',
            'price' => 1000,
            'stock_qty' => 5,
            'min_stock_alert' => 2,
            'is_stock_managed' => true,
            'attributes' => [],
        ]);

        Sanctum::actingAs($admin);

        $response = $this->postJson('/api/v1/sales-orders', [
            'customer_id' => $customer->id,
            'sales_type' => SalesOrder::TYPE_ORDER,
            'down_payment' => 0,
            'total' => 1000,
            'items' => [
                [
                    'item_type' => 'product',
                    'item_id' => $product->id,
                    'qty' => 1,
                    'unit_price' => 1000,
                ],
            ],
        ]);

        $response->assertCreated();

        $orderId = $response->json('data.id');
        $product->refresh();

        $this->assertSame(4.0, (float) $product->stock_qty);

        $this->assertDatabaseHas('stock_movements', [
            'product_id' => $product->id,
            'type' => StockMovement::TYPE_OUT,
            'ref_type' => 'sales_order',
            'ref_id' => $orderId,
            'qty' => '1.00',
        ]);

        $updateResponse = $this->putJson("/api/v1/sales-orders/{$orderId}", [
            'items' => [
                [
                    'item_type' => 'product',
                    'item_id' => $product->id,
                    'qty' => 2,
                    'unit_price' => 1000,
                ],
            ],
        ]);

        $updateResponse->assertOk();

        $product->refresh();

        $this->assertSame(3.0, (float) $product->stock_qty);

        $this->assertDatabaseHas('stock_movements', [
            'product_id' => $product->id,
            'type' => StockMovement::TYPE_OUT,
            'ref_type' => 'sales_order',
            'ref_id' => $orderId,
            'qty' => '2.00',
        ]);

        $this->assertDatabaseCount('stock_movements', 1);

        $deleteResponse = $this->deleteJson("/api/v1/sales-orders/{$orderId}");
        $deleteResponse->assertNoContent();

        $product->refresh();

        $this->assertSame(5.0, (float) $product->stock_qty);
        $this->assertDatabaseCount('stock_movements', 0);
    }
}
