# কমিশন সিস্টেম ধারণা

## ১. কমিশন জেনারেশন আচরণ
- পেমেন্ট এন্ট্রি হলেই কমিশন "paid" হিসেবে সেভ হয় না।
- প্রতিটি পেমেন্টের পর সিস্টেম শুধুমাত্র কমিশন হিসাব করে preview/report আকারে ধরে রাখে।
- এই হিসাবগুলো ডাটাবেসে অপরিশোধিত (unpaid) অবস্থায় থেকে যায় যতক্ষণ না অ্যাডমিন অনুমোদন দেয়।

## ২. মাসিক প্রশাসনিক প্রসেস
1. মাস শেষে অ্যাডমিন "Commission Calculation Report" চালায়।
2. রিপোর্টে পুরো মাসের সকল বিক্রয় অনুযায়ী প্রত্যেকের কমিশন payable/unpaid অবস্থায় দেখায়।
3. যাচাই শেষে অ্যাডমিন "Process/Approve" বাটনে ক্লিক করলে:
   - প্রতিটি কমিশন রেকর্ড ডাটাবেসে insert হয়ে "paid" স্ট্যাটাস পায়।
   - সংশ্লিষ্ট কর্মীর ওয়ালেট ব্যালেন্সে কমিশন যোগ হয়।

## ৩. কর্মচারীদের ভিউ
- কর্মীরা (ME/MM/AGM/DGM/GM) দৈনিক বা মাসিক ভিত্তিতে তাদের সম্ভাব্য কমিশন দেখতে পারে।
- এসব পরিমাণ সবসময় unpaid/payable অবস্থায় থাকে যতক্ষণ না অ্যাডমিন অনুমোদন দেয়।
- অনুমোদনের আগ পর্যন্ত ওয়ালেট ব্যালেন্স অপরিবর্তিত থাকে।

## ৪. কমিশন ক্যালকুলেশন ইউনিট (CCU)
- প্রতিটি পেমেন্ট বা সেলের জন্য আলাদা CCU তৈরি হয় এবং `commission_calculation_units` টেবিলে `draft` স্ট্যাটাসে সেভ থাকে।
- প্রতিটি CCU-এর বিস্তারিত ব্রেকডাউন `commission_calculation_items` টেবিলে সংরক্ষিত হয়, যেখানে প্রত্যেক রিসিপিয়েন্টের সম্ভাব্য কমিশন আলাদা এন্ট্রি হিসেবে থাকে।
- CCU স্ট্যাটাস:
  - `draft/unpaid`: অ্যাডমিন এখনো অনুমোদন দেয়নি।
  - `paid`: অ্যাডমিন রিপোর্ট প্রসেস করে অনুমোদন দিয়েছে এবং সংশ্লিষ্ট কমিশনগুলো `commissions` টেবিলে paid হিসেবে তৈরি হয়েছে।

## ৫. কমিশন ফ্লো (স্টেপ-বাই-স্টেপ)
| ধাপ | কী হবে | দায়িত্বপ্রাপ্ত |
| --- | --- | --- |
| 1️⃣ | পেমেন্ট রেকর্ড হবে | সিস্টেম |
| 2️⃣ | CCU (কমিশন ব্রেকডাউনসহ) অটো জেনারেট হবে | সিস্টেম |
| 3️⃣ | কর্মীরা তাদের payable কমিশন রিপোর্টে দেখতে পারবে | সিস্টেম |
| 4️⃣ | মাস শেষে অ্যাডমিন "Commission Process" চালাবে | অ্যাডমিন |
| 5️⃣ | কমিশন paid হয়ে ওয়ালেটে ক্রেডিট হবে | সিস্টেম |

## ৬. গ্যাপ কমিশন রুল (ডেভেলপমেন্ট র‍্যাঙ্ক লজিক)
- মোট কমিশন সবসময় ডাউন-পেমেন্টের ৩০%।
- পূর্ণ র্যাঙ্ক চেইন (ME → MM → AGM → DGM → GM) উপস্থিত থাকলে প্রত্যেকে তাদের নির্ধারিত শতাংশ পায়।
- কোনো মধ্যবর্তী র‍্যাঙ্ক অনুপস্থিত থাকলে, উপরের র‍্যাঙ্কের ব্যক্তি ওই গ্যাপের শতাংশ পায়।
- উদাহরণ: GM সরাসরি ME নিয়ে এসেছে →
  - ME পাবে ১০%
  - GM পাবে বাকি ২০% (AGM/DGM অনুপস্থিত থাকায় তাদের অংশ GM-এর কাছে যায়)

