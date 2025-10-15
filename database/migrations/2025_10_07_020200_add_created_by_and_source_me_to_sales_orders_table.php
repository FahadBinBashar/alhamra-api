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
            $table->foreignId('source_me_id')
                ->nullable()
                ->after('employee_id')
                ->constrained('employees')
                ->nullOnDelete();

            $table->string('created_by')
                ->default('system')
                ->after('source_me_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('sales_orders', function (Blueprint $table) {
            $table->dropConstrainedForeignId('source_me_id');
            $table->dropColumn('created_by');
        });
    }
};
