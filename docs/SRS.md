# আল-হামরা ব্রোকারেজ ম্যানেজমেন্ট সিস্টেম

## 1. ভূমিকা
### 1.1 উদ্দেশ্য
এই ডকুমেন্টটির উদ্দেশ্য হলো আল-হামরা ব্রোকারেজ ম্যানেজমেন্ট সিস্টেমের (পরে "সিস্টেম") সফটওয়্যার রিকোয়ারমেন্ট স্পেসিফিকেশন (SRS) উপস্থাপন করা। ডকুমেন্টটি প্রকল্প ব্যবস্থাপক, ডেভেলপার, পরীক্ষক এবং অন্যান্য অংশীজনকে প্রয়োজনীয় ফাংশনাল ও নন-ফাংশনাল চাহিদা সম্পর্কে স্পষ্ট নির্দেশনা দেবে।

### 1.2 পরিধি
সিস্টেমটি একটি API-প্রথম Laravel ভিত্তিক ব্যাকএন্ড যা এজেন্ট ও ব্রাঞ্চ ম্যানেজমেন্ট, বিক্রয় অর্ডার, ইনস্টলমেন্ট, পেমেন্ট, কমিশন, র‍্যাঙ্ক ইনসেনটিভ, অ্যাকাউন্টিং লেজার, ডকুমেন্ট স্টোরেজ এবং রিপোর্টিং পরিচালনা করে। ফ্রন্টএন্ড হিসেবে React এবং মোবাইলের জন্য Android অ্যাপ ব্যবহারের পরিকল্পনা রয়েছে।【F:README.md†L1-L20】【F:README.md†L35-L53】

### 1.3 সংজ্ঞা, অ্যাক্রোনিম ও সংক্ষিপ্ত রূপ
- API: Application Programming Interface
- RBAC: Role-Based Access Control
- JWT: JSON Web Token (Laravel Sanctum টোকেন হিসেবে ব্যবহৃত)
- ME/MM/…/HD: মার্কেটিং টিমের র‍্যাঙ্ক কোড
- SRS: Software Requirements Specification
- OTP: One-Time Password

### 1.4 রেফারেন্স
- প্রকল্প README
- Laravel 10 ডকুমেন্টেশন
- Swagger ডকুমেন্টেশন জেনারেশন নির্দেশনা

## 2. সামগ্রিক বিবরণ
### 2.1 পণ্যের দৃষ্টিভঙ্গি
সিস্টেমটি একটি মাল্টি-টিয়ার, API-প্রথম ব্যাকএন্ড যা React ও Android ক্লায়েন্টকে JSON API প্রদান করে। রাউটসমূহ `routes/api.php` ফাইলে সংজ্ঞায়িত এবং Sanctum ভিত্তিক টোকেন অথেনটিকেশন প্রয়োগ করা হয়েছে।【F:routes/api.php†L1-L79】

### 2.2 ব্যবসায়িক প্রেক্ষিত
আল-হামরা ব্রোকারেজ একটি সেলস ও কমিশন ড্রাইভন ব্যবসা যেখানে এজেন্টরা জমি, পণ্য ও সার্ভিস বিক্রি করে এবং ডাউন পেমেন্ট ও কিস্তির উপর কমিশন অর্জন করে। সিস্টেমটি এজেন্ট/ব্রাঞ্চ হায়ারার্কি, র‍্যাঙ্ক উন্নয়ন ও ইনসেনটিভ বিতরণকে স্বয়ংক্রিয় করে।

### 2.3 ব্যবহারকারী শ্রেণি ও বৈশিষ্ট্য
User মডেলে নিচের রোলসমূহ সমর্থিত: Admin, Branch Admin, Agent, Agent Admin, Employee, Owner, Director এবং Customer। প্রতিটি রোলের অধিকার Spatie Permission প্যাকেজের মাধ্যমে কনফিগারযোগ্য।【F:app/Models/User.php†L17-L55】

### 2.4 অপারেশনাল পরিবেশ
- Laravel 10, PHP 8.1+
- MySQL বা সামঞ্জস্যপূর্ণ RDBMS
- Redis সহ Queue/Horizon
- Storage ডিস্ক (লোকাল/S3)
- SSLCommerz পেমেন্ট গেটওয়ে ইন্টিগ্রেশন (Sandbox/Production)