## ৭. সারসংক্ষেপ
"Sales বা Payment-এর সাথে সাথে কমিশন system-এ paid হিসেবে যায় না। বরং প্রতিটি পেমেন্টের জন্য CCU (Commission Calculation Unit) তৈরি হয়, যেখানে প্রত্যেক কর্মীর সম্ভাব্য কমিশনের হিসাব থাকে।

কর্মীরা প্রতিদিন বা মাসজুড়ে তাদের payable/unpaid কমিশন রিপোর্ট দেখতে পারে, কিন্তু টাকাটা তখনও wallet-এ যোগ হয় না।

মাসের শেষে অ্যাডমিন পুরো রিপোর্ট দেখে ‘Process’ করলে তবেই কমিশনগুলো paid হয় এবং প্রত্যেকের wallet-এ টাকা যোগ হয়। ফলে কমিশন হিসাব আলাদাভাবে verify ও approve করা যায় এবং ব্যবসায়িক দল মাসিক settlement-এর মাধ্যমে payment clear করতে পারে।"

## ৮. ডেমো API রেসপন্স (টেস্ট ডাটার ভিত্তিতে)
নিচের স্যাম্পলগুলো `tests/Feature/CommissionCalculationControllerTest.php` এবং `tests/Feature/CommissionServiceTest.php` এ ব্যবহৃত ডেটার হুবহু পুনর্নির্মাণ। স্ক্রিপ্টটি একবার চালালেই নিচের মত একটি ডাউন-পেমেন্ট কমিশন চেইন তৈরি হয়:

```bash
php artisan tinker --execute='\\DB::transaction(function () {
    $branch = App\\Models\\Branch::create(["name"=>"Dhaka","code"=>"DHK","address"=>"Dhaka"]);
    $gm = App\\Models\\Employee::create(["user_id"=>App\\Models\\User::factory()->create(["role"=>App\\Models\\User::ROLE_EMPLOYEE])->id,"branch_id"=>$branch->id,"rank"=>App\\Models\\Employee::RANK_GM]);
    $dgm = App\\Models\\Employee::create(["user_id"=>App\\Models\\User::factory()->create(["role"=>App\\Models\\User::ROLE_EMPLOYEE])->id,"branch_id"=>$branch->id,"rank"=>App\\Models\\Employee::RANK_DGM,"superior_id"=>$gm->id]);
    $agm = App\\Models\\Employee::create(["user_id"=>App\\Models\\User::factory()->create(["role"=>App\\Models\\User::ROLE_EMPLOYEE])->id,"branch_id"=>$branch->id,"rank"=>App\\Models\\Employee::RANK_AGM,"superior_id"=>$dgm->id]);
    $mm = App\\Models\\Employee::create(["user_id"=>App\\Models\\User::factory()->create(["role"=>App\\Models\\User::ROLE_EMPLOYEE])->id,"branch_id"=>$branch->id,"rank"=>App\\Models\\Employee::RANK_MM,"superior_id"=>$agm->id]);
    App\\Models\\CommissionSetting::updateOrCreate(["key"=>"development_bonus"],["value"=>[
        App\\Models\\Employee::RANK_MM=>["down_payment"=>15],
        App\\Models\\Employee::RANK_AGM=>["down_payment"=>20],
        App\\Models\\Employee::RANK_DGM=>["down_payment"=>25],
        App\\Models\\Employee::RANK_GM=>["down_payment"=>30],
    ]]);
    $order = App\\Models\\SalesOrder::create([
        "customer_id"=>App\\Models\\User::factory()->create()->id,
        "source_me_id"=>$mm->id,
        "branch_id"=>$branch->id,
        "sales_type"=>App\\Models\\SalesOrder::TYPE_LAND,
        "status"=>App\\Models\\SalesOrder::STATUS_ACTIVE,
        "down_payment"=>100000,
        "total"=>100000,
        "created_by"=>App\\Models\\SalesOrder::CREATED_BY_SYSTEM,
    ]);
    $payment = App\\Models\\Payment::create([
        "sales_order_id"=>$order->id,
        "paid_at"=>now(),
        "amount"=>100000,
        "type"=>App\\Models\\Payment::TYPE_DOWN_PAYMENT,
    ]);
    app(App\\Services\\CommissionService::class)->handlePayment($payment, true);
});'
```

