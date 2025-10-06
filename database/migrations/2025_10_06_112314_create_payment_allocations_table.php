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
        Schema::create('payment_allocations', function (Blueprint $t) {
        $t->id();
        $t->foreignId('payment_id')->constrained()->cascadeOnDelete();
        $t->foreignId('customer_installment_id')->constrained()->cascadeOnDelete();
        $t->decimal('allocated',14,2);
        $t->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payment_allocations');
    }
};
