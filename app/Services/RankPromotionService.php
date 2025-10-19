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

        $shareValueSetting = CommissionSetting::value('share_value', 500000);
        $shareValue = is_array($shareValueSetting) ? (float) ($shareValueSetting['amount'] ?? 500000) : (float) $shareValueSetting;
        $ordersQuery = $employee->salesOrders()
            ->where('status', '!=', SalesOrder::STATUS_CANCELLED);

        $totalDownPayment = (float) (clone $ordersQuery)->sum('down_payment');
        $shareCount = $shareValue > 0 ? floor($totalDownPayment / $shareValue) : 0;

        $eligibleRank = $employee->rank;

        foreach ($requirements as $requirement) {
            if (! $this->meetsRequirement($employee, $requirement, $shareCount, $shareValue, $ordersQuery)) {
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

    protected function meetsRequirement(Employee $employee, RankRequirement $requirement, int $shareCount, float $shareValue, Builder $ordersQuery): bool
    {
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
}
