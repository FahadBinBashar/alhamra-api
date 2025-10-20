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
use Tests\TestCase;

class CommissionServiceTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        $this->seedCommissionSettings();
    }

    public function test_handle_payment_returns_gap_commissions_without_persisting(): void
    {
        $payment = $this->createPaymentWithChain();

        $commissions = app(CommissionService::class)->handlePayment($payment);

        $this->assertCount(4, $commissions);
        $this->assertSame(15000.0, $commissions[0]['amount']);
        $this->assertSame(5000.0, $commissions[1]['amount']);
        $this->assertSame(5000.0, $commissions[2]['amount']);
        $this->assertSame(5000.0, $commissions[3]['amount']);
        $this->assertDatabaseCount('commissions', 0);
    }

    public function test_handle_payment_persists_when_requested(): void
    {
        $payment = $this->createPaymentWithChain();

        $created = app(CommissionService::class)->handlePayment($payment, true);

        $this->assertCount(4, $created);
        $this->assertDatabaseHas('commissions', [
            'payment_id' => $payment->id,
            'recipient_type' => Employee::class,
            'status' => 'unpaid',
        ]);
    }

    public function test_process_pending_commissions_marks_payment_and_updates_wallet(): void
    {
        $payment = $this->createPaymentWithChain();

        app(CommissionService::class)->processPendingCommissions();

        $payment->refresh();

        $this->assertNotNull($payment->commission_processed_at);
        $this->assertDatabaseHas('commissions', [
            'payment_id' => $payment->id,
            'status' => 'paid',
        ]);

        $mm = Employee::where('rank', Employee::RANK_MM)->first();
        $agm = Employee::where('rank', Employee::RANK_AGM)->first();
        $dgm = Employee::where('rank', Employee::RANK_DGM)->first();
        $gm = Employee::where('rank', Employee::RANK_GM)->first();

        $this->assertSame(15000.0, (float) $mm->wallet->balance);
        $this->assertSame(5000.0, (float) $agm->wallet->balance);
        $this->assertSame(5000.0, (float) $dgm->wallet->balance);
        $this->assertSame(5000.0, (float) $gm->wallet->balance);
    }

    protected function createPaymentWithChain(): Payment
    {
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
        ]);

        return Payment::create([
            'sales_order_id' => $order->id,
            'paid_at' => now(),
            'amount' => 100000,
            'type' => Payment::TYPE_DOWN_PAYMENT,
        ]);
    }

    protected function seedCommissionSettings(): void
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