### 2.5 ডিজাইন ও বাস্তবায়ন সীমাবদ্ধতা
- Sanctum টোকেনের মাধ্যমে API অ্যাক্সেস
- Spatie Activity Log দ্বারা অডিট ট্রেইল তৈরি (প্রতিটি মডেলের fillable পরিবর্তন লগ করা হয়)।【F:app/Traits/LogsActivityChanges.php†L1-L16】
- Double-entry লেজার পোস্টিং সবসময় ব্যালেন্সড হতে হবে; ব্যালেন্স না হলে InvalidArgumentException নিক্ষিপ্ত হয়।【F:app/Services/Accounting/LedgerService.php†L1-L44】

### 2.6 অনুমান ও নির্ভরতা
- সমস্ত ইমেইল/SMS নোটিফিকেশন Laravel Notification সিস্টেম ব্যবহার করবে।【F:app/Notifications/OtpNotification.php†L1-L39】
- Swagger ডকুমেন্টেশন `php artisan l5-swagger:generate` কমান্ডে আপডেট হয়।【F:README.md†L55-L69】

## 3. সিস্টেম ফিচার ও ফাংশনাল রিকোয়ারমেন্ট
### 3.1 অথেনটিকেশন ও অথরাইজেশন
1. ব্যবহারকারী রেজিস্ট্রেশন ও লগইন API উপলব্ধ; সাফল্যের পর Sanctum টোকেন প্রদান করা হয়।【F:app/Http/Controllers/AuthController.php†L13-L67】
2. Logout API বর্তমান টোকেন বাতিল করে।【F:app/Http/Controllers/AuthController.php†L69-L88】
3. কাস্টমারদের জন্য আলাদা রেজিস্ট্রেশন/লগইন API রয়েছে এবং তারা শুধুমাত্র নিজস্ব ডেটা দেখতে পারে।【F:routes/api.php†L20-L43】

### 3.2 ব্যবহারকারী ও রোল ব্যবস্থাপনা
1. Admin ব্রাঞ্চ, এজেন্ট, এমপ্লয়ি ও কাস্টমার তৈরি/হালনাগাদ/মুছে ফেলতে পারে।【F:routes/api.php†L45-L68】
2. AgentController নতুন এজেন্ট তৈরি করার সময় সংশ্লিষ্ট User তৈরি, Spatie Role অ্যাসাইন এবং পাসওয়ার্ড নোটিফাই করে।【F:app/Http/Controllers/AgentController.php†L33-L103】
3. কাস্টমার তালিকায় Agent/Admin ভূমিকাভিত্তিক ফিল্টার প্রয়োগ হয় এবং এজেন্ট শুধুমাত্র নিজের ক্রেতা দেখতে পারে।【F:app/Http/Controllers/CustomerController.php†L13-L96】

### 3.3 ব্রাঞ্চ ও এজেন্ট ব্যবস্থাপনা
1. এজেন্ট প্রোফাইলে ব্রাঞ্চ, ব্যবহারকারী, বিক্রয় সংখ্যা, র‍্যাঙ্ক মেম্বারশিপ সহ সম্পর্কিত তথ্য লোড করা যায়।【F:app/Http/Controllers/AgentController.php†L23-L78】
2. এজেন্ট মুছে ফেলার আগে তার কোন Sales Order থাকা যাবে না।【F:app/Http/Controllers/AgentController.php†L117-L136】

### 3.4 এমপ্লয়ি ও র‍্যাঙ্ক ব্যবস্থাপনা
1. Employee মডেল পূর্ণাঙ্গ বায়োডাটা, ঠিকানা, ফ্যামিলি তথ্য, শিক্ষা ও মনোনীত ব্যক্তির তথ্য সংরক্ষণ করে এবং ডকুমেন্ট আপলোড সমর্থন করে।【F:app/Models/Employee.php†L17-L97】
2. Rank, RankRequirement ও RankMembership মডেল র‍্যাঙ্ক কোড, প্রমোশন শর্ত, ইনসেনটিভ শতাংশ ও অর্জনের ইতিহাস ধারণ করে।【F:app/Models/Rank.php†L1-L34】【F:app/Models/RankRequirement.php†L1-L32】【F:app/Models/RankMembership.php†L1-L32】
3. `ranks:evaluate` কমান্ড মাসিক র‍্যাঙ্ক মূল্যায়ন চালায়; যোগ্য এজেন্টকে নতুন র‍্যাঙ্কে উন্নীত করে এবং ইনসেনটিভ লেজার এন্ট্রি রেকর্ড করে।【F:app/Console/Kernel.php†L11-L20】【F:app/Services/RankPromotionService.php†L1-L90】

