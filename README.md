# Al-Hamra Brokerage Management API

Laravel 10 based backend API for the Al-Hamra Brokerage Management System. The project embraces an API-first architecture to power the web and mobile clients that will cover supplier onboarding, customer transactions, commission distribution, and rank progression.

## Getting started

### Prerequisites
- PHP 8.2+
- Composer 2
- Node.js 18+
- MySQL 8 (or any Laravel-supported database)

### Installation
```bash
cp .env.example .env
composer install
php artisan key:generate
php artisan migrate
php artisan serve
```

### Running tests
```bash
php artisan test
```

> **Note:** When working in restricted environments without GitHub access, `composer install` may require GitHub OAuth credentials to download some dependencies from source.

## API endpoints

All endpoints are prefixed with `/api/v1` and require Sanctum authentication unless stated otherwise.

### Authentication
- `POST /auth/login`
- `POST /auth/register`
- `POST /auth/logout` (authenticated)

### Catalog
- `GET /categories` – List categories with optional `type` and `per_page` filters.
- `POST /categories` – Create a new category (`name`, `type`).
- `GET /categories/{id}` – Retrieve category details with product/service counters.
- `PUT /categories/{id}` – Update the category.
- `DELETE /categories/{id}` – Delete when no products or services are attached.

- `GET /products` – List products filtered by `category_id` or `product_type`.
- `POST /products` – Create a product (`category_id`, `name`, `product_type`, optional `price`, `attributes`).
- `GET /products/{id}` – Retrieve product with its category.
- `PUT /products/{id}` – Update product information.
- `DELETE /products/{id}` – Remove a product.

- `GET /services` – List services filtered by `category_id`.
- `POST /services` – Create a service (`category_id`, `name`, optional `price`, `attributes`).
- `GET /services/{id}` – Retrieve service with its category.
- `PUT /services/{id}` – Update service information.
- `DELETE /services/{id}` – Remove a service.

## Postman collection

A ready-to-import Postman collection covering the catalog endpoints lives at [`docs/postman/al-hamra-brokerage.postman_collection.json`](docs/postman/al-hamra-brokerage.postman_collection.json). Configure the `base_url` and `access_token` variables after importing to begin testing.

## Project structure highlights
- `app/Http/Controllers` – REST controllers for the catalog domain.
- `app/Http/Requests` – Form requests that handle validation rules.
- `app/Http/Resources` – API response transformers ensuring consistent payloads.
- `database/migrations` – Schema definitions for categories, products, and services.

Further modules (land management, commissions, ranks, etc.) will build upon this foundation.
