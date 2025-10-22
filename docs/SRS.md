# আল-হামরা ব্রোকারেজ ম্যানেজমেন্ট সিস্টেম – Software Requirements Specification

## 1. ভূমিকা
### 1.1 উদ্দেশ্য
এই ডকুমেন্টটি আল-হামরা ব্রোকারেজ ম্যানেজমেন্ট সিস্টেমের (পরবর্তী অংশে “সিস্টেম”) কার্যকরী ও অকার্যকরী চাহিদাগুলিকে সুনির্দিষ্ট করে। প্রকল্প ব্যবস্থাপক, ডেভেলপার, পরীক্ষক এবং অন্যান্য স্টেকহোল্ডাররা এখান থেকে সাম্প্রতিক ফিচার আপডেটসহ সিস্টেমের প্রত্যাশিত আচরণ সম্পর্কে দ্রুত ধারণা পাবেন।

### 1.2 পরিধি
সিস্টেমটি Laravel 10 ভিত্তিক REST API, React ভিত্তিক অ্যাডমিন ইন্টারফেস, Android গ্রাহক অ্যাপ এবং সংশ্লিষ্ট ব্যাকঅফিস সেবাসমূহকে অন্তর্ভুক্ত করে। নতুন সংস্করণে অ্যাডমিন পেমেন্ট রিপোর্ট, উন্নত বিশ্লেষণাত্মক প্রতিবেদন এবং কর্মদক্ষতা ট্র্যাকিং একত্রিত হয়েছে।

### 1.3 অভিধান
- API: Application Programming Interface
- RBAC: Role Based Access Control
- CSV: Comma Separated Values
- SRS: Software Requirements Specification
- OTP: One Time Password

### 1.4 রেফারেন্স
- README.md (সেটআপ ও রান নির্দেশনা)
- Swagger ডকুমেন্টেশন (php artisan l5-swagger:generate)
- Postman সংগ্রহ: docs/postman/Al-Hamra Brokerage API v2.postman_collection.json

## 2. সিস্টেম ওভারভিউ
### 2.1 ব্যবহারকারী শ্রেণি
- Admin, Branch Admin, Agent, Agent Admin, Employee, Owner, Director
- Customer (Self-service পোর্টাল)

### 2.2 প্রাথমিক অপারেটিং পরিবেশ
- PHP 8.1+, Laravel 10
- MySQL (প্রধান ডাটাবেইস), Redis (Queue/Horizon)
- ফাইল স্টোরেজ: লোকাল অথবা AWS S3

### 2.3 অনুমান ও নির্ভরশীলতা
- Laravel Sanctum দ্বারা API টোকেন জেনারেশন
- Spatie Permission দ্বারা রোল ও পারমিশন ব্যবস্থাপনা
- SSLCommerz গেটওয়ের মাধ্যমে অনলাইন পেমেন্ট

## 3. কার্যকরী চাহিদা
### 3.1 অথেন্টিকেশন ও ইউজার ম্যানেজমেন্ট
- লগইন, রেজিস্ট্রেশন, পাসওয়ার্ড পুনরুদ্ধার ও লগআউট API
- রোল ভিত্তিক প্রবেশ ও JWT সদৃশ Bearer টোকেন (Sanctum)

### 3.2 সেলস অর্ডার ও ইনস্টলমেন্ট
- সেলস অর্ডার CRUD, কিস্তি জেনারেশন ও পুনঃনির্ধারণ
- কাস্টমার ইনস্টলমেন্ট তালিকা ও আপডেট

### 3.3 পেমেন্ট ব্যবস্থাপনা
- সেলস অর্ডারের বিপরীতে পেমেন্ট রেকর্ডিং এবং কিস্তি বরাদ্দF:app/Http/Controllers/PaymentController.php+L128-L183?
- ইভেন্ট ট্রিগার PaymentRecorded দ্বারা লেজার এন্ট্রি সিঙ্কF:app/Listeners/RecordPaymentLedgerEntry.php+L1-L60?

### 3.4 অ্যাকাউন্টিং ও লেজার
- ডাবল এন্ট্রি লেজার সার্ভিসF:app/Services/Accounting/LedgerService.php+L1-L78?
- কনফিগারযোগ্য চার্ট অফ অ্যাকাউন্টF:config/accounting.php+L1-L40?

### 3.5 রিপোর্ট ও বিশ্লেষণ
1. সারসংক্ষেপ প্রতিবেদন (Receivables, Payables, Commission, Rank Fund, Agent Performance, Stock)F:app/Http/Controllers/ReportController.php+L1-L179?
2. /api/v1/payments এন্ডপয়েন্টের মাধ্যমে পেমেন্ট ইতিহাস তালিকা, উন্নত ফিল্টার (গ্রাহক, এজেন্ট, শাখা, সেলস টাইপ), সারাংশ এবং CSV/প্রিন্ট আউটপুটF:app/Http/Controllers/PaymentController.php+L19-L240?
3. উন্নত অ্যাডমিন রিপোর্টসমূহ—
   - কমিশন বিস্তারিত: /api/v1/reports/commissions/detail
   - সেলস বিস্তারিত: /api/v1/reports/sales/detail
   - স্টক বিস্তারিত: /api/v1/reports/stock/detail
   - আয় লেজার: /api/v1/reports/incomes
   - গ্রাহক লেজার: /api/v1/reports/ledger/customer
   - সাপ্লায়ার লেজার: /api/v1/reports/ledger/supplier
   - অ্যাকাউন্ট স্টেটমেন্ট: /api/v1/reports/ledger/account
   > প্রতিটি এন্ডপয়েন্টে বহুমাত্রিক ফিল্টার, রিলেশন ইনক্লুড, সারাংশ এবং CSV/Print রেসপন্স বিদ্যমান।F:app/Http/Controllers/AdminReportController.php+L24-L620?
