<?php

namespace Tests\Feature;

use App\Models\Category;
use App\Models\Product;
use App\Models\StockMovement;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class StockMovementTest extends TestCase
{
    use RefreshDatabase;

    public function test_admin_can_record_stock_in_and_out(): void
    {
        $admin = User::factory()->create([
            'role' => User::ROLE_ADMIN,
        ]);

        Sanctum::actingAs($admin);

        $category = Category::create([
            'name' => 'Supplies',
            'type' => 'product',
        ]);

        $product = Product::create([
            'category_id' => $category->id,
            'name' => 'Printer Paper',
            'product_type' => 'small',
            'price' => 250,
            'stock_qty' => 0,
            'min_stock_alert' => 5,
            'is_stock_managed' => true,
            'attributes' => [],
        ]);

        $stockIn = $this->postJson('/api/v1/stock-movements', [
            'product_id' => $product->id,
            'type' => StockMovement::TYPE_IN,
            'qty' => 10,
            'ref_type' => 'purchase',
            'ref_id' => 1,
        ]);

        $stockIn->assertCreated();

        $product->refresh();
        $this->assertSame(10.0, (float) $product->stock_qty);

        $this->assertDatabaseHas('stock_movements', [
            'product_id' => $product->id,
            'type' => StockMovement::TYPE_IN,
            'qty' => '10.00',
        ]);

        $stockOut = $this->postJson('/api/v1/stock-movements', [
            'product_id' => $product->id,
            'type' => StockMovement::TYPE_OUT,
            'qty' => 3,
            'ref_type' => 'adjustment',
        ]);

        $stockOut->assertCreated();

        $product->refresh();
        $this->assertSame(7.0, (float) $product->stock_qty);

        $this->assertDatabaseHas('stock_movements', [
            'product_id' => $product->id,
            'type' => StockMovement::TYPE_OUT,
            'qty' => '3.00',
        ]);
    }

    public function test_stock_movement_rejected_for_non_managed_product(): void
    {
        $admin = User::factory()->create([
            'role' => User::ROLE_ADMIN,
        ]);

        Sanctum::actingAs($admin);

        $category = Category::create([
            'name' => 'Real Estate',
            'type' => 'product',
        ]);

        $product = Product::create([
            'category_id' => $category->id,
            'name' => 'Premium Plot',
            'product_type' => 'land',
            'price' => 500000,
            'stock_qty' => 0,
            'min_stock_alert' => 0,
            'is_stock_managed' => false,
            'attributes' => [],
        ]);

        $response = $this->postJson('/api/v1/stock-movements', [
            'product_id' => $product->id,
            'type' => StockMovement::TYPE_IN,
            'qty' => 5,
        ]);

        $response->assertStatus(422);
        $response->assertJsonValidationErrors(['product_id']);

        $this->assertSame(0.0, (float) $product->fresh()->stock_qty);
        $this->assertDatabaseCount('stock_movements', 0);
    }
}
