<?php

namespace App\Console\Commands;

use App\Events\PaymentRecorded;
use App\Models\Payment;
use Illuminate\Console\Command;

class ReprocessPayments extends Command
{
    protected $signature = 'payments:reprocess
        {ids* : Payment IDs to re-dispatch PaymentRecorded}
        {--force : Reprocess even if commission_processed_at is already set}';

    protected $description = 'Re-dispatch PaymentRecorded for specific payments.';

    public function handle(): int
    {
        $ids = array_values(array_unique(array_map('intval', $this->argument('ids') ?? [])));

        if (empty($ids)) {
            $this->error('No payment IDs provided.');
            return self::FAILURE;
        }

        $payments = Payment::query()
            ->whereIn('id', $ids)
            ->get()
            ->keyBy('id');

        $missing = array_values(array_diff($ids, $payments->keys()->all()));
        if (! empty($missing)) {
            $this->warn('Missing payment IDs: ' . implode(', ', $missing));
        }

        $reprocessed = 0;
        $skipped = 0;

        foreach ($payments as $payment) {
            if ($payment->commission_processed_at && ! $this->option('force')) {
                $skipped++;
                continue;
            }

            event(new PaymentRecorded($payment->fresh()));
            $reprocessed++;
        }

        $this->info("Re-dispatched events for {$reprocessed} payments.");
        if ($skipped > 0) {
            $this->info("Skipped {$skipped} payments (already processed). Use --force to override.");
        }

        return self::SUCCESS;
    }
}
