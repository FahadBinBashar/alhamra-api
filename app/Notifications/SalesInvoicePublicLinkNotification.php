<?php

namespace App\Notifications;

use App\Models\SalesOrder;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class SalesInvoicePublicLinkNotification extends Notification
{
    public function __construct(
        protected SalesOrder $salesOrder,
        protected string $invoiceUrl,
    ) {}

    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
            ->subject('Your invoice is ready - SO-' . $this->salesOrder->id)
            ->greeting('Assalamu Alaikum ' . ($notifiable->name ?? 'Customer') . ',')
            ->line('Your sales invoice has been generated successfully.')
            ->line('Invoice No: SO-' . $this->salesOrder->id)
            ->line('Total Amount: ' . number_format((float) $this->salesOrder->total, 2))
            ->action('View Invoice', $this->invoiceUrl)
            ->line('You can open this link from your mobile as well.');
    }

    public function toSmsText(): string
    {
        return sprintf(
            'Invoice ready. Order SO-%d. View: %s',
            $this->salesOrder->id,
            $this->invoiceUrl,
        );
    }
}

