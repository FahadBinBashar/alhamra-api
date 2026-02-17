<?php

namespace Tests\Feature;

use App\Models\Announcement;
use App\Models\Employee;
use App\Models\Rank;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class AnnouncementFeatureTest extends TestCase
{
    use RefreshDatabase;

    private Rank $meRank;
    private Rank $mmRank;
    private Rank $dirRank;

    protected function setUp(): void
    {
        parent::setUp();

        $this->meRank = Rank::create(['name' => 'Marketing Executive', 'code' => Employee::RANK_ME, 'sort_order' => 1]);
        $this->mmRank = Rank::create(['name' => 'Marketing Manager', 'code' => Employee::RANK_MM, 'sort_order' => 2]);
        $this->dirRank = Rank::create(['name' => 'Director', 'code' => Employee::RANK_DIR, 'sort_order' => 10]);
    }

    public function test_admin_can_create_rank_wise_announcement_and_targets_only_selected_ranks(): void
    {
        $admin = User::factory()->create(['role' => User::ROLE_ADMIN]);

        $meUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        Employee::create([
            'user_id' => $meUser->id,
            'employee_code' => 'ME-100',
            'rank' => Employee::RANK_ME,
            'full_name_en' => 'ME User',
            'mobile' => '01710000001',
        ]);

        $mmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        Employee::create([
            'user_id' => $mmUser->id,
            'employee_code' => 'MM-100',
            'rank' => Employee::RANK_MM,
            'full_name_en' => 'MM User',
            'mobile' => '01710000002',
        ]);

        Sanctum::actingAs($admin);

        $response = $this->postJson('/api/v1/announcements', [
            'title' => 'Manager Update',
            'message' => 'Only manager level update',
            'target_type' => Announcement::TARGET_RANK_WISE,
            'target_ranks' => [$this->mmRank->id],
        ]);

        $response->assertCreated();

        $announcementId = $response->json('data.id');

        $this->assertDatabaseHas('announcements', [
            'id' => $announcementId,
            'target_type' => Announcement::TARGET_RANK_WISE,
        ]);

        $this->assertDatabaseHas('announcement_user', [
            'announcement_id' => $announcementId,
            'user_id' => $mmUser->id,
            'is_read' => false,
        ]);

        $this->assertDatabaseMissing('announcement_user', [
            'announcement_id' => $announcementId,
            'user_id' => $meUser->id,
        ]);
    }

    public function test_employee_can_list_and_mark_announcement_as_read(): void
    {
        $admin = User::factory()->create(['role' => User::ROLE_ADMIN]);
        $employeeUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);

        Employee::create([
            'user_id' => $employeeUser->id,
            'employee_code' => 'MM-200',
            'rank' => Employee::RANK_MM,
            'full_name_en' => 'MM Employee',
            'mobile' => '01710000003',
        ]);

        Sanctum::actingAs($admin);

        $createResponse = $this->postJson('/api/v1/announcements', [
            'title' => 'All Hands',
            'message' => 'For all employees',
            'target_type' => Announcement::TARGET_ALL,
        ])->assertCreated();

        $announcementId = $createResponse->json('data.id');

        Sanctum::actingAs($employeeUser);

        $listResponse = $this->getJson('/api/v1/employees/dashboard/announcements');
        $listResponse->assertOk();
        $this->assertSame($announcementId, $listResponse->json('data.0.id'));
        $this->assertFalse($listResponse->json('data.0.is_read'));

        $countResponse = $this->getJson('/api/v1/employees/dashboard/announcements/unread-count');
        $countResponse->assertOk()->assertJson(['unread_count' => 1]);

        $this->postJson('/api/v1/employees/dashboard/announcements/' . $announcementId . '/read')
            ->assertOk();

        $this->assertDatabaseHas('announcement_user', [
            'announcement_id' => $announcementId,
            'user_id' => $employeeUser->id,
            'is_read' => true,
        ]);
    }

    public function test_employee_cannot_access_admin_announcement_listing(): void
    {
        $employeeUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);

        Sanctum::actingAs($employeeUser);

        $this->getJson('/api/v1/announcements')->assertForbidden();
    }
}
