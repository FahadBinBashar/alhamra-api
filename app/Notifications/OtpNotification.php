<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class OtpNotification extends Notification
{
    use Queueable;

    public function __construct(public string $otp)
    {
    }

    public function via(object $notifiable): array
    {
        return ['mail', 'database'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage())
            ->subject('Your One-Time Password')
            ->line('Use the OTP below to complete your verification request:')
            ->line($this->otp)
            ->line('The OTP will expire in 10 minutes.');
    }

    public function toArray(object $notifiable): array
    {
        return [
            'otp' => $this->otp,
            'expires_in_minutes' => 10,
        ];
    }
}