### 3.5 কাস্টমার পোর্টাল কার্যাবলি
1. কাস্টমাররা প্রোফাইল দেখার/আপডেট করার সুবিধা পায় এবং পাসওয়ার্ড পরিবর্তন করলে স্বয়ংক্রিয়ভাবে হ্যাশ করা হয়।【F:app/Http/Controllers/Customer/CustomerProfileController.php†L8-L39】【F:app/Models/User.php†L47-L55】
2. কাস্টমার সেলস অর্ডার ও কিস্তির তালিকা দেখাতে পারে, প্রতিটি অর্ডারে আইটেম, পেমেন্ট ও ইনস্টলমেন্ট লোড হয়।【F:app/Http/Controllers/Customer/CustomerSalesOrderController.php†L10-L41】【F:app/Http/Controllers/Customer/CustomerInstallmentController.php†L10-L23】
3. অনলাইন পেমেন্ট ইনিশিয়েট করলে PaymentIntent তৈরি হয় এবং SSLCommerz রিডাইরেক্ট লিংক প্রদান করে।【F:app/Http/Controllers/Customer/CustomerPaymentController.php†L21-L76】【F:app/Services/Payments/SSLCommerzGateway.php†L1-L41】
4. গেটওয়ে কলব্যাক পেমেন্ট যাচাই করে, পেমেন্ট রেকর্ড তৈরি করে এবং সংশ্লিষ্ট ইনস্টলমেন্টে বরাদ্দ করে।【F:app/Http/Controllers/Customer/CustomerPaymentController.php†L78-L170】

### 3.6 প্রোডাক্ট, সার্ভিস ও স্টক
1. পণ্য ও সার্ভিস আলাদা মডেল/কন্ট্রোলারে পরিচালিত হয়; পণ্য স্টক ম্যানেজমেন্ট ফ্ল্যাগ, সর্বনিম্ন স্টক সতর্কতা ও স্টক মুভমেন্ট ইতিহাস বজায় রাখে।【F:app/Models/Product.php†L1-L47】【F:app/Models/StockMovement.php†L1-L41】
2. স্টক মুভমেন্ট API ইন/আউট, প্রোডাক্ট ও তারিখ ফিল্টারসহ পেজিনেশন সাপোর্ট করে।【F:app/Http/Controllers/ReportController.php†L146-L179】

### 3.7 বিক্রয় অর্ডার ব্যবস্থাপনা
1. SalesOrder মডেল Land/Share/Product/Service টাইপ, ডাউন পেমেন্ট, টোটাল, ক্রিয়েটর টাইপ ও স্ট্যাটাস ট্র্যাক করে এবং আইটেম, ইনস্টলমেন্ট, পেমেন্ট, কমিশন সম্পর্ক বজায় রাখে।【F:app/Models/SalesOrder.php†L1-L96】
2. SalesOrderController ডেটা যাচাই করে, এজেন্ট-ব্রাঞ্চ সামঞ্জস্য নিশ্চিত করে, আইটেম যোগ করে এবং স্টক সিঙ্ক্রোনাইজ করার হুক অন্তর্ভুক্ত করেছে।【F:app/Http/Controllers/SalesOrderController.php†L21-L123】
3. ডাউন পেমেন্ট টোটালের বেশি হলে ভ্যালিডেশন ত্রুটি প্রদান করে।【F:app/Http/Controllers/SalesOrderController.php†L73-L92】

### 3.8 ইনস্টলমেন্ট ও পেমেন্ট বরাদ্দ
1. CustomerInstallment মডেল প্রতিটি কিস্তির পরিমাণ, পরিশোধিত অংশ ও স্ট্যাটাস ট্র্যাক করে।【F:app/Models/CustomerInstallment.php†L1-L33】
2. PaymentAllocation মডেল পেমেন্টকে নির্দিষ্ট ইনস্টলমেন্টে বরাদ্দ করে এবং পেমেন্ট গেটওয়ে কলব্যাকের সময় আংশিক/পূর্ণ পরিশোধ স্ট্যাটাস আপডেট করে।【F:app/Http/Controllers/Customer/CustomerPaymentController.php†L112-L156】

