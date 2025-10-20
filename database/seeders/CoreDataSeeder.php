<?php

namespace Database\Seeders;

use App\Models\Branch;
use App\Models\Category;
use App\Models\CommissionRule;
use App\Models\CommissionSetting;
use App\Models\LedgerAccount;
use App\Models\Rank;
use App\Models\RankRequirement;
use Illuminate\Database\Seeder;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Config;

class CoreDataSeeder extends Seeder
{
    public function run(): void
    {
        $this->seedBranches();
        $this->seedCategories();
        $this->seedRanks();
        $this->seedRankRequirements();
        $this->seedLedgerAccounts();
        $this->seedCommissionSettings();
        $this->seedCommissionRules();
    }

    private function seedCommissionSettings(): void
    {
        $settings = [
            'share_value' => 500000,
            'agent_rates' => [
                'down_payment' => 5,
                'installment' => 1,
            ],
            'branch_rates' => [
                'down_payment' => 5,
                'installment' => 1,
            ],
            'development_bonus' => [
                'MM' => [
                    'down_payment' => 15,
                    'installment' => 5,
                ],
                'AGM' => [
                    'down_payment' => 18,
                    'installment' => 6,
                ],
                'DGM' => [
                    'down_payment' => 25,
                    'installment' => 9,
                ],
                'GM' => [
                    'down_payment' => 30,
                    'installment' => 11,
                ],
            ],
            'monthly_incentives' => [
                'MM' => 10000,
                'AGM' => 20000,
                'DGM' => 40000,
                'GM' => 100000,
                'PD' => 200000,
                'ED' => 200000,
                'DMD' => 200000,
                'DIR' => 200000,
            ],
            'director_fund' => [
                'PD' => [
                    'percentage' => 2,
                    'frequency' => 'quarterly',
                ],
                'ED' => [
                    'percentage' => 2,
                    'frequency' => 'half_yearly',
                ],
                'DMD' => [
                    'percentage' => 1,
                    'frequency' => 'yearly',
                ],
                'DIR' => [
                    'percentage' => 20,
                    'per_person_share' => 1,
                ],
            ],
            'service_sales' => [
                'percentage' => 15,
            ],
        ];

        foreach ($settings as $key => $value) {
            CommissionSetting::updateOrCreate(
                ['key' => $key],
                ['value' => $value]
            );
        }
    }

    private function seedBranches(): void
    {
        $branches = [
            [
                'code' => 'DHK-HQ',
                'name' => 'Dhaka Head Office',
                'address' => 'Level 12, Al-Hamra Tower, Gulshan-2, Dhaka',
            ],
            [
                'code' => 'CTG-CEN',
                'name' => 'Chattogram Central',
                'address' => 'Bayazid Bostami Road, Chattogram',
            ],
            [
                'code' => 'SYL-HILL',
                'name' => 'Sylhet Hill View',
                'address' => 'Zindabazar, Sylhet',
            ],
        ];

        foreach ($branches as $branch) {
            Branch::updateOrCreate(
                ['code' => $branch['code']],
                Arr::only($branch, ['name', 'address'])
            );
        }
    }

    private function seedCategories(): void
    {
        $categories = [
            ['name' => 'Land & Plot', 'type' => 'product'],
            ['name' => 'Residential Apartment', 'type' => 'product'],
            ['name' => 'Construction Material', 'type' => 'product'],
            ['name' => 'Share Investment', 'type' => 'product'],
            ['name' => 'Hospitality Service', 'type' => 'service'],
            ['name' => 'Healthcare Service', 'type' => 'service'],
            ['name' => 'Transport Logistics', 'type' => 'service'],
            ['name' => 'Hajj & Umrah Package', 'type' => 'service'],
            ['name' => 'Tourism Package', 'type' => 'service'],
        ];

        foreach ($categories as $category) {
            Category::updateOrCreate(
                ['name' => $category['name'], 'type' => $category['type']],
                []
            );
        }
    }

