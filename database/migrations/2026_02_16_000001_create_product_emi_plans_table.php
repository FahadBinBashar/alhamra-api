<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('product_emi_plans', function (Blueprint $table) {
            $table->id();
            $table->foreignId('product_id')->constrained()->cascadeOnDelete();
            $table->unsignedInteger('tenure_months');
            $table->enum('extra_type', ['percent', 'flat']);
            $table->decimal('extra_value', 15, 2);
            $table->boolean('is_active')->default(true);
            $table->json('meta')->nullable();
            $table->timestamps();

            $table->unique(['product_id', 'tenure_months']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('product_emi_plans');
    }
};
