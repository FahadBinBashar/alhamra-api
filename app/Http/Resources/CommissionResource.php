<?php

namespace App\Http\Resources;

use App\Models\Agent;
use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\Commission
 */
class CommissionResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $salesOrder = $this->whenLoaded('salesOrder');
        $recipient = $this->whenLoaded('recipient');
        $agent = $salesOrder && $salesOrder->relationLoaded('agent') ? $salesOrder->agent : null;
        $agentUser = $agent && $agent->relationLoaded('user') ? $agent->user : null;
        $branch = $salesOrder && $salesOrder->relationLoaded('branch') ? $salesOrder->branch : null;

        $recipientName = $this->resolveRecipientName($recipient);
        $recipientRank = $this->resolveRecipientRank($recipient);
        $recipientBranch = $this->resolveRecipientBranchName($recipient);

        return [
            'id' => $this->id,
            'commission_rule_id' => $this->commission_rule_id,
            'payment_id' => $this->payment_id,
            'sales_order_id' => $this->sales_order_id,
            'recipient_type' => $this->recipient_type,
            'recipient_id' => $this->recipient_id,
            'amount' => $this->amount,
            'status' => $this->status,
            'paid_at' => $this->paid_at,
            'meta' => $this->meta,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'recipient_name' => $recipientName,
            'recipient_rank' => $recipientRank,
            'recipient_branch' => $recipientBranch,
            'agent_name' => $agentUser?->name,
            'branch_name' => $branch?->name,
            'rule' => $this->whenLoaded('rule', fn () => new CommissionRuleResource($this->rule)),
            'payment' => $this->whenLoaded('payment', function () {
                return [
                    'id' => $this->payment->id,
                    'sales_order_id' => $this->payment->sales_order_id,
                    'paid_at' => $this->payment->paid_at,
                    'amount' => $this->payment->amount,
                    'type' => $this->payment->type,
                    'method' => $this->payment->method,
                ];
            }),
            'sales_order' => $this->whenLoaded('salesOrder', fn () => new SalesOrderResource($this->salesOrder)),
            'recipient' => $this->when($recipient, function () use ($recipientName, $recipientRank, $recipientBranch) {
                return [
                    'type' => $this->recipient_type,
                    'id' => $this->recipient_id,
                    'name' => $recipientName,
                    'rank' => $recipientRank,
                    'branch' => $recipientBranch,
                ];
            }),
        ];
    }

    protected function resolveRecipientName($recipient): ?string
    {
        if (! $recipient) {
            return null;
        }

        if (isset($recipient->full_name_en) && $recipient->full_name_en) {
            return (string) $recipient->full_name_en;
        }

        if (isset($recipient->name) && $recipient->name) {
            return (string) $recipient->name;
        }

        if (isset($recipient->user) && $recipient->user && $recipient->user->name) {
            return (string) $recipient->user->name;
        }

        if (method_exists($recipient, 'getAttribute')) {
            $value = $recipient->getAttribute('name');

            if ($value) {
                return (string) $value;
            }
        }

        return null;
    }

    protected function resolveRecipientRank($recipient): ?string
    {
        if (! $recipient) {
            return null;
        }

        if ($recipient instanceof Employee) {
            return $recipient->rank;
        }

        if ($recipient instanceof Agent) {
            return $recipient->relationLoaded('activeRank') ? optional($recipient->activeRank)->rank : null;
        }

        return null;
    }

    protected function resolveRecipientBranchName($recipient): ?string
    {
        if (! $recipient) {
            return null;
        }

        $branch = null;

        if ($recipient instanceof Employee) {
            $branch = $recipient->relationLoaded('branch') ? $recipient->branch : null;
        } elseif ($recipient instanceof Agent) {
            $branch = $recipient->relationLoaded('branch') ? $recipient->branch : null;
        }

        return $branch?->name;
    }
}
