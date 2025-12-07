<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('journals', function (Blueprint $table) {
            $table->id();
            $table->string('tx_id')->unique();
            $table->string('description')->nullable();
            $table->timestamp('occurred_at');
            $table->json('meta')->nullable();
            $table->timestamps();
        });

        Schema::table('ledger_entries', function (Blueprint $table) {
            $table->foreignId('journal_id')->nullable()->after('id')->constrained('journals')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('ledger_entries', function (Blueprint $table) {
            $table->dropConstrainedForeignId('journal_id');
        });

        Schema::dropIfExists('journals');
    }
};
