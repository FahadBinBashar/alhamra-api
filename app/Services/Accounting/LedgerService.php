<?php

namespace App\Services\Accounting;

use App\Models\LedgerAccount;
use App\Models\LedgerEntry;
use App\Models\Journal;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use InvalidArgumentException;

class LedgerService
{
    public function record(string $txId, $occurredAt, array $lines, array $meta = []): void
    {
        $occurredAt = Carbon::parse($occurredAt);

        $debitTotal = collect($lines)->sum(fn ($line) => (float) ($line['debit'] ?? 0));
        $creditTotal = collect($lines)->sum(fn ($line) => (float) ($line['credit'] ?? 0));

        if (round($debitTotal, 2) !== round($creditTotal, 2)) {
            throw new InvalidArgumentException('Double-entry transaction must balance.');
        }

        DB::transaction(function () use ($txId, $occurredAt, $lines, $meta) {
            $journal = Journal::firstOrCreate(
                ['tx_id' => $txId],
                [
                    'occurred_at' => $occurredAt,
                    'meta' => $meta,
                ]
            );

            if ($journal->wasRecentlyCreated === false) {
                return;
            }

            foreach ($lines as $index => $line) {
                $accountId = $this->resolveAccountId($line);

                LedgerEntry::create([
                    'journal_id' => $journal->id,
                    'tx_id' => $txId,
                    'account_id' => $accountId,
                    'debit' => $line['debit'] ?? 0,
                    'credit' => $line['credit'] ?? 0,
                    'occurred_at' => $occurredAt,
                    'meta' => $meta,
                ]);
            }
        });
    }

    public function ensureAccount(string $code, string $name, string $type): LedgerAccount
    {
        return LedgerAccount::firstOrCreate(
            ['code' => $code],
            ['name' => $name, 'type' => $type]
        );
    }

    protected function resolveAccountId(array $line): int
    {
        if (isset($line['account_id'])) {
            return (int) $line['account_id'];
        }

        $code = $line['account_code'] ?? null;
        $name = $line['account_name'] ?? $code;
        $type = $line['account_type'] ?? 'asset';

        if (! $code) {
            throw new InvalidArgumentException('account_id or account_code is required for ledger line.');
        }

        $account = $this->ensureAccount($code, $name, $type);

        return $account->id;
    }
}
