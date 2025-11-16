<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('monthly_incentives', function (Blueprint $table) {
            $table->id();
            $table->foreignId('employee_id')->constrained()->cascadeOnDelete();
            $table->date('period_start');
            $table->date('period_end');
            $table->decimal('total_commissionable_sales', 15, 2)->default(0);
            $table->decimal('incentive_rate', 5, 2)->default(1.00);
            $table->decimal('amount', 15, 2)->default(0);
            $table->string('status')->default('draft');
            $table->json('meta')->nullable();
            $table->timestamp('processed_at')->nullable();
            $table->timestamps();

            $table->unique(['employee_id', 'period_start']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('monthly_incentives');
    }
};
