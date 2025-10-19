<?php

namespace Tests\Feature;

use App\Events\PaymentRecorded;
use App\Listeners\ProcessPaymentCommissions;
use App\Models\Branch;
use App\Models\CommissionSetting;
use App\Models\Employee;
use App\Models\Payment;
use App\Models\Rank;
use App\Models\SalesOrder;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Str;
use Tests\TestCase;

class ProcessPaymentCommissionsTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        $this->ensureRanks(Employee::RANKS);
    }

    public function test_marketing_executive_is_promoted_before_commission_generation(): void
    {
        $branch = Branch::create([
            'name' => 'Dhaka',
            'code' => 'DHK',
            'address' => 'Dhaka',
        ]);

        $employeeUser = User::factory()->create([
            'role' => User::ROLE_EMPLOYEE,
        ]);

        $employee = Employee::create([
            'user_id' => $employeeUser->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_ME,
        ]);

        $customer = User::factory()->create();

        $salesOrder = SalesOrder::create([
            'customer_id' => $customer->id,
            'source_me_id' => $employee->id,
            'branch_id' => $branch->id,
            'sales_type' => SalesOrder::TYPE_LAND,
            'status' => SalesOrder::STATUS_ACTIVE,
            'down_payment' => 60000,
            'total' => 200000,
            'created_by' => SalesOrder::CREATED_BY_SYSTEM,
        ]);

        $payment = Payment::create([
            'sales_order_id' => $salesOrder->id,
            'paid_at' => now(),
            'amount' => 60000,
            'type' => Payment::TYPE_DOWN_PAYMENT,
            'method' => 'cash',
        ]);

        CommissionSetting::create([
            'key' => 'development_bonus',
            'value' => [
                Employee::RANK_MO => [
                    'down_payment' => 10,
                ],
            ],
        ]);

        $listener = app(ProcessPaymentCommissions::class);

        $listener->handle(new PaymentRecorded($payment));

        $this->assertSame(Employee::RANK_MO, $employee->fresh()->rank);

        $this->assertDatabaseHas('commissions', [
            'payment_id' => $payment->id,
            'recipient_type' => Employee::class,
            'recipient_id' => $employee->id,
            'amount' => 6000.0,
        ]);
    }

    public function test_employee_is_not_promoted_when_threshold_is_not_met(): void
    {
        $branch = Branch::create([
            'name' => 'Chattogram',
            'code' => 'CTG',
            'address' => 'Chattogram',
        ]);

        $employeeUser = User::factory()->create([
            'role' => User::ROLE_EMPLOYEE,
        ]);

        $employee = Employee::create([
            'user_id' => $employeeUser->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_ME,
        ]);

        $customer = User::factory()->create();

        $salesOrder = SalesOrder::create([
            'customer_id' => $customer->id,
            'source_me_id' => $employee->id,
            'branch_id' => $branch->id,
            'sales_type' => SalesOrder::TYPE_LAND,
            'status' => SalesOrder::STATUS_ACTIVE,
            'down_payment' => 40000,
            'total' => 150000,
            'created_by' => SalesOrder::CREATED_BY_SYSTEM,
        ]);

        $payment = Payment::create([
            'sales_order_id' => $salesOrder->id,
            'paid_at' => now(),
            'amount' => 40000,
            'type' => Payment::TYPE_DOWN_PAYMENT,
            'method' => 'cash',
        ]);

        CommissionSetting::create([
            'key' => 'development_bonus',
            'value' => [
                Employee::RANK_MO => [
                    'down_payment' => 10,
                ],
            ],
        ]);

        $listener = app(ProcessPaymentCommissions::class);

        $listener->handle(new PaymentRecorded($payment));

        $this->assertSame(Employee::RANK_ME, $employee->fresh()->rank);

        $this->assertDatabaseCount('commissions', 0);
    }

    protected function ensureRanks(array $codes): void
    {
        foreach ($codes as $index => $code) {
            Rank::firstOrCreate(
                ['code' => $code],
                ['name' => Str::upper($code), 'sort_order' => $index + 1]
            );
        }
    }
}
