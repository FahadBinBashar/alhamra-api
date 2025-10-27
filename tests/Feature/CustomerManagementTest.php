<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\Branch;
use App\Models\Employee;
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

    public function test_admin_can_create_customer(): void
    {
        $admin = User::factory()->create([
            'role' => User::ROLE_ADMIN,
        ]);

        Sanctum::actingAs($admin);

        $payload = [
            'name' => 'New Customer',
            'email' => 'new-customer@example.com',
            'password' => 'password123',
            'father_name' => 'John Senior',
            'mother_name' => 'Jane Senior',
            'marital_status' => 'Married',
            'spouse_name' => 'Spouse Name',
            'profession' => 'Engineer',
            'permanent_address' => '123 Main Street, Dhaka',
            'present_address' => '456 Market Road, Dhaka',
            'contact_number' => '01700000000',
            'residence_phone' => '01700000001',
            'whatsapp_number' => '01700000002',
            'national_id' => 'NID1234567890',
            'passport_number' => 'PA1234567',
            'nationality' => 'Bangladeshi',
            'religion' => 'Islam',
            'date_of_birth' => '1990-01-01',
            'blood_group' => 'A+',
            'nominee_name' => 'Nominee Name',
            'nominee_relation' => 'Brother',
            'nominee_phone' => '01700000003',
            'authorized_person_name' => 'Authorised Person',
            'authorized_person_address' => 'Authorised Address',
            'joint_applicants' => 'Applicant One, Applicant Two',
        ];

        $response = $this->postJson('/api/v1/customers', $payload);

        $response->assertCreated();
        $response->assertJsonPath('data.added_by_role', User::ROLE_ADMIN);

        $createdCustomer = User::where('email', 'new-customer@example.com')->first();

        $this->assertNotNull($createdCustomer);
        $this->assertSame(User::ROLE_CUSTOMER, $createdCustomer->role);
        $this->assertSame('John Senior', $createdCustomer->father_name);
        $this->assertSame('Jane Senior', $createdCustomer->mother_name);
        $this->assertSame('Married', $createdCustomer->marital_status);
        $this->assertSame('Spouse Name', $createdCustomer->spouse_name);
        $this->assertSame('Engineer', $createdCustomer->profession);
        $this->assertSame('123 Main Street, Dhaka', $createdCustomer->permanent_address);
        $this->assertSame('456 Market Road, Dhaka', $createdCustomer->present_address);
        $this->assertSame('01700000000', $createdCustomer->contact_number);
        $this->assertSame('01700000001', $createdCustomer->residence_phone);
        $this->assertSame('01700000002', $createdCustomer->whatsapp_number);
        $this->assertSame('NID1234567890', $createdCustomer->national_id);
        $this->assertSame('PA1234567', $createdCustomer->passport_number);
        $this->assertSame('Bangladeshi', $createdCustomer->nationality);
        $this->assertSame('Islam', $createdCustomer->religion);
        $this->assertSame('1990-01-01', $createdCustomer->date_of_birth?->format('Y-m-d'));
        $this->assertSame('A+', $createdCustomer->blood_group);
        $this->assertSame('Nominee Name', $createdCustomer->nominee_name);
        $this->assertSame('Brother', $createdCustomer->nominee_relation);
        $this->assertSame('01700000003', $createdCustomer->nominee_phone);
        $this->assertSame('Authorised Person', $createdCustomer->authorized_person_name);
        $this->assertSame('Authorised Address', $createdCustomer->authorized_person_address);
        $this->assertSame('Applicant One, Applicant Two', $createdCustomer->joint_applicants);
        $this->assertSame(User::ROLE_ADMIN, $createdCustomer->added_by_role);
        $this->assertNull($createdCustomer->added_by_agent_id);
    }

    public function test_agent_only_sees_own_customers(): void
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

        $createdCustomer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
            'added_by_role' => User::ROLE_AGENT_ADMIN,
            'added_by_agent_id' => $agent->id,
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
        $response->assertJsonCount(3, 'data');
        $response->assertJsonMissing(['id' => $otherCustomer->id]);
        $response->assertJsonFragment(['id' => $createdCustomer->id]);
    }

    public function test_branch_admin_only_sees_customers_from_their_branch(): void
    {
        $branchOne = Branch::create([
            'name' => 'Branch One',
            'code' => 'BR-001',
        ]);

        $branchTwo = Branch::create([
            'name' => 'Branch Two',
            'code' => 'BR-002',
        ]);

        $branchAdmin = User::factory()->create([
            'role' => User::ROLE_BRANCH_ADMIN,
        ]);

        Employee::create([
            'user_id' => $branchAdmin->id,
            'branch_id' => $branchOne->id,
        ]);

        $branchCustomer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
            'added_by_role' => User::ROLE_BRANCH_ADMIN,
            'added_by_branch_id' => $branchOne->id,
        ]);

        $branchOrderCustomer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        $otherBranchCustomer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
            'added_by_role' => User::ROLE_BRANCH_ADMIN,
            'added_by_branch_id' => $branchTwo->id,
        ]);

        SalesOrder::create([
            'customer_id' => $branchOrderCustomer->id,
            'branch_id' => $branchOne->id,
            'down_payment' => 0,
            'total' => 1200,
            'status' => SalesOrder::STATUS_ACTIVE,
        ]);

        SalesOrder::create([
            'customer_id' => $otherBranchCustomer->id,
            'branch_id' => $branchTwo->id,
            'down_payment' => 0,
            'total' => 900,
            'status' => SalesOrder::STATUS_ACTIVE,
        ]);

        Sanctum::actingAs($branchAdmin);

        $response = $this->getJson('/api/v1/customers');

        $response->assertOk();
        $response->assertJsonCount(2, 'data');
        $response->assertJsonFragment([
            'id' => $branchCustomer->id,
        ]);
        $response->assertJsonFragment([
            'id' => $branchOrderCustomer->id,
        ]);
        $response->assertJsonMissing([
            'id' => $otherBranchCustomer->id,
        ]);
    }

    public function test_branch_admin_cannot_view_customers_from_other_branches(): void
    {
        $branchOne = Branch::create([
            'name' => 'Branch One',
            'code' => 'BR-101',
        ]);

        $branchTwo = Branch::create([
            'name' => 'Branch Two',
            'code' => 'BR-202',
        ]);

        $branchAdmin = User::factory()->create([
            'role' => User::ROLE_BRANCH_ADMIN,
        ]);

        Employee::create([
            'user_id' => $branchAdmin->id,
            'branch_id' => $branchOne->id,
        ]);

        $branchCustomer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
            'added_by_role' => User::ROLE_BRANCH_ADMIN,
            'added_by_branch_id' => $branchOne->id,
        ]);

        $otherBranchCustomer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
            'added_by_role' => User::ROLE_BRANCH_ADMIN,
            'added_by_branch_id' => $branchTwo->id,
        ]);

        SalesOrder::create([
            'customer_id' => $otherBranchCustomer->id,
            'branch_id' => $branchTwo->id,
            'down_payment' => 0,
            'total' => 950,
            'status' => SalesOrder::STATUS_ACTIVE,
        ]);

        Sanctum::actingAs($branchAdmin);

        $response = $this->getJson(sprintf('/api/v1/customers/%d', $otherBranchCustomer->id));

        $response->assertForbidden();

        $this->getJson(sprintf('/api/v1/customers/%d', $branchCustomer->id))
            ->assertOk()
            ->assertJsonFragment([
                'id' => $branchCustomer->id,
            ]);
    }

    public function test_agent_admin_can_create_customer(): void
    {
        $agentUser = User::factory()->create([
            'role' => User::ROLE_AGENT_ADMIN,
        ]);

        $agent = Agent::create([
            'user_id' => $agentUser->id,
            'agent_code' => Str::uuid()->toString(),
        ]);

        Sanctum::actingAs($agentUser);

        $response = $this->postJson('/api/v1/customers', [
            'name' => 'Agent Customer',
            'email' => 'agent-customer@example.com',
            'password' => 'password123',
            'whatsapp_number' => '01800000000',
        ]);

        $response->assertCreated();
        $response->assertJsonPath('data.added_by_role', User::ROLE_AGENT_ADMIN);
        $response->assertJsonPath('data.added_by_agent_id', $agent->id);

        $createdCustomer = User::where('email', 'agent-customer@example.com')->first();

        $this->assertNotNull($createdCustomer);
        $this->assertSame(User::ROLE_CUSTOMER, $createdCustomer->role);
        $this->assertSame('01800000000', $createdCustomer->whatsapp_number);
        $this->assertSame(User::ROLE_AGENT_ADMIN, $createdCustomer->added_by_role);
        $this->assertSame($agent->id, $createdCustomer->added_by_agent_id);
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

        $createdCustomer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
            'added_by_role' => User::ROLE_AGENT_ADMIN,
            'added_by_agent_id' => $agent->id,
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

        $this->getJson("/api/v1/customers/{$createdCustomer->id}")->assertOk();

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

    public function test_non_privileged_user_cannot_create_customer(): void
    {
        $customer = User::factory()->create([
            'role' => User::ROLE_CUSTOMER,
        ]);

        Sanctum::actingAs($customer);

        $this->postJson('/api/v1/customers', [
            'name' => 'Unauthorized Customer',
            'email' => 'unauthorized@example.com',
            'password' => 'password123',
        ])->assertForbidden();

        $this->assertDatabaseMissing('users', [
            'email' => 'unauthorized@example.com',
        ]);
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
