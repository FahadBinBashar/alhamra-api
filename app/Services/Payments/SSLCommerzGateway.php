<?php

namespace App\Services\Payments;

use App\Models\PaymentIntent;
use Illuminate\Support\Arr;
use Illuminate\Support\Str;

class SSLCommerzGateway
{
    public function initiate(PaymentIntent $intent): array
    {
        $transactionId = $intent->gateway_transaction_id ?: 'SSL-' . Str::orderedUuid()->toString();
        $intent->gateway_transaction_id = $transactionId;

        $meta = $intent->meta ?? [];
        $meta['initiated_at'] = now()->toIso8601String();
        $meta['gateway'] = 'sslcommerz';

        $paymentUrl = $this->buildRedirectUrl($transactionId);
        $meta['redirect_url'] = $paymentUrl;

        $intent->meta = $meta;
        $intent->save();

        return [
            'transaction_id' => $transactionId,
            'redirect_url' => $paymentUrl,
            'gateway' => $intent->gateway,
            'payload' => Arr::only($meta, ['callback_url', 'order_reference']),
        ];
    }

    protected function buildRedirectUrl(string $transactionId): string
    {
        $baseUrl = config('services.sslcommerz.payment_url', 'https://sandbox.sslcommerz.com/');
        $baseUrl = rtrim($baseUrl, '/');

        return $baseUrl . '/' . $transactionId;
    }
}
