<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ledger_entries', function (Blueprint $table) {
            $table->id();
            $table->string('tx_id');
            $table->foreignId('account_id')->constrained('ledger_accounts')->cascadeOnDelete();
            $table->decimal('debit', 14, 2)->default(0);
            $table->decimal('credit', 14, 2)->default(0);
            $table->timestamp('occurred_at');
            $table->json('meta')->nullable();
            $table->timestamps();

            $table->index('tx_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ledger_entries');
    }
};