    private function seedRanks(): void
    {
        $ranks = [
            ['code' => 'ME', 'name' => 'Marketing Executive', 'sort_order' => 1],
            ['code' => 'MM', 'name' => 'Marketing Manager', 'sort_order' => 2],
            ['code' => 'AGM', 'name' => 'Assistant General Manager', 'sort_order' => 3],
            ['code' => 'DGM', 'name' => 'Deputy General Manager', 'sort_order' => 4],
            ['code' => 'GM', 'name' => 'General Manager', 'sort_order' => 5],
            ['code' => 'PD', 'name' => 'Project Director', 'sort_order' => 6],
            ['code' => 'ED', 'name' => 'Executive Director', 'sort_order' => 7],
            ['code' => 'DMD', 'name' => 'Deputy Managing Director', 'sort_order' => 8],
            ['code' => 'DIR', 'name' => 'Director', 'sort_order' => 9],
        ];

        foreach ($ranks as $rank) {
            Rank::updateOrCreate(
                ['code' => $rank['code']],
                Arr::except($rank, ['code'])
            );
        }

        Rank::whereNotIn('code', array_column($ranks, 'code'))->delete();
    }

    private function seedRankRequirements(): void
    {
        $ranks = [
            [
                'rank' => 'ME',
                'sequence' => 1,
                'personal_sales_target' => 0,
                'bonus_down_payment' => 0,
                'bonus_installment' => 0,
                'direct_required' => 0,
                'meta' => [
                    'shares_required' => 0,
                    'share_value' => 500000,
                    'minimum_share_per_period' => 1,
                    'period_months' => 4,
                ],
            ],
            [
                'rank' => 'MM',
                'sequence' => 2,
                'personal_sales_target' => 500000,
                'bonus_down_payment' => 15,
                'bonus_installment' => 5,
                'direct_required' => 0,
                'meta' => [
                    'shares_required' => 1,
                    'minimum_share_per_period' => 1,
                    'period_months' => 4,
                    'monthly_incentive' => 10000,
                ],
            ],
            [
                'rank' => 'AGM',
                'sequence' => 3,
                'personal_sales_target' => 1000000,
                'bonus_down_payment' => 18,
                'bonus_installment' => 6,
                'direct_required' => 0,
                'meta' => [
                    'shares_required' => 3,
                    'minimum_share_per_period' => 1,
                    'period_months' => 4,
                    'monthly_incentive' => 20000,
                ],
            ],
            [
                'rank' => 'DGM',
                'sequence' => 4,
                'personal_sales_target' => 1500000,
                'bonus_down_payment' => 25,
                'bonus_installment' => 9,
                'direct_required' => 0,
                'meta' => [
                    'shares_required' => 6,
                    'minimum_share_per_period' => 1,
                    'period_months' => 4,
                    'monthly_incentive' => 40000,
                ],
            ],
            [
                'rank' => 'GM',
                'sequence' => 5,
                'personal_sales_target' => 2000000,
                'bonus_down_payment' => 30,
                'bonus_installment' => 11,
                'direct_required' => 0,
                'meta' => [
                    'shares_required' => 10,
                    'minimum_share_per_period' => 1,
                    'period_months' => 4,
                    'monthly_incentive' => 100000,
                ],
            ],
            [
                'rank' => 'PD',
                'sequence' => 6,
                'personal_sales_target' => 2500000,
                'bonus_down_payment' => 30,
                'bonus_installment' => 11,
                'direct_required' => 0,
                'meta' => [
                    'shares_required' => 12,
                    'direct_mm_required' => 12,
                    'minimum_share_per_period' => 1,
                    'period_months' => 4,
                    'fund_percentage' => 2,
                ],
            ],
            [
                'rank' => 'ED',
                'sequence' => 7,
                'personal_sales_target' => 3000000,
                'bonus_down_payment' => 30,
                'bonus_installment' => 11,
                'direct_required' => 0,
                'meta' => [
                    'shares_required' => 18,
                    'direct_mm_required' => 25,
                    'minimum_share_per_period' => 1,
                    'period_months' => 4,
                    'fund_percentage' => 2,
                ],
            ],
            [
                'rank' => 'DMD',
                'sequence' => 8,
                'personal_sales_target' => 3500000,
                'bonus_down_payment' => 30,
                'bonus_installment' => 11,
                'direct_required' => 0,
                'meta' => [
                    'shares_required' => 24,
                    'direct_mm_required' => 40,
                    'minimum_share_per_period' => 1,
                    'period_months' => 4,
                    'fund_percentage' => 1,
                ],
            ],
            [
                'rank' => 'DIR',
                'sequence' => 9,
                'personal_sales_target' => 4000000,
                'bonus_down_payment' => 30,
                'bonus_installment' => 11,
                'direct_required' => 0,
                'meta' => [
                    'shares_required' => 30,
                    'direct_pd_required' => 20,
                    'minimum_share_per_period' => 1,
                    'period_months' => 4,
                    'fund_percentage' => 20,
                ],
            ],
        ];

        foreach ($ranks as $rank) {
            RankRequirement::updateOrCreate(
                ['rank' => $rank['rank']],
                Arr::except($rank, ['rank'])
            );
        }

        RankRequirement::whereNotIn('rank', array_column($ranks, 'rank'))->delete();
    }

