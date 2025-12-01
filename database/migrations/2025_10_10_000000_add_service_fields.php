<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('services', function (Blueprint $table) {
            if (! Schema::hasColumn('services', 'commission_percentage')) {
                $table->decimal('commission_percentage', 5, 2)->default(0)->after('price');
            }
        });

        Schema::table('commissions', function (Blueprint $table) {
            if (! Schema::hasColumn('commissions', 'category')) {
                $table->string('category')->default('general')->after('sales_order_id');
            }
        });
    }

    public function down(): void
    {
        Schema::table('commissions', function (Blueprint $table) {
            if (Schema::hasColumn('commissions', 'category')) {
                $table->dropColumn('category');
            }
        });

        Schema::table('services', function (Blueprint $table) {
            if (Schema::hasColumn('services', 'commission_percentage')) {
                $table->dropColumn('commission_percentage');
            }
        });
    }
};
