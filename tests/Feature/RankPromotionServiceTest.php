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

    public function test_it_does_not_downgrade_existing_higher_rank_employee_when_requirements_start_from_me(): void
    {
        CommissionSetting::create(['key' => 'share_value', 'value' => 50000]);

        RankRequirement::insert([
            $this->requirement(Employee::RANK_ME, 1),
            $this->requirement(Employee::RANK_MM, 2),
            $this->requirement(Employee::RANK_AGM, 3),
            $this->requirement(Employee::RANK_DGM, 4),
        ]);

        $employee = $this->createEmployee('agm@alhamra.test', Employee::RANK_AGM);

        app(RankPromotionService::class)->evaluateEmployee($employee->fresh());

        $this->assertSame(Employee::RANK_AGM, $employee->fresh()->rank);
    }


    public function test_it_counts_higher_ranks_towards_gm_target_for_director_promotions(): void
    {
        CommissionSetting::create(['key' => 'share_value', 'value' => 50000]);
        CommissionSetting::create([
            'key' => 'director_rank_settings',
            'value' => [
                'ed' => ['share_target' => 0, 'gm_target' => 2],
            ],
        ]);

        RankRequirement::insert([
            $this->requirement(Employee::RANK_PD, 1),
            $this->requirement(Employee::RANK_ED, 2),
        ]);

        $employee = $this->createEmployee('pd-candidate@alhamra.test', Employee::RANK_PD);

        $this->createEmployee('direct-gm@alhamra.test', Employee::RANK_GM, $employee->id);
        $this->createEmployee('direct-dmd@alhamra.test', Employee::RANK_DMD, $employee->id);

        app(RankPromotionService::class)->evaluateEmployee($employee->fresh());

        $this->assertSame(Employee::RANK_ED, $employee->fresh()->rank);
    }

    public function test_it_counts_higher_direct_ranks_towards_lower_rank_requirements(): void
    {
        CommissionSetting::create(['key' => 'share_value', 'value' => 50000]);

        RankRequirement::insert([
            $this->requirement(Employee::RANK_ME, 1),
            $this->requirement(Employee::RANK_MM, 2),
            $this->requirement(Employee::RANK_AGM, 3),
            $this->requirement(Employee::RANK_DGM, 4, ['direct_mm_required' => 3]),
        ]);

        $employee = $this->createEmployee('candidate@alhamra.test', Employee::RANK_AGM);

        $this->createEmployee('direct-mm@alhamra.test', Employee::RANK_MM, $employee->id);
        $this->createEmployee('direct-agm@alhamra.test', Employee::RANK_AGM, $employee->id);
        $this->createEmployee('direct-dgm@alhamra.test', Employee::RANK_DGM, $employee->id);

        app(RankPromotionService::class)->evaluateEmployee($employee->fresh());

        $this->assertSame(Employee::RANK_DGM, $employee->fresh()->rank);
    }

    private function requirement(string $rank, int $sequence, array $meta = []): array
    {
        return [
            'rank' => $rank,
            'sequence' => $sequence,
            'personal_sales_target' => 0,
            'bonus_down_payment' => 0,
            'bonus_installment' => 0,
            'direct_required' => 0,
            'meta' => json_encode(array_merge(['shares_required' => 0], $meta)),
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
