<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('sales_orders', function (Blueprint $table) {
            $table->decimal('emi_extra_total', 15, 2)->default(0)->after('installment_tenure_months');
            $table->decimal('total_installment_payable', 15, 2)->nullable()->after('emi_extra_total');
        });
    }

    public function down(): void
    {
        Schema::table('sales_orders', function (Blueprint $table) {
            $table->dropColumn(['emi_extra_total', 'total_installment_payable']);
        });
    }
};
