<?php

namespace Tests\Feature;

use App\Models\Employee;
use App\Models\Rank;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Str;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class RankManagementTest extends TestCase
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

    public function test_admin_can_create_rank_with_automatic_sort_order(): void
    {
        $this->actingAsAdmin();

        Rank::factory()->create(['sort_order' => 3]);

        $response = $this->postJson('/api/v1/ranks', [
            'name' => 'National Director',
            'code' => 'nd',
            'description' => 'Top leadership rank',
        ]);

        $response->assertCreated();
        $response->assertJsonPath('data.code', 'ND');
        $response->assertJsonPath('data.sort_order', 4);
        $this->assertDatabaseHas('ranks', [
            'name' => 'National Director',
            'code' => 'ND',
            'description' => 'Top leadership rank',
            'sort_order' => 4,
        ]);
    }

    public function test_admin_can_filter_ranks_by_code(): void
    {
        $this->actingAsAdmin();

        Rank::factory()->count(2)->create();
        $target = Rank::factory()->create([
            'name' => 'Marketing Executive',
            'code' => 'ME',
            'sort_order' => 1,
        ]);

        $response = $this->getJson('/api/v1/ranks?code=me');

        $response->assertOk();
        $response->assertJsonPath('data.0.id', $target->id);
        $response->assertJsonCount(1, 'data');
    }

    public function test_admin_can_update_rank(): void
    {
        $this->actingAsAdmin();

        $rank = Rank::factory()->create([
            'name' => 'Marketing Executive',
            'code' => 'ME',
        ]);

        $response = $this->putJson("/api/v1/ranks/{$rank->id}", [
            'name' => 'Marketing Manager',
            'code' => 'mm',
            'sort_order' => 10,
        ]);

        $response->assertOk();
        $response->assertJsonPath('data.name', 'Marketing Manager');
        $response->assertJsonPath('data.code', 'MM');
        $response->assertJsonPath('data.sort_order', 10);
        $this->assertDatabaseHas('ranks', [
            'id' => $rank->id,
            'name' => 'Marketing Manager',
            'code' => 'MM',
            'sort_order' => 10,
        ]);
    }

    public function test_rank_cannot_be_deleted_when_in_use(): void
    {
        $this->actingAsAdmin();

        $rank = Rank::factory()->create([
            'code' => 'ME',
        ]);

        $user = User::factory()->create([
            'role' => User::ROLE_EMPLOYEE,
        ]);

        Employee::create([
            'user_id' => $user->id,
            'employee_code' => Str::uuid()->toString(),
            'full_name_en' => 'Test Employee',
            'rank' => $rank->code,
        ]);

        $response = $this->deleteJson("/api/v1/ranks/{$rank->id}");

        $response->assertStatus(422);
        $response->assertJsonFragment([
            'message' => 'Rank cannot be deleted while it is in use.',
        ]);
        $this->assertDatabaseHas('ranks', ['id' => $rank->id]);
    }

    public function test_rank_can_be_deleted_when_unused(): void
    {
        $this->actingAsAdmin();

        $rank = Rank::factory()->create([
            'code' => 'TMP',
        ]);

        $response = $this->deleteJson("/api/v1/ranks/{$rank->id}");

        $response->assertNoContent();
        $this->assertDatabaseMissing('ranks', ['id' => $rank->id]);
    }
}
