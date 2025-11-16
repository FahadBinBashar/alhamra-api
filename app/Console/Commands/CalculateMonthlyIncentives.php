<?php

namespace App\Console\Commands;

use App\Services\MonthlyIncentiveService;
use Illuminate\Console\Command;

class CalculateMonthlyIncentives extends Command
{
    protected $signature = 'incentives:calculate {--month=}';

    protected $description = 'Calculate monthly incentives for the specified month (defaults to previous month).';

    public function handle(MonthlyIncentiveService $service): int
    {
        $month = $this->option('month');
        $incentives = $service->calculate($month);

        $this->info(sprintf('Calculated %d monthly incentives.', $incentives->count()));

        return self::SUCCESS;
    }
}
