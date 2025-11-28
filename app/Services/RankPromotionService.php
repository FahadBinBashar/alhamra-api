<?php

namespace App\Services;

use App\Models\CommissionSetting;
use App\Models\Employee;
use App\Models\SalesOrder;
use App\Models\RankRequirement;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Collection;

class RankPromotionService
{
    public function promoteToMarketingOfficer(Employee $employee): bool
    {
        if ($employee->rank !== Employee::RANK_ME) {
            return false;
        }

        return DB::transaction(function () use ($employee) {
            $employee->forceFill(['rank' => Employee::RANK_MM])->save();

            return true;
        });
    }

    public function evaluate(): void
    {
        $requirements = RankRequirement::orderBy('sequence')->get();

        if ($requirements->isEmpty()) {
            return;
        }

        Employee::query()
            ->with('subordinates')
            ->chunkById(200, function ($employees) use ($requirements) {
                foreach ($employees as $employee) {
                    $this->evaluateEmployee($employee, $requirements);
                }
            });
    }

    public function evaluateEmployee(Employee $employee, ?Collection $requirements = null): void
    {
        $requirements ??= RankRequirement::orderBy('sequence')->get();

        if (! $requirements || $requirements->isEmpty()) {
            return;
        }

        $shareValue = (float) CommissionSetting::value('share_value', 50000);
        $ordersQuery = SalesOrder::query()
            ->where('employee_id', $employee->id)
            ->where('status', '!=', SalesOrder::STATUS_CANCELLED);

        $totalDownPayment = (float) (clone $ordersQuery)->sum('down_payment');
        $shareCount = $shareValue > 0 ? floor($totalDownPayment / $shareValue) : 0;

        $eligibleRank = $employee->rank;

        $directorSettings = $this->getDirectorRankSettings();

        foreach ($requirements as $requirement) {
            if (! $this->meetsRequirement($employee, $requirement, $shareCount, $shareValue, $ordersQuery, $directorSettings)) {
                break;
            }

            $eligibleRank = $requirement->rank;
        }

        if ($eligibleRank === $employee->rank) {
            return;
        }

        DB::transaction(function () use ($employee, $eligibleRank) {
            $employee->forceFill(['rank' => $eligibleRank])->save();
        });
    }

    protected function meetsRequirement(Employee $employee, RankRequirement $requirement, int $shareCount, float $shareValue, Builder $ordersQuery, array $directorSettings): bool
    {
        if (isset($directorSettings[$requirement->rank])) {
            $config = $directorSettings[$requirement->rank];
            $shareTarget = (int) ($config['share_target'] ?? 0);
            $gmTarget = (int) ($config['gm_target'] ?? 0);

            if ($shareTarget > 0 && $shareCount < $shareTarget) {
                return false;
            }

            if ($gmTarget > 0 && $this->countDirectorLevelSubordinates($employee) < $gmTarget) {
                return false;
            }

            return true;
        }

        $meta = $requirement->meta ?? [];

        $requiredShares = (int) ($meta['shares_required'] ?? 0);

        if ($requiredShares > 0 && $shareCount < $requiredShares) {
            return false;
        }

        $periodMonths = (int) ($meta['period_months'] ?? 0);
        $minimumSharePerPeriod = (int) ($meta['minimum_share_per_period'] ?? 0);

        if ($periodMonths > 0 && $minimumSharePerPeriod > 0) {
            $recentDownPayment = (float) (clone $ordersQuery)
                ->where('created_at', '>=', now()->subMonths($periodMonths))
                ->sum('down_payment');

            $recentShares = $shareValue > 0 ? floor($recentDownPayment / $shareValue) : 0;

            if ($recentShares < $minimumSharePerPeriod) {
                return false;
            }
        }

        $directRequirements = collect($meta)
            ->filter(fn ($value, $key) => str_ends_with($key, '_required') && str_starts_with($key, 'direct_'));

        if ($directRequirements->isEmpty()) {
            return true;
        }

        foreach ($directRequirements as $key => $requiredCount) {
            $rankCode = strtoupper(str_replace(['direct_', '_required'], ['', ''], $key));
            $count = $employee->subordinates()
                ->where('rank', $rankCode)
                ->count();

            if ($count < (int) $requiredCount) {
                return false;
            }
        }

        return true;
    }

    protected function getDirectorRankSettings(): array
    {
        $defaults = [
            Employee::RANK_ED => ['share_target' => 10, 'gm_target' => 10],
            Employee::RANK_AMD => ['share_target' => 20, 'gm_target' => 20],
            Employee::RANK_DMD => ['share_target' => 25, 'gm_target' => 25],
            Employee::RANK_DIR => ['share_target' => 30, 'gm_target' => 30],
        ];

        $settings = CommissionSetting::value('director_rank_settings', []);

        return is_array($settings) ? array_merge($defaults, $settings) : $defaults;
    }

    protected function countDirectorLevelSubordinates(Employee $employee): int
    {
        $rankOrder = array_values(Employee::RANKS);
        $gmPosition = array_search(Employee::RANK_GM, $rankOrder, true);

        if ($gmPosition === false) {
            return 0;
        }

        $directorRanks = array_slice($rankOrder, $gmPosition);

        return $employee->subordinates()
            ->whereIn('rank', $directorRanks)
            ->count();
    }
}
