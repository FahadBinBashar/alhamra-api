<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pd_special_selections', function (Blueprint $table) {
            $table->id();
            $table->foreignId('employee_id')->constrained('employees');
            $table->string('month', 7);
            $table->decimal('percentage', 5, 2)->default(4);
            $table->foreignId('selected_by')->constrained('users');
            $table->json('meta')->nullable();
            $table->timestamps();

            $table->unique(['employee_id', 'month']);
            $table->index('month');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pd_special_selections');
    }
};
