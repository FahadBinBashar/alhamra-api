<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('employee_wallet_transactions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('employee_wallet_id')->constrained('employee_wallets')->cascadeOnDelete();
            $table->foreignId('employee_id')->constrained('employees')->cascadeOnDelete();
            $table->string('type', 100);
            $table->decimal('amount', 14, 2);
            $table->string('currency', 10)->default('BDT');
            $table->string('reference_type', 100)->nullable();
            $table->unsignedBigInteger('reference_id')->nullable();
            $table->string('narration')->nullable();
            $table->json('meta')->nullable();
            $table->timestamps();

            $table->index(['employee_id', 'type']);
            $table->index(['reference_type', 'reference_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('employee_wallet_transactions');
    }
};
