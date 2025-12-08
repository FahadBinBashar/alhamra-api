<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pd_special_month_locks', function (Blueprint $table) {
            $table->id();
            $table->string('month', 7)->unique();
            $table->dateTime('locked_at');
            $table->foreignId('locked_by')->constrained('users');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pd_special_month_locks');
    }
};
