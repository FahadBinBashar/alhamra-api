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
        Schema::create('products', function (Blueprint $t) {
        $t->id();
        $t->foreignId('category_id')->constrained()->cascadeOnUpdate()->restrictOnDelete();
        $t->string('name');
        $t->enum('product_type', ['small','big','land','share','other']);
        $t->decimal('price',14,2)->default(0);
        $t->json('attributes')->nullable(); // কাস্টম অ্যাট্রিবিউট
        $t->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
