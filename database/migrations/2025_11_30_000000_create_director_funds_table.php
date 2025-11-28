<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('director_funds', function (Blueprint $table) {
            $table->id();
            $table->foreignId('employee_id')->constrained()->cascadeOnDelete();
            $table->string('type');
            $table->date('period_start');
            $table->date('period_end');
            $table->decimal('percentage_used', 8, 2)->default(0);
            $table->decimal('total_fund', 15, 2)->default(0);
            $table->decimal('per_person_amount', 15, 2)->default(0);
            $table->string('status')->default('draft');
            $table->json('meta')->nullable();
            $table->timestamp('processed_at')->nullable();
            $table->timestamps();

            $table->unique(['employee_id', 'type', 'period_start']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('director_funds');
    }
};
