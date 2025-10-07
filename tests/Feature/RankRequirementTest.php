<?php

namespace Tests\Feature;

use App\Models\RankRequirement;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class RankRequirementTest extends TestCase
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

    public function test_rank_requirement_can_be_created(): void
    {
        $this->actingAsAdmin();

        $response = $this->postJson('/api/v1/rank-requirements', [
            'rank' => 'MM',
            'sequence' => 2,
            'personal_sales_target' => 100000,
            'bonus_down_payment' => 5,
            'bonus_installment' => 2,
            'direct_required' => 0,
        ]);

        $response->assertCreated();
        $response->assertJsonPath('data.rank', 'MM');
        $this->assertDatabaseHas('rank_requirements', [
            'rank' => 'MM',
            'sequence' => 2,
        ]);
    }

    public function test_rank_requirement_can_be_updated(): void
    {
        $this->actingAsAdmin();

        $requirement = RankRequirement::create([
            'rank' => 'MM',
            'sequence' => 2,
            'personal_sales_target' => 100000,
            'bonus_down_payment' => 5,
            'bonus_installment' => 2,
            'direct_required' => 0,
        ]);

        $response = $this->patchJson('/api/v1/rank-requirements/' . $requirement->id, [
            'bonus_down_payment' => 7.5,
        ]);

        $response->assertOk();
        $this->assertDatabaseHas('rank_requirements', [
            'id' => $requirement->id,
            'bonus_down_payment' => 7.5,
        ]);
    }

    public function test_rank_requirement_listing_returns_ordered_data(): void
    {
        $this->actingAsAdmin();

        RankRequirement::create([
            'rank' => 'ME',
            'sequence' => 1,
            'personal_sales_target' => 50000,
            'bonus_down_payment' => 3,
            'bonus_installment' => 1,
            'direct_required' => 0,
        ]);

        RankRequirement::create([
            'rank' => 'MM',
            'sequence' => 2,
            'personal_sales_target' => 100000,
            'bonus_down_payment' => 5,
            'bonus_installment' => 2,
            'direct_required' => 0,
        ]);

        $response = $this->getJson('/api/v1/rank-requirements');

        $response->assertOk();
        $this->assertSame('ME', $response->json('data.0.rank'));
        $this->assertSame('MM', $response->json('data.1.rank'));
    }
}