### 3.9 পেমেন্ট ব্যবস্থাপনা
1. Payment মডেল ডাউন পেমেন্ট, ইনস্টলমেন্ট ও ফুল পেমেন্ট টাইপ সমর্থন করে এবং কমিশন ক্যালকুলেশনের জন্য কমিশনেবল পরিমাণ নির্ণয় করে।【F:app/Models/Payment.php†L1-L73】
2. পেমেন্ট তৈরি হলে PaymentRecorded ইভেন্ট ট্রিগার হয়, যা লেজার এন্ট্রি ও কমিশন প্রসেসিংয়ের জন্য লিসনার চালু করে।【F:app/Models/Payment.php†L61-L73】【F:app/Listeners/RecordPaymentLedgerEntry.php†L1-L44】【F:app/Listeners/ProcessPaymentCommissions.php†L1-L16】

### 3.10 কমিশন ইঞ্জিন
1. CommissionRule মডেল ট্রিগার, স্কোপ, রিসিপিয়েন্ট, শতকরা/ফ্ল্যাট পরিমাণ এবং মেটা কনফিগারেশন ধারণ করে।【F:app/Models/CommissionRule.php†L1-L37】
2. CommissionService পেমেন্ট টাইপ ও র‍্যাঙ্ক স্কোপ অনুযায়ী প্রযোজ্য নিয়ম নির্বাচন করে, কমিশন রেকর্ড তৈরি করে এবং কমিশন ব্যয় বনাম পাওনাদি লেজারে নথিভুক্ত করে।【F:app/Services/CommissionService.php†L1-L120】

### 3.11 অ্যাকাউন্টিং ও লেজার
1. LedgerService ডাবল-এন্ট্রি রেকর্ড নিশ্চিত করে এবং প্রয়োজনীয় অ্যাকাউন্ট স্বয়ংক্রিয়ভাবে তৈরি করে।【F:app/Services/Accounting/LedgerService.php†L1-L54】
2. কনফিগে Cash, Bank, Accounts Receivable, Commission Expense, Commission Payable এবং Incentive Fund অ্যাকাউন্ট কোড সংজ্ঞায়িত।【F:config/accounting.php†L1-L27】
3. পেমেন্ট ও র‍্যাঙ্ক ইনসেনটিভ উভয়ই লেজারে আলাদা ট্রান্সঅ্যাকশন তৈরি করে।【F:app/Listeners/RecordPaymentLedgerEntry.php†L1-L44】【F:app/Services/RankPromotionService.php†L71-L90】

### 3.12 রিপোর্টিং ও ড্যাশবোর্ড
1. Receivable, Payable, Commission, Rank Fund, Agent Performance ও Stock সম্পর্কিত রিপোর্ট API উপলব্ধ।【F:app/Http/Controllers/ReportController.php†L1-L179】
2. Dashboard সারাংশে বিক্রয়, সংগ্রহ, পাওনা, কমিশন, র‍্যাঙ্ক ফান্ড, স্টক ও কাস্টমার মেট্রিক্স প্রদান করে এবং Agent ব্যবহারকারীর জন্য ডেটা ফিল্টার করে।【F:app/Http/Controllers/ReportController.php†L59-L135】

### 3.13 ডকুমেন্ট ম্যানেজমেন্ট
1. DocumentController ফাইল আপলোড করার সময় ক্যাটাগরি ভিত্তিক স্টোরেজ, ডিস্ক নির্বাচন এবং আপলোডার ট্র্যাক করে।【F:app/Http/Controllers/DocumentController.php†L1-L42】
2. Document মডেল আকার, MIME টাইপ, পাথ ও আপলোডারের তথ্য সংরক্ষণ করে এবং যেকোন মডেলের সাথে পলিমরফিক সম্পর্ক স্থাপন করে।【F:app/Models/Document.php†L1-L40】

### 3.14 নোটিফিকেশন ও সতর্কতা
1. Agent ও Employee ক্রেডেনশিয়াল ইমেইল নোটিফিকেশন পাঠানো হয়।【F:app/Notifications/AgentCredentialNotification.php†L1-L63】
2. OTP নোটিফিকেশন ইমেইল ও ডাটাবেস চ্যানেলে পাঠানো হয়; ১০ মিনিট মেয়াদী।【F:app/Notifications/OtpNotification.php†L1-L39】
3. Payment Reminder কিস্তির নির্ধারিত তারিখের পূর্বে মেইল ও ইন-অ্যাপ নোটিফিকেশন প্রেরণ করে।【F:app/Notifications/PaymentReminderNotification.php†L1-L44】

