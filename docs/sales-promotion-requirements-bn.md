# Sales Promotion System APIs
## Dynamic, Target-Based & Admin-Controlled Incentive Engine (Wallet Integrated)

## ১) সিস্টেমের উদ্দেশ্য
এই সিস্টেমের মাধ্যমে কোম্পানি নির্দিষ্ট সময়সীমার জন্য Sales Promotion ঘোষণা করবে।
নির্ধারিত সেলস টার্গেট পূরণকারী কর্মীরা “Eligible” হিসেবে চিহ্নিত হবে।

Award স্বয়ংক্রিয়ভাবে প্রদান করা হবে না।
Admin যাচাই করে “Generate” এবং “Process” করার মাধ্যমে চূড়ান্তভাবে Award প্রদান করবে।

---

## ২) প্রোমোশন কাঠামো

### 🔹 A. Monthly Promotion

#### Eligibility (Dynamic Selection: যেকোনো একটি)
- Personal Sales Down Payment Count
- অথবা 1st Step Sales Down Payment Count

#### অতিরিক্ত শর্ত
- ন্যূনতম ২টি Product/Share Sales (Dynamic Target Set)
- শুধুমাত্র Finance Verified Down Payment গণনায় ধরা হবে

#### Incentive (Dynamic Configuration)
- National Tour (Self / Couple)
- Fund (Wallet Credit)

### 🔹 B. Yearly Promotion

#### Eligibility
- শুধুমাত্র 1st Step + 2nd Step Sales Down Payment (Combined Count)
- Step configuration সম্পূর্ণ Dynamic হবে

#### Incentive (Dynamic Configuration)
- Foreign Tour (Self / Couple)
- Fund (Wallet Credit)
- Car
- House

---

## ৩) Core Functional Requirements (API-Centric)

### FR-01: Promotion Session Management
- Admin Promotion Session তৈরি, Edit, Active, Close করতে পারবে।
- Session Type: Monthly / Yearly
- Session Date Range বাধ্যতামূলক:
  - `start_date`
  - `end_date`
- Session Active হওয়ার আগে Target Configuration বাধ্যতামূলক।

### FR-02: Dynamic Target Setup
- Admin প্রতিটি Session-এর জন্য target নির্ধারণ করবে।
- Target Metric উদাহরণ:
  - Down Payment Count
  - Minimum Product/Share Sales Count
- Monthly ও Yearly session অনুযায়ী eligibility basis আলাদা হবে।

### FR-03: Eligibility Calculation Engine
- সিস্টেম scheduled/on-demand ক্যালকুলেশন চালাবে।
- Monthly eligibility:
  - Personal অথবা 1st Step Down Payment count (config অনুযায়ী)
- Yearly eligibility:
  - 1st + 2nd Step Down Payment combined count
- Finance verified নয় এমন down payment গণনায় আসবে না।

### FR-04: Award Lifecycle Control
- Award Status Flow:
  1. Calculated
  2. Eligible
  3. Generated (Admin action)
  4. Processed (Admin action)
- Generated না হলে Process করা যাবে না।
- Process এর পর record immutable হবে (audit exception ছাড়া)।

### FR-05: Fund Incentive Wallet Integration
- Incentive type যদি `fund` হয় এবং Admin Process করে, তাহলে:
  - Employee wallet balance update হবে
  - Wallet transaction তৈরি হবে
  - Notification পাঠানো হবে
- Transaction Type: `Promotion Reward`
- Reference: `Session Name + Slot`

### FR-06: Duplicate Protection
- একই Session + একই Slot + একই Employee একাধিকবার Process করা যাবে না।
- Wallet credit exactly-once হতে হবে।
- DB unique constraint + service-layer guard বাধ্যতামূলক।

### FR-07: Employee Dashboard Data
প্রতিটি Employee দেখতে পারবে:

#### অর্জিত প্রোমোশনসমূহ
- Session Name
- Slot
- Incentive Type
- Award Date

#### চলমান প্রোমোশনের অগ্রগতি
- Target
- Current Down Payment Count
- Remaining Count
- Eligibility Type (Personal / 1st Step / Combined)

উদাহরণ:
- Monthly Promotion
- Target: 20 Down Payments
- Your Count: 14
- Remaining: 6

### FR-08: Reporting & Transparency
- Eligible তালিকা (session-wise)
- Generated vs Processed Award রিপোর্ট
- Fund liability vs wallet disbursement রিপোর্ট
- Wallet reward ট্রেস রিপোর্ট (employee-wise)

