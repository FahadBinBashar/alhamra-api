<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('commission_calculation_units', function (Blueprint $table) {
            $table->id();
            $table->foreignId('payment_id')->unique()->constrained()->cascadeOnDelete();
            $table->foreignId('sales_order_id')->nullable()->constrained()->nullOnDelete();
            $table->enum('status', ['draft', 'paid'])->default('draft');
            $table->timestamp('calculated_at')->nullable();
            $table->timestamp('processed_at')->nullable();
            $table->json('meta')->nullable();
            $table->timestamps();
        });

        Schema::create('commission_calculation_items', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('commission_calculation_unit_id');
            $table->string('recipient_type');
            $table->unsignedBigInteger('recipient_id')->nullable();
            $table->decimal('amount', 14, 2)->default(0);
            $table->decimal('percentage', 6, 3)->nullable();
            $table->json('meta')->nullable();
            $table->timestamps();

            // ✅ Shortened foreign key name
            $table->foreign('commission_calculation_unit_id', 'ccu_item_fk')
                ->references('id')
                ->on('commission_calculation_units')
                ->cascadeOnDelete();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('commission_calculation_items');
        Schema::dropIfExists('commission_calculation_units');
    }
};
