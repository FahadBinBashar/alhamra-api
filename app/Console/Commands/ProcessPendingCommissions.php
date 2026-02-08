<?php

namespace App\Console\Commands;

use App\Services\CommissionService;
use Carbon\Carbon;
use Illuminate\Console\Command;

class ProcessPendingCommissions extends Command
{
    protected $signature = 'commissions:process {--date=}';

    protected $description = 'Finalize pending commissions up to the provided date.';

    public function __construct(private CommissionService $commissionService)
    {
        parent::__construct();
    }

    public function handle(): int
    {
        $dateOption = $this->option('date');
        $upTo = $dateOption ? Carbon::parse($dateOption) : null;

        $commissions = $this->commissionService->processPendingCommissions(null, $upTo);

        $this->info(sprintf('Processed %d commission payouts.', $commissions->count()));

        return self::SUCCESS;
    }
}