### 3.15 অডিট ও লগিং
Spatie Activitylog-এর মাধ্যমে প্রতিটি মডেলের fillable ফিল্ড পরিবর্তনের লগ `audit` লগনেমে সংরক্ষণ হয়, যা ট্র্যাকিং ও অডিট ট্রেইল নিশ্চিত করে।【F:app/Traits/LogsActivityChanges.php†L1-L16】

## 4. ডেটা রিকোয়ারমেন্ট
### 4.1 প্রধান এন্টিটি ও সম্পর্ক
- User ←→ Agent/Employee (one-to-one)【F:app/Models/User.php†L57-L64】
- Agent ←→ SalesOrder/RankMembership (one-to-many)【F:app/Models/Agent.php†L16-L40】
- SalesOrder ←→ OrderItem/CustomerInstallment/Payment/Commission (one-to-many)【F:app/Models/SalesOrder.php†L65-L96】
- Payment ←→ Commission/PaymentAllocation (one-to-many)【F:app/Models/Payment.php†L75-L86】
- LedgerAccount ←→ LedgerEntry (one-to-many)【F:app/Models/LedgerAccount.php†L1-L28】【F:app/Models/LedgerEntry.php†L1-L33】

### 4.2 ডেটা ভ্যালিডেশন নিয়ম
- ইমেইল ইউনিক, পাসওয়ার্ড কমপক্ষে ৮ অক্ষরের এবং স্বয়ংক্রিয়ভাবে হ্যাশ হয়।【F:app/Http/Controllers/AuthController.php†L17-L45】【F:app/Models/User.php†L47-L55】
- Sales Order তৈরি/আপডেটের সময় বৈধ ব্রাঞ্চ, এজেন্ট ও সোর্স ME আইডি প্রয়োজন এবং ডাউন পেমেন্ট টোটালের চেয়ে বড় হতে পারে না।【F:app/Http/Controllers/SalesOrderController.php†L32-L92】
- কাস্টমার পেমেন্ট ইনিশিয়েশনে পরিমাণ শূন্যের বেশি হতে হবে এবং ইনস্টলমেন্ট টাইপ হলে বৈধ কিস্তি আইডি দিতে হবে।【F:app/Http/Controllers/Customer/CustomerPaymentController.php†L38-L86】

## 5. বাহ্যিক ইন্টারফেস রিকোয়ারমেন্ট
### 5.1 API ইন্টারফেস
- RESTful JSON API, সব রেসপন্স JSON অবজেক্ট/কলেকশন হিসেবে আসে।
- Sanctum Bearer টোকেন হেডারে দিতে হবে (Authorization: Bearer {token})।
- পেজিনেশন ডিফল্ট ১৫ আইটেম এবং `per_page` কুইরি প্যারামিটারে কাস্টমাইজযোগ্য।【F:app/Http/Controllers/AgentController.php†L42-L65】【F:app/Http/Controllers/ReportController.php†L162-L179】

### 5.2 তৃতীয় পক্ষ ইন্টিগ্রেশন
- SSLCommerz পেমেন্ট গেটওয়ে `services.sslcommerz` কনফিগ অনুযায়ী স্টোর আইডি/পাসওয়ার্ড, পেমেন্ট URL ও কারেন্সি ব্যবহার করে।【F:config/services.php†L31-L45】
- AWS S3 সহ অন্যান্য স্টোরেজ ড্রাইভার `league/flysystem-aws-s3` এর মাধ্যমে সমর্থিত।【F:composer.json†L8-L31】

### 5.3 নোটিফিকেশন চ্যানেল
- ইমেইল (MailMessage)
- ডাটাবেস নোটিফিকেশন (activity feed)
- ভবিষ্যতে SMS ইন্টিগ্রেশনের জন্য Notification via মেথড সম্প্রসারণযোগ্য।