4. কর্মদক্ষতা প্রতিবেদন: /api/v1/reports/employee-performance এন্ডপয়েন্টে সংগ্রহকৃত সেলস সংখ্যা, মোট বিক্রয়, ডাউন-পেমেন্ট, সংগ্রহ, গড় অর্ডার মূল্য ও সংগ্রহ হার প্রকাশিত হয়।F:app/Http/Controllers/AdminReportController.php+L346-L520?
5. ড্যাশবোর্ড স্ট্যাটিস্টিক্স (মোট বিক্রয়, আদায়, গ্রাহক সংক্ষিপ্তসার, স্টক সারাংশ)।F:app/Http/Controllers/ReportController.php+L59-L135?

### 3.6 নোটিফিকেশন
- OTP, এজেন্ট ক্রেডেনশিয়াল, পেমেন্ট রিমাইন্ডার নোটিফিকেশনF:app/Notifications/OtpNotification.php+L1-L39?

### 3.7 অ্যাক্টিভিটি লগ
- প্রতিটি মডেলে পরিবর্তন লগ Spatie Activitylog দ্বারা সংরক্ষণ

## 4. অকার্যকরী চাহিদা
### 4.1 নিরাপত্তা
- HTTPS বাধ্যতামূলক
- রোল ভিত্তিক অনুমতি যাচাই
- সংবেদনশীল ডেটার জন্য সার্ভার সাইড এনক্রিপশন

### 4.2 কর্মদক্ষতা
- পেমেন্ট ও রিপোর্ট এন্ডপয়েন্টগুলোতে প্যাজিনেশন ডিফল্ট 15/25
- বড় এক্সপোর্টের ক্ষেত্রে স্ট্রিমড CSV ডাউনলোড ব্যবহৃত হচ্ছে

### 4.3 স্কেলেবিলিটি
- Redis Queue/Horizon দ্বারা ব্যাকগ্রাউন্ড জব
- পৃথক রিপোর্ট সার্ভিসে ক্লোনযোগ্য কোয়েরি ব্যবহার

### 4.4 লগিং ও মনিটরিং
- Horizon ড্যাশবোর্ড, অ্যাপ্লিকেশন লগ এবং ডাটাবেস অডিট ট্রেল

## 5. বহিঃস্থ ইন্টারফেস
### 5.1 API এন্ডপয়েন্ট সারাংশ
| মডিউল | HTTP মেথড | রুট | উদ্দেশ্য |
| --- | --- | --- | --- |
| পেমেন্ট | GET | /api/v1/payments | ফিল্টারসহ পেমেন্ট রিপোর্ট |
| রিপোর্ট | GET | /api/v1/reports/commissions/detail | কমিশন বিস্তারিত |
| রিপোর্ট | GET | /api/v1/reports/sales/detail | সেলস বিস্তারিত |
| রিপোর্ট | GET | /api/v1/reports/stock/detail | স্টক মূল্যায়ন |
| রিপোর্ট | GET | /api/v1/reports/incomes | আয় লেজার |
| রিপোর্ট | GET | /api/v1/reports/ledger/customer | গ্রাহক লেজার |
| রিপোর্ট | GET | /api/v1/reports/ledger/supplier | সাপ্লায়ার লেজার |
| রিপোর্ট | GET | /api/v1/reports/ledger/account | অ্যাকাউন্ট স্টেটমেন্ট |
| রিপোর্ট | GET | /api/v1/reports/employee-performance | কর্মদক্ষতা বিশ্লেষণ |

### 5.2 API প্রতিক্রিয়া বৈশিষ্ট্য
- JSON বডি, প্যাজিনেটেড রেসপন্সে summary অবজেক্ট সহ
- CSV ডাউনলোডের জন্য স্ট্রিমড রেসপন্স হেডার
- প্রিন্ট ভিউয়ের জন্য ormat=print অথবা print=1

## 6. পরীক্ষার মানদণ্ড
- ইউনিট টেস্ট দ্বারা পেমেন্ট ও রিপোর্ট কোয়েরি যাচাই
- পোস্টম্যান কালেকশন দ্বারা ম্যানুয়াল রিগ্রেশন (Reports ফোল্ডারে নতুন রিকোয়েস্ট অন্তর্ভুক্ত)F:docs/postman/Al-Hamra Brokerage API v2.postman_collection.json+L1480-L3200?

## 7. ভবিষ্যৎ উন্নয়ন
- অফলাইনে রিপোর্ট ব্যাচ স্কেজুলিং
- গ্রাফ ভিত্তিক ড্যাশবোর্ড ভিজ্যুয়ালাইজেশন
- AI সহায়ক বিক্রয় পূর্বাভাস