---

## ৪) প্রস্তাবিত API Endpoints

### ৪.১ Admin APIs
- `POST /api/v1/promotions/sessions`
- `PUT /api/v1/promotions/sessions/{id}`
- `POST /api/v1/promotions/sessions/{id}/activate`
- `POST /api/v1/promotions/sessions/{id}/close`
- `POST /api/v1/promotions/sessions/{id}/calculate-eligibility`
- `POST /api/v1/promotions/awards/generate`
- `POST /api/v1/promotions/awards/process`

### ৪.২ Employee APIs
- `GET /api/v1/employee/promotions/achievements`
- `GET /api/v1/employee/promotions/progress`
- `GET /api/v1/employee/wallet/transactions?type=promotion_reward`

### ৪.৩ Wallet/Internal APIs
- `POST /api/v1/wallet/credits/promotion`
- `GET /api/v1/wallet/transactions/{id}`

---

## ৫) প্রস্তাবিত ডেটা মডেল

### ৫.১ `promotion_sessions`
- id
- name
- session_type (`monthly`, `yearly`)
- start_date
- end_date
- status (`draft`, `active`, `closed`)
- target_metric (`down_payment_count`)
- target_value
- min_product_or_share_sales
- created_by
- updated_by
- timestamps

### ৫.২ `promotion_rules`
- id
- session_id
- slot_no
- eligibility_basis (`personal`, `first_step`, `combined_step_1_2`)
- finance_verified_only (bool)
- incentive_type (`national_tour_self`, `national_tour_couple`, `foreign_tour_self`, `foreign_tour_couple`, `fund`, `car`, `house`)
- fund_amount (nullable)
- currency (nullable)
- timestamps

### ৫.৩ `promotion_eligibilities`
- id
- session_id
- rule_id
- employee_id
- current_down_payment_count
- current_sales_count
- eligibility_status (`not_eligible`, `eligible`)
- calculated_at
- timestamps

### ৫.৪ `promotion_awards`
- id
- session_id
- rule_id
- employee_id
- award_status (`generated`, `processed`)
- generated_by
- generated_at
- processed_by
- processed_at
- wallet_transaction_id (nullable)
- remarks
- timestamps

### ৫.৫ `wallet_transactions` (বিদ্যমান টেবিলের সাথে ইন্টিগ্রেশন)
- id
- wallet_id
- type (`promotion_reward`)
- amount
- currency
- reference_type (`promotion_award`)
- reference_id
- narration (উদাহরণ: "Monthly Promotion Reward – 50,000 BDT")
- created_at

---

## ৬) Validation Rules
- Session overlap policy অনুযায়ী active date range conflict অনুমোদিত হবে না।
- `end_date > start_date` বাধ্যতামূলক।
- Monthly session-এ eligibility basis শুধু `personal` বা `first_step` হতে পারবে।
- Yearly session-এ eligibility basis শুধু `combined_step_1_2` হতে পারবে।
- `min_product_or_share_sales >= 2` বাধ্যতামূলক।
- Fund incentive হলে `fund_amount > 0` বাধ্যতামূলক।
- একই award-এর জন্য একাধিক processed record নিষিদ্ধ (unique constraint)।

---

## ৭) System Flow (Fund Incentive)
1. Admin Promotion Session তৈরি ও Active করবে
2. সিস্টেম Eligibility গণনা করে Eligible তালিকা প্রস্তুত করবে
3. Admin “Generate Award” করবে
4. Admin “Process Award” করলে:
   - Employee Wallet-এ Fund Amount যোগ হবে
   - Wallet Transaction Record তৈরি হবে
   - Employee Notification পাবে

---

## ৮) Business Transparency নিশ্চয়তা
এই সিস্টেম নিশ্চিত করবে:
- ✔ Admin-এর পূর্ণ নিয়ন্ত্রণ
- ✔ Employee-এর Real-time Progress Visibility
- ✔ Fund-এর সরাসরি Wallet Integration
- ✔ প্রতিটি Transaction-এর পূর্ণ Traceability

---

## ৯) Final Business Flow Summary
- Monthly → Personal বা 1st Step ভিত্তিক
- Yearly → 1st & 2nd Step combined ভিত্তিক
- Eligibility → System Calculated
- Award → Admin Generated & Processed
- Fund → Wallet Credited
- Employee → Real-time Promotion Status Visible
