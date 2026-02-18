<?php

namespace App\Console\Commands;

use App\Services\MonthlyIncentiveService;
use Illuminate\Console\Command;

class CalculateMonthlyIncentives extends Command
{
    protected $signature = 'incentives:calculate {--month=} {--week=} {--frequency=monthly}';

    protected $description = 'Calculate incentives for a monthly or weekly period (defaults to previous period).';

    public function handle(MonthlyIncentiveService $service): int
    {
        $month = $this->option('month');
        $week = $this->option('week');
        $frequency = $this->option('frequency') ?? 'monthly';

        $incentives = $service->calculate($month, $frequency, $week);

        $this->info(sprintf(
            'Calculated %d %s incentives.',
            $incentives->count(),
            $frequency
        ));

        return self::SUCCESS;
    }
}
