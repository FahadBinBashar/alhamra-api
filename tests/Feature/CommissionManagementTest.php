<?php

namespace Tests\Feature;

use App\Models\Commission;
use App\Models\CommissionRule;
use App\Models\Payment;
use App\Models\SalesOrder;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class CommissionManagementTest extends TestCase
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

    public function test_admin_can_create_and_update_commission_rule(): void
    {
        $this->actingAsAdmin();

        $response = $this->postJson('/api/v1/commission-rules', [
            'name' => 'Agent Down Payment',
            'scope' => 'down_payment',
            'trigger' => CommissionRule::TRIGGER_ON_PAYMENT,
            'recipient_type' => 'agent',
            'percentage' => 5,
            'active' => true,
            'meta' => ['commission_base' => 'amount'],
        ]);

        $response->assertCreated();

        $ruleId = $response->json('data.id');

        $this->assertDatabaseHas('commission_rules', [
            'id' => $ruleId,
            'name' => 'Agent Down Payment',
            'scope' => 'down_payment',
            'trigger' => CommissionRule::TRIGGER_ON_PAYMENT,
            'recipient_type' => 'agent',
            'percentage' => 5.00,
            'active' => true,
        ]);

        $update = $this->patchJson("/api/v1/commission-rules/{$ruleId}", [
            'name' => 'Agent Installment Bonus',
            'percentage' => null,
            'flat_amount' => 1500,
            'active' => false,
        ]);

        $update->assertOk();

        $this->assertDatabaseHas('commission_rules', [
            'id' => $ruleId,
            'name' => 'Agent Installment Bonus',
            'flat_amount' => 1500.00,
            'percentage' => null,
            'active' => false,
        ]);
    }

    public function test_commission_rule_with_commissions_cannot_be_deleted(): void
    {
        $this->actingAsAdmin();

        $rule = CommissionRule::create([
            'name' => 'Owner Share',
            'scope' => 'global',
            'trigger' => CommissionRule::TRIGGER_ON_PAYMENT,
            'recipient_type' => 'owner',
            'recipient_id' => 1,
            'percentage' => 10,
            'active' => true,
        ]);

        Commission::create([
            'commission_rule_id' => $rule->id,
            'recipient_type' => 'owner',
            'recipient_id' => 1,
            'amount' => 5000,
            'status' => 'unpaid',
        ]);

        $response = $this->deleteJson("/api/v1/commission-rules/{$rule->id}");

        $response->assertStatus(422);
        $response->assertJsonFragment([
            'message' => 'Commission rule cannot be deleted while commissions are attached.',
        ]);

        $this->assertDatabaseHas('commission_rules', ['id' => $rule->id]);
    }

    public function test_admin_can_create_and_update_commission_records(): void
    {
        $this->actingAsAdmin();

        $customer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        $order = SalesOrder::create([
            'customer_id' => $customer->id,
            'down_payment' => 100000,
            'total' => 300000,
            'status' => SalesOrder::STATUS_ACTIVE,
        ]);

        $payment = Payment::create([
            'sales_order_id' => $order->id,
            'paid_at' => now()->toDateString(),
            'amount' => 100000,
            'type' => 'down_payment',
        ]);

        $rule = CommissionRule::create([
            'name' => 'Agent Down Payment Commission',
            'scope' => 'down_payment',
            'trigger' => CommissionRule::TRIGGER_ON_PAYMENT,
            'recipient_type' => 'agent',
            'percentage' => 5,
            'active' => true,
        ]);

        $response = $this->postJson('/api/v1/commissions', [
            'commission_rule_id' => $rule->id,
            'payment_id' => $payment->id,
            'recipient_type' => 'agent',
            'recipient_id' => 42,
            'amount' => 5000,
            'status' => 'paid',
        ]);

        $response->assertCreated();

        $commissionId = $response->json('data.id');

        $this->assertDatabaseHas('commissions', [
            'id' => $commissionId,
            'commission_rule_id' => $rule->id,
            'payment_id' => $payment->id,
            'sales_order_id' => $order->id,
            'status' => 'paid',
        ]);

        $this->assertNotNull($response->json('data.paid_at'));

        $update = $this->patchJson("/api/v1/commissions/{$commissionId}", [
            'status' => 'unpaid',
        ]);

        $update->assertOk();
        $update->assertJsonPath('data.status', 'unpaid');
        $update->assertJsonPath('data.paid_at', null);

        $this->assertDatabaseHas('commissions', [
            'id' => $commissionId,
            'status' => 'unpaid',
            'paid_at' => null,
        ]);

        $listing = $this->getJson('/api/v1/commissions?status=unpaid');

        $listing->assertOk();
        $this->assertSame(1, $listing->json('meta.total'));
    }
}
