<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pd_special_bonuses', function (Blueprint $table) {
            $table->id();
            $table->foreignId('employee_id')->constrained('employees');
            $table->string('month', 7);
            $table->decimal('total_dp', 15, 2)->default(0);
            $table->decimal('percentage', 5, 2)->default(4);
            $table->decimal('amount', 15, 2)->default(0);
            $table->string('status')->default('draft');
            $table->dateTime('processed_at')->nullable();
            $table->json('meta')->nullable();
            $table->timestamps();

            $table->unique(['employee_id', 'month']);
            $table->index(['month', 'status']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pd_special_bonuses');
    }
};
