<?php

namespace Database\Seeders;

use App\Models\Branch;
use App\Models\Category;
use App\Models\CommissionRule;
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
        $this->seedCommissionRules();
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
            ['code' => 'ME', 'name' => 'ME', 'sort_order' => 1],
            ['code' => 'MM', 'name' => 'MM', 'sort_order' => 2],
            ['code' => 'DGM', 'name' => 'DGM', 'sort_order' => 3],
            ['code' => 'GM', 'name' => 'GM', 'sort_order' => 4],
            ['code' => 'PD', 'name' => 'PD', 'sort_order' => 5],
            ['code' => 'ED', 'name' => 'ED', 'sort_order' => 6],
            ['code' => 'DMD', 'name' => 'DMD', 'sort_order' => 7],
            ['code' => 'HD', 'name' => 'HD', 'sort_order' => 8],
        ];

        foreach ($ranks as $rank) {
            Rank::updateOrCreate(
                ['code' => $rank['code']],
                Arr::except($rank, ['code'])
            );
        }
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
                    'description' => 'Entry level marketers recruited by MM and above ranks.',
                    'incentive' => 0,
                ],
            ],
            [
                'rank' => 'MM',
                'sequence' => 2,
                'personal_sales_target' => 100000,
                'bonus_down_payment' => 5,
                'bonus_installment' => 2,
                'direct_required' => 0,
                'meta' => [
                    'monthly_incentive' => 20000,
                ],
            ],
            [
                'rank' => 'DGM',
                'sequence' => 3,
                'personal_sales_target' => 100000,
                'bonus_down_payment' => 10,
                'bonus_installment' => 4,
                'direct_required' => 5,
                'meta' => [
                    'monthly_incentive' => 50000,
                ],
            ],
            [
                'rank' => 'GM',
                'sequence' => 4,
                'personal_sales_target' => 100000,
                'bonus_down_payment' => 15,
                'bonus_installment' => 6,
                'direct_required' => 10,
                'meta' => [
                    'monthly_incentive' => 100000,
                ],
            ],
            [
                'rank' => 'PD',
                'sequence' => 5,
                'personal_sales_target' => 150000,
                'bonus_down_payment' => 15,
                'bonus_installment' => 6,
                'direct_required' => 20,
                'meta' => [
                    'monthly_incentive' => 200000,
                    'fund_percentage' => 3,
                ],
            ],
            [
                'rank' => 'ED',
                'sequence' => 6,
                'personal_sales_target' => 200000,
                'bonus_down_payment' => 15,
                'bonus_installment' => 6,
                'direct_required' => 30,
                'meta' => [
                    'quarterly_incentive' => 300000,
                    'fund_percentage' => 1,
                ],
            ],
            [
                'rank' => 'DMD',
                'sequence' => 7,
                'personal_sales_target' => 250000,
                'bonus_down_payment' => 15,
                'bonus_installment' => 6,
                'direct_required' => 40,
                'meta' => [
                    'yearly_incentive' => 500000,
                    'fund_percentage' => 1,
                ],
            ],
            [
                'rank' => 'HD',
                'sequence' => 8,
                'personal_sales_target' => 300000,
                'bonus_down_payment' => 20,
                'bonus_installment' => 8,
                'direct_required' => 10,
                'meta' => [
                    'profit_share' => 20,
                    'yearly_incentive' => 1000000,
                ],
            ],
        ];

        foreach ($ranks as $rank) {
            RankRequirement::updateOrCreate(
                ['rank' => $rank['rank']],
                Arr::except($rank, ['rank'])
            );
        }
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

