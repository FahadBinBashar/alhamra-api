<?php

namespace App\Http\Controllers;

use App\Models\Agent;
use App\Models\Employee;
use App\Models\Product;
use App\Models\SalesOrder;
use App\Models\StockMovement;
use App\Models\Service;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;

class SalesOrderController extends Controller
{
    public function index(Request $request)
    {
        $this->ensureSalesEntryPermission($request->user());

        $orders = SalesOrder::with([
            'items.itemable',
            'agent.user',
            'branch',
            'customer',
            'employee.user',
            'sourceMe.user',
            'introducer',
            'rankDefinition',
        ])
            ->when($request->query('sales_type'), function ($query, $salesType) {
                if (in_array($salesType, SalesOrder::SALES_TYPES, true)) {
                    $query->where('sales_type', $salesType);
                }
            })
            ->orderByDesc('id')
            ->paginate((int) $request->query('per_page', 15));

        return response()->json($orders);
    }

    public function store(Request $request)
    {
        $user = $request->user();
        $this->ensureSalesEntryPermission($user);

        $data = $request->validate([
            'customer_id' => ['required', 'integer', 'exists:users,id'],
            'sales_type' => ['required', 'string', Rule::in(SalesOrder::SALES_TYPES)],
            'branch_id' => ['sometimes', 'integer', 'exists:branches,id'],
            'agent_id' => ['sometimes', 'integer', 'exists:agents,id'],
            'source_me_id' => ['nullable', 'integer', 'exists:employees,id'],
            'rank' => ['sometimes', 'string', Rule::exists('ranks', 'code')],
            'introducer_id' => ['nullable', 'integer', 'different:customer_id', 'exists:users,id'],
            'down_payment' => ['required', 'numeric', 'min:0'],
            'total' => ['required', 'numeric', 'min:0'],
            'items' => ['sometimes', 'array'],
            'items.*.item_type' => ['required_with:items', 'string', 'in:product,service'],
            'items.*.item_id' => ['required_with:items', 'integer'],
            'items.*.qty' => ['required_with:items', 'integer', 'min:1'],
            'items.*.unit_price' => ['nullable', 'numeric', 'min:0'],
        ]);

        $data = $this->applyEntryRoleConstraints($user, $data);
        $data = $this->applySourceContextForStore($user, $data);
        $data['created_by'] = $this->resolveCreatedByFlag($user);

        $preparedItems = null;
        if (! empty($data['items'])) {
            $preparedItems = $this->prepareOrderItems($data['items']);
            $data['items'] = $preparedItems['items'];
            if ($preparedItems['total'] > 0) {
                $data['total'] = $preparedItems['total'];
            }
        }

        if ($data['down_payment'] > $data['total']) {
            throw ValidationException::withMessages([
                'down_payment' => 'The down payment may not be greater than the total amount.',
            ]);
        }

        $this->ensureAgentBelongsToBranch($data['agent_id'] ?? null, $data['branch_id'] ?? null);

        $order = DB::transaction(function () use ($data, $preparedItems) {
            $payload = Arr::only($data, [
                'customer_id',
                'employee_id',
                'source_me_id',
                'agent_id',
                'branch_id',
                'sales_type',
                'rank',
                'introducer_id',
                'down_payment',
                'total',
                'created_by',
            ]);
            $payload['status'] = SalesOrder::STATUS_ACTIVE;

            /** @var SalesOrder $order */
            $order = SalesOrder::create($payload);

            if ($preparedItems) {
                $order->items()->createMany($preparedItems['items']);
            }

            $order->load('items.itemable');
            $this->syncStockForSalesOrder($order);

            return $order;
        });

        return response()->json([
            'data' => $order->load([
                'items.itemable',
                'agent.user',
                'branch',
                'customer',
                'employee.user',
                'sourceMe.user',
                'introducer',
                'rankDefinition',
            ]),
        ], 201);
    }

    public function show(Request $request, SalesOrder $salesOrder)
    {
        $this->ensureSalesEntryPermission($request->user());

        return response()->json([
            'data' => $salesOrder->load([
                'items.itemable',
                'agent.user',
                'branch',
                'customer',
                'employee.user',
                'sourceMe.user',
                'introducer',
                'rankDefinition',
            ]),
        ]);
    }

