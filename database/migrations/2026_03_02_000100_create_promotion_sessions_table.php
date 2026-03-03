<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('promotion_sessions', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->enum('session_type', ['monthly', 'yearly']);
            $table->date('start_date');
            $table->date('end_date');
            $table->enum('status', ['draft', 'active', 'closed'])->default('draft');
            $table->string('target_metric')->default('down_payment_count');
            $table->unsignedInteger('target_value')->default(0);
            $table->unsignedInteger('min_product_or_share_sales')->default(2);
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('updated_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('promotion_sessions');
    }
};
