<?php

namespace Tests\Feature;

use App\Models\CustomerInstallment;
use App\Models\SalesOrder;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class InstallmentManagementTest extends TestCase
{
    use RefreshDatabase;

    protected function actingAsAdmin(): User
    {
        $admin = User::factory()->create([
            'role' => User::ROLE_ADMIN,
        ]);

        Sanctum::actingAs($admin);

        return $admin;
    }

    protected function createSalesOrder(): SalesOrder
    {
        $customer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        return SalesOrder::create([
            'customer_id' => $customer->id,
            'down_payment' => 0,
            'total' => 10000,
            'status' => SalesOrder::STATUS_ACTIVE,
        ]);
    }

    public function test_admin_can_perform_crud_on_installments(): void
    {
        $this->actingAsAdmin();
        $order = $this->createSalesOrder();

        $create = $this->postJson('/api/v1/installments', [
            'sales_order_id' => $order->id,
            'due_date' => now()->addMonth()->toDateString(),
            'amount' => 5000,
        ]);

        $create->assertCreated();
        $create->assertJsonPath('data.sales_order_id', $order->id);
        $create->assertJsonPath('data.status', 'due');

        $installmentId = $create->json('data.id');

        $this->assertDatabaseHas('customer_installments', [
            'id' => $installmentId,
            'sales_order_id' => $order->id,
            'amount' => 5000,
            'status' => 'due',
        ]);

        $list = $this->getJson('/api/v1/installments');
        $list->assertOk();
        $list->assertJsonFragment(['id' => $installmentId]);

        $show = $this->getJson("/api/v1/installments/{$installmentId}");
        $show->assertOk();
        $show->assertJsonPath('data.id', $installmentId);

        $update = $this->patchJson("/api/v1/installments/{$installmentId}", [
            'status' => 'partial',
            'paid' => 2500,
        ]);

        $update->assertOk();
        $update->assertJsonPath('data.status', 'partial');
        $update->assertJsonPath('data.paid', 2500);

        $this->assertDatabaseHas('customer_installments', [
            'id' => $installmentId,
            'paid' => 2500,
            'status' => 'partial',
        ]);

        $this->patchJson("/api/v1/installments/{$installmentId}", [
            'paid' => 0,
            'status' => 'due',
        ])->assertOk();

        $delete = $this->deleteJson("/api/v1/installments/{$installmentId}");
        $delete->assertNoContent();

        $this->assertDatabaseMissing('customer_installments', [
            'id' => $installmentId,
        ]);
    }

    public function test_installment_with_payments_cannot_be_deleted(): void
    {
        $this->actingAsAdmin();
        $order = $this->createSalesOrder();

        $installment = CustomerInstallment::create([
            'sales_order_id' => $order->id,
            'due_date' => now()->addMonth()->toDateString(),
            'amount' => 3000,
            'paid' => 1500,
            'status' => 'partial',
        ]);

        $response = $this->deleteJson("/api/v1/installments/{$installment->id}");

        $response->assertStatus(422);
        $response->assertJsonFragment([
            'message' => 'Installment cannot be deleted once payments have been recorded.',
        ]);

        $this->assertDatabaseHas('customer_installments', [
            'id' => $installment->id,
        ]);
    }
}