> **দ্রষ্টব্য:** ওপরের কমান্ড চালালে লোকাল ডাটাবেসে `commission_calculation_units` টেবিলে একটি ড্রাফট এন্ট্রি, সাথে ৪টি `commission_calculation_items` তৈরি হয়।

### ৮.১ `GET /api/v1/commission-calculations`
```bash
curl --location 'http://127.0.0.1:8000/api/v1/commission-calculations?include=items,payment.salesOrder' \
  --header 'Accept: application/json' \
  --header 'Authorization: Bearer <token>'
```

উপরের ডাটার ভিত্তিতে রেসপন্স হবে (টাইমস্ট্যাম্প ও আইডি লোকাল ডাটাবেস অনুযায়ী বদলাতে পারে):

```json
{
  "data": [
    {
      "id": 1,
      "payment_id": 1,
      "sales_order_id": 1,
      "status": "draft",
      "calculated_at": "2025-01-31T10:15:30.000000Z",
      "processed_at": null,
      "meta": {
        "commissionable_amount": 100000,
        "payment_type": "down_payment",
        "order_created_by": "system"
      },
      "commissionable_amount": 100000,
      "total_items": 4,
      "total_amount": 30000,
      "payment": {
        "id": 1,
        "sales_order_id": 1,
        "sales_order": {
          "id": 1,
          "order_no": "SO-1",
          "sales_type": "land",
          "status": "active",
          "total": "100000.00",
          "down_payment": "100000.00",
          "created_at": "2025-01-31T10:15:30.000000Z"
        },
        "amount": "100000.00",
        "type": "down_payment",
        "intent_type": null,
        "method": null,
        "commission_base_amount": null,
        "commission_processed_at": null,
        "meta": null,
        "paid_at": "2025-01-31",
        "created_at": "2025-01-31T10:15:30.000000Z",
        "updated_at": "2025-01-31T10:15:30.000000Z"
      },
      "items": [
        {
          "id": 1,
          "commission_calculation_unit_id": 1,
          "recipient_type": "App\\\Models\\Employee",
          "recipient_id": 4,
          "amount": 15000,
          "percentage": 15,
          "meta": {
            "category": "development_bonus",
            "rank": "mm",
            "payment_type": "down_payment",
            "percentage": 15
          },
          "created_at": "2025-01-31T10:15:30.000000Z",
          "updated_at": "2025-01-31T10:15:30.000000Z"
        },
        {
          "id": 2,
          "commission_calculation_unit_id": 1,
          "recipient_type": "App\\\Models\\Employee",
          "recipient_id": 3,
          "amount": 5000,
          "percentage": 5,
          "meta": {
            "category": "development_bonus",
            "rank": "agm",
            "payment_type": "down_payment",
            "percentage": 5
          },
          "created_at": "2025-01-31T10:15:30.000000Z",
          "updated_at": "2025-01-31T10:15:30.000000Z"
        },
        {
          "id": 3,
          "commission_calculation_unit_id": 1,
          "recipient_type": "App\\\Models\\Employee",
          "recipient_id": 2,
          "amount": 5000,
          "percentage": 5,
          "meta": {
            "category": "development_bonus",
            "rank": "dgm",
            "payment_type": "down_payment",
            "percentage": 5
          },
          "created_at": "2025-01-31T10:15:30.000000Z",
          "updated_at": "2025-01-31T10:15:30.000000Z"
        },
        {
          "id": 4,
          "commission_calculation_unit_id": 1,
          "recipient_type": "App\\\Models\\Employee",
          "recipient_id": 1,
          "amount": 5000,
          "percentage": 5,
          "meta": {
            "category": "development_bonus",
            "rank": "gm",
            "payment_type": "down_payment",
            "percentage": 5
          },
          "created_at": "2025-01-31T10:15:30.000000Z",
          "updated_at": "2025-01-31T10:15:30.000000Z"
        }
      ],
      "created_at": "2025-01-31T10:15:30.000000Z",
      "updated_at": "2025-01-31T10:15:30.000000Z"
    }
  ],
  "links": {
    "first": "http://127.0.0.1:8000/api/v1/commission-calculations?page=1",
    "last": "http://127.0.0.1:8000/api/v1/commission-calculations?page=1",
    "prev": null,
    "next": null
  },
  "meta": {
    "current_page": 1,
    "from": 1,
    "last_page": 1,
    "path": "http://127.0.0.1:8000/api/v1/commission-calculations",
    "per_page": 15,
    "to": 1,
    "total": 1
  },
  "summary": {
    "units": 1,
    "items": 4,
    "total_amount": 30000
  }
}
```

