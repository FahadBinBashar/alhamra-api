<?php

namespace App\Http\Controllers;

use App\Models\LedgerAccount;
use App\Models\LedgerEntry;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;

class AccountingReportController extends Controller
{
    public function trialBalance(Request $request)
    {
        $accounts = $this->sumByAccount($request);

        $summary = [
            'total_debit' => $accounts->sum('debit_total'),
            'total_credit' => $accounts->sum('credit_total'),
        ];

        return [
            'data' => $accounts->values(),
            'summary' => $summary,
        ];
    }

    public function profitAndLoss(Request $request)
    {
        $accounts = $this->sumByAccount($request);
        $revenues = $accounts->where('type', 'revenue');
        $expenses = $accounts->where('type', 'expense');

        $incomeTotal = $revenues->sum(fn ($account) => $account['credit_total'] - $account['debit_total']);
        $expenseTotal = $expenses->sum(fn ($account) => $account['debit_total'] - $account['credit_total']);

        return [
            'revenues' => $revenues->values(),
            'expenses' => $expenses->values(),
            'net_profit' => round($incomeTotal - $expenseTotal, 2),
            'totals' => [
                'revenues' => round($incomeTotal, 2),
                'expenses' => round($expenseTotal, 2),
            ],
        ];
    }

    public function balanceSheet(Request $request)
    {
        $accounts = $this->sumByAccount($request);

        $assets = $accounts->where('type', 'asset')->values();
        $liabilities = $accounts->where('type', 'liability')->values();
        $equity = $accounts->where('type', 'equity')->values();

        return [
            'assets' => [
                'accounts' => $assets,
                'total' => $this->netBalance($assets, 'asset'),
            ],
            'liabilities' => [
                'accounts' => $liabilities,
                'total' => $this->netBalance($liabilities, 'liability'),
            ],
            'equity' => [
                'accounts' => $equity,
                'total' => $this->netBalance($equity, 'equity'),
            ],
        ];
    }

    public function ledger(Request $request)
    {
        $query = LedgerEntry::query()->with(['account', 'journal'])->orderByDesc('occurred_at');

        if ($request->filled('account_id')) {
            $query->where('account_id', (int) $request->query('account_id'));
        }

        if ($request->filled('account_code')) {
            $code = $request->query('account_code');
            $query->whereHas('account', fn (Builder $builder) => $builder->where('code', $code));
        }

        if ($request->filled('from')) {
            $query->whereDate('occurred_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('occurred_at', '<=', $request->date('to'));
        }

        $perPage = max(1, (int) $request->query('per_page', 25));

        return $query->paginate($perPage)->appends($request->query());
    }

    protected function sumByAccount(Request $request): Collection
    {
        $accounts = LedgerAccount::query()
            ->withSum(['entries as debit_total' => function ($query) use ($request) {
                $this->applyDateFilter($query, $request);
            }], 'debit')
            ->withSum(['entries as credit_total' => function ($query) use ($request) {
                $this->applyDateFilter($query, $request);
            }], 'credit')
            ->orderBy('code')
            ->get()
            ->map(function (LedgerAccount $account) {
                return [
                    'id' => $account->id,
                    'code' => $account->code,
                    'name' => $account->name,
                    'type' => $account->type,
                    'debit_total' => round((float) $account->debit_total, 2),
                    'credit_total' => round((float) $account->credit_total, 2),
                ];
            });

        return $accounts;
    }

    protected function applyDateFilter($query, Request $request): void
    {
        if ($request->filled('from')) {
            $query->whereDate('occurred_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('occurred_at', '<=', $request->date('to'));
        }
    }

    protected function netBalance(Collection $accounts, string $type): float
    {
        $net = 0.0;

        foreach ($accounts as $account) {
            $debit = (float) ($account['debit_total'] ?? 0);
            $credit = (float) ($account['credit_total'] ?? 0);

            if ($type === 'asset') {
                $net += $debit - $credit;
            } else {
                $net += $credit - $debit;
            }
        }

        return round($net, 2);
    }
}
