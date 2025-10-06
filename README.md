# Alhamra API

Backend services for the Alhamra sales and commission platform. The project is built with Laravel 10 and provides order management, commission automation, accounting, and reporting APIs.

## Features

- Agent & branch management with role-based permissions.
- Sales order lifecycle with installments, payments, and allocations.
- Event-driven commission engine with configurable rules and distribution.
- Rank promotion scheduler that evaluates agents and records incentive funds.
- Double-entry accounting ledger for payments, commissions, and incentives.
- Reporting and dashboard endpoints for receivables, payables, commissions, rank funds, and agent performance.
- Secure document storage for contracts, invoices, and identification documents.
- Audit logging via `spatie/laravel-activitylog` for key models.
- Notification channels (OTP, payment reminders) using Laravel Notifications.

## Getting Started

```bash
cp .env.example .env
composer install
php artisan key:generate
php artisan migrate
```

Run the development server:

```bash
php artisan serve
```

### Background Workers

Queues are required for OTP delivery, payment reminders, and other background jobs. Configure Redis and run a worker with Horizon or Supervisor:

```bash
php artisan horizon
```

Set the Horizon prefix/domain through the `.env` file if the application is running behind a load balancer.

### Scheduler

Rank promotion and other scheduled jobs rely on the Laravel scheduler. Add the following Cron entry to your server:

```
* * * * * php /path/to/artisan schedule:run >> /dev/null 2>&1
```

### Backups

Configure `BACKUP_DISK` and schedule database/storage backups using your preferred tooling. Ensure the storage disk is available (local or S3).

### Swagger Documentation

API documentation is powered by `darkaonline/l5-swagger`.

```bash
php artisan l5-swagger:generate
```

The generated docs will be available under `storage/api-docs` and can be served via your preferred viewer.

### Testing

```bash
php artisan test
```

## Deployment Checklist

- Update `.env` with production database, cache, queue, mail, and storage credentials.
- Run database migrations: `php artisan migrate --force`.
- Warm up caches: `php artisan config:cache && php artisan route:cache`.
- Start Horizon (or Supervisor-managed queue workers).
- Ensure the scheduler is active (`php artisan schedule:work` or system cron).
- Generate Swagger docs and distribute to the team.
- Verify backups are configured for both the database and storage disks.

## License

This project is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
