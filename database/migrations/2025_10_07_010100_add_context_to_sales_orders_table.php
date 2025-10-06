<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('sales_orders', function (Blueprint $table) {
            $table->foreignId('employee_id')->nullable()->after('customer_id')->constrained()->nullOnDelete();
            $table->string('sales_type')->default('order')->after('agent_id');
            $table->string('rank')->nullable()->after('sales_type');
            $table->foreignId('introducer_id')->nullable()->after('rank')->constrained('users')->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('sales_orders', function (Blueprint $table) {
            $table->dropConstrainedForeignId('employee_id');
            $table->dropColumn('sales_type');
            $table->dropColumn('rank');
            $table->dropConstrainedForeignId('introducer_id');
        });
    }
};
