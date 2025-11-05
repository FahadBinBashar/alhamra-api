<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\AgentWallet;
use App\Models\Commission;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class AgentDashboardControllerTest extends TestCase
{
    use RefreshDatabase;

    public function test_agent_can_view_own_wallet(): void
    {
        $user = User::factory()->create(['role' => User::ROLE_AGENT]);
        $agent = Agent::create([
            'user_id' => $user->id,
            'agent_code' => 'AGT-1000',
        ]);

        AgentWallet::create([
            'agent_id' => $agent->id,
            'balance' => 12345.67,
        ]);

        Sanctum::actingAs($user);

        $response = $this->getJson('/api/v1/agents/dashboard/wallet');

        $response
            ->assertOk()
            ->assertJsonPath('data.agent_id', $agent->id)
            ->assertJsonPath('data.balance', 12345.67);
    }

    public function test_agent_commission_listing_is_scoped_to_authenticated_agent(): void
    {
        $agentUser = User::factory()->create(['role' => User::ROLE_AGENT]);
        $agent = Agent::create([
            'user_id' => $agentUser->id,
            'agent_code' => 'AGT-2000',
        ]);

        $otherUser = User::factory()->create(['role' => User::ROLE_AGENT]);
        $otherAgent = Agent::create([
            'user_id' => $otherUser->id,
            'agent_code' => 'AGT-3000',
        ]);

        Commission::create([
            'recipient_type' => Agent::class,
            'recipient_id' => $agent->id,
            'amount' => 5000,
            'status' => 'paid',
        ]);

        Commission::create([
            'recipient_type' => Agent::class,
            'recipient_id' => $otherAgent->id,
            'amount' => 7000,
            'status' => 'paid',
        ]);

        Sanctum::actingAs($agentUser);

        $response = $this->getJson('/api/v1/agents/dashboard/commissions');

        $response
            ->assertOk()
            ->assertJsonCount(1, 'data')
            ->assertJsonPath('data.0.recipient_id', $agent->id)
            ->assertJsonPath('data.0.amount', '5000.00');
    }
}
