<?php

namespace Tests\Feature;

use App\Models\Branch;
use App\Models\Employee;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class EmployeeTreeControllerTest extends TestCase
{
    use RefreshDatabase;

    public function test_employee_tree_returns_mobile_for_team_nodes(): void
    {
        $admin = User::factory()->create([
            'role' => User::ROLE_ADMIN,
        ]);

        Sanctum::actingAs($admin);

        $branch = Branch::create([
            'name' => 'Dhaka',
            'code' => 'DHK',
            'address' => 'Dhaka',
        ]);

        $rootUser = User::factory()->create([
            'role' => User::ROLE_EMPLOYEE,
            'name' => 'Root Employee',
        ]);

        $root = Employee::create([
            'user_id' => $rootUser->id,
            'branch_id' => $branch->id,
            'employee_code' => 'EMP-ROOT-001',
            'full_name_en' => 'Root Employee',
            'rank' => Employee::RANK_MM,
        ]);

        $childUser = User::factory()->create([
            'role' => User::ROLE_EMPLOYEE,
            'name' => 'Child Employee',
        ]);

        $child = Employee::create([
            'user_id' => $childUser->id,
            'branch_id' => $branch->id,
            'superior_id' => $root->id,
            'employee_code' => 'EMP-CHILD-001',
            'full_name_en' => 'Child Employee',
            'mobile' => '01700000000',
            'rank' => Employee::RANK_ME,
        ]);

        $response = $this->getJson('/api/v1/employees/tree?root_employee_id=' . $root->id . '&max_depth=1');

        $response->assertOk();
        $response->assertJsonPath('nodes.0.id', $child->id);
        $response->assertJsonPath('nodes.0.mobile', '01700000000');
    }
}
