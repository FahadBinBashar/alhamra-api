<?php

namespace App\Http\Controllers;

use App\Models\Agent;
use App\Models\Employee;
use App\Models\Product;
use App\Models\SalesOrder;
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
            'introducer',
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

        $employee = $user?->employee;

        if (! $employee) {
            throw ValidationException::withMessages([
                'employee_id' => 'The authenticated user is not linked to an employee profile.',
            ]);
        }

        $data = $request->validate([
            'customer_id' => ['required', 'integer', 'exists:users,id'],
            'sales_type' => ['required', 'string', Rule::in(SalesOrder::SALES_TYPES)],
            'branch_id' => ['sometimes', 'integer', 'exists:branches,id'],
            'agent_id' => ['sometimes', 'integer', 'exists:agents,id'],
            'rank' => ['sometimes', 'string', Rule::in(Employee::RANKS)],
            'introducer_id' => ['nullable', 'integer', 'different:customer_id', 'exists:users,id'],
            'down_payment' => ['required', 'numeric', 'min:0'],
            'total' => ['required', 'numeric', 'min:0'],
            'items' => ['sometimes', 'array'],
            'items.*.item_type' => ['required_with:items', 'string', 'in:product,service'],
            'items.*.item_id' => ['required_with:items', 'integer'],
            'items.*.qty' => ['required_with:items', 'integer', 'min:1'],
            'items.*.unit_price' => ['nullable', 'numeric', 'min:0'],
        ]);

        $data = $this->resolveEmployeeContext($data, $employee);

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

        $this->ensureAgentBelongsToBranch($data['agent_id'], $data['branch_id']);

        $order = DB::transaction(function () use ($data, $preparedItems) {
            $payload = Arr::only($data, [
                'customer_id',
                'employee_id',
                'agent_id',
                'branch_id',
                'sales_type',
                'rank',
                'introducer_id',
                'down_payment',
                'total',
            ]);
            $payload['status'] = SalesOrder::STATUS_ACTIVE;

            /** @var SalesOrder $order */
            $order = SalesOrder::create($payload);

            if ($preparedItems) {
                $order->items()->createMany($preparedItems['items']);
            }

            return $order;
        });

        return response()->json([
            'data' => $order->load([
                'items.itemable',
                'agent.user',
                'branch',
                'customer',
                'employee.user',
                'introducer',
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
                'introducer',
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
            'rank' => ['sometimes', 'string', Rule::in(Employee::RANKS)],
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
            $salesOrder->fill($data);
            $salesOrder->save();

            if ($itemsProvided) {
                $salesOrder->items()->delete();

                if (! empty($preparedItems['items'])) {
                    $salesOrder->items()->createMany($preparedItems['items']);
                }
            }
        });

        return response()->json([
            'data' => $salesOrder->fresh()->load([
                'items.itemable',
                'agent.user',
                'branch',
                'customer',
                'employee.user',
                'introducer',
            ]),
        ]);
    }

    public function destroy(Request $request, SalesOrder $salesOrder)
    {
        $this->ensureSalesEntryPermission($request->user());

        $salesOrder->delete();

        return response()->noContent();
    }

    private function ensureSalesEntryPermission(?User $user): void
    {
        if (! $user || ! in_array($user->role, [
            User::ROLE_ADMIN,
            User::ROLE_BRANCH_ADMIN,
            User::ROLE_AGENT_ADMIN,
        ], true)) {
            abort(403, 'You are not authorised to manage sales entries.');
        }
    }

    private function resolveEmployeeContext(array $data, Employee $employee): array
    {
        $data['employee_id'] = $employee->id;

        if (! array_key_exists('branch_id', $data) || is_null($data['branch_id'])) {
            $data['branch_id'] = $employee->branch_id;
        }

        if (! array_key_exists('agent_id', $data) || is_null($data['agent_id'])) {
            $data['agent_id'] = $employee->agent_id;
        }

        if (! array_key_exists('rank', $data) || is_null($data['rank'])) {
            $data['rank'] = $employee->rank;
        }

        $messages = [];

        foreach (['branch_id', 'agent_id', 'rank'] as $field) {
            if (! isset($data[$field])) {
                $messages[$field] = 'The '.$field.' could not be determined from the employee profile.';
            }
        }

        if ($messages) {
            throw ValidationException::withMessages($messages);
        }

        $data['branch_id'] = (int) $data['branch_id'];
        $data['agent_id'] = (int) $data['agent_id'];

        return $data;
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
