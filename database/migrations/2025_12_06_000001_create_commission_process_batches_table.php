<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('commission_process_batches', function (Blueprint $table): void {
            $table->id();
            $table->enum('period_type', ['date', 'month']);
            $table->date('cutoff_date')->nullable();
            $table->string('month', 7)->nullable();
            $table->unsignedInteger('processed_units')->default(0);
            $table->unsignedInteger('processed_items')->default(0);
            $table->decimal('total_amount', 15, 2)->default(0);
            $table->foreignId('processed_by')->constrained('users');
            $table->dateTime('processed_at');
            $table->json('meta')->nullable();
            $table->timestamp('created_at')->useCurrent();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('commission_process_batches');
    }
};
