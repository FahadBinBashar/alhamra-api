<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class StockMovement extends Model
{
    use HasFactory;

    public const TYPE_IN = 'in';
    public const TYPE_OUT = 'out';

    /**
     * @var array<int, string>
     */
    protected $fillable = [
        'product_id',
        'type',
        'qty',
        'ref_type',
        'ref_id',
        'note',
    ];

    /**
     * @var array<string, string>
     */
    protected $casts = [
        'qty' => 'decimal:2',
    ];

    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }
}
