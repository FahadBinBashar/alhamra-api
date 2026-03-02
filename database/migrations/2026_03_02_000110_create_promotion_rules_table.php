<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('promotion_rules', function (Blueprint $table) {
            $table->id();
            $table->foreignId('session_id')->constrained('promotion_sessions')->cascadeOnDelete();
            $table->unsignedTinyInteger('slot_no');
            $table->enum('eligibility_basis', ['personal', 'first_step', 'combined_step_1_2']);
            $table->boolean('finance_verified_only')->default(true);
            $table->enum('incentive_type', [
                'national_tour_self',
                'national_tour_couple',
                'foreign_tour_self',
                'foreign_tour_couple',
                'fund',
                'car',
                'house',
            ]);
            $table->decimal('fund_amount', 14, 2)->nullable();
            $table->string('currency', 10)->nullable();
            $table->timestamps();

            $table->unique(['session_id', 'slot_no']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('promotion_rules');
    }
};
