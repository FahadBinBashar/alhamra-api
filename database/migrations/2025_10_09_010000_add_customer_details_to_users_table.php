<?php

use Illuminate\\Database\\Migrations\\Migration;
use Illuminate\\Database\\Schema\\Blueprint;
use Illuminate\\Support\\Facades\\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('father_name')->nullable()->after('name');
            $table->string('mother_name')->nullable()->after('father_name');
            $table->string('marital_status')->nullable()->after('mother_name');
            $table->string('spouse_name')->nullable()->after('marital_status');
            $table->string('profession')->nullable()->after('spouse_name');
            $table->text('permanent_address')->nullable()->after('profession');
            $table->text('present_address')->nullable()->after('permanent_address');
            $table->string('contact_number')->nullable()->after('present_address');
            $table->string('residence_phone')->nullable()->after('contact_number');
            $table->string('whatsapp_number')->nullable()->after('residence_phone');
            $table->string('national_id')->nullable()->after('whatsapp_number');
            $table->string('passport_number')->nullable()->after('national_id');
            $table->string('nationality')->nullable()->after('passport_number');
            $table->string('religion')->nullable()->after('nationality');
            $table->date('date_of_birth')->nullable()->after('religion');
            $table->string('blood_group')->nullable()->after('date_of_birth');
            $table->string('nominee_name')->nullable()->after('blood_group');
            $table->string('nominee_relation')->nullable()->after('nominee_name');
            $table->string('nominee_phone')->nullable()->after('nominee_relation');
            $table->string('authorized_person_name')->nullable()->after('nominee_phone');
            $table->text('authorized_person_address')->nullable()->after('authorized_person_name');
            $table->text('joint_applicants')->nullable()->after('authorized_person_address');
            $table->string('added_by_role')->nullable()->after('joint_applicants');
            $table->foreignId('added_by_agent_id')->nullable()->after('added_by_role')
                ->constrained('agents')
                ->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropConstrainedForeignId('added_by_agent_id');
            $table->dropColumn([
                'father_name',
                'mother_name',
                'marital_status',
                'spouse_name',
                'profession',
                'permanent_address',
                'present_address',
                'contact_number',
                'residence_phone',
                'whatsapp_number',
                'national_id',
                'passport_number',
                'nationality',
                'religion',
                'date_of_birth',
                'blood_group',
                'nominee_name',
                'nominee_relation',
                'nominee_phone',
                'authorized_person_name',
                'authorized_person_address',
                'joint_applicants',
                'added_by_role',
            ]);
        });
    }
};
