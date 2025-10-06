<?php

namespace App\Http\Controllers;

use App\Http\Resources\StockMovementResource;
use App\Models\Product;
use App\Models\StockMovement;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;

class StockMovementController extends Controller
{
    public function index(Request $request): AnonymousResourceCollection
    {
        $query = StockMovement::query()->with(['product.category']);

        if ($request->filled('product_id')) {
            $query->where('product_id', $request->integer('product_id'));
        }

        if ($request->filled('type')) {
            $query->where('type', $request->string('type'));
        }

        if ($request->filled('ref_type')) {
            $query->where('ref_type', $request->string('ref_type'));
        }

        if ($request->filled('from')) {
            $query->whereDate('created_at', '>=', $request->date('from'));
        }

        if ($request->filled('to')) {
            $query->whereDate('created_at', '<=', $request->date('to'));
        }

        $movements = $query->orderByDesc('id')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return StockMovementResource::collection($movements);
    }

    public function store(Request $request): JsonResponse
    {
        $data = $request->validate([
            'product_id' => ['required', 'integer', 'exists:products,id'],
            'type' => ['required', Rule::in([StockMovement::TYPE_IN, StockMovement::TYPE_OUT])],
            'qty' => ['required', 'numeric', 'min:0.01'],
            'ref_type' => ['nullable', 'string', 'max:255'],
            'ref_id' => ['nullable', 'integer'],
            'note' => ['nullable', 'string'],
        ]);

        /** @var Product $product */
        $product = Product::find($data['product_id']);

        if (! $product || (! $product->is_stock_managed || $product->product_type === 'land')) {
            throw ValidationException::withMessages([
                'product_id' => 'The selected product does not support stock tracking.',
            ]);
        }

        $movement = DB::transaction(function () use ($data, $product) {
            /** @var StockMovement $movement */
            $movement = StockMovement::create($data);

            $quantity = (float) $movement->qty;

            if ($movement->type === StockMovement::TYPE_IN) {
                $product->increment('stock_qty', $quantity);
            } else {
                if ($product->stock_qty < $quantity) {
                    throw ValidationException::withMessages([
                        'qty' => 'Insufficient stock available for this movement.',
                    ]);
                }

                $product->decrement('stock_qty', $quantity);
            }

            return $movement->load('product.category');
        });

        return (new StockMovementResource($movement))->response($request)->setStatusCode(201);
    }
}
