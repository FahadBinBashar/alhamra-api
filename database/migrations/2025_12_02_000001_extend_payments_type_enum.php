<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (! Schema::hasTable('payments')) {
            return;
        }

        DB::statement(<<<SQL
            ALTER TABLE payments
            MODIFY COLUMN type ENUM('down_payment', 'installment', 'full_payment', 'partial_payment')
            DEFAULT 'installment'
        SQL);
    }

    public function down(): void
    {
        if (! Schema::hasTable('payments')) {
            return;
        }

        DB::statement(<<<SQL
            ALTER TABLE payments
            MODIFY COLUMN type ENUM('down_payment', 'installment', 'full_payment')
            DEFAULT 'installment'
        SQL);
    }
};
