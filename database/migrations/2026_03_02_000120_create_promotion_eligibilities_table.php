<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('promotion_eligibilities', function (Blueprint $table) {
            $table->id();
            $table->foreignId('session_id')->constrained('promotion_sessions')->cascadeOnDelete();
            $table->foreignId('rule_id')->constrained('promotion_rules')->cascadeOnDelete();
            $table->foreignId('employee_id')->constrained('employees')->cascadeOnDelete();
            $table->unsignedInteger('current_down_payment_count')->default(0);
            $table->unsignedInteger('current_sales_count')->default(0);
            $table->enum('eligibility_status', ['not_eligible', 'eligible'])->default('not_eligible');
            $table->timestamp('calculated_at')->nullable();
            $table->timestamps();

            $table->unique(['session_id', 'rule_id', 'employee_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('promotion_eligibilities');
    }
};
