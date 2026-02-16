<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('payments', function (Blueprint $table) {
            $table->decimal('base_amount', 15, 2)->nullable()->after('amount');
            $table->decimal('emi_extra_amount', 15, 2)->default(0)->after('base_amount');
        });

        DB::table('payments')
            ->whereNull('base_amount')
            ->update([
                'base_amount' => DB::raw('amount'),
            ]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('payments', function (Blueprint $table) {
            $table->dropColumn(['base_amount', 'emi_extra_amount']);
        });
    }
};
