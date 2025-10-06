<?php

namespace App\Services;

use App\Models\Agent;
use App\Models\RankMembership;
use App\Models\RankRequirement;
use App\Services\Accounting\LedgerService;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class RankPromotionService
{
    public function __construct(private LedgerService $ledgerService)
    {
    }

    public function evaluate(): void
    {
        Agent::with(['salesOrders', 'rankMemberships'])
            ->chunkById(100, function ($agents) {
                $requirements = RankRequirement::orderBy('sequence')->get();

                foreach ($agents as $agent) {
                    $this->evaluateAgent($agent, $requirements);
                }
            });
    }

    public function evaluateAgent(Agent $agent, $requirements = null): void
    {
        $requirements ??= RankRequirement::orderBy('sequence')->get();

        if ($requirements->isEmpty()) {
            return;
        }

        $salesTotal = $agent->salesOrders()->sum('total');
        $downPaymentTotal = $agent->salesOrders()->sum('down_payment');
        $activeRank = $agent->rankMemberships()->where('active', true)->first();

        $eligibleRank = null;

        foreach ($requirements as $requirement) {
            if ($salesTotal < $requirement->personal_sales_target) {
                break;
            }

            $directRequirement = (int) $requirement->direct_required;
            if ($directRequirement > 0) {
                $directCount = Agent::where('branch_id', $agent->branch_id)
                    ->whereHas('rankMemberships', function ($query) use ($requirement) {
                        $query->where('rank', $requirement->rank)->where('active', true);
                    })
                    ->count();

                if ($directCount < $directRequirement) {
                    break;
                }
            }

            $eligibleRank = $requirement;
        }

        if (! $eligibleRank) {
            return;
        }

        if ($activeRank && $activeRank->rank === $eligibleRank->rank) {
            return;
        }

        DB::transaction(function () use ($agent, $activeRank, $eligibleRank, $downPaymentTotal) {
            if ($activeRank) {
                $activeRank->update(['active' => false]);
            }

            $membership = RankMembership::create([
                'agent_id' => $agent->id,
                'rank' => $eligibleRank->rank,
                'achieved_at' => Carbon::now(),
                'active' => true,
                'meta' => [
                    'trigger' => 'monthly_evaluation',
                ],
            ]);

            $this->disburseIncentive($membership, $eligibleRank, $downPaymentTotal);
        });
    }

    protected function disburseIncentive(RankMembership $membership, RankRequirement $requirement, float $downPaymentTotal): void
    {
        $bonusPercent = (float) $requirement->bonus_down_payment;
        $amount = round($downPaymentTotal * $bonusPercent / 100, 2);

        if ($amount <= 0) {
            return;
        }

        $txId = 'RANK-' . $membership->id;

        $this->ledgerService->record($txId, now(), [
            [
                'account_code' => config('accounting.accounts.incentive_fund.code'),
                'account_name' => config('accounting.accounts.incentive_fund.name'),
                'account_type' => 'liability',
                'debit' => $amount,
                'credit' => 0,
            ],
            [
                'account_code' => config('accounting.accounts.cash.code'),
                'account_name' => config('accounting.accounts.cash.name'),
                'account_type' => 'asset',
                'debit' => 0,
                'credit' => $amount,
            ],
        ], [
            'rank_membership_id' => $membership->id,
            'rank' => $membership->rank,
        ]);
    }
}