    public function update(Request $request, SalesOrder $salesOrder)
    {
        $this->ensureSalesEntryPermission($request->user());

        $data = $request->validate([
            'customer_id' => ['sometimes', 'integer', 'exists:users,id'],
            'sales_type' => ['sometimes', 'string', Rule::in(SalesOrder::SALES_TYPES)],
            'branch_id' => ['sometimes', 'integer', 'exists:branches,id'],
            'agent_id' => ['sometimes', 'integer', 'exists:agents,id'],
            'source_me_id' => ['sometimes', 'integer', 'exists:employees,id'],
            'rank' => ['sometimes', 'string', Rule::exists('ranks', 'code')],
            'introducer_id' => ['sometimes', 'nullable', 'integer', 'different:customer_id', 'exists:users,id'],
            'down_payment' => ['sometimes', 'numeric', 'min:0'],
            'total' => ['sometimes', 'numeric', 'min:0'],
            'status' => ['sometimes', 'string', Rule::in(SalesOrder::STATUSES)],
            'items' => ['sometimes', 'array'],
            'items.*.item_type' => ['required_with:items', 'string', 'in:product,service'],
            'items.*.item_id' => ['required_with:items', 'integer'],
            'items.*.qty' => ['required_with:items', 'integer', 'min:1'],
            'items.*.unit_price' => ['nullable', 'numeric', 'min:0'],
        ]);

        $data = $this->applyEntryRoleConstraints($request->user(), $data);

        [$data, $sourceProvided] = $this->applySourceContextForUpdate($request->user(), $salesOrder, $data);

        if (! $sourceProvided) {
            $this->assertExistingSourceAlignment($salesOrder, $data);
        }

        $itemsProvided = array_key_exists('items', $data);
        $preparedItems = ['items' => []];

        if ($itemsProvided) {
            $preparedItems = $this->prepareOrderItems($data['items'] ?? []);
            $data['total'] = $preparedItems['total'];
            unset($data['items']);
        }

        $branchId = $data['branch_id'] ?? $salesOrder->branch_id;
        $agentId = $data['agent_id'] ?? $salesOrder->agent_id;
        $this->ensureAgentBelongsToBranch($agentId, $branchId);

        $total = $data['total'] ?? $salesOrder->total;
        $downPayment = $data['down_payment'] ?? $salesOrder->down_payment;

        if ($downPayment > $total) {
            throw ValidationException::withMessages([
                'down_payment' => 'The down payment may not be greater than the total amount.',
            ]);
        }

        DB::transaction(function () use ($salesOrder, $data, $itemsProvided, $preparedItems) {
            if ($itemsProvided) {
                $this->revertStockMovementsForOrder($salesOrder);
            }

            $salesOrder->fill($data);
            $salesOrder->save();

            if ($itemsProvided) {
                $salesOrder->items()->delete();

                if (! empty($preparedItems['items'])) {
                    $salesOrder->items()->createMany($preparedItems['items']);
                }

                $salesOrder->load('items.itemable');
                $this->syncStockForSalesOrder($salesOrder);
            }
        });

        return response()->json([
            'data' => $salesOrder->fresh()->load([
                'items.itemable',
                'agent.user',
                'branch',
                'customer',
                'employee.user',
                'sourceMe.user',
                'introducer',
                'rankDefinition',
            ]),
        ]);
    }

    public function destroy(Request $request, SalesOrder $salesOrder)
    {
        $this->ensureSalesEntryPermission($request->user());

        DB::transaction(function () use ($salesOrder) {
            $this->revertStockMovementsForOrder($salesOrder);
            $salesOrder->delete();
        });

        return response()->noContent();
    }

    private function ensureSalesEntryPermission(?User $user): void
    {
        if (! $user || ! in_array($user->role, [
            User::ROLE_ADMIN,
            User::ROLE_BRANCH_ADMIN,
            User::ROLE_AGENT_ADMIN,
            User::ROLE_AGENT,
        ], true)) {
            abort(403, 'You are not authorised to manage sales entries.');
        }
    }

    private function resolveCreatedByFlag(?User $user): string
    {
        if (! $user) {
            return SalesOrder::CREATED_BY_SYSTEM;
        }

        return match ($user->role) {
            User::ROLE_ADMIN => SalesOrder::CREATED_BY_ADMIN,
            User::ROLE_BRANCH_ADMIN => SalesOrder::CREATED_BY_BRANCH_ADMIN,
            User::ROLE_AGENT, User::ROLE_AGENT_ADMIN => SalesOrder::CREATED_BY_AGENT,
            User::ROLE_CUSTOMER => SalesOrder::CREATED_BY_CUSTOMER,
            default => SalesOrder::CREATED_BY_SYSTEM,
        };
    }

