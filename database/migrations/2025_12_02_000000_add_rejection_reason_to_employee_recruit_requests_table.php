<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('employee_recruit_requests', function (Blueprint $table) {
            $table->string('rejection_reason', 500)->nullable()->after('created_employee_id');
        });
    }

    public function down(): void
    {
        Schema::table('employee_recruit_requests', function (Blueprint $table) {
            $table->dropColumn('rejection_reason');
        });
    }
};