## 6. নন-ফাংশনাল রিকোয়ারমেন্ট
### 6.1 সিকিউরিটি
- সকল পাসওয়ার্ড হ্যাশড ফিল্ডে সংরক্ষিত।【F:app/Models/User.php†L47-L55】
- RBAC Spatie Permission দ্বারা নিয়ন্ত্রিত এবং রোলভিত্তিক মিডলওয়্যার প্রয়োগ করা হয়েছে (যেমন `role.customer`)।【F:routes/api.php†L27-L43】
- ডকুমেন্ট আপলোডের সময় শুধুমাত্র অথেনটিকেটেড ব্যবহারকারী `uploaded_by` হিসেবে লিপিবদ্ধ হয়।【F:app/Http/Controllers/DocumentController.php†L15-L42】

### 6.2 পারফরম্যান্স
- বড় ডেটাসেটের জন্য পেজিনেশন ডিফল্ট ১৫ আইটেম।
- এজেন্ট ও রিপোর্ট এন্ডপয়েন্টে প্রয়োজনীয় সম্পর্ক ইগার লোড করা হয় যাতে N+1 কোয়েরি কমে।【F:app/Http/Controllers/AgentController.php†L23-L78】【F:app/Http/Controllers/ReportController.php†L10-L179】

### 6.3 স্কেলেবিলিটি
- Queue ও Scheduler ব্যাকগ্রাউন্ড কাজ (OTP, পেমেন্ট রিমাইন্ডার, র‍্যাঙ্ক মূল্যায়ন) সমর্থন করে; Redis/Horizon ব্যবহার সুপারিশকৃত।【F:README.md†L21-L48】

### 6.4 রিলায়েবিলিটি
- লেজার পোস্টিং সবসময় ট্রানজেকশনাল ব্লকে সম্পন্ন হয় যাতে ডাটা কনসিসটেন্সি বজায় থাকে।【F:app/Services/Accounting/LedgerService.php†L30-L44】
- কমিশন ও র‍্যাঙ্ক প্রমোশন প্রসেস ডাটাবেজ ট্রানজেকশনের মধ্যে সম্পাদিত হয়।【F:app/Services/CommissionService.php†L37-L78】【F:app/Services/RankPromotionService.php†L33-L90】

### 6.5 মেইনটেইনেবিলিটি
- কোডবেস Laravel কনভেনশন মেনে কন্ট্রোলার/মডেল/রিসোর্স স্ট্রাকচার ব্যবহার করে।
- Activity Log ও কনফিগ ড্রাইভেন কমিশন নিয়ম সহজে সম্প্রসারণযোগ্য।

### 6.6 ইউজেবিলিটি
- কাস্টমার API গুলি ফ্রন্টএন্ডে গ্রাহক অভিজ্ঞতা উন্নত করতে সাজানো (প্রোফাইল, অর্ডার, পেমেন্ট ইতিহাস)।【F:app/Http/Controllers/Customer/CustomerPaymentController.php†L21-L170】

### 6.7 ব্যাকআপ ও রিকভারি
- README তে ডাটাবেস ও স্টোরেজ ব্যাকআপ কনফিগার করার নির্দেশনা রয়েছে এবং ব্যাকআপ ডিস্ক পরিবেশ ভেরিয়েবল দ্বারা নির্ধারিত।【F:README.md†L49-L53】

## 7. অপারেশন ও ডেপ্লয়মেন্ট নির্দেশনা
1. `.env` কনফিগার করার পর `composer install`, `php artisan migrate`, `php artisan key:generate` চালাতে হবে।【F:README.md†L21-L34】
2. ডেভ সার্ভারের জন্য `php artisan serve`, Queue প্রসেসের জন্য `php artisan horizon` চালু রাখতে হবে।【F:README.md†L35-L48】
3. প্রোডাকশনে কনফিগ ও রুট ক্যাশ, Horizon ও Scheduler সক্রিয় এবং ব্যাকআপ ভেরিফাই করতে হবে।【F:README.md†L71-L94】

## 8. সীমাবদ্ধতা ও ভবিষ্যৎ উন্নয়ন
- InstallmentController এ জেনারেশন লজিক এখনও সংযোজিত হয়নি; ভবিষ্যতে কিস্তি সময়সূচি জেনারেশনের API সম্পূর্ণ করতে হবে।【F:app/Http/Controllers/InstallmentController.php†L1-L9】
- AI-চালিত সেলস রেকমেন্ডেশন ও CRM ইন্টিগ্রেশন ভবিষ্যৎ পরিকল্পনার অংশ (README-র প্রসঙ্গ)।

