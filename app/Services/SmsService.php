<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Throwable;

class SmsService
{
    public function send(?string $to, string $message): bool
    {
        if (! $to) {
            return false;
        }

        $endpoint = config('services.sms.endpoint');

        if (! $endpoint) {
            Log::info('SMS endpoint not configured. Skipping SMS send.', [
                'to' => $to,
                'message' => $message,
            ]);

            return false;
        }

        try {
            Http::asForm()
                ->withHeaders([
                    'X-API-KEY' => (string) config('services.sms.api_key'),
                ])
                ->post($endpoint, [
                    'to' => $to,
                    'message' => $message,
                    'sender_id' => config('services.sms.sender_id'),
                ])
                ->throw();

            return true;
        } catch (Throwable $exception) {
            Log::error('SMS send failed.', [
                'to' => $to,
                'message' => $message,
                'error' => $exception->getMessage(),
            ]);

            return false;
        }
    }
}
