<?php

namespace Tests\Feature;

use App\Models\Employee;
use App\Models\EmployeeRecruitRequest;
use App\Models\Rank;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Notification;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class EmployeeRecruitRequestTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        Rank::create(['name' => 'Marketing Executive', 'code' => Employee::RANK_ME, 'sort_order' => 1]);
        Rank::create(['name' => 'Marketing Manager', 'code' => Employee::RANK_MM, 'sort_order' => 2]);
    }

    public function test_only_mm_and_above_can_submit_request(): void
    {
        $meUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $meEmployee = Employee::create([
            'user_id' => $meUser->id,
            'employee_code' => 'ME-001',
            'rank' => Employee::RANK_ME,
            'full_name_en' => 'Junior Employee',
            'mobile' => '01700000000',
        ]);

        Sanctum::actingAs($meUser);

        $response = $this->postJson('/api/v1/employee-recruit-requests', [
            'full_name_en' => 'Requested Executive',
            'email' => 'candidate@example.com',
            'mobile' => '01700000001',
        ]);

        $response->assertForbidden();

        $mmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $mmEmployee = Employee::create([
            'user_id' => $mmUser->id,
            'employee_code' => 'MM-001',
            'rank' => Employee::RANK_MM,
            'full_name_en' => 'Manager',
            'mobile' => '01700000002',
        ]);

        Sanctum::actingAs($mmUser);

        $response = $this->postJson('/api/v1/employee-recruit-requests', [
            'full_name_en' => 'Requested Executive',
            'email' => 'candidate2@example.com',
            'mobile' => '01700000003',
        ]);

        $response->assertCreated();
        $this->assertDatabaseHas('employee_recruit_requests', [
            'requested_by_employee_id' => $mmEmployee->id,
            'status' => EmployeeRecruitRequest::STATUS_PENDING,
        ]);
    }

    public function test_admin_can_approve_request_and_create_employee(): void
    {
        Notification::fake();

        $mmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $mmEmployee = Employee::create([
            'user_id' => $mmUser->id,
            'employee_code' => 'MM-002',
            'rank' => Employee::RANK_MM,
            'full_name_en' => 'Manager Two',
            'mobile' => '01700000004',
        ]);

        Sanctum::actingAs($mmUser);

        $storeResponse = $this->postJson('/api/v1/employee-recruit-requests', [
            'full_name_en' => 'Candidate Approve',
            'email' => 'approve@example.com',
            'mobile' => '01700000005',
        ])->assertCreated();

        $recruitRequest = EmployeeRecruitRequest::first();

        $adminUser = User::factory()->create(['role' => User::ROLE_ADMIN]);
        Sanctum::actingAs($adminUser);

        $approveResponse = $this->postJson('/api/v1/employee-recruit-requests/' . $recruitRequest->id . '/approve');

        $approveResponse->assertOk();

        $recruitRequest->refresh();

        $this->assertSame(EmployeeRecruitRequest::STATUS_APPROVED, $recruitRequest->status);
        $this->assertNotNull($recruitRequest->created_employee_id);

        $createdEmployee = Employee::find($recruitRequest->created_employee_id);
        $this->assertNotNull($createdEmployee);
        $this->assertSame(Employee::RANK_ME, $createdEmployee->rank);
        $this->assertSame('approve@example.com', $createdEmployee->user->email);
    }

    public function test_admin_can_reject_request(): void
    {
        $mmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $mmEmployee = Employee::create([
            'user_id' => $mmUser->id,
            'employee_code' => 'MM-003',
            'rank' => Employee::RANK_MM,
            'full_name_en' => 'Manager Three',
            'mobile' => '01700000006',
        ]);

        Sanctum::actingAs($mmUser);

        $this->postJson('/api/v1/employee-recruit-requests', [
            'full_name_en' => 'Candidate Reject',
            'email' => 'reject@example.com',
            'mobile' => '01700000007',
        ])->assertCreated();

        $recruitRequest = EmployeeRecruitRequest::first();

        $adminUser = User::factory()->create(['role' => User::ROLE_ADMIN]);
        Sanctum::actingAs($adminUser);

        $response = $this->postJson('/api/v1/employee-recruit-requests/' . $recruitRequest->id . '/reject', [
            'rejection_reason' => 'Incomplete documents',
        ]);

        $response->assertOk();

        $recruitRequest->refresh();

        $this->assertSame(EmployeeRecruitRequest::STATUS_REJECTED, $recruitRequest->status);
        $this->assertSame('Incomplete documents', $recruitRequest->rejection_reason);
        $this->assertSame($adminUser->id, $recruitRequest->reviewed_by_user_id);
    }

    public function test_employee_can_view_their_own_requests(): void
    {
        $mmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $mmEmployee = Employee::create([
            'user_id' => $mmUser->id,
            'employee_code' => 'MM-004',
            'rank' => Employee::RANK_MM,
            'full_name_en' => 'Manager Four',
            'mobile' => '01700000008',
        ]);

        $otherUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $otherEmployee = Employee::create([
            'user_id' => $otherUser->id,
            'employee_code' => 'MM-005',
            'rank' => Employee::RANK_MM,
            'full_name_en' => 'Manager Five',
            'mobile' => '01700000009',
        ]);

        EmployeeRecruitRequest::create([
            'requested_by_employee_id' => $mmEmployee->id,
            'data' => [
                'full_name_en' => 'Candidate Own',
                'email' => 'own@example.com',
                'mobile' => '01700000010',
                'rank' => Employee::RANK_ME,
            ],
            'status' => EmployeeRecruitRequest::STATUS_PENDING,
        ]);

        EmployeeRecruitRequest::create([
            'requested_by_employee_id' => $otherEmployee->id,
            'data' => [
                'full_name_en' => 'Candidate Other',
                'email' => 'other@example.com',
                'mobile' => '01700000011',
                'rank' => Employee::RANK_ME,
            ],
            'status' => EmployeeRecruitRequest::STATUS_PENDING,
        ]);

        Sanctum::actingAs($mmUser);

        $response = $this->getJson('/api/v1/employee-recruit-requests');

        $response->assertOk();
        $this->assertCount(1, $response->json('data'));
        $this->assertSame($mmEmployee->id, $response->json('data.0.requested_by_employee_id'));
    }
}
