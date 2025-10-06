<?php

namespace App\Notifications;

use App\Models\CustomerInstallment;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class PaymentReminderNotification extends Notification
{
    use Queueable;

    public function __construct(public CustomerInstallment $installment)
    {
        $this->installment->loadMissing('salesOrder.customer');
    }

    public function via(object $notifiable): array
    {
        return ['mail', 'database'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage())
            ->subject('Payment Reminder')
            ->greeting('Hello ' . ($notifiable->name ?? 'Customer'))
            ->line('This is a friendly reminder for your upcoming installment payment.')
            ->line('Due date: ' . $this->installment->due_date?->format('d M Y'))
            ->line('Amount due: ' . number_format($this->installment->amount, 2))
            ->line('Please complete the payment by the due date to avoid penalties.');
    }

    public function toArray(object $notifiable): array
    {
        return [
            'installment_id' => $this->installment->id,
            'due_date' => $this->installment->due_date,
            'amount' => $this->installment->amount,
        ];
    }
}
