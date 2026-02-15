<?php

namespace Tests\Feature;

use App\Models\CommissionSetting;
use App\Models\Employee;
use App\Models\RankRequirement;
use App\Models\SalesOrder;
use App\Models\User;
use App\Services\RankPromotionService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class RankPromotionServiceTest extends TestCase
{
    use RefreshDatabase;

    public function test_it_applies_director_rank_settings_with_vc_alias_and_flexible_keys(): void
    {
        CommissionSetting::create(['key' => 'share_value', 'value' => 50000]);
        CommissionSetting::create([
            'key' => 'director_rank_settings',
            'value' => [
                'ed' => ['share' => 10, 'gm' => 2],
                'amd' => ['share' => 12, 'gm' => 3],
                'dmd' => ['share' => 8, 'gm' => 4],
                'vc' => ['share' => 8, 'gm' => 5],
            ],
        ]);

        RankRequirement::insert([
            $this->requirement(Employee::RANK_PD, 1),
            $this->requirement(Employee::RANK_ED, 2),
            $this->requirement(Employee::RANK_DMD, 3),
            $this->requirement(Employee::RANK_DIR, 4),
        ]);

        $employee = $this->createEmployee('lead@alhamra.test', Employee::RANK_PD);
        $this->createEmployee('gm1@alhamra.test', Employee::RANK_GM, $employee->id);
        $this->createEmployee('gm2@alhamra.test', Employee::RANK_GM, $employee->id);

        $customer = User::factory()->create();

        SalesOrder::create([
            'customer_id' => $customer->id,
            'employee_id' => $employee->id,
            'source_me_id' => $employee->id,
            'down_payment' => 500000,
            'total' => 500000,
            'status' => SalesOrder::STATUS_ACTIVE,
            'created_by' => SalesOrder::CREATED_BY_SYSTEM,
        ]);

        app(RankPromotionService::class)->evaluateEmployee($employee->fresh());

        $this->assertSame(Employee::RANK_ED, $employee->fresh()->rank);
    }

    private function requirement(string $rank, int $sequence): array
    {
        return [
            'rank' => $rank,
            'sequence' => $sequence,
            'personal_sales_target' => 0,
            'bonus_down_payment' => 0,
            'bonus_installment' => 0,
            'direct_required' => 0,
            'meta' => json_encode(['shares_required' => 0]),
            'created_at' => now(),
            'updated_at' => now(),
        ];
    }

    private function createEmployee(string $email, string $rank, ?int $superiorId = null): Employee
    {
        $user = User::factory()->create(['email' => $email]);

        return Employee::create([
            'user_id' => $user->id,
            'employee_code' => 'EMP-'.$user->id,
            'full_name_en' => $user->name,
            'rank' => $rank,
            'superior_id' => $superiorId,
        ]);
    }
}
