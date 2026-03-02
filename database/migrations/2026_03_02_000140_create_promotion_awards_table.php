<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('promotion_awards', function (Blueprint $table) {
            $table->id();
            $table->foreignId('session_id')->constrained('promotion_sessions')->cascadeOnDelete();
            $table->foreignId('rule_id')->constrained('promotion_rules')->cascadeOnDelete();
            $table->foreignId('employee_id')->constrained('employees')->cascadeOnDelete();
            $table->enum('award_status', ['generated', 'processed'])->default('generated');
            $table->foreignId('generated_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('generated_at')->nullable();
            $table->foreignId('processed_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('processed_at')->nullable();
            $table->foreignId('wallet_transaction_id')->nullable()->constrained('employee_wallet_transactions')->nullOnDelete();
            $table->text('remarks')->nullable();
            $table->timestamps();

            $table->unique(['session_id', 'rule_id', 'employee_id']);
            $table->index(['session_id', 'award_status']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('promotion_awards');
    }
};