    private function applySourceContextForStore(?User $user, array $data): array
    {
        $sourceId = $data['source_me_id'] ?? null;
        $role = $user?->role;

        if ($user && in_array($role, [User::ROLE_AGENT, User::ROLE_AGENT_ADMIN], true)) {
            if ($sourceId) {
                throw ValidationException::withMessages([
                    'source_me_id' => 'Agents may not assign a marketing executive to their own sales orders.',
                ]);
            }

            $data['source_me_id'] = null;
            $data['employee_id'] = null;

            return $data;
        }

        if ($user && in_array($role, [User::ROLE_ADMIN, User::ROLE_BRANCH_ADMIN], true) && ! $sourceId) {
            throw ValidationException::withMessages([
                'source_me_id' => 'A marketing executive is required for admin-entered sales orders.',
            ]);
        }

        if ($sourceId) {
            $sourceEmployee = Employee::find($sourceId);

            if (! $sourceEmployee) {
                throw ValidationException::withMessages([
                    'source_me_id' => 'The selected marketing executive could not be found.',
                ]);
            }

            return $this->resolveSourceContext($data, $sourceEmployee);
        }

        $data['source_me_id'] = null;
        $data['employee_id'] = null;

        return $data;
    }

    private function applySourceContextForUpdate(?User $user, SalesOrder $salesOrder, array $data): array
    {
        $sourceProvided = array_key_exists('source_me_id', $data);
        $sourceId = $data['source_me_id'] ?? null;
        $role = $user?->role;

        if ($user && in_array($role, [User::ROLE_AGENT, User::ROLE_AGENT_ADMIN], true)) {
            if ($sourceProvided && ! is_null($sourceId)) {
                throw ValidationException::withMessages([
                    'source_me_id' => 'Agents may not assign a marketing executive to their own sales orders.',
                ]);
            }

            if ($sourceProvided) {
                $data['source_me_id'] = null;
                $data['employee_id'] = null;
            }

            return [$data, $sourceProvided];
        }

        if ($sourceProvided) {
            if ($user && in_array($role, [User::ROLE_ADMIN, User::ROLE_BRANCH_ADMIN], true) && ! $sourceId) {
                throw ValidationException::withMessages([
                    'source_me_id' => 'A marketing executive is required for admin-entered sales orders.',
                ]);
            }

            if ($sourceId) {
                $sourceEmployee = Employee::find($sourceId);

                if (! $sourceEmployee) {
                    throw ValidationException::withMessages([
                        'source_me_id' => 'The selected marketing executive could not be found.',
                    ]);
                }

                $data = $this->resolveSourceContext($data, $sourceEmployee);
            } else {
                $data['employee_id'] = null;
            }
        }

        return [$data, $sourceProvided];
    }

    private function applyEntryRoleConstraints(?User $user, array $data): array
    {
        if (! $user) {
            return $data;
        }

        if (in_array($user->role, [User::ROLE_ADMIN, User::ROLE_BRANCH_ADMIN], true)) {
            $data['agent_id'] = null;
        }

        if (in_array($user->role, [User::ROLE_AGENT, User::ROLE_AGENT_ADMIN], true)) {
            $agentProfile = $user->agent;

            if (! $agentProfile) {
                throw ValidationException::withMessages([
                    'agent_id' => 'The authenticated agent profile is missing.',
                ]);
            }

            if (isset($data['agent_id']) && (int) $data['agent_id'] !== (int) $agentProfile->id) {
                throw ValidationException::withMessages([
                    'agent_id' => 'Agents may only manage orders for their own profile.',
                ]);
            }

            $data['agent_id'] = $agentProfile->id;

            if (! array_key_exists('branch_id', $data) || is_null($data['branch_id'])) {
                $data['branch_id'] = $agentProfile->branch_id;
            }
        }

        if (array_key_exists('agent_id', $data) && ! is_null($data['agent_id'])) {
            $data['agent_id'] = (int) $data['agent_id'];
        }

        if (array_key_exists('branch_id', $data) && ! is_null($data['branch_id'])) {
            $data['branch_id'] = (int) $data['branch_id'];
        }

        return $data;
    }

    private function resolveSourceContext(array $data, Employee $employee): array
    {
        $data['source_me_id'] = $employee->id;
        $data['employee_id'] = $employee->id;

        if (! array_key_exists('branch_id', $data) || is_null($data['branch_id'])) {
            $data['branch_id'] = $employee->branch_id;
        }

        if (! array_key_exists('rank', $data) || is_null($data['rank'])) {
            $data['rank'] = $employee->rank;
        }

        $messages = [];

        if ($employee->branch_id && isset($data['branch_id']) && (int) $employee->branch_id !== (int) $data['branch_id']) {
            $messages['branch_id'] = 'The selected branch does not match the marketing executive profile.';
        }

        if ($employee->agent_id && isset($data['agent_id']) && (int) $employee->agent_id !== (int) $data['agent_id']) {
            $messages['agent_id'] = 'The selected agent does not match the marketing executive profile.';
        }

        if ($employee->rank && isset($data['rank']) && $employee->rank !== $data['rank']) {
            $messages['rank'] = 'The selected rank does not match the marketing executive profile.';
        }

        if ($messages) {
            throw ValidationException::withMessages($messages);
        }

        if (isset($data['branch_id'])) {
            $data['branch_id'] = (int) $data['branch_id'];
        }

        if (isset($data['agent_id']) && ! is_null($data['agent_id'])) {
            $data['agent_id'] = (int) $data['agent_id'];
        }

        return $data;
    }

