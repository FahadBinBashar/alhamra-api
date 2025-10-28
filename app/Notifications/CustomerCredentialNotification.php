<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class CustomerCredentialNotification extends Notification implements ShouldQueue
{
    use Queueable;

    public function __construct(
        protected string $email,
        protected string $password,
        protected ?string $loginUrl = null,
    ) {
    }

    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        $url = $this->loginUrl ?? config('app.frontend_url', config('app.url'));

        return (new MailMessage())
            ->subject('Your Al-Hamra customer account credentials')
            ->greeting('Hello ' . $notifiable->name . '!')
            ->line('A customer account has been created for you at Al-Hamra Brokerage Management System.')
            ->line('You can sign in with the following credentials:')
            ->line('Email: ' . $this->email)
            ->line('Password: ' . $this->password)
            ->action('Login to your dashboard', $url)
            ->line('For security, please change your password after logging in.');
    }
}