    private function seedLedgerAccounts(): void
    {
        $accounts = Config::get('accounting.accounts', []);

        foreach ($accounts as $key => $account) {
            LedgerAccount::updateOrCreate(
                ['code' => $account['code']],
                Arr::only($account, ['name', 'type']) + ['meta' => ['key' => $key]]
            );
        }
    }

    private function seedCommissionRules(): void
    {
        $rules = [
            [
                'name' => 'Agent Down Payment Commission',
                'scope' => CommissionRule::SCOPE_GLOBAL,
                'trigger' => CommissionRule::TRIGGER_ON_PAYMENT,
                'recipient_type' => \App\Models\Agent::class,
                'recipient_id' => null,
                'percentage' => 5,
                'flat_amount' => null,
                'active' => true,
                'meta' => [
                    'applies_to' => 'down_payment',
                ],
            ],
            [
                'name' => 'Agent Installment Commission',
                'scope' => CommissionRule::SCOPE_GLOBAL,
                'trigger' => CommissionRule::TRIGGER_ON_PAYMENT,
                'recipient_type' => \App\Models\Agent::class,
                'recipient_id' => null,
                'percentage' => 1,
                'flat_amount' => null,
                'active' => true,
                'meta' => [
                    'applies_to' => 'installment',
                ],
            ],
            [
                'name' => 'Branch Down Payment Commission',
                'scope' => CommissionRule::SCOPE_GLOBAL,
                'trigger' => CommissionRule::TRIGGER_ON_PAYMENT,
                'recipient_type' => \App\Models\Branch::class,
                'recipient_id' => null,
                'percentage' => 5,
                'flat_amount' => null,
                'active' => true,
                'meta' => [
                    'applies_to' => 'down_payment',
                ],
            ],
            [
                'name' => 'Branch Installment Commission',
                'scope' => CommissionRule::SCOPE_GLOBAL,
                'trigger' => CommissionRule::TRIGGER_ON_PAYMENT,
                'recipient_type' => \App\Models\Branch::class,
                'recipient_id' => null,
                'percentage' => 1,
                'flat_amount' => null,
                'active' => true,
                'meta' => [
                    'applies_to' => 'installment',
                ],
            ],
            [
                'name' => 'Director Marketing Down Payment Bonus',
                'scope' => CommissionRule::SCOPE_GLOBAL,
                'trigger' => CommissionRule::TRIGGER_ON_PAYMENT,
                'recipient_type' => \App\Models\User::class,
                'recipient_id' => null,
                'percentage' => 5,
                'flat_amount' => null,
                'active' => true,
                'meta' => [
                    'applies_to' => 'down_payment',
                    'role' => 'director',
                ],
            ],
            [
                'name' => 'Owner 01 Down Payment Share',
                'scope' => CommissionRule::SCOPE_GLOBAL,
                'trigger' => CommissionRule::TRIGGER_ON_PAYMENT,
                'recipient_type' => \App\Models\User::class,
                'recipient_id' => null,
                'percentage' => 2.5,
                'flat_amount' => null,
                'active' => true,
                'meta' => [
                    'applies_to' => 'down_payment',
                    'owner_position' => 'owner_01',
                ],
            ],
            [
                'name' => 'Owner 02 Down Payment Share',
                'scope' => CommissionRule::SCOPE_GLOBAL,
                'trigger' => CommissionRule::TRIGGER_ON_PAYMENT,
                'recipient_type' => \App\Models\User::class,
                'recipient_id' => null,
                'percentage' => 2.5,
                'flat_amount' => null,
                'active' => true,
                'meta' => [
                    'applies_to' => 'down_payment',
                    'owner_position' => 'owner_02',
                ],
            ],
        ];

        foreach ($rules as $rule) {
            CommissionRule::updateOrCreate(
                ['name' => $rule['name']],
                Arr::except($rule, ['name'])
            );
        }
    }
}

