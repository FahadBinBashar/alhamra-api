<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('employee_recruit_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('requested_by_employee_id')->constrained('employees');
            $table->json('data');
            $table->string('status')->default('pending');
            $table->foreignId('reviewed_by_user_id')->nullable()->constrained('users');
            $table->foreignId('created_employee_id')->nullable()->constrained('employees');
            $table->timestamps();

            $table->index('status');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('employee_recruit_requests');
    }
};
