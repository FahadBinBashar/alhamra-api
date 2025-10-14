<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\SalesOrder;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Str;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class CustomerManagementTest extends TestCase
{
    use RefreshDatabase;

    public function test_admin_can_list_all_customers(): void
    {
        $admin = User::factory()->create([
            'role' => User::ROLE_ADMIN,
        ]);

        $customers = User::factory()->count(3)->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        Sanctum::actingAs($admin);

        $response = $this->getJson('/api/v1/customers');

        $response->assertOk();
        $response->assertJsonCount(3, 'data');

        foreach ($customers as $customer) {
            $response->assertJsonFragment([
                'id' => $customer->id,
                'name' => $customer->name,
                'email' => $customer->email,
                'role' => User::ROLE_CUSTOMER,
            ]);
        }
    }

    public function test_agent_only_sees_assigned_customers(): void
    {
        $agentUser = User::factory()->create([
            'role' => User::ROLE_AGENT_ADMIN,
        ]);

        $agent = Agent::create([
            'user_id' => $agentUser->id,
            'agent_code' => Str::uuid()->toString(),
        ]);

        $customerOne = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        $customerTwo = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        $otherCustomer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        SalesOrder::create([
            'customer_id' => $customerOne->id,
            'agent_id' => $agent->id,
            'down_payment' => 0,
            'total' => 1000,
            'status' => SalesOrder::STATUS_ACTIVE,
        ]);

        SalesOrder::create([
            'customer_id' => $customerTwo->id,
            'agent_id' => $agent->id,
            'down_payment' => 0,
            'total' => 500,
            'status' => SalesOrder::STATUS_ACTIVE,
        ]);

        $otherAgentUser = User::factory()->create([
            'role' => User::ROLE_AGENT_ADMIN,
        ]);

        $otherAgent = Agent::create([
            'user_id' => $otherAgentUser->id,
            'agent_code' => Str::uuid()->toString(),
        ]);

        SalesOrder::create([
            'customer_id' => $otherCustomer->id,
            'agent_id' => $otherAgent->id,
            'down_payment' => 0,
            'total' => 750,
            'status' => SalesOrder::STATUS_ACTIVE,
        ]);

        Sanctum::actingAs($agentUser);

        $response = $this->getJson('/api/v1/customers');

        $response->assertOk();
        $response->assertJsonCount(2, 'data');
        $response->assertJsonMissing(['id' => $otherCustomer->id]);
    }

    public function test_agent_cannot_view_unassigned_customer(): void
    {
        $agentUser = User::factory()->create([
            'role' => User::ROLE_AGENT_ADMIN,
        ]);

        $agent = Agent::create([
            'user_id' => $agentUser->id,
            'agent_code' => Str::uuid()->toString(),
        ]);

        $customer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        $otherCustomer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        SalesOrder::create([
            'customer_id' => $customer->id,
            'agent_id' => $agent->id,
            'down_payment' => 0,
            'total' => 1200,
            'status' => SalesOrder::STATUS_ACTIVE,
        ]);

        Sanctum::actingAs($agentUser);

        $this->getJson("/api/v1/customers/{$customer->id}")->assertOk();

        $this->getJson("/api/v1/customers/{$otherCustomer->id}")->assertForbidden();
    }

    public function test_non_privileged_user_cannot_access_customer_api(): void
    {
        $customer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        Sanctum::actingAs($customer);

        $this->getJson('/api/v1/customers')->assertForbidden();
    }

    public function test_dashboard_includes_customer_summary_for_admin(): void
    {
        $admin = User::factory()->create([
            'role' => User::ROLE_ADMIN,
        ]);

        User::factory()->count(3)->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        Sanctum::actingAs($admin);

        $response = $this->getJson('/api/v1/dashboard');

        $response->assertOk();
        $response->assertJsonPath('customers.total', 3);
        $response->assertJsonCount(3, 'customers.recent');
    }

    public function test_agent_dashboard_only_counts_assigned_customers(): void
    {
        $agentUser = User::factory()->create([
            'role' => User::ROLE_AGENT_ADMIN,
        ]);

        $agent = Agent::create([
            'user_id' => $agentUser->id,
            'agent_code' => Str::uuid()->toString(),
        ]);

        $customerOne = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        $customerTwo = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        $otherCustomer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        SalesOrder::create([
            'customer_id' => $customerOne->id,
            'agent_id' => $agent->id,
            'down_payment' => 0,
            'total' => 900,
            'status' => SalesOrder::STATUS_ACTIVE,
        ]);

        SalesOrder::create([
            'customer_id' => $customerTwo->id,
            'agent_id' => $agent->id,
            'down_payment' => 0,
            'total' => 1100,
            'status' => SalesOrder::STATUS_ACTIVE,
        ]);

        $otherAgentUser = User::factory()->create([
            'role' => User::ROLE_AGENT_ADMIN,
        ]);

        $otherAgent = Agent::create([
            'user_id' => $otherAgentUser->id,
            'agent_code' => Str::uuid()->toString(),
        ]);

        SalesOrder::create([
            'customer_id' => $otherCustomer->id,
            'agent_id' => $otherAgent->id,
            'down_payment' => 0,
            'total' => 400,
            'status' => SalesOrder::STATUS_ACTIVE,
        ]);

        Sanctum::actingAs($agentUser);

        $response = $this->getJson('/api/v1/dashboard');

        $response->assertOk();
        $response->assertJsonPath('customers.total', 2);
        $response->assertJsonCount(2, 'customers.recent');
        $response->assertJsonMissing(['id' => $otherCustomer->id]);
    }
}
