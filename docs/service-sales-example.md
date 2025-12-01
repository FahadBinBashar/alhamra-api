# Service Sales API Example

Use this example to create a service-only sales order where pricing is taken directly from the service catalog and no down payment or installments are involved.

## Prerequisites
- A customer record (use its `id` in `customer_id`).
- A published service with pricing configured, e.g., `id: 2`, `price: 300000`, and `commission_percentage: 5`.
- Optional: the agent or employee who brought the customer.

## Create a Service Sales Order
**Endpoint:** `POST /sales-orders`

**Request body:**
```json
{
  "customer_id": 10,
  "sales_type": "service",
  "items": [
    {
      "item_type": "service",
      "item_id": 2,
      "qty": 1
    }
  ],
  "down_payment": null,
  "total": null,
  "agent_id": 7
}
```

### What happens
- The controller uses the service’s catalog price (here `300000`) as the unit price and computes `total` for you; you can leave `total` as `null` in the request.
- `down_payment` is forced to `null` and installments are not generated for service orders.
- The `items[0].item_id` references the service; no separate top-level `service_id` field is needed.
- If `agent_id` is provided, the commission is marked **paid** instantly and credited to the agent’s wallet. If instead you set `source_me_id` (and no `agent_id`), the commission is stored as **draft** for month-end processing.

## Record a Payment for the Service Order
After the order is created, post a payment against it. For example:

**Endpoint:** `POST /payments`

**Request body:**
```json
{
  "sales_order_id": 55,
  "amount": 200000,
  "paid_at": "2025-02-15"
}
```

When this payment is processed for a service order:
- Agent flow: commission = `payment.amount × commission_percentage` → `200000 × 0.05 = 10000`, status = `paid`, wallet is credited immediately.
- Employee flow (using `source_me_id` on the order and no `agent_id`): commission is stored as `draft`; at month-end call `POST /service-commissions/process?month=2025-02` to mark it `paid` and credit the employee’s wallet.
