<?php

namespace App\Console\Commands;

use App\Services\MonthlyIncentiveService;
use Illuminate\Console\Command;

class ProcessMonthlyIncentives extends Command
{
    protected $signature = 'incentives:process {--month=} {--week=} {--frequency=monthly}';

    protected $description = 'Approve (if needed) and pay incentives for a monthly or weekly period.';

    public function handle(MonthlyIncentiveService $service): int
    {
        $month = $this->option('month');
        $week = $this->option('week');
        $frequency = $this->option('frequency') ?? 'monthly';

        $processed = $service->process($month, $frequency, $week);

        $this->info(sprintf('Processed %d %s incentives.', $processed->count(), $frequency));

        return self::SUCCESS;
    }
}
