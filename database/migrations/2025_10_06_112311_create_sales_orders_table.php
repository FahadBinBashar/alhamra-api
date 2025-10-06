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
   
        Schema::create('sales_orders', function (Blueprint $t) {
        $t->id();
        $t->foreignId('customer_id')->constrained('users');
        $t->foreignId('agent_id')->nullable()->constrained();
        $t->foreignId('branch_id')->nullable()->constrained();
        $t->decimal('down_payment',14,2)->default(0);
        $t->decimal('total',14,2);
        $t->enum('status',['draft','active','completed','cancelled'])->default('draft');
        $t->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sales_orders');
    }
};
