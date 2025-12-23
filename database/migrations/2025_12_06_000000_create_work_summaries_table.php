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
        Schema::create('work_summaries', function (Blueprint $table) {
            $table->id();
            $table->foreignId('employee_id')->constrained()->cascadeOnDelete();
            $table->enum('type', ['daily', 'weekly']);
            $table->date('report_date')->nullable();
            $table->date('week_start')->nullable();
            $table->date('week_end')->nullable();
            $table->decimal('today_sales_amount', 15, 2)->default(0);
            $table->text('remarks')->nullable();
            $table->json('sections')->nullable();
            $table->dateTime('submitted_at')->nullable();
            $table->timestamps();

            $table->unique(['employee_id', 'type', 'report_date']);
            $table->unique(['employee_id', 'type', 'week_start']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('work_summaries');
    }
};
