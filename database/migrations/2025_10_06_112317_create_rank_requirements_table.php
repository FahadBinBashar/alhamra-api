<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('rank_requirements', function (Blueprint $table) {
            $table->id();
            $table->string('rank')->unique();
            $table->unsignedInteger('sequence')->default(0);
            $table->decimal('personal_sales_target', 14, 2)->default(0);
            $table->decimal('bonus_down_payment', 5, 2)->default(0);
            $table->decimal('bonus_installment', 5, 2)->default(0);
            $table->unsignedInteger('direct_required')->default(0);
            $table->json('meta')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('rank_requirements');
    }
};
