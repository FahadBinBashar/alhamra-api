<?php

namespace Tests\Feature;

use App\Models\Agent;
use App\Models\Branch;
use App\Models\Employee;
use App\Models\Rank;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Str;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class EmployeeManagementTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        $this->ensureRanks(Employee::RANKS);
    }

    protected function actingAsAdmin(): User
    {
        $admin = User::factory()->create([
            'role' => User::ROLE_ADMIN,
        ]);

        Sanctum::actingAs($admin);

        return $admin;
    }

    protected function ensureRanks(array $codes): void
    {
        foreach ($codes as $index => $code) {
            Rank::firstOrCreate(
                ['code' => $code],
                ['name' => $code, 'sort_order' => $index + 1]
            );
        }
    }

    public function test_admin_can_create_employee_with_rank(): void
    {
        $this->actingAsAdmin();

        $branch = Branch::create([
            'name' => 'Dhaka',
            'code' => 'DHK',
            'address' => 'Dhaka',
        ]);

        $user = User::factory()->create([
            'role' => User::ROLE_EMPLOYEE,
        ]);

        $agent = Agent::create([
            'user_id' => $user->id,
            'branch_id' => $branch->id,
            'agent_code' => Str::uuid()->toString(),
        ]);

        $response = $this->postJson('/api/v1/employees', [
            'user_id' => $user->id,
            'agent_id' => $agent->id,
            'rank' => Employee::RANK_MM,
        ]);

        $response->assertCreated();
        $response->assertJsonPath('data.rank', Employee::RANK_MM);
        $response->assertJsonPath('data.branch_id', $branch->id);
        $this->assertDatabaseHas('employees', [
            'user_id' => $user->id,
            'agent_id' => $agent->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_MM,
        ]);
    }

    public function test_admin_can_update_employee_rank_and_branch(): void
    {
        $this->actingAsAdmin();

        $branch = Branch::create([
            'name' => 'Chattogram',
            'code' => 'CTG',
            'address' => 'Chattogram',
        ]);

        $user = User::factory()->create([
            'role' => User::ROLE_EMPLOYEE,
        ]);

        $agent = Agent::create([
            'user_id' => $user->id,
            'branch_id' => $branch->id,
            'agent_code' => Str::uuid()->toString(),
        ]);

        $employee = Employee::create([
            'user_id' => $user->id,
            'branch_id' => $branch->id,
            'agent_id' => $agent->id,
            'rank' => Employee::RANK_ME,
        ]);

        $response = $this->patchJson('/api/v1/employees/' . $employee->id, [
            'rank' => Employee::RANK_DGM,
        ]);

        $response->assertOk();
        $response->assertJsonPath('data.rank', Employee::RANK_DGM);
        $this->assertDatabaseHas('employees', [
            'id' => $employee->id,
            'rank' => Employee::RANK_DGM,
        ]);
    }

    public function test_employee_listing_can_be_filtered_by_rank(): void
    {
        $this->actingAsAdmin();

        $branch = Branch::create([
            'name' => 'Sylhet',
            'code' => 'SYL',
            'address' => 'Sylhet',
        ]);

        $userMm = User::factory()->create();
        $agentMm = Agent::create([
            'user_id' => $userMm->id,
            'branch_id' => $branch->id,
            'agent_code' => Str::uuid()->toString(),
        ]);
        Employee::create([
            'user_id' => $userMm->id,
            'branch_id' => $branch->id,
            'agent_id' => $agentMm->id,
            'rank' => Employee::RANK_MM,
        ]);

        $userMe = User::factory()->create();
        $agentMe = Agent::create([
            'user_id' => $userMe->id,
            'branch_id' => $branch->id,
            'agent_code' => Str::uuid()->toString(),
        ]);
        Employee::create([
            'user_id' => $userMe->id,
            'branch_id' => $branch->id,
            'agent_id' => $agentMe->id,
            'rank' => Employee::RANK_ME,
        ]);

        $response = $this->getJson('/api/v1/employees?rank=' . Employee::RANK_MM);

        $response->assertOk();
        $this->assertSame(1, $response->json('total'));
        $this->assertSame(Employee::RANK_MM, $response->json('data.0.rank'));
    }

    public function test_superior_listing_returns_next_rank_employees(): void
    {
        $this->actingAsAdmin();

        $branch = Branch::create([
            'name' => 'Khulna',
            'code' => 'KHL',
            'address' => 'Khulna',
        ]);

        $mmUser = User::factory()->create();
        $mmAgent = Agent::create([
            'user_id' => $mmUser->id,
            'branch_id' => $branch->id,
            'agent_code' => Str::uuid()->toString(),
        ]);
        $mmEmployee = Employee::create([
            'user_id' => $mmUser->id,
            'branch_id' => $branch->id,
            'agent_id' => $mmAgent->id,
            'rank' => Employee::RANK_MM,
            'employee_code' => Str::uuid()->toString(),
            'full_name_en' => 'MM Employee',
        ]);

        $meUser = User::factory()->create();
        $meAgent = Agent::create([
            'user_id' => $meUser->id,
            'branch_id' => $branch->id,
            'agent_code' => Str::uuid()->toString(),
        ]);
        Employee::create([
            'user_id' => $meUser->id,
            'branch_id' => $branch->id,
            'agent_id' => $meAgent->id,
            'rank' => Employee::RANK_ME,
            'employee_code' => Str::uuid()->toString(),
            'full_name_en' => 'ME Employee',
        ]);

        $response = $this->getJson('/api/v1/employees/superiors?rank=' . Employee::RANK_ME);

        $response->assertOk();
        $this->assertSame($mmEmployee->id, $response->json('data.0.id'));
        $this->assertSame(Employee::RANK_MM, $response->json('data.0.rank'));
    }

    public function test_superior_listing_returns_empty_for_highest_rank(): void
    {
        $this->actingAsAdmin();

        $branch = Branch::create([
            'name' => 'Barishal',
            'code' => 'BAR',
            'address' => 'Barishal',
        ]);

        $hdUser = User::factory()->create();
        $hdAgent = Agent::create([
            'user_id' => $hdUser->id,
            'branch_id' => $branch->id,
            'agent_code' => Str::uuid()->toString(),
        ]);
        Employee::create([
            'user_id' => $hdUser->id,
            'branch_id' => $branch->id,
            'agent_id' => $hdAgent->id,
            'rank' => Employee::RANK_DIR,
            'employee_code' => Str::uuid()->toString(),
            'full_name_en' => 'Director Employee',
        ]);

        $response = $this->getJson('/api/v1/employees/superiors?rank=' . Employee::RANK_DIR);

        $response->assertOk();
        $this->assertSame([], $response->json('data'));
    }
}
