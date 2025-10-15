<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('payments', function (Blueprint $table) {
            $table->decimal('commission_base_amount', 14, 2)->nullable()->after('amount');
        });

        DB::table('payments')->whereNull('commission_base_amount')->update([
            'commission_base_amount' => DB::raw('amount'),
        ]);
    }

    public function down(): void
    {
        Schema::table('payments', function (Blueprint $table) {
            $table->dropColumn('commission_base_amount');
        });
    }
};