### ৮.২ `POST /api/v1/commission-calculations/process`
```bash
curl --location 'http://127.0.0.1:8000/api/v1/commission-calculations/process' \
  --header 'Accept: application/json' \
  --header 'Authorization: Bearer <token>' \
  --header 'Content-Type: application/json' \
  --data '{"date":"2025-01-31"}'
```

উপরে তৈরি হওয়া একমাত্র CCU প্রসেস করলে রেসপন্স হবে:

```json
{
  "processed": 4,
  "total_amount": 30000,
  "cutoff_date": "2025-01-31"
}
```

### ৮.৩ `GET /api/v1/reports/commissions/detail`
প্রসেসিং সম্পন্ন হলে একই ডেটা রিপোর্ট API থেকে দেখালে এই রকম এন্ট্রি পাওয়া যায়:

```bash
curl --location 'http://127.0.0.1:8000/api/v1/reports/commissions/detail?status=paid&include=recipient,salesOrder.branch' \
  --header 'Accept: application/json' \
  --header 'Authorization: Bearer <token>'
```

```json
{
  "data": [
    {
      "id": 1,
      "commission_rule_id": null,
      "payment_id": 1,
      "sales_order_id": 1,
      "recipient_type": "App\\\Models\\Employee",
      "recipient_id": 4,
      "amount": "15000.00",
      "status": "paid",
      "paid_at": "2025-01-31T10:20:00.000000Z",
      "meta": {
        "category": "development_bonus",
        "rank": "mm",
        "payment_type": "down_payment",
        "percentage": 15,
        "calculation_unit_id": 1,
        "calculation_item_id": 1
      },
      "created_at": "2025-01-31T10:20:00.000000Z",
      "updated_at": "2025-01-31T10:20:00.000000Z",
      "recipient_name": null,
      "recipient_rank": "mm",
      "recipient_branch": "Dhaka",
      "agent_name": null,
      "branch_name": "Dhaka",
      "sales_order": {
        "id": 1,
        "customer_id": 1,
        "source_me_id": 4,
        "branch_id": 1,
        "sales_type": "land",
        "status": "active",
        "down_payment": "100000.00",
        "total": "100000.00",
        "created_at": "2025-01-31T10:15:30.000000Z",
        "updated_at": "2025-01-31T10:20:00.000000Z"
      },
      "recipient": {
        "type": "App\\\Models\\Employee",
        "id": 4,
        "name": null,
        "rank": "mm",
        "branch": "Dhaka"
      }
    },
    "… আরও তিনটি এন্ট্রি (AGM, DGM, GM) একই রকম কাঠামো ও ৫,০০০ টাকা করে প্রদর্শিত হবে …"
  ],
  "summary": {
    "total_commissions": 4,
    "total_amount": "30000.00",
    "paid": "30000.00",
    "unpaid": "0.00"
  }
}
```

এই ডেমো আউটপুট দেখে সহজেই যাচাই করা যায় কোন API কখন কী ডেটা ফেরত দেয় এবং কেন `processed: 0` বা খালি লিস্ট পাওয়া যেতে পারে।
