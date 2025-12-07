<?php

namespace App\Http\Controllers;

use App\Models\Journal;
use App\Services\Accounting\LedgerService;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class JournalController extends Controller
{
    public function __construct(private LedgerService $ledgerService)
    {
    }

    public function index(Request $request)
    {
        $query = Journal::query()->with('lines.account')->orderByDesc('occurred_at');

        if ($request->filled('from')) {
            $query->whereDate('occurred_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('occurred_at', '<=', $request->date('to'));
        }

        $perPage = max(1, (int) $request->query('per_page', 15));

        return $query->paginate($perPage)->appends($request->query());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'tx_id' => ['string', 'nullable'],
            'description' => ['string', 'nullable'],
            'occurred_at' => ['required', 'date'],
            'meta' => ['array'],
            'lines' => ['required', 'array', 'min:2'],
            'lines.*.account_id' => ['integer', 'exists:ledger_accounts,id'],
            'lines.*.account_code' => ['string', 'nullable'],
            'lines.*.account_name' => ['string', 'nullable'],
            'lines.*.account_type' => ['string', 'nullable'],
            'lines.*.debit' => ['numeric', 'nullable', 'min:0'],
            'lines.*.credit' => ['numeric', 'nullable', 'min:0'],
        ]);

        $lines = collect($data['lines'])
            ->map(function ($line) {
                $debit = (float) ($line['debit'] ?? 0);
                $credit = (float) ($line['credit'] ?? 0);

                if ($debit <= 0 && $credit <= 0) {
                    throw ValidationException::withMessages([
                        'lines' => ['Each journal line must have a debit or credit amount.'],
                    ]);
                }

                return $line;
            })
            ->all();

        $txId = $data['tx_id'] ?? 'JRNL-' . Str::orderedUuid();
        $meta = $data['meta'] ?? [];

        $this->ledgerService->record($txId, $data['occurred_at'], $lines, $meta);

        $journal = Journal::with('lines.account')->where('tx_id', $txId)->first();

        if ($journal && $data['description']) {
            $journal->description = $data['description'];
            $journal->save();
        }

        return response()->json($journal, 201);
    }
}
