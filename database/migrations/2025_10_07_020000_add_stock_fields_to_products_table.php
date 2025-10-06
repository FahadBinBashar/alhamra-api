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
        Schema::table('products', function (Blueprint $table): void {
            $table->decimal('stock_qty', 14, 2)->default(0);
            $table->decimal('min_stock_alert', 14, 2)->default(0);
            $table->boolean('is_stock_managed')->default(true);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('products', function (Blueprint $table): void {
            $table->dropColumn([
                'stock_qty',
                'min_stock_alert',
                'is_stock_managed',
            ]);
        });
    }
};
