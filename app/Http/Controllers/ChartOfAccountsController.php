<?php

namespace App\Http\Controllers;

use App\Models\LedgerAccount;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class ChartOfAccountsController extends Controller
{
    public function index()
    {
        return LedgerAccount::orderBy('code')->get();
    }

    public function store(Request $request)
    {
        $data = $this->validateAccount($request);

        $account = LedgerAccount::create($data);

        return response()->json($account, 201);
    }

    public function update(Request $request, LedgerAccount $account)
    {
        $data = $this->validateAccount($request, $account->id);

        $account->update($data);

        return $account;
    }

    public function destroy(LedgerAccount $account)
    {
        $account->delete();

        return response()->noContent();
    }

    protected function validateAccount(Request $request, ?int $accountId = null): array
    {
        return $request->validate([
            'code' => ['required', 'string', Rule::unique('ledger_accounts')->ignore($accountId)],
            'name' => ['required', 'string', 'max:255'],
            'type' => ['required', 'string', Rule::in(['asset', 'liability', 'equity', 'revenue', 'expense'])],
            'meta' => ['array', 'nullable'],
        ]);
    }
}
