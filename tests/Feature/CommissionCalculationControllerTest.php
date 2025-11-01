<?php

namespace Tests\Feature;

use App\Models\Branch;
use App\Models\CommissionSetting;
use App\Models\Employee;
use App\Models\Payment;
use App\Models\SalesOrder;
use App\Models\User;
use App\Services\CommissionService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class CommissionCalculationControllerTest extends TestCase
{
    use RefreshDatabase;

    public function test_admin_can_list_pending_calculations(): void
    {
        $this->actingAsAdmin();
        $payment = $this->createPaymentWithChain();

        app(CommissionService::class)->handlePayment($payment, true);

        $response = $this->getJson('/api/v1/commission-calculations?include=items,payment.salesOrder');

        $response->assertOk();
        $response->assertJsonPath('summary.units', 1);
        $response->assertJsonPath('summary.items', 4);
        $response->assertJsonPath('summary.total_amount', 30000.0);
        $response->assertJsonCount(1, 'data');
        $response->assertJsonCount(4, 'data.0.items');
    }

    public function test_employee_can_filter_calculations_by_recipient(): void
    {
        $payment = $this->createPaymentWithChain();
        $items = app(CommissionService::class)->handlePayment($payment, true);
        $mmId = $items->firstWhere('recipient_type', Employee::class)['recipient_id'];

        $employeeUser = User::factory()->create([
            'role' => User::ROLE_EMPLOYEE,
        ]);

        Sanctum::actingAs($employeeUser);

        $response = $this->getJson(sprintf(
            '/api/v1/commission-calculations?include=items&recipient_type=%s&recipient_id=%d',
            urlencode(Employee::class),
            $mmId
        ));

        $response->assertOk();
        $response->assertJsonCount(1, 'data');
        $response->assertJsonCount(4, 'data.0.items');
    }

    public function test_admin_can_process_pending_calculations(): void
    {
        $this->actingAsAdmin();
        $payment = $this->createPaymentWithChain();

        app(CommissionService::class)->handlePayment($payment, true);

        $response = $this->postJson('/api/v1/commission-calculations/process', [
            'date' => now()->toDateString(),
        ]);

        $response->assertOk();
        $response->assertJsonPath('processed', 4);
        $response->assertJsonPath('total_amount', 30000.0);

        $this->assertDatabaseHas('commission_calculation_units', [
            'payment_id' => $payment->id,
            'status' => 'paid',
        ]);

        $this->assertDatabaseHas('commissions', [
            'payment_id' => $payment->id,
            'status' => 'paid',
        ]);
    }

    protected function actingAsAdmin(): User
    {
        $admin = User::factory()->create([
            'role' => User::ROLE_ADMIN,
        ]);

        Sanctum::actingAs($admin);

        return $admin;
    }

    protected function createPaymentWithChain(): Payment
    {
        $this->seedDevelopmentSettings();

        $branch = Branch::create([
            'name' => 'Dhaka',
            'code' => 'DHK',
            'address' => 'Dhaka',
        ]);

        $gmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $dgmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $agmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);
        $mmUser = User::factory()->create(['role' => User::ROLE_EMPLOYEE]);

        $gm = Employee::create([
            'user_id' => $gmUser->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_GM,
        ]);

        $dgm = Employee::create([
            'user_id' => $dgmUser->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_DGM,
            'superior_id' => $gm->id,
        ]);

        $agm = Employee::create([
            'user_id' => $agmUser->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_AGM,
            'superior_id' => $dgm->id,
        ]);

        $mm = Employee::create([
            'user_id' => $mmUser->id,
            'branch_id' => $branch->id,
            'rank' => Employee::RANK_MM,
            'superior_id' => $agm->id,
        ]);

        $customer = User::factory()->create();

        $order = SalesOrder::create([
            'customer_id' => $customer->id,
            'source_me_id' => $mm->id,
            'branch_id' => $branch->id,
            'sales_type' => SalesOrder::TYPE_LAND,
            'status' => SalesOrder::STATUS_ACTIVE,
            'down_payment' => 100000,
            'total' => 100000,
            'created_by' => SalesOrder::CREATED_BY_SYSTEM,
        ]);

        return Payment::create([
            'sales_order_id' => $order->id,
            'paid_at' => now(),
            'amount' => 100000,
            'type' => Payment::TYPE_DOWN_PAYMENT,
        ]);
    }

    protected function seedDevelopmentSettings(): void
    {
        CommissionSetting::updateOrCreate([
            'key' => 'development_bonus',
        ], [
            'value' => [
                Employee::RANK_MM => ['down_payment' => 15],
                Employee::RANK_AGM => ['down_payment' => 20],
                Employee::RANK_DGM => ['down_payment' => 25],
                Employee::RANK_GM => ['down_payment' => 30],
            ],
        ]);
    }
}
