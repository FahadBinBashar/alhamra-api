<?php

namespace Tests\Feature;

use App\Models\Category;
use App\Models\OrderItem;
use App\Models\Payment;
use App\Models\Product;
use App\Models\SalesOrder;
use App\Models\Supplier;
use App\Models\SupplierPayable;
use App\Models\User;
use App\Services\SupplierPayableService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class SupplierPayableServiceTest extends TestCase
{
    use RefreshDatabase;

    public function test_down_payment_creates_supplier_payable_using_product_down_payment_percentage(): void
    {
        [$order, $supplier] = $this->createOrderWithSupplierProduct(0, 12.5);

        $payment = Payment::withoutEvents(fn () => Payment::create([
            'sales_order_id' => $order->id,
            'paid_at' => now(),
            'amount' => 20000,
            'type' => Payment::TYPE_DOWN_PAYMENT,
            'method' => 'cash',
        ]));

        app(SupplierPayableService::class)->handlePayment($payment);

        $this->assertDatabaseHas('supplier_payables', [
            'supplier_id' => $supplier->id,
            'payment_id' => $payment->id,
            'sales_order_id' => $order->id,
            'amount' => 2500.00,
            'status' => SupplierPayable::STATUS_UNPAID,
        ]);
    }

    public function test_installment_keeps_using_product_installment_percentage(): void
    {
        [$order, $supplier] = $this->createOrderWithSupplierProduct(10, 80);

        $payment = Payment::withoutEvents(fn () => Payment::create([
            'sales_order_id' => $order->id,
            'paid_at' => now(),
            'amount' => 20000,
            'type' => Payment::TYPE_INSTALLMENT,
            'method' => 'cash',
        ]));

        app(SupplierPayableService::class)->handlePayment($payment);

        $this->assertDatabaseHas('supplier_payables', [
            'supplier_id' => $supplier->id,
            'payment_id' => $payment->id,
            'sales_order_id' => $order->id,
            'amount' => 2000.00,
            'status' => SupplierPayable::STATUS_UNPAID,
        ]);
    }

    /**
     * @return array{0: SalesOrder, 1: Supplier}
     */
    protected function createOrderWithSupplierProduct(float $installmentPercentage, float $downPaymentPercentage): array
    {
        $customer = User::factory()->create();

        $supplier = Supplier::create([
            'name' => 'Supplier One',
            'email' => 'supplier@example.test',
        ]);

        $category = Category::create([
            'name' => 'Land',
            'type' => 'product',
        ]);

        $product = Product::create([
            'category_id' => $category->id,
            'supplier_id' => $supplier->id,
            'supplier_percentage' => $installmentPercentage,
            'supplier_down_payment_percentage' => $downPaymentPercentage,
            'name' => 'Plot A',
            'product_type' => 'land',
            'price' => 100000,
            'attributes' => [],
        ]);

        $order = SalesOrder::create([
            'customer_id' => $customer->id,
            'sales_type' => SalesOrder::TYPE_LAND,
            'status' => SalesOrder::STATUS_ACTIVE,
            'down_payment' => 20000,
            'total' => 100000,
            'created_by' => SalesOrder::CREATED_BY_SYSTEM,
        ]);

        OrderItem::create([
            'sales_order_id' => $order->id,
            'itemable_id' => $product->id,
            'itemable_type' => Product::class,
            'qty' => 1,
            'unit_price' => 100000,
            'line_total' => 100000,
        ]);

        return [$order, $supplier];
    }
}
