<?php

namespace App\Console\Commands;

use App\Services\RankPromotionService;
use Illuminate\Console\Command;

class EvaluateAgentRanks extends Command
{
    protected $signature = 'ranks:evaluate';

    protected $description = 'Evaluate marketing employee rank promotions and apply status updates.';

    public function handle(RankPromotionService $service): int
    {
        $this->info('Starting rank evaluation...');
        $service->evaluate();
        $this->info('Rank evaluation completed.');

        return self::SUCCESS;
    }
}
