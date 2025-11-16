<?php

namespace App\Console\Commands;

use App\Services\MonthlyIncentiveService;
use Illuminate\Console\Command;

class ProcessMonthlyIncentives extends Command
{
    protected $signature = 'incentives:process {--month=}';

    protected $description = 'Process draft monthly incentives for the specified month and credit wallets.';

    public function handle(MonthlyIncentiveService $service): int
    {
        $month = $this->option('month');
        $processed = $service->process($month);

        $this->info(sprintf('Processed %d monthly incentives.', $processed->count()));

        return self::SUCCESS;
    }
}
