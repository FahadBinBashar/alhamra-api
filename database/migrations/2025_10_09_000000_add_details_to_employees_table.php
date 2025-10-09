<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('employees', function (Blueprint $table) {
            $table->string('employee_code')->unique()->after('id');
            $table->string('full_name_en')->after('employee_code');
            $table->string('full_name_bn')->nullable()->after('full_name_en');
            $table->string('father_name')->nullable()->after('full_name_bn');
            $table->string('mother_name')->nullable()->after('father_name');
            $table->string('mobile')->nullable()->after('mother_name');
            $table->string('national_id')->nullable()->after('mobile');
            $table->date('date_of_birth')->nullable()->after('national_id');
            $table->string('marital_status')->nullable()->after('date_of_birth');
            $table->string('religion')->nullable()->after('marital_status');
            $table->string('gender')->nullable()->after('religion');
            $table->string('nationality')->nullable()->after('gender');
            $table->string('district')->nullable()->after('nationality');
            $table->string('upazila')->nullable()->after('district');
            $table->text('present_address')->nullable()->after('upazila');
            $table->text('permanent_address')->nullable()->after('present_address');
            $table->string('post_code')->nullable()->after('permanent_address');
            $table->foreignId('superior_id')->nullable()->after('agent_id')->constrained('employees')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('employees', function (Blueprint $table) {
            $table->dropForeign(['superior_id']);
            $table->dropColumn([
                'employee_code',
                'full_name_en',
                'full_name_bn',
                'father_name',
                'mother_name',
                'mobile',
                'national_id',
                'date_of_birth',
                'marital_status',
                'religion',
                'gender',
                'nationality',
                'district',
                'upazila',
                'present_address',
                'permanent_address',
                'post_code',
                'superior_id',
            ]);
        });
    }
};