    private function assertExistingSourceAlignment(SalesOrder $salesOrder, array $data): void
    {
        $source = $salesOrder->sourceMe;

        if (! $source) {
            return;
        }

        $messages = [];

        if (array_key_exists('branch_id', $data) && ! is_null($data['branch_id']) && $source->branch_id && (int) $data['branch_id'] !== (int) $source->branch_id) {
            $messages['branch_id'] = 'The selected branch does not match the marketing executive profile.';
        }

        if (array_key_exists('agent_id', $data) && ! is_null($data['agent_id']) && $source->agent_id && (int) $data['agent_id'] !== (int) $source->agent_id) {
            $messages['agent_id'] = 'The selected agent does not match the marketing executive profile.';
        }

        if (array_key_exists('rank', $data) && ! is_null($data['rank']) && $source->rank && $source->rank !== $data['rank']) {
            $messages['rank'] = 'The selected rank does not match the marketing executive profile.';
        }

        if ($messages) {
            throw ValidationException::withMessages($messages);
        }
    }

    private function ensureAgentBelongsToBranch(?int $agentId, ?int $branchId): void
    {
        if (! $agentId || ! $branchId) {
            return;
        }

        $agent = Agent::find($agentId);

        if ($agent && $agent->branch_id && (int) $agent->branch_id !== (int) $branchId) {
            throw ValidationException::withMessages([
                'agent_id' => 'The selected agent does not belong to the specified branch.',
            ]);
        }
    }

    private function syncStockForSalesOrder(SalesOrder $order): void
    {
        $order->loadMissing('items.itemable');

        foreach ($order->items as $item) {
            $product = $item->itemable;

            if (! $product instanceof Product) {
                continue;
            }

            if (! $product->is_stock_managed || $product->product_type === 'land') {
                continue;
            }

            $qty = (float) $item->qty;

            if ($qty <= 0) {
                continue;
            }

            StockMovement::create([
                'product_id' => $product->id,
                'type' => StockMovement::TYPE_OUT,
                'qty' => $qty,
                'ref_type' => 'sales_order',
                'ref_id' => $order->id,
            ]);

            Product::query()->whereKey($product->id)->decrement('stock_qty', $qty);
        }
    }

    private function revertStockMovementsForOrder(SalesOrder $order): void
    {
        $movements = StockMovement::query()
            ->where('ref_type', 'sales_order')
            ->where('ref_id', $order->id)
            ->get();

        if ($movements->isEmpty()) {
            return;
        }

        foreach ($movements as $movement) {
            $qty = (float) $movement->qty;

            if ($movement->type === StockMovement::TYPE_OUT) {
                Product::query()->whereKey($movement->product_id)->increment('stock_qty', $qty);
            } elseif ($movement->type === StockMovement::TYPE_IN) {
                Product::query()->whereKey($movement->product_id)->decrement('stock_qty', $qty);
            }
        }

        StockMovement::query()
            ->where('ref_type', 'sales_order')
            ->where('ref_id', $order->id)
            ->delete();
    }

    private function prepareOrderItems(array $items): array
    {
        $resolved = [];
        $total = 0;

        foreach ($items as $index => $itemData) {
            $itemable = $this->resolveItemable($itemData['item_type'] ?? '', (int) ($itemData['item_id'] ?? 0), $index);
            $qty = (int) ($itemData['qty'] ?? 0);
            $unitPrice = array_key_exists('unit_price', $itemData)
                ? (float) $itemData['unit_price']
                : (float) ($itemable->price ?? 0);
            $lineTotal = round($qty * $unitPrice, 2);

            $resolved[] = [
                'itemable_type' => get_class($itemable),
                'itemable_id' => $itemable->id,
                'qty' => $qty,
                'unit_price' => $unitPrice,
                'line_total' => $lineTotal,
            ];

            $total += $lineTotal;
        }

        return [
            'items' => $resolved,
            'total' => round($total, 2),
        ];
    }

    private function resolveItemable(string $type, int $id, int $index)
    {
        $map = [
            'product' => Product::class,
            'service' => Service::class,
        ];

        if (! array_key_exists($type, $map)) {
            throw ValidationException::withMessages([
                "items.$index.item_type" => 'The selected item type is invalid.',
            ]);
        }

        $modelClass = $map[$type];
        $model = $modelClass::find($id);

        if (! $model) {
            throw ValidationException::withMessages([
                "items.$index.item_id" => 'The selected item is invalid.',
            ]);
        }

        return $model;
    }
}
