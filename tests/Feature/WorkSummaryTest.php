<?php

namespace Tests\Feature;

use App\Models\Employee;
use App\Models\User;
use App\Models\WorkSummary;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class WorkSummaryTest extends TestCase
{
    use RefreshDatabase;

    public function test_employee_can_submit_daily_summary(): void
    {
        $user = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $employee = Employee::create([
            'user_id' => $user->id,
            'employee_code' => 'ME-100',
            'rank' => Employee::RANK_ME,
            'full_name_en' => 'Summary Employee',
            'mobile' => '01700000100',
        ]);

        Sanctum::actingAs($user);

        $payload = [
            'type' => 'daily',
            'report_date' => '2025-12-23',
            'today_sales_amount' => 50000,
            'remarks' => 'Good day',
            'sections' => [
                'products_discussion' => [
                    [
                        'name' => 'Rahim',
                        'mobile' => '01700000101',
                        'products' => 'Flat A',
                        'project' => 'Alhamra Garden',
                        'place' => 'Dhaka',
                    ],
                ],
                'office_visit' => [],
                'project_visit' => [],
                'business_meeting' => [],
            ],
        ];

        $response = $this->postJson('/api/v1/work-summaries', $payload);

        $response->assertCreated();
        $this->assertDatabaseHas('work_summaries', [
            'employee_id' => $employee->id,
            'type' => WorkSummary::TYPE_DAILY,
            'report_date' => '2025-12-23',
        ]);

        $summary = WorkSummary::first();
        $this->assertNotNull($summary->submitted_at);
        $this->assertSame('Rahim', $summary->sections['products_discussion'][0]['name']);
    }

    public function test_employee_cannot_submit_duplicate_daily_summary(): void
    {
        $user = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $employee = Employee::create([
            'user_id' => $user->id,
            'employee_code' => 'ME-101',
            'rank' => Employee::RANK_ME,
            'full_name_en' => 'Duplicate Employee',
            'mobile' => '01700000102',
        ]);

        WorkSummary::create([
            'employee_id' => $employee->id,
            'type' => WorkSummary::TYPE_DAILY,
            'report_date' => '2025-12-24',
            'today_sales_amount' => 0,
            'sections' => [],
            'submitted_at' => now(),
        ]);

        Sanctum::actingAs($user);

        $response = $this->postJson('/api/v1/work-summaries', [
            'type' => 'daily',
            'report_date' => '2025-12-24',
        ]);

        $response->assertUnprocessable();
    }

    public function test_admin_can_view_all_summaries_with_employee_name(): void
    {
        $employeeUser = User::factory()->create([
            'role' => User::ROLE_EMPLOYEE,
            'name' => 'Summary User',
        ]);
        $employee = Employee::create([
            'user_id' => $employeeUser->id,
            'employee_code' => 'ME-102',
            'rank' => Employee::RANK_ME,
            'full_name_en' => 'Summary User',
            'mobile' => '01700000103',
        ]);

        WorkSummary::create([
            'employee_id' => $employee->id,
            'type' => WorkSummary::TYPE_WEEKLY,
            'week_start' => '2025-12-16',
            'week_end' => '2025-12-23',
            'today_sales_amount' => 0,
            'sections' => [],
            'submitted_at' => now(),
        ]);

        $adminUser = User::factory()->create(['role' => User::ROLE_ADMIN]);
        Sanctum::actingAs($adminUser);

        $response = $this->getJson('/api/v1/admin/work-summaries');

        $response->assertOk();
        $this->assertSame('Summary User', $response->json('data.0.employee_name'));
    }
}
