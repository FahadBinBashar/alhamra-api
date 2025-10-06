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
        Schema::create('services', function (Blueprint $t) {
        $t->id();
        $t->foreignId('category_id')->constrained()->cascadeOnUpdate()->restrictOnDelete();
        $t->string('name');
        $t->decimal('price',14,2)->default(0);
        $t->json('attributes')->nullable();
        $t->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('services');
    }
};
