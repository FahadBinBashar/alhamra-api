<?php

namespace Database\Seeders;

use App\Models\Agent;
use App\Models\Branch;
use App\Models\Commission;
use App\Models\CommissionRule;
use App\Models\CustomerInstallment;
use App\Models\Document;
use App\Models\Employee;
use App\Models\LedgerAccount;
use App\Models\LedgerEntry;
use App\Models\OrderItem;
use App\Models\Payment;
use App\Models\PaymentAllocation;
use App\Models\Product;
use App\Models\RankMembership;
use App\Models\RankRequirement;
use App\Models\SalesOrder;
use App\Models\Service;
use App\Models\StockMovement;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class DemoDataSeeder extends Seeder
{
    public function run(): void
    {
        DB::transaction(function (): void {
            $users = $this->seedUsers();
            $this->seedAgentsAndEmployees($users);
            $inventory = $this->seedInventory();
            $this->seedSalesFlow($users, $inventory);
        });
    }

    /**
     * @return array<string, \App\Models\User>
     */
    private function seedUsers(): array
    {
        $definitions = [
            'admin@alhamra.test' => [
                'name' => 'System Admin',
                'role' => User::ROLE_ADMIN,
                'spatie_roles' => ['admin'],
            ],
            'finance@alhamra.test' => [
                'name' => 'Finance Manager',
                'role' => User::ROLE_EMPLOYEE,
                'spatie_roles' => ['finance'],
            ],
            'branch.manager@alhamra.test' => [
                'name' => 'Branch Manager',
                'role' => User::ROLE_BRANCH_ADMIN,
                'spatie_roles' => ['branch-manager'],
            ],
            'agent@alhamra.test' => [
                'name' => 'Lead Agent',
                'role' => User::ROLE_AGENT_ADMIN,
                'spatie_roles' => ['agent'],
            ],
            'director@alhamra.test' => [
                'name' => 'Director Marketing',
                'role' => User::ROLE_DIRECTOR,
                'spatie_roles' => ['director'],
            ],
            'owner.one@alhamra.test' => [
                'name' => 'Owner 01',
                'role' => User::ROLE_OWNER,
                'spatie_roles' => ['owner'],
            ],
            'owner.two@alhamra.test' => [
                'name' => 'Owner 02',
                'role' => User::ROLE_OWNER,
                'spatie_roles' => ['owner'],
            ],
            'customer@alhamra.test' => [
                'name' => 'Primary Customer',
                'role' => 'customer',
                'spatie_roles' => ['customer'],
            ],
            'introducer@alhamra.test' => [
                'name' => 'Senior Introducer',
                'role' => User::ROLE_DIRECTOR,
                'spatie_roles' => ['director'],
            ],
        ];

        $users = [];

        foreach ($definitions as $email => $data) {
            $user = User::updateOrCreate(
                ['email' => $email],
                [
                    'name' => $data['name'],
                    'password' => Hash::make('password'),
                    'role' => $data['role'],
                ]
            );

            if (! empty($data['spatie_roles'])) {
                $user->syncRoles($data['spatie_roles']);
            }

            $users[$email] = $user;
        }

        return $users;
    }

    /**
     * @param array<string, \App\Models\User> $users
     */
    private function seedAgentsAndEmployees(array $users): void
    {
        $branch = Branch::where('code', 'DHK-HQ')->firstOrFail();

        $agentUser = $users['agent@alhamra.test'];
        $branchManager = $users['branch.manager@alhamra.test'];
        $director = $users['director@alhamra.test'];

        $agent = Agent::updateOrCreate(
            ['user_id' => $agentUser->id],
            [
                'branch_id' => $branch->id,
                'agent_code' => 'AGT-0001',
            ]
        );

        Employee::updateOrCreate(
            ['user_id' => $branchManager->id],
            [
                'branch_id' => $branch->id,
                'rank' => Employee::RANK_MM,
                'employee_code' => sprintf('EMP-%04d', $branchManager->id),
                'full_name_en' => $branchManager->name,
            ]
        );

        Employee::updateOrCreate(
            ['user_id' => $agentUser->id],
            [
                'branch_id' => $branch->id,
                'agent_id' => $agent->id,
                'rank' => Employee::RANK_ME,
                'employee_code' => sprintf('EMP-%04d', $agentUser->id),
                'full_name_en' => $agentUser->name,
            ]
        );

        Employee::updateOrCreate(
            ['user_id' => $director->id],
            [
                'rank' => Employee::RANK_PD,
                'employee_code' => sprintf('EMP-%04d', $director->id),
                'full_name_en' => $director->name,
            ]
        );

        $rankRequirement = RankRequirement::where('rank', Employee::RANK_ME)->first();

        RankMembership::updateOrCreate(
            ['agent_id' => $agent->id, 'rank' => Employee::RANK_ME],
            [
                'achieved_at' => Carbon::now()->subMonthsNoOverflow(2),
                'active' => true,
                'meta' => [
                    'requirement_sequence' => $rankRequirement?->sequence,
                ],
            ]
        );
    }

    /**
     * @return array<string, mixed>
     */
    private function seedInventory(): array
    {
        $landCategory = CategorySeederHelper::getCategoryId('Land & Plot', 'product');
        $apartmentCategory = CategorySeederHelper::getCategoryId('Residential Apartment', 'product');
        $serviceCategory = CategorySeederHelper::getCategoryId('Hajj & Umrah Package', 'service');

        $landProduct = Product::updateOrCreate(
            ['name' => 'Bashundhara Residential Plot'],
            [
                'category_id' => $landCategory,
                'product_type' => 'land',
                'price' => 5000000,
                'ccu_percentage' => 0,
                'attributes' => [
                    'size' => '5 katha',
                    'location' => 'Bashundhara Block D',
                ],
                'stock_qty' => 10,
                'min_stock_alert' => 1,
                'is_stock_managed' => true,
            ]
        );

        $apartmentProduct = Product::updateOrCreate(
            ['name' => 'Premium Apartment Unit'],
            [
                'category_id' => $apartmentCategory,
                'product_type' => 'big',
                'price' => 8000000,
                'ccu_percentage' => 0,
                'attributes' => [
                    'bedrooms' => 4,
                    'bathrooms' => 3,
                ],
                'stock_qty' => 5,
                'min_stock_alert' => 1,
                'is_stock_managed' => true,
            ]
        );

        $hajjService = Service::updateOrCreate(
            ['name' => 'Premium Hajj Package'],
            [
                'category_id' => $serviceCategory,
                'price' => 800000,
                'attributes' => [
                    'duration' => '30 days',
                    'includes' => ['visa', 'hotel', 'transport'],
                ],
            ]
        );

        StockMovement::updateOrCreate(
            ['product_id' => $landProduct->id, 'ref_type' => 'seed-initial', 'ref_id' => $landProduct->id],
            [
                'type' => StockMovement::TYPE_IN,
                'qty' => 10,
                'note' => 'Initial stock for demo seeding',
            ]
        );

        StockMovement::updateOrCreate(
            ['product_id' => $apartmentProduct->id, 'ref_type' => 'seed-initial', 'ref_id' => $apartmentProduct->id],
            [
                'type' => StockMovement::TYPE_IN,
                'qty' => 5,
                'note' => 'Initial stock for demo seeding',
            ]
        );

        return [
            'land' => $landProduct,
            'apartment' => $apartmentProduct,
            'service' => $hajjService,
        ];
    }

    /**
     * @param array<string, \App\Models\User> $users
     * @param array<string, mixed> $inventory
     */
    private function seedSalesFlow(array $users, array $inventory): void
    {
        $branch = Branch::where('code', 'DHK-HQ')->firstOrFail();
        $agent = Agent::where('agent_code', 'AGT-0001')->firstOrFail();
        $agentEmployee = Employee::where('agent_id', $agent->id)->first();

        $customer = $users['customer@alhamra.test'];
        $introducer = $users['introducer@alhamra.test'];
        $director = $users['director@alhamra.test'];
        $ownerOne = $users['owner.one@alhamra.test'];
        $ownerTwo = $users['owner.two@alhamra.test'];

        $downPayment = 500000;

        $salesOrder = SalesOrder::updateOrCreate(
            [
                'customer_id' => $customer->id,
                'branch_id' => $branch->id,
                'agent_id' => $agent->id,
                'sales_type' => SalesOrder::TYPE_ORDER,
            ],
            [
                'employee_id' => $agentEmployee?->id,
                'rank' => Employee::RANK_ME,
                'introducer_id' => $introducer->id,
                'down_payment' => $downPayment,
                'total' => 5800000,
                'status' => SalesOrder::STATUS_ACTIVE,
            ]
        );

        $items = [
            [
                'model' => $inventory['land'],
                'qty' => 1,
                'unit_price' => 5000000,
            ],
            [
                'model' => $inventory['service'],
                'qty' => 1,
                'unit_price' => 800000,
            ],
        ];

        foreach ($items as $item) {
            OrderItem::updateOrCreate(
                [
                    'sales_order_id' => $salesOrder->id,
                    'itemable_id' => $item['model']->id,
                    'itemable_type' => $item['model']::class,
                ],
                [
                    'qty' => $item['qty'],
                    'unit_price' => $item['unit_price'],
                    'line_total' => $item['qty'] * $item['unit_price'],
                ]
            );
        }

        StockMovement::updateOrCreate(
            [
                'product_id' => $inventory['land']->id,
                'ref_type' => 'sales-order',
                'ref_id' => $salesOrder->id,
            ],
            [
                'type' => StockMovement::TYPE_OUT,
                'qty' => 1,
                'note' => 'Reserved for customer order',
            ]
        );

        $installments = [
            [
                'due_date' => Carbon::now()->addMonth(),
                'amount' => 2000000,
                'paid' => 2000000,
                'status' => 'paid',
            ],
            [
                'due_date' => Carbon::now()->addMonthsNoOverflow(2),
                'amount' => 2000000,
                'paid' => 0,
                'status' => 'due',
            ],
            [
                'due_date' => Carbon::now()->addMonthsNoOverflow(3),
                'amount' => 1300000,
                'paid' => 0,
                'status' => 'due',
            ],
        ];

        $installmentModels = [];

        foreach ($installments as $index => $installment) {
            $model = CustomerInstallment::updateOrCreate(
                [
                    'sales_order_id' => $salesOrder->id,
                    'due_date' => $installment['due_date'],
                ],
                Arr::only($installment, ['amount', 'paid', 'status'])
            );

            $installmentModels[$index] = $model;
        }

        $downPaymentRecord = Payment::updateOrCreate(
            [
                'sales_order_id' => $salesOrder->id,
                'type' => 'down_payment',
            ],
            [
                'paid_at' => Carbon::now()->subDays(5),
                'amount' => $downPayment,
                'method' => 'bank',
            ]
        );

        $installmentPayment = Payment::updateOrCreate(
            [
                'sales_order_id' => $salesOrder->id,
                'type' => 'installment',
                'paid_at' => $installments[0]['due_date'],
            ],
            [
                'amount' => 2000000,
                'method' => 'bank',
            ]
        );

        PaymentAllocation::updateOrCreate(
            [
                'payment_id' => $installmentPayment->id,
                'customer_installment_id' => $installmentModels[0]->id,
            ],
            [
                'allocated' => 2000000,
            ]
        );

        $this->seedCommissions(
            $downPaymentRecord,
            $installmentPayment,
            $agent,
            $branch,
            $director,
            $ownerOne,
            $ownerTwo
        );

        $this->seedLedgerEntries($salesOrder, $downPaymentRecord, $installmentPayment);

        Document::updateOrCreate(
            [
                'documentable_type' => SalesOrder::class,
                'documentable_id' => $salesOrder->id,
                'path' => 'contracts/so-2025-0001.pdf',
            ],
            [
                'category' => 'contract',
                'disk' => 'local',
                'original_name' => 'SO-2025-0001.pdf',
                'mime_type' => 'application/pdf',
                'size' => 245760,
                'uploaded_by' => $users['admin@alhamra.test']->id,
            ]
        );
    }

    private function seedCommissions(
        Payment $downPayment,
        Payment $installmentPayment,
        Agent $agent,
        Branch $branch,
        User $director,
        User $ownerOne,
        User $ownerTwo
    ): void {
        $rules = CommissionRule::whereIn('name', [
            'Agent Down Payment Commission',
            'Agent Installment Commission',
            'Branch Down Payment Commission',
            'Branch Installment Commission',
            'Director Marketing Down Payment Bonus',
            'Owner 01 Down Payment Share',
            'Owner 02 Down Payment Share',
        ])->get()->keyBy('name');

        if (($rules['Director Marketing Down Payment Bonus'] ?? null) && ! $rules['Director Marketing Down Payment Bonus']->recipient_id) {
            $rules['Director Marketing Down Payment Bonus']->update(['recipient_id' => $director->id]);
        }

        if (($rules['Owner 01 Down Payment Share'] ?? null) && ! $rules['Owner 01 Down Payment Share']->recipient_id) {
            $rules['Owner 01 Down Payment Share']->update(['recipient_id' => $ownerOne->id]);
        }

        if (($rules['Owner 02 Down Payment Share'] ?? null) && ! $rules['Owner 02 Down Payment Share']->recipient_id) {
            $rules['Owner 02 Down Payment Share']->update(['recipient_id' => $ownerTwo->id]);
        }

        $downPaymentAmount = $downPayment->amount;
        $installmentAmount = $installmentPayment->amount;

        $commissionDefinitions = [
            [
                'rule' => $rules['Agent Down Payment Commission'] ?? null,
                'payment' => $downPayment,
                'recipient_type' => Agent::class,
                'recipient_id' => $agent->id,
                'amount' => $downPaymentAmount * 0.05,
            ],
            [
                'rule' => $rules['Agent Installment Commission'] ?? null,
                'payment' => $installmentPayment,
                'recipient_type' => Agent::class,
                'recipient_id' => $agent->id,
                'amount' => $installmentAmount * 0.01,
            ],
            [
                'rule' => $rules['Branch Down Payment Commission'] ?? null,
                'payment' => $downPayment,
                'recipient_type' => Branch::class,
                'recipient_id' => $branch->id,
                'amount' => $downPaymentAmount * 0.05,
            ],
            [
                'rule' => $rules['Branch Installment Commission'] ?? null,
                'payment' => $installmentPayment,
                'recipient_type' => Branch::class,
                'recipient_id' => $branch->id,
                'amount' => $installmentAmount * 0.01,
            ],
            [
                'rule' => $rules['Director Marketing Down Payment Bonus'] ?? null,
                'payment' => $downPayment,
                'recipient_type' => User::class,
                'recipient_id' => $director->id,
                'amount' => $downPaymentAmount * 0.05,
            ],
            [
                'rule' => $rules['Owner 01 Down Payment Share'] ?? null,
                'payment' => $downPayment,
                'recipient_type' => User::class,
                'recipient_id' => $ownerOne->id,
                'amount' => $downPaymentAmount * 0.025,
            ],
            [
                'rule' => $rules['Owner 02 Down Payment Share'] ?? null,
                'payment' => $downPayment,
                'recipient_type' => User::class,
                'recipient_id' => $ownerTwo->id,
                'amount' => $downPaymentAmount * 0.025,
            ],
        ];

        foreach ($commissionDefinitions as $definition) {
            if (! $definition['rule']) {
                continue;
            }

            Commission::updateOrCreate(
                [
                    'commission_rule_id' => $definition['rule']->id,
                    'payment_id' => $definition['payment']->id,
                    'recipient_type' => $definition['recipient_type'],
                    'recipient_id' => $definition['recipient_id'],
                ],
                [
                    'sales_order_id' => $definition['payment']->sales_order_id,
                    'amount' => round($definition['amount'], 2),
                    'status' => 'unpaid',
                ]
            );
        }
    }

    private function seedLedgerEntries(SalesOrder $order, Payment $downPayment, Payment $installmentPayment): void
    {
        $accounts = LedgerAccount::whereIn('code', ['101', '110', '510', '210'])->get()->keyBy('code');
        $txDownPayment = 'SO-'.$order->id.'-DP';
        $txInstallment = 'SO-'.$order->id.'-INS1';
        $txCommission = 'SO-'.$order->id.'-COM-DP';

        $this->createLedgerPair(
            $txDownPayment,
            $accounts['101'] ?? null,
            $accounts['110'] ?? null,
            $downPayment->amount,
            Carbon::now()->subDays(5)
        );

        $this->createLedgerPair(
            $txInstallment,
            $accounts['101'] ?? null,
            $accounts['110'] ?? null,
            $installmentPayment->amount,
            $installmentPayment->paid_at ?? Carbon::now()
        );

        $commissionTotal = Commission::where('payment_id', $downPayment->id)->sum('amount');

        if ($commissionTotal > 0) {
            $this->createLedgerPair(
                $txCommission,
                $accounts['510'] ?? null,
                $accounts['210'] ?? null,
                $commissionTotal,
                Carbon::now()->subDays(4)
            );
        }
    }

    private function createLedgerPair(
        string $txId,
        ?LedgerAccount $debitAccount,
        ?LedgerAccount $creditAccount,
        float $amount,
        Carbon $occurredAt
    ): void {
        if (! $debitAccount || ! $creditAccount) {
            return;
        }

        LedgerEntry::updateOrCreate(
            [
                'tx_id' => $txId,
                'account_id' => $debitAccount->id,
            ],
            [
                'debit' => $amount,
                'credit' => 0,
                'occurred_at' => $occurredAt,
            ]
        );

        LedgerEntry::updateOrCreate(
            [
                'tx_id' => $txId,
                'account_id' => $creditAccount->id,
            ],
            [
                'debit' => 0,
                'credit' => $amount,
                'occurred_at' => $occurredAt,
            ]
        );
    }
}

/**
 * Helper for retrieving category identifiers while keeping DemoDataSeeder concise.
 */
final class CategorySeederHelper
{
    public static function getCategoryId(string $name, ?string $type = null): int
    {
        $query = \App\Models\Category::query()->where('name', $name);

        if ($type) {
            $query->where('type', $type);
        }

        $categoryId = $query->value('id');

        if ($categoryId) {
            return $categoryId;
        }

        $fallbackQuery = \App\Models\Category::query();

        if ($type) {
            $fallbackQuery->where('type', $type);
        }

        return $fallbackQuery->value('id')
            ?? throw new \RuntimeException('Category not found for '.$name);
    }
}

