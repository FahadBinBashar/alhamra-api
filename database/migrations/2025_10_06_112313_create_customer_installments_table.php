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
        Schema::create('customer_installments', function (Blueprint $t) {
        $t->id();
        $t->foreignId('sales_order_id')->constrained()->cascadeOnDelete();
        $t->date('due_date');
        $t->decimal('amount',14,2);
        $t->decimal('paid',14,2)->default(0);
        $t->enum('status',['due','partial','paid'])->default('due');
        $t->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('customer_installments');
    }
};
