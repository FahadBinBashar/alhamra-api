<?php

use App\Models\Employee;
use App\Models\SalesOrder;
use App\Models\User;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('employee_activities', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(Employee::class)->constrained()->cascadeOnDelete();
            $table->foreignIdFor(User::class, 'created_by')->constrained('users')->cascadeOnDelete();
            $table->date('activity_date');
            $table->string('title');
            $table->string('location')->nullable();
            $table->foreignIdFor(User::class, 'customer_id')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignIdFor(SalesOrder::class)->nullable()->constrained()->nullOnDelete();
            $table->text('notes')->nullable();
            $table->json('meta')->nullable();
            $table->timestamps();

            $table->index(['employee_id', 'activity_date']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('employee_activities');
    }
};
