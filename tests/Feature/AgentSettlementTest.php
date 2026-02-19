<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\AgentSettlement;
use App\Models\Payment;
use App\Models\SalesOrder;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class AgentSettlementTest extends TestCase
{
    use RefreshDatabase;

    public function test_agent_can_submit_settlement_and_see_pending_amount(): void
    {
        [$agentUser, $agent] = $this->createAgent();
        $customer = User::factory()->create(['role' => User::ROLE_CUSTOMER]);

        $order = SalesOrder::create([
            'customer_id' => $customer->id,
            'agent_id' => $agent->id,
            'total' => 5000,
            'down_payment' => 0,
            'status' => 'active',
        ]);

        Payment::create([
            'sales_order_id' => $order->id,
            'paid_at' => now()->toDateString(),
            'amount' => 2000,
            'base_amount' => 2000,
            'emi_extra_amount' => 0,
            'type' => Payment::TYPE_FULL_PAYMENT,
            'intent_type' => Payment::INTENT_DUE,
            'method' => 'cash',
        ]);

        Sanctum::actingAs($agentUser);

        $this->getJson('/api/v1/agent-settlements/my/pending')
            ->assertOk()
            ->assertJsonPath('data.pending_settlement_amount', 2000);

        Storage::fake('public');

        $response = $this->postJson('/api/v1/agent-settlements/my', [
            'amount' => 1500,
            'payment_method' => AgentSettlement::PAYMENT_METHOD_BANK,
            'reference_no' => 'TXN-101',
            'attachment' => UploadedFile::fake()->image('slip.png'),
            'note' => 'Bank deposit slip uploaded.',
        ])->assertOk()
            ->assertJsonPath('data.status', AgentSettlement::STATUS_PENDING);

        $storedPath = $response->json('data.attachment_url');
        $this->assertNotEmpty($storedPath);
        Storage::disk('public')->assertExists($storedPath);

        $this->getJson('/api/v1/agent-settlements/my/pending')
            ->assertOk()
            ->assertJsonPath('data.pending_settlement_amount', 500.0);
    }

    public function test_admin_can_approve_settlement_and_post_ledger_entries(): void
    {
        $admin = User::factory()->create(['role' => User::ROLE_ADMIN]);
        [, $agent] = $this->createAgent();

        $settlement = AgentSettlement::create([
            'agent_id' => $agent->id,
            'amount' => 1200,
            'payment_method' => AgentSettlement::PAYMENT_METHOD_CASH,
            'reference_no' => 'CASH-22',
            'attachment_url' => 'https://example.com/cash-slip.png',
            'status' => AgentSettlement::STATUS_PENDING,
        ]);

        Sanctum::actingAs($admin);

        $this->postJson("/api/v1/admin/agent-settlements/{$settlement->id}/approve")
            ->assertOk()
            ->assertJsonPath('data.status', AgentSettlement::STATUS_APPROVED);

        $this->assertDatabaseHas('agent_settlements', [
            'id' => $settlement->id,
            'status' => AgentSettlement::STATUS_APPROVED,
        ]);

        $this->assertDatabaseHas('journals', [
            'tx_id' => 'agent_settlement_'.$settlement->id,
        ]);

        $this->assertDatabaseHas('ledger_entries', [
            'tx_id' => 'agent_settlement_'.$settlement->id,
            'debit' => 1200,
        ]);

        $this->assertDatabaseHas('ledger_entries', [
            'tx_id' => 'agent_settlement_'.$settlement->id,
            'credit' => 1200,
        ]);
    }


    public function test_agent_cannot_access_admin_settlement_actions(): void
    {
        [$agentUser, $agent] = $this->createAgent();

        $settlement = AgentSettlement::create([
            'agent_id' => $agent->id,
            'amount' => 750,
            'payment_method' => AgentSettlement::PAYMENT_METHOD_CASH,
            'attachment_url' => 'https://example.com/slip.png',
            'status' => AgentSettlement::STATUS_PENDING,
        ]);

        Sanctum::actingAs($agentUser);

        $this->getJson('/api/v1/admin/agent-settlements')->assertForbidden();

        $this->postJson("/api/v1/admin/agent-settlements/{$settlement->id}/approve")
            ->assertForbidden();
    }

    public function test_admin_can_reject_settlement_with_reason(): void
    {
        $admin = User::factory()->create(['role' => User::ROLE_ADMIN]);
        [, $agent] = $this->createAgent();

        $settlement = AgentSettlement::create([
            'agent_id' => $agent->id,
            'amount' => 900,
            'payment_method' => AgentSettlement::PAYMENT_METHOD_BANK,
            'attachment_url' => 'https://example.com/slip-2.png',
            'status' => AgentSettlement::STATUS_PENDING,
        ]);

        Sanctum::actingAs($admin);

        $this->postJson("/api/v1/admin/agent-settlements/{$settlement->id}/reject", [
            'reason' => 'Transaction not found in bank statement.',
        ])->assertOk()
            ->assertJsonPath('data.status', AgentSettlement::STATUS_REJECTED)
            ->assertJsonPath('data.admin_note', 'Transaction not found in bank statement.');

        $this->assertDatabaseHas('agent_settlements', [
            'id' => $settlement->id,
            'status' => AgentSettlement::STATUS_REJECTED,
            'admin_note' => 'Transaction not found in bank statement.',
        ]);
    }

    private function createAgent(): array
    {
        $agentUser = User::factory()->create(['role' => User::ROLE_AGENT]);

        $agent = Agent::create([
            'user_id' => $agentUser->id,
            'agent_code' => 'AG-'.uniqid(),
        ]);

        return [$agentUser, $agent];
    }
}
