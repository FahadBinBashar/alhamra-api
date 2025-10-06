<?php

return [
    'accounts' => [
        'cash' => [
            'code' => '101',
            'name' => 'Cash',
            'type' => 'asset',
        ],
        'bank' => [
            'code' => '102',
            'name' => 'Bank',
            'type' => 'asset',
        ],
        'accounts_receivable' => [
            'code' => '110',
            'name' => 'Accounts Receivable',
            'type' => 'asset',
        ],
        'commission_expense' => [
            'code' => '510',
            'name' => 'Commission Expense',
            'type' => 'expense',
        ],
        'commission_payable' => [
            'code' => '210',
            'name' => 'Commission Payable',
            'type' => 'liability',
        ],
        'incentive_fund' => [
            'code' => '220',
            'name' => 'Incentive Fund Payable',
            'type' => 'liability',
        ],
    ],
];
