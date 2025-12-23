-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 23, 2025 at 06:06 AM
-- Server version: 10.11.14-MariaDB-ubu2204
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `alha_alhamra`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `log_name` varchar(255) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `subject_type` varchar(255) DEFAULT NULL,
  `subject_id` bigint(20) UNSIGNED DEFAULT NULL,
  `causer_type` varchar(255) DEFAULT NULL,
  `causer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`properties`)),
  `batch_uuid` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_log`
--

INSERT INTO `activity_log` (`id`, `log_name`, `event`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(1, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-03 17:28:11', '2025-11-03 17:28:11'),
(2, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"itemable_id\":2,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-03 17:28:11', '2025-11-03 17:28:11'),
(3, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"due_date\":\"2025-11-08T00:00:00.000000Z\",\"amount\":\"450000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-03 17:28:16', '2025-11-03 17:28:16'),
(4, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 17:30:29', '2025-11-03 17:30:29'),
(5, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 17:30:29', '2025-11-03 17:30:29'),
(6, 'audit', 'updated', 'updated', 'App\\Models\\Employee', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"rank\":\"MM\"},\"old\":{\"rank\":\"ME\"}}', NULL, '2025-11-03 17:30:29', '2025-11-03 17:30:29'),
(7, 'audit', 'created', 'created', 'App\\Models\\Payment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"paid_at\":\"2025-11-03T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"bank_transfer\",\"meta\":{\"reference\":\"12121212\"}}}', NULL, '2025-11-03 17:30:29', '2025-11-03 17:30:29'),
(8, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":1,\"customer_installment_id\":1,\"allocated\":\"0.00\"}}', NULL, '2025-11-03 17:30:29', '2025-11-03 17:30:29'),
(9, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-03 17:30:29', '2025-11-03 17:30:29'),
(10, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":100000},\"old\":{\"value\":50000}}', NULL, '2025-11-03 17:35:31', '2025-11-03 17:35:31'),
(11, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-03 17:37:45', '2025-11-03 17:37:45'),
(12, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-03 17:37:45', '2025-11-03 17:37:45'),
(13, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"due_date\":\"2025-11-08T00:00:00.000000Z\",\"amount\":\"450000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-03 17:37:50', '2025-11-03 17:37:50'),
(14, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 17:38:01', '2025-11-03 17:38:01'),
(15, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 17:38:01', '2025-11-03 17:38:01'),
(16, 'audit', 'updated', 'updated', 'App\\Models\\Employee', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"rank\":\"MM\"},\"old\":{\"rank\":\"ME\"}}', NULL, '2025-11-03 17:38:01', '2025-11-03 17:38:01'),
(17, 'audit', 'created', 'created', 'App\\Models\\Payment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"paid_at\":\"2025-11-03T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"bank_transfer\",\"meta\":{\"reference\":\"123123213\"}}}', NULL, '2025-11-03 17:38:01', '2025-11-03 17:38:01'),
(18, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":1,\"customer_installment_id\":1,\"allocated\":\"0.00\"}}', NULL, '2025-11-03 17:38:01', '2025-11-03 17:38:01'),
(19, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-03 17:38:01', '2025-11-03 17:38:01'),
(20, 'audit', 'updated', 'updated', 'App\\Models\\RankRequirement', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"personal_sales_target\":\"50000.00\"},\"old\":{\"personal_sales_target\":\"10000.00\"}}', NULL, '2025-11-03 17:51:38', '2025-11-03 17:51:38'),
(21, 'audit', 'updated', 'updated', 'App\\Models\\RankRequirement', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"personal_sales_target\":\"250000.00\"},\"old\":{\"personal_sales_target\":\"1000000.00\"}}', NULL, '2025-11-03 17:51:52', '2025-11-03 17:51:52'),
(22, 'audit', 'updated', 'updated', 'App\\Models\\RankRequirement', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"personal_sales_target\":\"750000.00\"},\"old\":{\"personal_sales_target\":\"1500000.00\"}}', NULL, '2025-11-03 17:52:26', '2025-11-03 17:52:26'),
(23, 'audit', 'updated', 'updated', 'App\\Models\\RankRequirement', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"personal_sales_target\":\"3750000.00\"},\"old\":{\"personal_sales_target\":\"2500000.00\"}}', NULL, '2025-11-03 17:53:02', '2025-11-03 17:53:02'),
(24, 'audit', 'updated', 'updated', 'App\\Models\\RankRequirement', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"personal_sales_target\":\"6250000.00\"},\"old\":{\"personal_sales_target\":\"3000000.00\"}}', NULL, '2025-11-03 17:53:23', '2025-11-03 17:53:23'),
(25, 'audit', 'updated', 'updated', 'App\\Models\\RankRequirement', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"personal_sales_target\":\"10000000.00\"},\"old\":{\"personal_sales_target\":\"3500000.00\"}}', NULL, '2025-11-03 17:53:41', '2025-11-03 17:53:41'),
(26, 'audit', 'updated', 'updated', 'App\\Models\\RankRequirement', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"personal_sales_target\":\"75000000.00\"},\"old\":{\"personal_sales_target\":\"4000000.00\"}}', NULL, '2025-11-03 17:54:03', '2025-11-03 17:54:03'),
(27, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-03 17:57:03', '2025-11-03 17:57:03'),
(28, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-03 17:57:03', '2025-11-03 17:57:03'),
(29, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"due_date\":\"2025-11-08T00:00:00.000000Z\",\"amount\":\"450000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-03 17:57:10', '2025-11-03 17:57:10'),
(30, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 17:57:26', '2025-11-03 17:57:26'),
(31, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 17:57:26', '2025-11-03 17:57:26'),
(32, 'audit', 'created', 'created', 'App\\Models\\Payment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"paid_at\":\"2025-11-03T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"bank_transfer\",\"meta\":{\"reference\":\"123213213123\"}}}', NULL, '2025-11-03 17:57:26', '2025-11-03 17:57:26'),
(33, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":1,\"customer_installment_id\":1,\"allocated\":\"0.00\"}}', NULL, '2025-11-03 17:57:26', '2025-11-03 17:57:26'),
(34, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-03 17:57:26', '2025-11-03 17:57:26'),
(35, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-03 17:58:33', '2025-11-03 17:58:33'),
(36, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":2,\"itemable_id\":2,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-03 17:58:33', '2025-11-03 17:58:33'),
(37, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":2,\"due_date\":\"2025-11-08T00:00:00.000000Z\",\"amount\":\"450000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-03 17:58:50', '2025-11-03 17:58:50'),
(38, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-2\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":2,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 17:59:07', '2025-11-03 17:59:07'),
(39, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-2\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":2,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 17:59:07', '2025-11-03 17:59:07'),
(40, 'audit', 'created', 'created', 'App\\Models\\Payment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"paid_at\":\"2025-11-03T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"bank_transfer\",\"meta\":{\"reference\":\"3123123123\"}}}', NULL, '2025-11-03 17:59:07', '2025-11-03 17:59:07'),
(41, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":2,\"customer_installment_id\":1,\"allocated\":\"0.00\"}}', NULL, '2025-11-03 17:59:07', '2025-11-03 17:59:07'),
(42, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-03 18:13:18', '2025-11-03 18:13:18'),
(43, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-03 18:13:18', '2025-11-03 18:13:18'),
(44, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"due_date\":\"2025-11-08T00:00:00.000000Z\",\"amount\":\"450000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-03 18:13:23', '2025-11-03 18:13:23'),
(45, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 18:14:20', '2025-11-03 18:14:20'),
(46, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 18:14:20', '2025-11-03 18:14:20'),
(47, 'audit', 'created', 'created', 'App\\Models\\Payment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"paid_at\":\"2025-11-03T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"bank_transfer\",\"meta\":{\"reference\":\"123213213\"}}}', NULL, '2025-11-03 18:14:20', '2025-11-03 18:14:20'),
(48, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":1,\"customer_installment_id\":1,\"allocated\":\"0.00\"}}', NULL, '2025-11-03 18:14:20', '2025-11-03 18:14:20'),
(49, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-03 18:14:20', '2025-11-03 18:14:20'),
(50, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-03 18:15:31', '2025-11-03 18:15:31'),
(51, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":2,\"itemable_id\":2,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-03 18:15:31', '2025-11-03 18:15:31'),
(52, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":2,\"due_date\":\"2025-11-08T00:00:00.000000Z\",\"amount\":\"450000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-03 18:15:36', '2025-11-03 18:15:36'),
(53, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-2\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":2,\"sales_order_id\":1,\"method\":\"cash\"}}}', NULL, '2025-11-03 18:15:53', '2025-11-03 18:15:53'),
(54, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-2\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":2,\"sales_order_id\":1,\"method\":\"cash\"}}}', NULL, '2025-11-03 18:15:53', '2025-11-03 18:15:53'),
(55, 'audit', 'updated', 'updated', 'App\\Models\\Employee', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"rank\":\"MM\"},\"old\":{\"rank\":\"ME\"}}', NULL, '2025-11-03 18:15:53', '2025-11-03 18:15:53'),
(56, 'audit', 'created', 'created', 'App\\Models\\Payment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"paid_at\":\"2025-11-03T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"123213\"}}}', NULL, '2025-11-03 18:15:53', '2025-11-03 18:15:53'),
(57, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":2,\"customer_installment_id\":1,\"allocated\":\"0.00\"}}', NULL, '2025-11-03 18:15:53', '2025-11-03 18:15:53'),
(58, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-03 18:28:32', '2025-11-03 18:28:32'),
(59, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-03 18:28:32', '2025-11-03 18:28:32'),
(60, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"due_date\":\"2025-11-08T00:00:00.000000Z\",\"amount\":\"450000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-03 18:28:37', '2025-11-03 18:28:37'),
(61, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 18:28:51', '2025-11-03 18:28:51'),
(62, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 18:28:51', '2025-11-03 18:28:51'),
(63, 'audit', 'created', 'created', 'App\\Models\\Payment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"paid_at\":\"2025-11-03T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"bank_transfer\",\"meta\":{\"reference\":\"21313213\"}}}', NULL, '2025-11-03 18:28:51', '2025-11-03 18:28:51'),
(64, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":1,\"customer_installment_id\":1,\"allocated\":\"0.00\"}}', NULL, '2025-11-03 18:28:51', '2025-11-03 18:28:51'),
(65, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-03 18:28:51', '2025-11-03 18:28:51'),
(66, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"600000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-03 18:31:04', '2025-11-03 18:31:04'),
(67, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":2,\"itemable_id\":2,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"600000.00\",\"line_total\":\"600000.00\"}}', NULL, '2025-11-03 18:31:04', '2025-11-03 18:31:04'),
(68, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":2,\"due_date\":\"2025-11-08T00:00:00.000000Z\",\"amount\":\"550000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-03 18:31:09', '2025-11-03 18:31:09'),
(69, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-2\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":2,\"sales_order_id\":2,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 18:31:22', '2025-11-03 18:31:22'),
(70, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-2\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":2,\"sales_order_id\":2,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-03 18:31:22', '2025-11-03 18:31:22'),
(71, 'audit', 'updated', 'updated', 'App\\Models\\Employee', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"rank\":\"MM\"},\"old\":{\"rank\":\"ME\"}}', NULL, '2025-11-03 18:31:22', '2025-11-03 18:31:22'),
(72, 'audit', 'created', 'created', 'App\\Models\\Payment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":2,\"paid_at\":\"2025-11-03T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"bank_transfer\",\"meta\":{\"reference\":\"23243243\"}}}', NULL, '2025-11-03 18:31:22', '2025-11-03 18:31:22'),
(73, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":2,\"customer_installment_id\":2,\"allocated\":\"0.00\"}}', NULL, '2025-11-03 18:31:22', '2025-11-03 18:31:22'),
(74, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-03 18:31:22', '2025-11-03 18:31:22'),
(75, 'audit', 'created', 'created', 'App\\Models\\Employee', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":50,\"branch_id\":2,\"agent_id\":null,\"superior_id\":12,\"employee_code\":\"AL-00010\",\"rank\":\"ME\",\"full_name_en\":\"SABBIR MIA\",\"full_name_bn\":\"SABBIR MIA\",\"father_name\":\"SAJED\",\"mother_name\":\"SHAJEDA BEGUM\",\"mobile\":\"0199222121\",\"national_id\":\"13123123123\",\"date_of_birth\":\"1998-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-04 15:52:07', '2025-11-04 15:52:07'),
(76, 'audit', 'created', 'created', 'App\\Models\\EmployeeEducation', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":19,\"level\":\"Bachelor\\/Honours\",\"institution\":null,\"subject\":\"CSE\",\"result\":\"3.56\",\"passing_year\":\"2025\"}}', NULL, '2025-11-04 15:52:07', '2025-11-04 15:52:07'),
(77, 'audit', 'created', 'created', 'App\\Models\\EmployeeNominee', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":19,\"name\":\"MD MAYIN UDDIN\",\"relation\":\"Brother\",\"phone\":\"01999070234\",\"email\":null,\"address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\"}}', NULL, '2025-11-04 15:52:07', '2025-11-04 15:52:07'),
(78, 'audit', 'created', 'created', 'App\\Models\\EmployeeNominee', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":19,\"name\":\"MD MAYIN UDDIN\",\"relation\":\"Brother\",\"phone\":\"01999070234\",\"email\":null,\"address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\"}}', NULL, '2025-11-04 15:52:07', '2025-11-04 15:52:07'),
(79, 'audit', 'created', 'created', 'App\\Models\\Document', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"documentable_type\":\"App\\\\Models\\\\Employee\",\"documentable_id\":19,\"category\":\"photo\",\"disk\":\"local\",\"path\":\"documents\\/employees\\/photo\\/gJfsZSYmdnC9OwR5QDOMzDYmQFFx3zeDEv19nLEL.png\",\"original_name\":\"cng.png\",\"mime_type\":\"image\\/png\",\"size\":28929,\"uploaded_by\":10}}', NULL, '2025-11-04 15:52:07', '2025-11-04 15:52:07'),
(80, 'audit', 'created', 'created', 'App\\Models\\Document', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"documentable_type\":\"App\\\\Models\\\\Employee\",\"documentable_id\":19,\"category\":\"signature\",\"disk\":\"local\",\"path\":\"documents\\/employees\\/signature\\/JDnjmnCjCSLjgRj4CztgS92rNaQIrjA3p8qeEek2.png\",\"original_name\":\"cng.png\",\"mime_type\":\"image\\/png\",\"size\":28929,\"uploaded_by\":10}}', NULL, '2025-11-04 15:52:07', '2025-11-04 15:52:07'),
(81, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"600000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-04 15:54:32', '2025-11-04 15:54:32'),
(82, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":3,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"600000.00\",\"line_total\":\"600000.00\"}}', NULL, '2025-11-04 15:54:32', '2025-11-04 15:54:32'),
(83, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":3,\"due_date\":\"2025-11-09T00:00:00.000000Z\",\"amount\":\"550000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-04 15:54:41', '2025-11-04 15:54:41'),
(84, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 5, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-3\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":3,\"sales_order_id\":3,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-04 15:54:53', '2025-11-04 15:54:53'),
(85, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-3\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":3,\"sales_order_id\":3,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-04 15:54:53', '2025-11-04 15:54:53'),
(86, 'audit', 'created', 'created', 'App\\Models\\Payment', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":3,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"bank_transfer\",\"meta\":{\"reference\":\"123123213\"}}}', NULL, '2025-11-04 15:54:53', '2025-11-04 15:54:53'),
(87, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":3,\"customer_installment_id\":3,\"allocated\":\"0.00\"}}', NULL, '2025-11-04 15:54:53', '2025-11-04 15:54:53'),
(88, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-04 15:54:53', '2025-11-04 15:54:53'),
(89, 'audit', 'created', 'created', 'App\\Models\\Commission', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":1,\"sales_order_id\":1,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"amount\":\"5000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":10,\"calculation_unit_id\":1,\"calculation_item_id\":1,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(90, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-8\",\"account_id\":4,\"debit\":\"5000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(91, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-8\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"5000.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(92, 'audit', 'created', 'created', 'App\\Models\\Commission', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":1,\"sales_order_id\":1,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":15,\"amount\":\"2500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":1,\"calculation_item_id\":2,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(93, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-9\",\"account_id\":4,\"debit\":\"2500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":15}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(94, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-9\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2500.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":15}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(95, 'audit', 'created', 'created', 'App\\Models\\Commission', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":1,\"sales_order_id\":1,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14,\"amount\":\"2500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"AGM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":1,\"calculation_item_id\":3,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(96, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-10\",\"account_id\":4,\"debit\":\"2500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(97, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-10\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2500.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(98, 'audit', 'created', 'created', 'App\\Models\\Commission', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":1,\"sales_order_id\":1,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13,\"amount\":\"2500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"DGM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":1,\"calculation_item_id\":4,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(99, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-11\",\"account_id\":4,\"debit\":\"2500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":11,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(100, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-11\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2500.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":11,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(101, 'audit', 'created', 'created', 'App\\Models\\Commission', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":1,\"sales_order_id\":1,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"2500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":1,\"calculation_item_id\":5,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(102, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 15, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-12\",\"account_id\":4,\"debit\":\"2500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":12,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(103, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-12\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2500.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":12,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(104, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-04T15:55:57.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(105, 'audit', 'created', 'created', 'App\\Models\\Commission', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":2,\"sales_order_id\":2,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"amount\":\"7500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"calculation_unit_id\":2,\"calculation_item_id\":6,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(106, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-13\",\"account_id\":4,\"debit\":\"7500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":13,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(107, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 18, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-13\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"7500.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":13,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(108, 'audit', 'created', 'created', 'App\\Models\\Commission', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":2,\"sales_order_id\":2,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14,\"amount\":\"2500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"AGM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":2,\"calculation_item_id\":7,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(109, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-14\",\"account_id\":4,\"debit\":\"2500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":14,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(110, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 20, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-14\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2500.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":14,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(111, 'audit', 'created', 'created', 'App\\Models\\Commission', 15, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":2,\"sales_order_id\":2,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13,\"amount\":\"2500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"DGM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":2,\"calculation_item_id\":8,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(112, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 21, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-15\",\"account_id\":4,\"debit\":\"2500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":15,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(113, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 22, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-15\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2500.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":15,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(114, 'audit', 'created', 'created', 'App\\Models\\Commission', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":2,\"sales_order_id\":2,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"2500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":2,\"calculation_item_id\":9,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(115, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 23, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-16\",\"account_id\":4,\"debit\":\"2500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":16,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(116, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 24, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-16\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2500.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":16,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(117, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-04T15:55:57.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(118, 'audit', 'created', 'created', 'App\\Models\\Commission', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":3,\"sales_order_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"5000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":10,\"calculation_unit_id\":3,\"calculation_item_id\":10,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(119, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 25, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-17\",\"account_id\":4,\"debit\":\"5000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":17,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(120, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 26, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-17\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"5000.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":17,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(121, 'audit', 'created', 'created', 'App\\Models\\Commission', 18, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":3,\"sales_order_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"10000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":20,\"calculation_unit_id\":3,\"calculation_item_id\":11,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(122, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 27, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-18\",\"account_id\":4,\"debit\":\"10000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":18,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(123, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 28, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-18\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"10000.00\",\"occurred_at\":\"2025-11-04T15:55:57.000000Z\",\"meta\":{\"commission_id\":18,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(124, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-04T15:55:57.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-04 15:55:57', '2025-11-04 15:55:57'),
(125, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"600000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-04 16:03:24', '2025-11-04 16:03:24'),
(126, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"600000.00\",\"line_total\":\"600000.00\"}}', NULL, '2025-11-04 16:03:24', '2025-11-04 16:03:24'),
(127, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"due_date\":\"2025-11-09T00:00:00.000000Z\",\"amount\":\"550000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-04 16:03:30', '2025-11-04 16:03:30'),
(128, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"cash\"}}}', NULL, '2025-11-04 16:03:39', '2025-11-04 16:03:39'),
(129, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"cash\"}}}', NULL, '2025-11-04 16:03:39', '2025-11-04 16:03:39'),
(130, 'audit', 'created', 'created', 'App\\Models\\Payment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"213132\"}}}', NULL, '2025-11-04 16:03:40', '2025-11-04 16:03:40'),
(131, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":1,\"customer_installment_id\":1,\"allocated\":\"0.00\"}}', NULL, '2025-11-04 16:03:40', '2025-11-04 16:03:40'),
(132, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-04 16:03:40', '2025-11-04 16:03:40'),
(133, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-2\",\"account_id\":1,\"debit\":\"550000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":2,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-04 16:04:06', '2025-11-04 16:04:06'),
(134, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-2\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"550000.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":2,\"sales_order_id\":1,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-04 16:04:06', '2025-11-04 16:04:06'),
(135, 'audit', 'created', 'created', 'App\\Models\\Payment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"550000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment\",\"method\":\"bank_transfer\",\"meta\":{\"reference\":\"313324324\"}}}', NULL, '2025-11-04 16:04:06', '2025-11-04 16:04:06'),
(136, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":2,\"customer_installment_id\":1,\"allocated\":\"550000.00\"}}', NULL, '2025-11-04 16:04:06', '2025-11-04 16:04:06');
INSERT INTO `activity_log` (`id`, `log_name`, `event`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(137, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"paid\":\"550000.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-11-04 16:04:06', '2025-11-04 16:04:06'),
(138, 'audit', 'created', 'created', 'App\\Models\\Commission', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":1,\"sales_order_id\":1,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"5000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T16:05:35.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":10,\"calculation_unit_id\":1,\"calculation_item_id\":1,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(139, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 5, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-1\",\"account_id\":4,\"debit\":\"5000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T16:05:35.000000Z\",\"meta\":{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(140, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-1\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"5000.00\",\"occurred_at\":\"2025-11-04T16:05:35.000000Z\",\"meta\":{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(141, 'audit', 'created', 'created', 'App\\Models\\Commission', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":1,\"sales_order_id\":1,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"10000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T16:05:35.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":20,\"calculation_unit_id\":1,\"calculation_item_id\":2,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(142, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-2\",\"account_id\":4,\"debit\":\"10000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T16:05:35.000000Z\",\"meta\":{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(143, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-2\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"10000.00\",\"occurred_at\":\"2025-11-04T16:05:35.000000Z\",\"meta\":{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(144, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-04T16:05:35.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(145, 'audit', 'created', 'created', 'App\\Models\\Commission', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":2,\"sales_order_id\":1,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"22000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T16:05:35.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"installment\",\"percentage\":4,\"calculation_unit_id\":2,\"calculation_item_id\":3,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(146, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-3\",\"account_id\":4,\"debit\":\"22000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T16:05:35.000000Z\",\"meta\":{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(147, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-3\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"22000.00\",\"occurred_at\":\"2025-11-04T16:05:35.000000Z\",\"meta\":{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(148, 'audit', 'created', 'created', 'App\\Models\\Commission', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":2,\"sales_order_id\":1,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"38500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T16:05:35.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"installment\",\"percentage\":7,\"calculation_unit_id\":2,\"calculation_item_id\":4,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(149, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-4\",\"account_id\":4,\"debit\":\"38500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T16:05:35.000000Z\",\"meta\":{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(150, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-4\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"38500.00\",\"occurred_at\":\"2025-11-04T16:05:35.000000Z\",\"meta\":{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(151, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-04T16:05:35.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-04 16:05:35', '2025-11-04 16:05:35'),
(152, 'audit', 'created', 'created', 'App\\Models\\Agent', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":52,\"branch_id\":2,\"agent_code\":\"AGT-0001\",\"mobile\":\"01999070234\",\"address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\"}}', NULL, '2025-11-04 16:35:54', '2025-11-04 16:35:54'),
(153, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 2, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"40000.00\",\"total\":\"400000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-11-04 16:41:06', '2025-11-04 16:41:06'),
(154, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 2, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":2,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"400000.00\",\"line_total\":\"400000.00\"}}', NULL, '2025-11-04 16:41:06', '2025-11-04 16:41:06'),
(155, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 2, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":2,\"due_date\":\"2025-11-09T00:00:00.000000Z\",\"amount\":\"360000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-04 16:41:12', '2025-11-04 16:41:12'),
(156, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 3, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-11-04 16:44:02', '2025-11-04 16:44:02'),
(157, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 3, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":3,\"itemable_id\":2,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-04 16:44:02', '2025-11-04 16:44:02'),
(158, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 4, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"40000.00\",\"total\":\"400000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-11-04 16:47:09', '2025-11-04 16:47:09'),
(159, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 4, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":4,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"400000.00\",\"line_total\":\"400000.00\"}}', NULL, '2025-11-04 16:47:09', '2025-11-04 16:47:09'),
(160, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 3, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":4,\"due_date\":\"2025-11-09T00:00:00.000000Z\",\"amount\":\"360000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-04 16:47:14', '2025-11-04 16:47:14'),
(161, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 13, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-3\",\"account_id\":1,\"debit\":\"40000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":3,\"sales_order_id\":4,\"method\":\"cash\"}}}', NULL, '2025-11-04 16:51:53', '2025-11-04 16:51:53'),
(162, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 14, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-3\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"40000.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":3,\"sales_order_id\":4,\"method\":\"cash\"}}}', NULL, '2025-11-04 16:51:53', '2025-11-04 16:51:53'),
(163, 'audit', 'created', 'created', 'App\\Models\\Payment', 3, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":4,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"40000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":null}}}', NULL, '2025-11-04 16:51:53', '2025-11-04 16:51:53'),
(164, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 3, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":3,\"customer_installment_id\":3,\"allocated\":\"0.00\"}}', NULL, '2025-11-04 16:51:53', '2025-11-04 16:51:53'),
(165, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 3, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-04 16:51:53', '2025-11-04 16:51:53'),
(166, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 15, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-4\",\"account_id\":1,\"debit\":\"360000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":4,\"sales_order_id\":4,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-04 16:52:19', '2025-11-04 16:52:19'),
(167, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 16, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-4\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"360000.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":4,\"sales_order_id\":4,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-04 16:52:19', '2025-11-04 16:52:19'),
(168, 'audit', 'created', 'created', 'App\\Models\\Payment', 4, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":4,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"360000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment\",\"method\":\"bank_transfer\",\"meta\":{\"reference\":\"213123213\"}}}', NULL, '2025-11-04 16:52:19', '2025-11-04 16:52:19'),
(169, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 4, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":4,\"customer_installment_id\":3,\"allocated\":\"360000.00\"}}', NULL, '2025-11-04 16:52:19', '2025-11-04 16:52:19'),
(170, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 3, 'App\\Models\\User', 52, '{\"attributes\":{\"paid\":\"360000.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-11-04 16:52:19', '2025-11-04 16:52:19'),
(171, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"DOWN_PAYMENT\":{\"down_payment\":5,\"installment\":1}}},\"old\":{\"value\":{\"down_payment\":5,\"installment\":1}}}', NULL, '2025-11-04 17:09:19', '2025-11-04 17:09:19'),
(172, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"AGENT\":{\"down_payment\":5,\"installment\":1}}},\"old\":{\"value\":{\"DOWN_PAYMENT\":{\"down_payment\":5,\"installment\":1}}}}', NULL, '2025-11-04 17:10:04', '2025-11-04 17:10:04'),
(173, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 5, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"30000.00\",\"total\":\"300000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-11-04 17:11:50', '2025-11-04 17:11:50'),
(174, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 5, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":5,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"300000.00\",\"line_total\":\"300000.00\"}}', NULL, '2025-11-04 17:11:50', '2025-11-04 17:11:50'),
(175, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 4, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":5,\"due_date\":\"2025-11-09T00:00:00.000000Z\",\"amount\":\"270000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-04 17:11:54', '2025-11-04 17:11:54'),
(176, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 17, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-5\",\"account_id\":1,\"debit\":\"30000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":5,\"sales_order_id\":5,\"method\":\"cash\"}}}', NULL, '2025-11-04 17:12:06', '2025-11-04 17:12:06'),
(177, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 18, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-5\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"30000.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":5,\"sales_order_id\":5,\"method\":\"cash\"}}}', NULL, '2025-11-04 17:12:06', '2025-11-04 17:12:06'),
(178, 'audit', 'created', 'created', 'App\\Models\\Payment', 5, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":5,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"30000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"123123213\"}}}', NULL, '2025-11-04 17:12:06', '2025-11-04 17:12:06'),
(179, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 5, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":5,\"customer_installment_id\":4,\"allocated\":\"0.00\"}}', NULL, '2025-11-04 17:12:06', '2025-11-04 17:12:06'),
(180, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 4, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-04 17:12:06', '2025-11-04 17:12:06'),
(181, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 19, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-6\",\"account_id\":1,\"debit\":\"270000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":6,\"sales_order_id\":5,\"method\":\"cash\"}}}', NULL, '2025-11-04 17:13:10', '2025-11-04 17:13:10'),
(182, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 20, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-6\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"270000.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":6,\"sales_order_id\":5,\"method\":\"cash\"}}}', NULL, '2025-11-04 17:13:10', '2025-11-04 17:13:10'),
(183, 'audit', 'created', 'created', 'App\\Models\\Payment', 6, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":5,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"270000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment\",\"method\":\"cash\",\"meta\":{\"reference\":\"423432\"}}}', NULL, '2025-11-04 17:13:10', '2025-11-04 17:13:10'),
(184, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 6, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":6,\"customer_installment_id\":4,\"allocated\":\"270000.00\"}}', NULL, '2025-11-04 17:13:10', '2025-11-04 17:13:10'),
(185, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 4, 'App\\Models\\User', 52, '{\"attributes\":{\"paid\":\"270000.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-11-04 17:13:10', '2025-11-04 17:13:10'),
(186, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 6, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"32500.00\",\"total\":\"400000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-11-04 17:17:00', '2025-11-04 17:17:00'),
(187, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 6, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":6,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"400000.00\",\"line_total\":\"400000.00\"}}', NULL, '2025-11-04 17:17:00', '2025-11-04 17:17:00'),
(188, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 5, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":6,\"due_date\":\"2025-11-09T00:00:00.000000Z\",\"amount\":\"367500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-04 17:17:04', '2025-11-04 17:17:04'),
(189, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 21, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-7\",\"account_id\":1,\"debit\":\"32500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":7,\"sales_order_id\":6,\"method\":\"cash\"}}}', NULL, '2025-11-04 17:17:15', '2025-11-04 17:17:15'),
(190, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 22, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-7\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"32500.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":7,\"sales_order_id\":6,\"method\":\"cash\"}}}', NULL, '2025-11-04 17:17:15', '2025-11-04 17:17:15'),
(191, 'audit', 'created', 'created', 'App\\Models\\Payment', 7, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":6,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"32500.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":null}}}', NULL, '2025-11-04 17:17:15', '2025-11-04 17:17:15'),
(192, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 7, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":7,\"customer_installment_id\":5,\"allocated\":\"0.00\"}}', NULL, '2025-11-04 17:17:15', '2025-11-04 17:17:15'),
(193, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 5, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-04 17:17:15', '2025-11-04 17:17:15'),
(194, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"PD\":{\"percentage\":2,\"frequency\":\"quarterlysfdf\"},\"ED\":{\"percentage\":2,\"frequency\":\"half_yearly\"},\"DMD\":{\"percentage\":1,\"frequency\":\"yearly\"},\"DIR\":{\"percentage\":20,\"per_person_share\":1}}},\"old\":{\"value\":{\"PD\":{\"percentage\":2,\"frequency\":\"quarterly\"},\"ED\":{\"percentage\":2,\"frequency\":\"half_yearly\"},\"DMD\":{\"percentage\":1,\"frequency\":\"yearly\"},\"DIR\":{\"percentage\":20,\"per_person_share\":1}}}}', NULL, '2025-11-04 17:31:51', '2025-11-04 17:31:51'),
(195, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"PD\":{\"percentage\":2,\"frequency\":\"quarterly\"},\"ED\":{\"percentage\":2,\"frequency\":\"half_yearly\"},\"DMD\":{\"percentage\":1,\"frequency\":\"yearly\"},\"DIR\":{\"percentage\":20,\"per_person_share\":1}}},\"old\":{\"value\":{\"PD\":{\"percentage\":2,\"frequency\":\"quarterlysfdf\"},\"ED\":{\"percentage\":2,\"frequency\":\"half_yearly\"},\"DMD\":{\"percentage\":1,\"frequency\":\"yearly\"},\"DIR\":{\"percentage\":20,\"per_person_share\":1}}}}', NULL, '2025-11-04 17:32:02', '2025-11-04 17:32:02'),
(196, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"down_payment\":6,\"installment\":1}},\"old\":{\"value\":{\"down_payment\":5,\"installment\":1}}}', NULL, '2025-11-04 17:32:53', '2025-11-04 17:32:53'),
(197, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"down_payment\":5,\"installment\":1}},\"old\":{\"value\":{\"down_payment\":6,\"installment\":1}}}', NULL, '2025-11-04 17:33:10', '2025-11-04 17:33:10'),
(198, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 1, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"60000.00\",\"total\":\"600000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-11-04 17:33:46', '2025-11-04 17:33:46'),
(199, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 1, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":1,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"600000.00\",\"line_total\":\"600000.00\"}}', NULL, '2025-11-04 17:33:46', '2025-11-04 17:33:46'),
(200, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":1,\"due_date\":\"2025-11-09T00:00:00.000000Z\",\"amount\":\"540000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-04 17:33:50', '2025-11-04 17:33:50'),
(201, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 1, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":1,\"debit\":\"60000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"cash\"}}}', NULL, '2025-11-04 17:33:59', '2025-11-04 17:33:59'),
(202, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 2, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-1\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"60000.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"cash\"}}}', NULL, '2025-11-04 17:33:59', '2025-11-04 17:33:59'),
(203, 'audit', 'created', 'created', 'App\\Models\\Payment', 1, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":1,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"60000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"232424\"}}}', NULL, '2025-11-04 17:33:59', '2025-11-04 17:33:59'),
(204, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 1, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":1,\"customer_installment_id\":1,\"allocated\":\"0.00\"}}', NULL, '2025-11-04 17:33:59', '2025-11-04 17:33:59'),
(205, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 1, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-04 17:34:00', '2025-11-04 17:34:00'),
(206, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"51000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-04 17:35:41', '2025-11-04 17:35:41'),
(207, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":2,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-04 17:35:41', '2025-11-04 17:35:41'),
(208, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 2, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"51000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-04 17:36:48', '2025-11-04 17:36:48'),
(209, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"71000.00\",\"total\":\"700000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-04 17:37:24', '2025-11-04 17:37:24'),
(210, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":3,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"700000.00\",\"line_total\":\"700000.00\"}}', NULL, '2025-11-04 17:37:24', '2025-11-04 17:37:24'),
(211, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":3,\"due_date\":\"2025-11-09T00:00:00.000000Z\",\"amount\":\"629000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-04 17:37:30', '2025-11-04 17:37:30'),
(212, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-2\",\"account_id\":1,\"debit\":\"71000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":2,\"sales_order_id\":3,\"method\":\"cash\"}}}', NULL, '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(213, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-2\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"71000.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":2,\"sales_order_id\":3,\"method\":\"cash\"}}}', NULL, '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(214, 'audit', 'created', 'created', 'App\\Models\\Payment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":3,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"71000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"12321312\"}}}', NULL, '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(215, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":2,\"customer_installment_id\":2,\"allocated\":\"0.00\"}}', NULL, '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(216, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(217, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 4, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"20000.00\",\"total\":\"200000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-11-04 18:10:10', '2025-11-04 18:10:10'),
(218, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 4, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":4,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"200000.00\",\"line_total\":\"200000.00\"}}', NULL, '2025-11-04 18:10:10', '2025-11-04 18:10:10'),
(219, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 3, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":4,\"due_date\":\"2025-11-09T00:00:00.000000Z\",\"amount\":\"180000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-04 18:10:15', '2025-11-04 18:10:15'),
(220, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 5, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-3\",\"account_id\":1,\"debit\":\"20000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":3,\"sales_order_id\":4,\"method\":\"cash\"}}}', NULL, '2025-11-04 18:10:29', '2025-11-04 18:10:29'),
(221, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 6, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-3\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"20000.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":3,\"sales_order_id\":4,\"method\":\"cash\"}}}', NULL, '2025-11-04 18:10:29', '2025-11-04 18:10:29'),
(222, 'audit', 'created', 'created', 'App\\Models\\Payment', 3, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":4,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"20000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"111111\"}}}', NULL, '2025-11-04 18:10:29', '2025-11-04 18:10:29'),
(223, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 3, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":3,\"customer_installment_id\":3,\"allocated\":\"0.00\"}}', NULL, '2025-11-04 18:10:29', '2025-11-04 18:10:29'),
(224, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 3, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-04 18:10:29', '2025-11-04 18:10:29'),
(225, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 5, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"30000.00\",\"total\":\"300000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-04 18:13:01', '2025-11-04 18:13:01'),
(226, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 5, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":5,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"300000.00\",\"line_total\":\"300000.00\"}}', NULL, '2025-11-04 18:13:01', '2025-11-04 18:13:01'),
(227, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":5,\"due_date\":\"2025-11-09T00:00:00.000000Z\",\"amount\":\"270000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-04 18:13:05', '2025-11-04 18:13:05'),
(228, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-4\",\"account_id\":1,\"debit\":\"30000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":4,\"sales_order_id\":5,\"method\":\"cash\"}}}', NULL, '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(229, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-4\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"30000.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":4,\"sales_order_id\":5,\"method\":\"cash\"}}}', NULL, '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(230, 'audit', 'created', 'created', 'App\\Models\\Payment', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":5,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"30000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"2121\"}}}', NULL, '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(231, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":4,\"customer_installment_id\":4,\"allocated\":\"0.00\"}}', NULL, '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(232, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(233, 'audit', 'created', 'created', 'App\\Models\\Commission', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":1,\"sales_order_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"3000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"calculation_unit_id\":1,\"calculation_item_id\":1,\"order_created_by\":\"agent\"}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(234, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-1\",\"account_id\":4,\"debit\":\"3000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(235, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-1\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"3000.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(236, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-04T18:29:25.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(237, 'audit', 'created', 'created', 'App\\Models\\Commission', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":2,\"sales_order_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"amount\":\"7100.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":10,\"calculation_unit_id\":2,\"calculation_item_id\":2,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(238, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-2\",\"account_id\":4,\"debit\":\"7100.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(239, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-2\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"7100.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(240, 'audit', 'created', 'created', 'App\\Models\\Commission', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":2,\"sales_order_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":15,\"amount\":\"3550.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":2,\"calculation_item_id\":3,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(241, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-3\",\"account_id\":4,\"debit\":\"3550.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":15}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(242, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-3\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"3550.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":15}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(243, 'audit', 'created', 'created', 'App\\Models\\Commission', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":2,\"sales_order_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14,\"amount\":\"3550.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"AGM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":2,\"calculation_item_id\":4,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(244, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 15, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-4\",\"account_id\":4,\"debit\":\"3550.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(245, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-4\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"3550.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(246, 'audit', 'created', 'created', 'App\\Models\\Commission', 5, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":2,\"sales_order_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13,\"amount\":\"3550.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"DGM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":2,\"calculation_item_id\":5,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(247, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-5\",\"account_id\":4,\"debit\":\"3550.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":5,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(248, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 18, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-5\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"3550.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":5,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(249, 'audit', 'created', 'created', 'App\\Models\\Commission', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":2,\"sales_order_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"3550.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":2,\"calculation_item_id\":6,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(250, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-6\",\"account_id\":4,\"debit\":\"3550.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":6,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(251, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 20, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-6\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"3550.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":6,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(252, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-04T18:29:25.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(253, 'audit', 'created', 'created', 'App\\Models\\Commission', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":3,\"sales_order_id\":4,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"1000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":3,\"calculation_item_id\":7,\"order_created_by\":\"agent\"}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(254, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 21, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-7\",\"account_id\":4,\"debit\":\"1000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(255, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 22, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-7\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1000.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(256, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-04T18:29:25.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(257, 'audit', 'created', 'created', 'App\\Models\\Commission', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":4,\"sales_order_id\":5,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"3000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":10,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":4,\"calculation_item_id\":8,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(258, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 23, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-8\",\"account_id\":4,\"debit\":\"3000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(259, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 24, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-8\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"3000.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(260, 'audit', 'created', 'created', 'App\\Models\\Commission', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":4,\"sales_order_id\":5,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"6000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":20,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":4,\"calculation_item_id\":9,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(261, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 25, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-9\",\"account_id\":4,\"debit\":\"6000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(262, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 26, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-9\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"6000.00\",\"occurred_at\":\"2025-11-04T18:29:25.000000Z\",\"meta\":{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(263, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-04T18:29:25.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(264, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 6, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"20000.00\",\"total\":\"200000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-11-04 18:47:58', '2025-11-04 18:47:58'),
(265, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 6, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":6,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"200000.00\",\"line_total\":\"200000.00\"}}', NULL, '2025-11-04 18:47:58', '2025-11-04 18:47:58'),
(266, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 5, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":6,\"due_date\":\"2025-11-09T00:00:00.000000Z\",\"amount\":\"180000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-04 18:48:02', '2025-11-04 18:48:02'),
(267, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 27, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-5\",\"account_id\":1,\"debit\":\"20000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":5,\"sales_order_id\":6,\"method\":\"cash\"}}}', NULL, '2025-11-04 18:48:21', '2025-11-04 18:48:21'),
(268, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 28, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-5\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"20000.00\",\"occurred_at\":\"2025-11-04T00:00:00.000000Z\",\"meta\":{\"payment_id\":5,\"sales_order_id\":6,\"method\":\"cash\"}}}', NULL, '2025-11-04 18:48:21', '2025-11-04 18:48:21');
INSERT INTO `activity_log` (`id`, `log_name`, `event`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(269, 'audit', 'created', 'created', 'App\\Models\\Payment', 5, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":6,\"paid_at\":\"2025-11-04T00:00:00.000000Z\",\"amount\":\"20000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"11212\"}}}', NULL, '2025-11-04 18:48:21', '2025-11-04 18:48:21'),
(270, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 5, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":5,\"customer_installment_id\":5,\"allocated\":\"0.00\"}}', NULL, '2025-11-04 18:48:21', '2025-11-04 18:48:21'),
(271, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 5, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-04 18:48:21', '2025-11-04 18:48:21'),
(272, 'audit', 'created', 'created', 'App\\Models\\Commission', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":5,\"sales_order_id\":6,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"1000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-04T18:49:15.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":5,\"calculation_item_id\":10,\"order_created_by\":\"agent\"}}}', NULL, '2025-11-04 18:49:15', '2025-11-04 18:49:15'),
(273, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 29, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-10\",\"account_id\":4,\"debit\":\"1000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-04T18:49:15.000000Z\",\"meta\":{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-11-04 18:49:15', '2025-11-04 18:49:15'),
(274, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 30, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-10\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1000.00\",\"occurred_at\":\"2025-11-04T18:49:15.000000Z\",\"meta\":{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-11-04 18:49:15', '2025-11-04 18:49:15'),
(275, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 5, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-04T18:49:15.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-04 18:49:15', '2025-11-04 18:49:15'),
(276, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 7, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-11-05 06:11:39', '2025-11-05 06:11:39'),
(277, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 7, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":7,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-05 06:11:39', '2025-11-05 06:11:39'),
(278, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 6, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":7,\"due_date\":\"2025-11-10T00:00:00.000000Z\",\"amount\":\"450000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-05 06:11:44', '2025-11-05 06:11:44'),
(279, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 31, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-6\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-05T00:00:00.000000Z\",\"meta\":{\"payment_id\":6,\"sales_order_id\":7,\"method\":\"cash\"}}}', NULL, '2025-11-05 06:11:59', '2025-11-05 06:11:59'),
(280, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 32, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-6\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-05T00:00:00.000000Z\",\"meta\":{\"payment_id\":6,\"sales_order_id\":7,\"method\":\"cash\"}}}', NULL, '2025-11-05 06:11:59', '2025-11-05 06:11:59'),
(281, 'audit', 'created', 'created', 'App\\Models\\Payment', 6, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":7,\"paid_at\":\"2025-11-05T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":null,\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"afasdfasdfsd\"}}}', NULL, '2025-11-05 06:11:59', '2025-11-05 06:11:59'),
(282, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 6, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":6,\"customer_installment_id\":6,\"allocated\":\"0.00\"}}', NULL, '2025-11-05 06:11:59', '2025-11-05 06:11:59'),
(283, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 6, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-05 06:11:59', '2025-11-05 06:11:59'),
(284, 'audit', 'created', 'created', 'App\\Models\\Commission', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":6,\"sales_order_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"2500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-05T06:13:27.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":6,\"calculation_item_id\":11,\"order_created_by\":\"agent\"}}}', NULL, '2025-11-05 06:13:27', '2025-11-05 06:13:27'),
(285, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 33, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-11\",\"account_id\":4,\"debit\":\"2500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-05T06:13:27.000000Z\",\"meta\":{\"commission_id\":11,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-11-05 06:13:27', '2025-11-05 06:13:27'),
(286, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 34, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-11\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2500.00\",\"occurred_at\":\"2025-11-05T06:13:27.000000Z\",\"meta\":{\"commission_id\":11,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-11-05 06:13:27', '2025-11-05 06:13:27'),
(287, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-05T06:13:27.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-05 06:13:27', '2025-11-05 06:13:27'),
(288, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-10 15:21:07', '2025-11-10 15:21:07'),
(289, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":8,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-10 15:21:07', '2025-11-10 15:21:07'),
(290, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 8, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-10 15:22:53', '2025-11-10 15:22:53'),
(291, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"40000.00\",\"total\":\"600000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-10 15:28:48', '2025-11-10 15:28:48'),
(292, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":9,\"itemable_id\":2,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"600000.00\",\"line_total\":\"600000.00\"}}', NULL, '2025-11-10 15:28:48', '2025-11-10 15:28:48'),
(293, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":9,\"due_date\":\"2025-11-15T00:00:00.000000Z\",\"amount\":\"56000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(294, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":9,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"56000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(295, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":9,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"56000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(296, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":9,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"56000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(297, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":9,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"56000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(298, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":9,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"56000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(299, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":9,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"56000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(300, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":9,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"56000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(301, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 15, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":9,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"56000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(302, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":9,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"56000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(303, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-11 15:59:28', '2025-11-11 15:59:28'),
(304, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"itemable_id\":6,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-11 15:59:28', '2025-11-11 15:59:28'),
(305, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"due_date\":\"2025-11-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(306, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 18, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"due_date\":\"2025-12-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(307, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"due_date\":\"2026-01-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(308, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 20, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"due_date\":\"2026-02-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(309, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 21, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"due_date\":\"2026-03-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(310, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 22, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"due_date\":\"2026-04-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(311, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 23, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"due_date\":\"2026-05-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(312, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 24, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"due_date\":\"2026-06-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(313, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 25, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"due_date\":\"2026-07-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(314, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 26, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"due_date\":\"2026-08-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(315, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 27, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"due_date\":\"2026-09-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(316, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 28, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"due_date\":\"2026-10-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(317, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 35, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-7\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":7,\"sales_order_id\":10,\"method\":\"cash\"}}}', NULL, '2025-11-11 15:59:49', '2025-11-11 15:59:49'),
(318, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 36, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-7\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":7,\"sales_order_id\":10,\"method\":\"cash\"}}}', NULL, '2025-11-11 15:59:49', '2025-11-11 15:59:49'),
(319, 'audit', 'updated', 'updated', 'App\\Models\\Employee', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"rank\":\"MM\"},\"old\":{\"rank\":\"ME\"}}', NULL, '2025-11-11 15:59:49', '2025-11-11 15:59:49'),
(320, 'audit', 'created', 'created', 'App\\Models\\Payment', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"paid_at\":\"2025-11-11T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"45000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"sdfdsfdsf\"}}}', NULL, '2025-11-11 15:59:49', '2025-11-11 15:59:49'),
(321, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":7,\"customer_installment_id\":17,\"allocated\":\"0.00\"}}', NULL, '2025-11-11 15:59:49', '2025-11-11 15:59:49'),
(322, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-11 15:59:49', '2025-11-11 15:59:49'),
(323, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 37, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-8\",\"account_id\":1,\"debit\":\"37500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":8,\"sales_order_id\":10,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-11 16:02:14', '2025-11-11 16:02:14'),
(324, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 38, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-8\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"37500.00\",\"occurred_at\":\"2025-11-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":8,\"sales_order_id\":10,\"method\":\"bank_transfer\"}}}', NULL, '2025-11-11 16:02:14', '2025-11-11 16:02:14'),
(325, 'audit', 'created', 'created', 'App\\Models\\Payment', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":10,\"paid_at\":\"2025-11-11T00:00:00.000000Z\",\"amount\":\"37500.00\",\"commission_base_amount\":\"33750.00\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment\",\"method\":\"bank_transfer\",\"meta\":{\"reference\":\"345345435\"}}}', NULL, '2025-11-11 16:02:14', '2025-11-11 16:02:14'),
(326, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":8,\"customer_installment_id\":17,\"allocated\":\"37500.00\"}}', NULL, '2025-11-11 16:02:14', '2025-11-11 16:02:14'),
(327, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"paid\":\"37500.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-11-11 16:02:14', '2025-11-11 16:02:14'),
(328, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-11 16:07:51', '2025-11-11 16:07:51'),
(329, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"itemable_id\":6,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-11 16:07:51', '2025-11-11 16:07:51'),
(330, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 29, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"due_date\":\"2025-11-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(331, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 30, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"due_date\":\"2025-12-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(332, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 31, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"due_date\":\"2026-01-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(333, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 32, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"due_date\":\"2026-02-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(334, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 33, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"due_date\":\"2026-03-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(335, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 34, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"due_date\":\"2026-04-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(336, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 35, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"due_date\":\"2026-05-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(337, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 36, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"due_date\":\"2026-06-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(338, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 37, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"due_date\":\"2026-07-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(339, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 38, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"due_date\":\"2026-08-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(340, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 39, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"due_date\":\"2026-09-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(341, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 40, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"due_date\":\"2026-10-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(342, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 39, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-9\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":9,\"sales_order_id\":11,\"method\":\"cash\"}}}', NULL, '2025-11-11 16:08:16', '2025-11-11 16:08:16'),
(343, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 40, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-9\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":9,\"sales_order_id\":11,\"method\":\"cash\"}}}', NULL, '2025-11-11 16:08:16', '2025-11-11 16:08:16'),
(344, 'audit', 'created', 'created', 'App\\Models\\Payment', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"paid_at\":\"2025-11-11T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"45000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"123123123\"}}}', NULL, '2025-11-11 16:08:16', '2025-11-11 16:08:16'),
(345, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":9,\"customer_installment_id\":29,\"allocated\":\"0.00\"}}', NULL, '2025-11-11 16:08:16', '2025-11-11 16:08:16'),
(346, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 29, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-11 16:08:16', '2025-11-11 16:08:16'),
(347, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 41, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-10\",\"account_id\":1,\"debit\":\"37500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":10,\"sales_order_id\":11,\"method\":\"cash\"}}}', NULL, '2025-11-11 16:11:45', '2025-11-11 16:11:45'),
(348, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 42, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-10\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"37500.00\",\"occurred_at\":\"2025-11-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":10,\"sales_order_id\":11,\"method\":\"cash\"}}}', NULL, '2025-11-11 16:11:45', '2025-11-11 16:11:45'),
(349, 'audit', 'created', 'created', 'App\\Models\\Payment', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":11,\"paid_at\":\"2025-11-11T00:00:00.000000Z\",\"amount\":\"37500.00\",\"commission_base_amount\":\"33750.00\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment\",\"method\":\"cash\",\"meta\":{\"reference\":\"4324324324\"}}}', NULL, '2025-11-11 16:11:45', '2025-11-11 16:11:45'),
(350, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":10,\"customer_installment_id\":29,\"allocated\":\"37500.00\"}}', NULL, '2025-11-11 16:11:45', '2025-11-11 16:11:45'),
(351, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 29, 'App\\Models\\User', 10, '{\"attributes\":{\"paid\":\"37500.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-11-11 16:11:45', '2025-11-11 16:11:45'),
(352, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-11 17:00:43', '2025-11-11 17:00:43'),
(353, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"itemable_id\":10,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-11 17:00:43', '2025-11-11 17:00:43'),
(354, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 41, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"due_date\":\"2025-11-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(355, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 42, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"due_date\":\"2025-12-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(356, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 43, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"due_date\":\"2026-01-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(357, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 44, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"due_date\":\"2026-02-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(358, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 45, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"due_date\":\"2026-03-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(359, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 46, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"due_date\":\"2026-04-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(360, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 47, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"due_date\":\"2026-05-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(361, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 48, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"due_date\":\"2026-06-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(362, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 49, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"due_date\":\"2026-07-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(363, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 50, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"due_date\":\"2026-08-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(364, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 51, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"due_date\":\"2026-09-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(365, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 52, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"due_date\":\"2026-10-16T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(366, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 43, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-11\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":11,\"sales_order_id\":12,\"method\":\"cash\"}}}', NULL, '2025-11-11 17:02:08', '2025-11-11 17:02:08'),
(367, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 44, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-11\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":11,\"sales_order_id\":12,\"method\":\"cash\"}}}', NULL, '2025-11-11 17:02:08', '2025-11-11 17:02:08'),
(368, 'audit', 'updated', 'updated', 'App\\Models\\Employee', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"rank\":\"MM\"},\"old\":{\"rank\":\"ME\"}}', NULL, '2025-11-11 17:02:08', '2025-11-11 17:02:08'),
(369, 'audit', 'created', 'created', 'App\\Models\\Payment', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"paid_at\":\"2025-11-11T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"40000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"01999070235\"}}}', NULL, '2025-11-11 17:02:09', '2025-11-11 17:02:09'),
(370, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":11,\"customer_installment_id\":41,\"allocated\":\"0.00\"}}', NULL, '2025-11-11 17:02:09', '2025-11-11 17:02:09'),
(371, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 41, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-11 17:02:09', '2025-11-11 17:02:09'),
(372, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 45, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-12\",\"account_id\":1,\"debit\":\"37500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":12,\"sales_order_id\":12,\"method\":\"cash\"}}}', NULL, '2025-11-11 17:03:52', '2025-11-11 17:03:52'),
(373, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 46, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-12\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"37500.00\",\"occurred_at\":\"2025-11-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":12,\"sales_order_id\":12,\"method\":\"cash\"}}}', NULL, '2025-11-11 17:03:52', '2025-11-11 17:03:52'),
(374, 'audit', 'created', 'created', 'App\\Models\\Payment', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":12,\"paid_at\":\"2025-11-11T00:00:00.000000Z\",\"amount\":\"37500.00\",\"commission_base_amount\":\"30000.00\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment\",\"method\":\"cash\",\"meta\":{\"reference\":\"4345435\"}}}', NULL, '2025-11-11 17:03:52', '2025-11-11 17:03:52'),
(375, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":12,\"customer_installment_id\":41,\"allocated\":\"37500.00\"}}', NULL, '2025-11-11 17:03:52', '2025-11-11 17:03:52'),
(376, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 41, 'App\\Models\\User', 10, '{\"attributes\":{\"paid\":\"37500.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-11-11 17:03:52', '2025-11-11 17:03:52'),
(377, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-11 17:16:35', '2025-11-11 17:16:35'),
(378, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":13,\"itemable_id\":10,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-11 17:16:35', '2025-11-11 17:16:35'),
(379, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-12 18:38:51', '2025-11-12 18:38:51'),
(380, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"itemable_id\":11,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-12 18:38:51', '2025-11-12 18:38:51'),
(381, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 53, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"due_date\":\"2025-11-17T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(382, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 54, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"due_date\":\"2025-12-17T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(383, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 55, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"due_date\":\"2026-01-17T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(384, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 56, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"due_date\":\"2026-02-17T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(385, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 57, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"due_date\":\"2026-03-17T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(386, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 58, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"due_date\":\"2026-04-17T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(387, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 59, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"due_date\":\"2026-05-17T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(388, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 60, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"due_date\":\"2026-06-17T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(389, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 61, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"due_date\":\"2026-07-17T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(390, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 62, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"due_date\":\"2026-08-17T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(391, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 63, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"due_date\":\"2026-09-17T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(392, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 64, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"due_date\":\"2026-10-17T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(393, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 47, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-13\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-12T00:00:00.000000Z\",\"meta\":{\"payment_id\":13,\"sales_order_id\":14,\"method\":\"cash\"}}}', NULL, '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(394, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 48, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-13\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-12T00:00:00.000000Z\",\"meta\":{\"payment_id\":13,\"sales_order_id\":14,\"method\":\"cash\"}}}', NULL, '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(395, 'audit', 'created', 'created', 'App\\Models\\LedgerAccount', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"code\":\"520\",\"name\":\"Supplier Cost Expense\",\"type\":\"expense\",\"meta\":null}}', NULL, '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(396, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 49, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-13-1\",\"account_id\":7,\"debit\":\"10000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-12T00:00:00.000000Z\",\"meta\":{\"payment_id\":13,\"sales_order_id\":14,\"supplier_id\":1}}}', NULL, '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(397, 'audit', 'created', 'created', 'App\\Models\\LedgerAccount', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"code\":\"230\",\"name\":\"Supplier Payable\",\"type\":\"liability\",\"meta\":null}}', NULL, '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(398, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 50, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-13-1\",\"account_id\":8,\"debit\":\"0.00\",\"credit\":\"10000.00\",\"occurred_at\":\"2025-11-12T00:00:00.000000Z\",\"meta\":{\"payment_id\":13,\"sales_order_id\":14,\"supplier_id\":1}}}', NULL, '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(399, 'audit', 'created', 'created', 'App\\Models\\Payment', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"paid_at\":\"2025-11-12T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"35000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"32432432\"}}}', NULL, '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(400, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":13,\"customer_installment_id\":53,\"allocated\":\"0.00\"}}', NULL, '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(401, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 53, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(402, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 51, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-14\",\"account_id\":1,\"debit\":\"37500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-12T00:00:00.000000Z\",\"meta\":{\"payment_id\":14,\"sales_order_id\":14,\"method\":\"cash\"}}}', NULL, '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(403, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 52, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-14\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"37500.00\",\"occurred_at\":\"2025-11-12T00:00:00.000000Z\",\"meta\":{\"payment_id\":14,\"sales_order_id\":14,\"method\":\"cash\"}}}', NULL, '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(404, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 53, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-14-1\",\"account_id\":7,\"debit\":\"7500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-12T00:00:00.000000Z\",\"meta\":{\"payment_id\":14,\"sales_order_id\":14,\"supplier_id\":1}}}', NULL, '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(405, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 54, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-14-1\",\"account_id\":8,\"debit\":\"0.00\",\"credit\":\"7500.00\",\"occurred_at\":\"2025-11-12T00:00:00.000000Z\",\"meta\":{\"payment_id\":14,\"sales_order_id\":14,\"supplier_id\":1}}}', NULL, '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(406, 'audit', 'created', 'created', 'App\\Models\\Payment', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":14,\"paid_at\":\"2025-11-12T00:00:00.000000Z\",\"amount\":\"37500.00\",\"commission_base_amount\":\"26250.00\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment\",\"method\":\"cash\",\"meta\":{\"reference\":\"23234324\"}}}', NULL, '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(407, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":14,\"customer_installment_id\":53,\"allocated\":\"37500.00\"}}', NULL, '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(408, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 53, 'App\\Models\\User', 10, '{\"attributes\":{\"paid\":\"37500.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(409, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 15, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-13 04:32:14', '2025-11-13 04:32:14'),
(410, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 15, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"itemable_id\":12,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-13 04:32:14', '2025-11-13 04:32:14'),
(411, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 65, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"due_date\":\"2025-11-18T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(412, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 66, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"due_date\":\"2025-12-18T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(413, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 67, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"due_date\":\"2026-01-18T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(414, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 68, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"due_date\":\"2026-02-18T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(415, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 69, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"due_date\":\"2026-03-18T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(416, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 70, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"due_date\":\"2026-04-18T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(417, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 71, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"due_date\":\"2026-05-18T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(418, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 72, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"due_date\":\"2026-06-18T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(419, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 73, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"due_date\":\"2026-07-18T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(420, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 74, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"due_date\":\"2026-08-18T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-13 04:32:17', '2025-11-13 04:32:17');
INSERT INTO `activity_log` (`id`, `log_name`, `event`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(421, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 75, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"due_date\":\"2026-09-18T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(422, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 76, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"due_date\":\"2026-10-18T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(423, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 55, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-15\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-13T00:00:00.000000Z\",\"meta\":{\"payment_id\":15,\"sales_order_id\":15,\"method\":\"cash\"}}}', NULL, '2025-11-13 04:33:17', '2025-11-13 04:33:17'),
(424, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 56, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-15\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-13T00:00:00.000000Z\",\"meta\":{\"payment_id\":15,\"sales_order_id\":15,\"method\":\"cash\"}}}', NULL, '2025-11-13 04:33:17', '2025-11-13 04:33:17'),
(425, 'audit', 'created', 'created', 'App\\Models\\Payment', 15, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"paid_at\":\"2025-11-13T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"40000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"111\"}}}', NULL, '2025-11-13 04:33:17', '2025-11-13 04:33:17'),
(426, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 15, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":15,\"customer_installment_id\":65,\"allocated\":\"0.00\"}}', NULL, '2025-11-13 04:33:17', '2025-11-13 04:33:17'),
(427, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 65, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-13 04:33:17', '2025-11-13 04:33:17'),
(428, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 57, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-16\",\"account_id\":1,\"debit\":\"37500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-13T00:00:00.000000Z\",\"meta\":{\"payment_id\":16,\"sales_order_id\":15,\"method\":\"cash\"}}}', NULL, '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(429, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 58, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-16\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"37500.00\",\"occurred_at\":\"2025-11-13T00:00:00.000000Z\",\"meta\":{\"payment_id\":16,\"sales_order_id\":15,\"method\":\"cash\"}}}', NULL, '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(430, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 59, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-16-1\",\"account_id\":7,\"debit\":\"7500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-13T00:00:00.000000Z\",\"meta\":{\"payment_id\":16,\"sales_order_id\":15,\"supplier_id\":1}}}', NULL, '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(431, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 60, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-16-1\",\"account_id\":8,\"debit\":\"0.00\",\"credit\":\"7500.00\",\"occurred_at\":\"2025-11-13T00:00:00.000000Z\",\"meta\":{\"payment_id\":16,\"sales_order_id\":15,\"supplier_id\":1}}}', NULL, '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(432, 'audit', 'created', 'created', 'App\\Models\\Payment', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":15,\"paid_at\":\"2025-11-13T00:00:00.000000Z\",\"amount\":\"37500.00\",\"commission_base_amount\":\"30000.00\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment\",\"method\":\"cash\",\"meta\":{\"reference\":\"1111\"}}}', NULL, '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(433, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":16,\"customer_installment_id\":65,\"allocated\":\"37500.00\"}}', NULL, '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(434, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 65, 'App\\Models\\User', 10, '{\"attributes\":{\"paid\":\"37500.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(435, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":54,\"employee_id\":12,\"source_me_id\":12,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"GM\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-16 16:12:02', '2025-11-16 16:12:02'),
(436, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"itemable_id\":11,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-16 16:12:02', '2025-11-16 16:12:02'),
(437, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 77, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"due_date\":\"2025-11-21T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(438, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 78, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"due_date\":\"2025-12-21T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(439, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 79, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"due_date\":\"2026-01-21T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(440, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 80, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"due_date\":\"2026-02-21T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(441, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 81, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"due_date\":\"2026-03-21T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(442, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 82, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"due_date\":\"2026-04-21T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(443, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 83, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"due_date\":\"2026-05-21T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(444, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 84, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"due_date\":\"2026-06-21T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(445, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 85, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"due_date\":\"2026-07-21T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(446, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 86, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"due_date\":\"2026-08-21T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(447, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 87, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"due_date\":\"2026-09-21T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(448, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 88, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"due_date\":\"2026-10-21T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(449, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 61, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-17\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-16T00:00:00.000000Z\",\"meta\":{\"payment_id\":17,\"sales_order_id\":16,\"method\":\"cash\"}}}', NULL, '2025-11-16 16:12:17', '2025-11-16 16:12:17'),
(450, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 62, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-17\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-16T00:00:00.000000Z\",\"meta\":{\"payment_id\":17,\"sales_order_id\":16,\"method\":\"cash\"}}}', NULL, '2025-11-16 16:12:17', '2025-11-16 16:12:17'),
(451, 'audit', 'created', 'created', 'App\\Models\\Payment', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":16,\"paid_at\":\"2025-11-16T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"35000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"12323123213\"}}}', NULL, '2025-11-16 16:12:17', '2025-11-16 16:12:17'),
(452, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":17,\"customer_installment_id\":77,\"allocated\":\"0.00\"}}', NULL, '2025-11-16 16:12:17', '2025-11-16 16:12:17'),
(453, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 77, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-16 16:12:17', '2025-11-16 16:12:17'),
(454, 'audit', 'created', 'created', 'App\\Models\\CommissionSetting', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"key\":\"monthly_incentive_settings\",\"value\":{\"percentage\":1,\"max_levels\":4}}}', NULL, '2025-11-16 17:26:55', '2025-11-16 17:26:55'),
(455, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"percentage\":1,\"max_levels\":4,\"down_payment\":\"2\",\"installment\":\"5\"}},\"old\":{\"value\":{\"percentage\":1,\"max_levels\":4}}}', NULL, '2025-11-16 17:50:03', '2025-11-16 17:50:03'),
(456, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"percentage\":1,\"max_levels\":4,\"down_payment\":\"1\",\"installment\":\"6\"}},\"old\":{\"value\":{\"percentage\":1,\"max_levels\":4,\"down_payment\":\"2\",\"installment\":\"5\"}}}', NULL, '2025-11-16 17:51:38', '2025-11-16 17:51:38'),
(457, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"down_payment\":1,\"installment\":7}},\"old\":{\"value\":{\"percentage\":1,\"max_levels\":4,\"down_payment\":\"1\",\"installment\":\"6\"}}}', NULL, '2025-11-16 18:10:18', '2025-11-16 18:10:18'),
(458, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"down_payment\":1,\"installment\":7,\"percentage\":\"5\",\"max_levels\":\"5\"}},\"old\":{\"value\":{\"down_payment\":1,\"installment\":7}}}', NULL, '2025-11-16 18:12:04', '2025-11-16 18:12:04'),
(459, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"down_payment\":1,\"installment\":7,\"percentage\":\"1\",\"max_levels\":\"5\"}},\"old\":{\"value\":{\"down_payment\":1,\"installment\":7,\"percentage\":\"5\",\"max_levels\":\"5\"}}}', NULL, '2025-11-16 18:13:21', '2025-11-16 18:13:21'),
(460, 'audit', 'updated', 'updated', 'App\\Models\\CommissionRule', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"percentage\":\"2.98\",\"meta\":{\"commission_base\":\"amount\",\"applies_to\":\"any\"}},\"old\":{\"percentage\":\"2.50\",\"meta\":{\"applies_to\":\"down_payment\",\"owner_position\":\"owner_01\"}}}', NULL, '2025-11-18 19:02:53', '2025-11-18 19:02:53'),
(461, 'audit', 'updated', 'updated', 'App\\Models\\CommissionRule', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"scope\":\"down_payment\",\"meta\":{\"commission_base\":\"amount\",\"applies_to\":\"down_payment\"}},\"old\":{\"scope\":\"any\",\"meta\":{\"commission_base\":\"amount\",\"applies_to\":\"any\"}}}', NULL, '2025-11-18 19:03:35', '2025-11-18 19:03:35'),
(462, 'audit', 'updated', 'updated', 'App\\Models\\CommissionRule', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"percentage\":\"3.00\"},\"old\":{\"percentage\":\"2.98\"}}', NULL, '2025-11-18 19:03:55', '2025-11-18 19:03:55'),
(463, 'audit', 'updated', 'updated', 'App\\Models\\CommissionRule', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"percentage\":\"2.49\"},\"old\":{\"percentage\":\"3.00\"}}', NULL, '2025-11-18 19:05:05', '2025-11-18 19:05:05'),
(464, 'audit', 'updated', 'updated', 'App\\Models\\CommissionRule', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"percentage\":\"2.48\"},\"old\":{\"percentage\":\"2.49\"}}', NULL, '2025-11-18 19:05:31', '2025-11-18 19:05:31'),
(465, 'audit', 'updated', 'updated', 'App\\Models\\CommissionRule', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"percentage\":\"2.50\"},\"old\":{\"percentage\":\"2.48\"}}', NULL, '2025-11-18 19:06:44', '2025-11-18 19:06:44'),
(466, 'audit', 'updated', 'updated', 'App\\Models\\Rank', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"code\":\"HD\"},\"old\":{\"code\":\"PD\"}}', NULL, '2025-11-19 07:57:15', '2025-11-19 07:57:15'),
(467, 'audit', 'updated', 'updated', 'App\\Models\\Rank', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"code\":\"PD\"},\"old\":{\"code\":\"HD\"}}', NULL, '2025-11-19 07:59:36', '2025-11-19 07:59:36'),
(468, 'audit', 'created', 'created', 'App\\Models\\Employee', 20, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":55,\"branch_id\":1,\"agent_id\":null,\"superior_id\":16,\"employee_code\":\"0044\",\"rank\":\"MM\",\"full_name_en\":\"sumi\",\"full_name_bn\":\"sumi\",\"father_name\":\"sdee\",\"mother_name\":\"hhh\",\"mobile\":\"01766686301\",\"national_id\":\"3455\",\"date_of_birth\":\"2000-02-22T00:00:00.000000Z\",\"marital_status\":\"Married\",\"religion\":\"Islam\",\"gender\":\"Female\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"dddd\",\"permanent_address\":\"bbbb\",\"post_code\":null}}', NULL, '2025-11-19 08:08:06', '2025-11-19 08:08:06'),
(469, 'audit', 'created', 'created', 'App\\Models\\Employee', 21, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":56,\"branch_id\":1,\"agent_id\":null,\"superior_id\":null,\"employee_code\":\"2244\",\"rank\":\"MM\",\"full_name_en\":\"mizan\",\"full_name_bn\":\"mizan\",\"father_name\":\"dff\",\"mother_name\":\"hjhj\",\"mobile\":\"01766686301\",\"national_id\":\"2345\",\"date_of_birth\":\"2000-12-04T00:00:00.000000Z\",\"marital_status\":\"Married\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"dxc\",\"permanent_address\":\"ggg\",\"post_code\":null}}', NULL, '2025-11-19 08:15:46', '2025-11-19 08:15:46'),
(470, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 17, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"100000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-11-19 09:23:37', '2025-11-19 09:23:37'),
(471, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 17, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":17,\"itemable_id\":6,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-19 09:23:37', '2025-11-19 09:23:37'),
(472, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 89, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"due_date\":\"2025-11-24T00:00:00.000000Z\",\"amount\":\"33333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-19 09:23:47', '2025-11-19 09:23:47'),
(473, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 90, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"due_date\":\"2025-12-24T00:00:00.000000Z\",\"amount\":\"33333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-19 09:23:47', '2025-11-19 09:23:47'),
(474, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 91, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"due_date\":\"2026-01-24T00:00:00.000000Z\",\"amount\":\"33333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(475, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 92, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"due_date\":\"2026-02-24T00:00:00.000000Z\",\"amount\":\"33333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(476, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 93, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"due_date\":\"2026-03-24T00:00:00.000000Z\",\"amount\":\"33333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(477, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 94, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"due_date\":\"2026-04-24T00:00:00.000000Z\",\"amount\":\"33333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(478, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 95, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"due_date\":\"2026-05-24T00:00:00.000000Z\",\"amount\":\"33333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(479, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 96, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"due_date\":\"2026-06-24T00:00:00.000000Z\",\"amount\":\"33333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(480, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 97, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"due_date\":\"2026-07-24T00:00:00.000000Z\",\"amount\":\"33333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(481, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 98, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"due_date\":\"2026-08-24T00:00:00.000000Z\",\"amount\":\"33333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(482, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 99, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"due_date\":\"2026-09-24T00:00:00.000000Z\",\"amount\":\"33333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(483, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 100, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"due_date\":\"2026-10-24T00:00:00.000000Z\",\"amount\":\"33333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(484, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 63, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-18\",\"account_id\":1,\"debit\":\"100000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T00:00:00.000000Z\",\"meta\":{\"payment_id\":18,\"sales_order_id\":17,\"method\":\"cash\"}}}', NULL, '2025-11-19 09:24:32', '2025-11-19 09:24:32'),
(485, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 64, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-18\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"100000.00\",\"occurred_at\":\"2025-11-19T00:00:00.000000Z\",\"meta\":{\"payment_id\":18,\"sales_order_id\":17,\"method\":\"cash\"}}}', NULL, '2025-11-19 09:24:32', '2025-11-19 09:24:32'),
(486, 'audit', 'created', 'created', 'App\\Models\\Payment', 18, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"paid_at\":\"2025-11-19T00:00:00.000000Z\",\"amount\":\"100000.00\",\"commission_base_amount\":\"90000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"11111\"}}}', NULL, '2025-11-19 09:24:32', '2025-11-19 09:24:32'),
(487, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 18, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":18,\"customer_installment_id\":89,\"allocated\":\"0.00\"}}', NULL, '2025-11-19 09:24:32', '2025-11-19 09:24:32'),
(488, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 89, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-19 09:24:32', '2025-11-19 09:24:32'),
(489, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 65, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-19\",\"account_id\":1,\"debit\":\"33333.34\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T00:00:00.000000Z\",\"meta\":{\"payment_id\":19,\"sales_order_id\":17,\"method\":\"cheque\"}}}', NULL, '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(490, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 66, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-19\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"33333.34\",\"occurred_at\":\"2025-11-19T00:00:00.000000Z\",\"meta\":{\"payment_id\":19,\"sales_order_id\":17,\"method\":\"cheque\"}}}', NULL, '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(491, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 67, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-19-2\",\"account_id\":7,\"debit\":\"5000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T00:00:00.000000Z\",\"meta\":{\"payment_id\":19,\"sales_order_id\":17,\"supplier_id\":2}}}', NULL, '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(492, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 68, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-19-2\",\"account_id\":8,\"debit\":\"0.00\",\"credit\":\"5000.00\",\"occurred_at\":\"2025-11-19T00:00:00.000000Z\",\"meta\":{\"payment_id\":19,\"sales_order_id\":17,\"supplier_id\":2}}}', NULL, '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(493, 'audit', 'created', 'created', 'App\\Models\\Payment', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":17,\"paid_at\":\"2025-11-19T00:00:00.000000Z\",\"amount\":\"33333.34\",\"commission_base_amount\":\"30000.01\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment\",\"method\":\"cheque\",\"meta\":{\"reference\":\"11111\"}}}', NULL, '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(494, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":19,\"customer_installment_id\":89,\"allocated\":\"33333.34\"}}', NULL, '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(495, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 89, 'App\\Models\\User', 10, '{\"attributes\":{\"paid\":\"33333.34\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(496, 'audit', 'created', 'created', 'App\\Models\\Commission', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":7,\"sales_order_id\":10,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"amount\":\"6750.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:40.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"JAKARIA\",\"calculation_unit_id\":7,\"calculation_item_id\":12,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-19 09:26:40', '2025-11-19 09:26:40'),
(497, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 69, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-12\",\"account_id\":4,\"debit\":\"6750.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:40.000000Z\",\"meta\":{\"commission_id\":12,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-11-19 09:26:40', '2025-11-19 09:26:40'),
(498, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 70, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-12\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"6750.00\",\"occurred_at\":\"2025-11-19T09:26:40.000000Z\",\"meta\":{\"commission_id\":12,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-11-19 09:26:40', '2025-11-19 09:26:40'),
(499, 'audit', 'created', 'created', 'App\\Models\\Commission', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":7,\"sales_order_id\":10,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14,\"amount\":\"2250.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:40.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"AGM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"SABBIR RAHMAN\",\"calculation_unit_id\":7,\"calculation_item_id\":13,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-19 09:26:40', '2025-11-19 09:26:40'),
(500, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 71, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-13\",\"account_id\":4,\"debit\":\"2250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:40.000000Z\",\"meta\":{\"commission_id\":13,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-11-19 09:26:40', '2025-11-19 09:26:40'),
(501, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 72, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-13\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2250.00\",\"occurred_at\":\"2025-11-19T09:26:40.000000Z\",\"meta\":{\"commission_id\":13,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(502, 'audit', 'created', 'created', 'App\\Models\\Commission', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":7,\"sales_order_id\":10,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13,\"amount\":\"2250.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:40.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"DGM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"SAKIL AL\",\"calculation_unit_id\":7,\"calculation_item_id\":14,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(503, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 73, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-14\",\"account_id\":4,\"debit\":\"2250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":14,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(504, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 74, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-14\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2250.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":14,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(505, 'audit', 'created', 'created', 'App\\Models\\Commission', 15, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":7,\"sales_order_id\":10,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"2250.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:40.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":7,\"calculation_item_id\":15,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(506, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 75, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-15\",\"account_id\":4,\"debit\":\"2250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":15,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(507, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 76, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-15\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2250.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":15,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(508, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:40.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(509, 'audit', 'created', 'created', 'App\\Models\\Commission', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":8,\"sales_order_id\":10,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"amount\":\"1687.50\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"installment\",\"percentage\":5,\"recipient_name\":\"JAKARIA\",\"calculation_unit_id\":8,\"calculation_item_id\":16,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(510, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 77, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-16\",\"account_id\":4,\"debit\":\"1687.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":16,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(511, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 78, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-16\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1687.50\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":16,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(512, 'audit', 'created', 'created', 'App\\Models\\Commission', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":8,\"sales_order_id\":10,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14,\"amount\":\"337.50\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"AGM\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"SABBIR RAHMAN\",\"calculation_unit_id\":8,\"calculation_item_id\":17,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(513, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 79, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-17\",\"account_id\":4,\"debit\":\"337.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":17,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(514, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 80, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-17\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"337.50\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":17,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(515, 'audit', 'created', 'created', 'App\\Models\\Commission', 18, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":8,\"sales_order_id\":10,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13,\"amount\":\"1012.50\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"DGM\",\"payment_type\":\"installment\",\"percentage\":3,\"recipient_name\":\"SAKIL AL\",\"calculation_unit_id\":8,\"calculation_item_id\":18,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(516, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 81, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-18\",\"account_id\":4,\"debit\":\"1012.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":18,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(517, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 82, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-18\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1012.50\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":18,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(518, 'audit', 'created', 'created', 'App\\Models\\Commission', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":8,\"sales_order_id\":10,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"675.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"installment\",\"percentage\":2,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":8,\"calculation_item_id\":19,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(519, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 83, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-19\",\"account_id\":4,\"debit\":\"675.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":19,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(520, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 84, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-19\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"675.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":19,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(521, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:41.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(522, 'audit', 'created', 'created', 'App\\Models\\Commission', 20, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":9,\"sales_order_id\":11,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"4500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":10,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":9,\"calculation_item_id\":20,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(523, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 85, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-20\",\"account_id\":4,\"debit\":\"4500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":20,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(524, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 86, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-20\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"4500.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":20,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(525, 'audit', 'created', 'created', 'App\\Models\\Commission', 21, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":9,\"sales_order_id\":11,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"9000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":20,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":9,\"calculation_item_id\":21,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(526, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 87, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-21\",\"account_id\":4,\"debit\":\"9000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":21,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(527, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 88, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-21\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"9000.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":21,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(528, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:41.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(529, 'audit', 'created', 'created', 'App\\Models\\Commission', 22, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":10,\"sales_order_id\":11,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"1350.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"installment\",\"percentage\":4,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":10,\"calculation_item_id\":22,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(530, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 89, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-22\",\"account_id\":4,\"debit\":\"1350.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":22,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(531, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 90, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-22\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1350.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":22,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(532, 'audit', 'created', 'created', 'App\\Models\\Commission', 23, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":10,\"sales_order_id\":11,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"2362.50\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"installment\",\"percentage\":7,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":10,\"calculation_item_id\":23,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(533, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 91, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-23\",\"account_id\":4,\"debit\":\"2362.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":23,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(534, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 92, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-23\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2362.50\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":23,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(535, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:41.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(536, 'audit', 'created', 'created', 'App\\Models\\Commission', 24, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":11,\"sales_order_id\":12,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"6000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":11,\"calculation_item_id\":24,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(537, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 93, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-24\",\"account_id\":4,\"debit\":\"6000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":24,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(538, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 94, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-24\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"6000.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":24,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(539, 'audit', 'created', 'created', 'App\\Models\\Commission', 25, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":11,\"sales_order_id\":12,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"6000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":11,\"calculation_item_id\":25,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(540, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 95, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-25\",\"account_id\":4,\"debit\":\"6000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":25,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(541, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 96, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-25\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"6000.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":25,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(542, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:41.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(543, 'audit', 'created', 'created', 'App\\Models\\Commission', 26, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":12,\"sales_order_id\":12,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"1500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"installment\",\"percentage\":5,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":12,\"calculation_item_id\":26,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(544, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 97, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-26\",\"account_id\":4,\"debit\":\"1500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":26,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(545, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 98, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-26\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1500.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":26,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(546, 'audit', 'created', 'created', 'App\\Models\\Commission', 27, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":12,\"sales_order_id\":12,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"1800.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"installment\",\"percentage\":6,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":12,\"calculation_item_id\":27,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(547, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 99, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-27\",\"account_id\":4,\"debit\":\"1800.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":27,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(548, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 100, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-27\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1800.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":27,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(549, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:41.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(550, 'audit', 'created', 'created', 'App\\Models\\Commission', 28, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":13,\"sales_order_id\":14,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"5250.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":13,\"calculation_item_id\":28,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41');
INSERT INTO `activity_log` (`id`, `log_name`, `event`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(551, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 101, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-28\",\"account_id\":4,\"debit\":\"5250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":28,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(552, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 102, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-28\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"5250.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":28,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(553, 'audit', 'created', 'created', 'App\\Models\\Commission', 29, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":13,\"sales_order_id\":14,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"5250.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":13,\"calculation_item_id\":29,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(554, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 103, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-29\",\"account_id\":4,\"debit\":\"5250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":29,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(555, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 104, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-29\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"5250.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":29,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(556, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:41.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(557, 'audit', 'created', 'created', 'App\\Models\\Commission', 30, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":14,\"sales_order_id\":14,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"1312.50\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"installment\",\"percentage\":5,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":14,\"calculation_item_id\":30,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(558, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 105, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-30\",\"account_id\":4,\"debit\":\"1312.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":30,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(559, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 106, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-30\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1312.50\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":30,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(560, 'audit', 'created', 'created', 'App\\Models\\Commission', 31, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":14,\"sales_order_id\":14,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"1575.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"installment\",\"percentage\":6,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":14,\"calculation_item_id\":31,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(561, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 107, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-31\",\"account_id\":4,\"debit\":\"1575.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":31,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(562, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 108, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-31\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1575.00\",\"occurred_at\":\"2025-11-19T09:26:41.000000Z\",\"meta\":{\"commission_id\":31,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(563, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:41.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(564, 'audit', 'created', 'created', 'App\\Models\\Commission', 32, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":15,\"sales_order_id\":15,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"6000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":15,\"calculation_item_id\":32,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(565, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 109, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-32\",\"account_id\":4,\"debit\":\"6000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":32,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(566, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 110, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-32\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"6000.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":32,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(567, 'audit', 'created', 'created', 'App\\Models\\Commission', 33, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":15,\"sales_order_id\":15,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"6000.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":15,\"calculation_item_id\":33,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(568, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 111, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-33\",\"account_id\":4,\"debit\":\"6000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":33,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(569, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 112, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-33\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"6000.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":33,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(570, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 15, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:42.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(571, 'audit', 'created', 'created', 'App\\Models\\Commission', 34, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":16,\"sales_order_id\":15,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"1500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"installment\",\"percentage\":5,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":16,\"calculation_item_id\":34,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(572, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 113, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-34\",\"account_id\":4,\"debit\":\"1500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":34,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(573, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 114, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-34\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1500.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":34,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(574, 'audit', 'created', 'created', 'App\\Models\\Commission', 35, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":16,\"sales_order_id\":15,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"1800.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"installment\",\"percentage\":6,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":16,\"calculation_item_id\":35,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(575, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 115, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-35\",\"account_id\":4,\"debit\":\"1800.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":35,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(576, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 116, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-35\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1800.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":35,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(577, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:42.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(578, 'audit', 'created', 'created', 'App\\Models\\Commission', 36, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":17,\"sales_order_id\":16,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"10500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":30,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":17,\"calculation_item_id\":36,\"order_created_by\":\"admin\",\"source_me_id\":12}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(579, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 117, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-36\",\"account_id\":4,\"debit\":\"10500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":36,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(580, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 118, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-36\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"10500.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":36,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(581, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:42.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(582, 'audit', 'created', 'created', 'App\\Models\\Commission', 37, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":18,\"sales_order_id\":17,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"4500.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":18,\"calculation_item_id\":37,\"order_created_by\":\"agent\"}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(583, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 119, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-37\",\"account_id\":4,\"debit\":\"4500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":37,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(584, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 120, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-37\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"4500.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":37,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(585, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 18, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:42.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(586, 'audit', 'created', 'created', 'App\\Models\\Commission', 38, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":19,\"sales_order_id\":17,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"300.00\",\"status\":\"paid\",\"paid_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":19,\"calculation_item_id\":38,\"order_created_by\":\"agent\"}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(587, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 121, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-38\",\"account_id\":4,\"debit\":\"300.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":38,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(588, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 122, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-38\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"300.00\",\"occurred_at\":\"2025-11-19T09:26:42.000000Z\",\"meta\":{\"commission_id\":38,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(589, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-19T09:26:42.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(590, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 123, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-9\",\"account_id\":4,\"debit\":\"3587.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-25T16:25:32.000000Z\",\"meta\":{\"employee_id\":12,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-25 16:25:32', '2025-11-25 16:25:32'),
(591, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 124, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-9\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"3587.50\",\"occurred_at\":\"2025-11-25T16:25:32.000000Z\",\"meta\":{\"employee_id\":12,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-25 16:25:32', '2025-11-25 16:25:32'),
(592, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 125, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-10\",\"account_id\":4,\"debit\":\"787.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-25T16:58:20.000000Z\",\"meta\":{\"employee_id\":13,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-25 16:58:20', '2025-11-25 16:58:20'),
(593, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 126, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-10\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"787.50\",\"occurred_at\":\"2025-11-25T16:58:20.000000Z\",\"meta\":{\"employee_id\":13,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-25 16:58:20', '2025-11-25 16:58:20'),
(594, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 127, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-11\",\"account_id\":4,\"debit\":\"787.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-25T16:58:47.000000Z\",\"meta\":{\"employee_id\":14,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-25 16:58:47', '2025-11-25 16:58:47'),
(595, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 128, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-11\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"787.50\",\"occurred_at\":\"2025-11-25T16:58:47.000000Z\",\"meta\":{\"employee_id\":14,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-25 16:58:47', '2025-11-25 16:58:47'),
(596, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 129, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-13\",\"account_id\":4,\"debit\":\"3587.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-25T17:02:35.000000Z\",\"meta\":{\"employee_id\":12,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-25 17:02:35', '2025-11-25 17:02:35'),
(597, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 130, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-13\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"3587.50\",\"occurred_at\":\"2025-11-25T17:02:35.000000Z\",\"meta\":{\"employee_id\":12,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-25 17:02:35', '2025-11-25 17:02:35'),
(598, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"down_payment\":1,\"installment\":7,\"percentage\":\"2\",\"max_levels\":\"4\"}},\"old\":{\"value\":{\"down_payment\":1,\"installment\":7,\"percentage\":\"1\",\"max_levels\":\"5\"}}}', NULL, '2025-11-26 11:10:46', '2025-11-26 11:10:46'),
(599, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"down_payment\":1,\"installment\":7,\"percentage\":\"1\",\"max_levels\":\"5\"}},\"old\":{\"value\":{\"down_payment\":1,\"installment\":7,\"percentage\":\"2\",\"max_levels\":\"4\"}}}', NULL, '2025-11-26 11:11:00', '2025-11-26 11:11:00'),
(600, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 131, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-17\",\"account_id\":4,\"debit\":\"3587.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-26T11:11:07.000000Z\",\"meta\":{\"employee_id\":12,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-26 11:11:07', '2025-11-26 11:11:07'),
(601, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 132, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-17\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"3587.50\",\"occurred_at\":\"2025-11-26T11:11:07.000000Z\",\"meta\":{\"employee_id\":12,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-26 11:11:07', '2025-11-26 11:11:07'),
(602, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 133, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-18\",\"account_id\":4,\"debit\":\"787.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-26T11:11:07.000000Z\",\"meta\":{\"employee_id\":13,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-26 11:11:07', '2025-11-26 11:11:07'),
(603, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 134, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-18\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"787.50\",\"occurred_at\":\"2025-11-26T11:11:07.000000Z\",\"meta\":{\"employee_id\":13,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-26 11:11:07', '2025-11-26 11:11:07'),
(604, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 135, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-20\",\"account_id\":4,\"debit\":\"787.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-26T11:11:07.000000Z\",\"meta\":{\"employee_id\":15,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-26 11:11:07', '2025-11-26 11:11:07'),
(605, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 136, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"INC-20\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"787.50\",\"occurred_at\":\"2025-11-26T11:11:07.000000Z\",\"meta\":{\"employee_id\":15,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}}}', NULL, '2025-11-26 11:11:07', '2025-11-26 11:11:07'),
(606, 'audit', 'created', 'created', 'App\\Models\\Employee', 22, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":58,\"branch_id\":1,\"agent_id\":null,\"superior_id\":null,\"employee_code\":\"ED-0001\",\"rank\":\"ED\",\"full_name_en\":\"SAD MIA\",\"full_name_bn\":\"SAD MIA\",\"father_name\":\"Amjad\",\"mother_name\":\"Fatema\",\"mobile\":\"01999111111\",\"national_id\":\"1234567111\",\"date_of_birth\":\"1998-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-28 16:30:52', '2025-11-28 16:30:52'),
(607, 'audit', 'created', 'created', 'App\\Models\\EmployeeEducation', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":22,\"level\":\"PSC\\/5 Pass\",\"institution\":null,\"subject\":\"cs\",\"result\":\"3.5\",\"passing_year\":\"2007\"}}', NULL, '2025-11-28 16:30:52', '2025-11-28 16:30:52'),
(608, 'audit', 'created', 'created', 'App\\Models\\EmployeeNominee', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":22,\"name\":\"MD MAYIN UDDIN\",\"relation\":\"dsfsfd\",\"phone\":\"01999070234\",\"email\":null,\"address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\"}}', NULL, '2025-11-28 16:30:52', '2025-11-28 16:30:52'),
(609, 'audit', 'created', 'created', 'App\\Models\\Rank', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"name\":\"Assistant Managind Director\",\"code\":\"AMD\",\"description\":null,\"sort_order\":10}}', NULL, '2025-11-28 16:32:16', '2025-11-28 16:32:16'),
(610, 'audit', 'created', 'created', 'App\\Models\\Employee', 23, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":59,\"branch_id\":1,\"agent_id\":null,\"superior_id\":null,\"employee_code\":\"AMD-0001\",\"rank\":\"AMD\",\"full_name_en\":\"SAPLA\",\"full_name_bn\":\"SAPLA\",\"father_name\":\"sapila\",\"mother_name\":\"sapeda\",\"mobile\":\"0199902222\",\"national_id\":\"21213123\",\"date_of_birth\":\"1997-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-28 16:33:55', '2025-11-28 16:33:55'),
(611, 'audit', 'created', 'created', 'App\\Models\\EmployeeEducation', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":23,\"level\":\"PSC\\/5 Pass\",\"institution\":null,\"subject\":\"CSE\",\"result\":\"3.5\",\"passing_year\":\"2024\"}}', NULL, '2025-11-28 16:33:55', '2025-11-28 16:33:55'),
(612, 'audit', 'created', 'created', 'App\\Models\\EmployeeNominee', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":23,\"name\":\"MD MAYIN UDDIN\",\"relation\":\"sfsdf\",\"phone\":\"01999070234\",\"email\":null,\"address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\"}}', NULL, '2025-11-28 16:33:55', '2025-11-28 16:33:55'),
(613, 'audit', 'created', 'created', 'App\\Models\\Employee', 24, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":60,\"branch_id\":1,\"agent_id\":null,\"superior_id\":null,\"employee_code\":\"D-00001\",\"rank\":\"DIR\",\"full_name_en\":\"FAJLE\",\"full_name_bn\":\"FAJLE\",\"father_name\":\"SAPILA\",\"mother_name\":\"Nasima Begum\",\"mobile\":\"0199907021\",\"national_id\":\"12313123\",\"date_of_birth\":\"1997-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-28 16:35:55', '2025-11-28 16:35:55'),
(614, 'audit', 'created', 'created', 'App\\Models\\EmployeeEducation', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":24,\"level\":\"PSC\\/5 Pass\",\"institution\":null,\"subject\":\"CS\",\"result\":\"3.75\",\"passing_year\":\"2025\"}}', NULL, '2025-11-28 16:35:55', '2025-11-28 16:35:55'),
(615, 'audit', 'created', 'created', 'App\\Models\\EmployeeNominee', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":24,\"name\":\"MD MAYIN UDDIN\",\"relation\":\"sfsdf\",\"phone\":\"01999070234\",\"email\":null,\"address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\"}}', NULL, '2025-11-28 16:35:55', '2025-11-28 16:35:55'),
(616, 'audit', 'created', 'created', 'App\\Models\\Employee', 25, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":61,\"branch_id\":1,\"agent_id\":null,\"superior_id\":null,\"employee_code\":\"DMD-0002\",\"rank\":\"DMD\",\"full_name_en\":\"MOSJA\",\"full_name_bn\":\"MOSJA\",\"father_name\":\"Sakil\",\"mother_name\":\"sakina\",\"mobile\":\"01992222112\",\"national_id\":\"21313123\",\"date_of_birth\":\"1997-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-28 16:37:39', '2025-11-28 16:37:39'),
(617, 'audit', 'created', 'created', 'App\\Models\\EmployeeEducation', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":25,\"level\":\"PSC\\/5 Pass\",\"institution\":null,\"subject\":\"cs\",\"result\":\"3.56\",\"passing_year\":\"2025\"}}', NULL, '2025-11-28 16:37:39', '2025-11-28 16:37:39'),
(618, 'audit', 'created', 'created', 'App\\Models\\EmployeeNominee', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":25,\"name\":\"MD MAYIN UDDIN\",\"relation\":\"brother\",\"phone\":\"01999070234\",\"email\":null,\"address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\"}}', NULL, '2025-11-28 16:37:39', '2025-11-28 16:37:39'),
(619, 'audit', 'created', 'created', 'App\\Models\\CommissionSetting', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"key\":\"ed_fund_settings\",\"value\":{\"percentage\":4,\"frequency\":\"monthly\"}}}', NULL, '2025-11-28 16:58:14', '2025-11-28 16:58:14'),
(620, 'audit', 'created', 'created', 'App\\Models\\CommissionSetting', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"key\":\"amd_fund_settings\",\"value\":{\"percentage\":2,\"frequency\":\"quarterly\"}}}', NULL, '2025-11-28 16:58:34', '2025-11-28 16:58:34'),
(621, 'audit', 'created', 'created', 'App\\Models\\CommissionSetting', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"key\":\"dmd_fund_settings\",\"value\":{\"percentage\":10,\"frequency\":\"yearly\"}}}', NULL, '2025-11-28 16:58:47', '2025-11-28 16:58:47'),
(622, 'audit', 'deleted', 'deleted', 'App\\Models\\CommissionSetting', 6, 'App\\Models\\User', 10, '{\"old\":{\"key\":\"director_fund\",\"value\":{\"PD\":{\"percentage\":2,\"frequency\":\"quarterly\"},\"ED\":{\"percentage\":2,\"frequency\":\"half_yearly\"},\"DMD\":{\"percentage\":1,\"frequency\":\"yearly\"},\"DIR\":{\"percentage\":20,\"per_person_share\":1}}}}', NULL, '2025-11-28 17:00:24', '2025-11-28 17:00:24'),
(623, 'audit', 'created', 'created', 'App\\Models\\CommissionSetting', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"key\":\"director_rank_settings\",\"value\":{\"ED\":{\"share_target\":10,\"gm_target\":10},\"AMD\":{\"share_target\":20,\"gm_target\":20},\"DMD\":{\"share_target\":25,\"gm_target\":25},\"DIR\":{\"share_target\":30,\"gm_target\":30}}}}', NULL, '2025-11-28 17:04:15', '2025-11-28 17:04:15'),
(624, 'audit', 'created', 'created', 'App\\Models\\DirectorFund', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":22,\"type\":\"ed\",\"period_start\":\"2025-11-01T00:00:00.000000Z\",\"period_end\":\"2025-11-30T00:00:00.000000Z\",\"percentage_used\":\"4.00\",\"total_fund\":\"20550.00\",\"per_person_amount\":\"20550.00\",\"status\":\"draft\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":513750.01,\"recipient_count\":1},\"processed_at\":null}}', NULL, '2025-11-29 08:03:00', '2025-11-29 08:03:00'),
(625, 'audit', 'created', 'created', 'App\\Models\\Employee', 26, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":62,\"branch_id\":1,\"agent_id\":null,\"superior_id\":null,\"employee_code\":\"ED-00002\",\"rank\":\"ED\",\"full_name_en\":\"MIZANUR RAHMAN\",\"full_name_bn\":\"MIZANUR RAHMAN\",\"father_name\":\"MOSHIUR RAHMAN\",\"mother_name\":\"mosejda\",\"mobile\":\"01521565478\",\"national_id\":\"1234567123\",\"date_of_birth\":\"1998-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 11:59:55', '2025-11-29 11:59:55'),
(626, 'audit', 'created', 'created', 'App\\Models\\EmployeeEducation', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":26,\"level\":\"HSC\\/A Level\\/Alim\",\"institution\":null,\"subject\":\"CSE\",\"result\":\"3.5\",\"passing_year\":\"2009\"}}', NULL, '2025-11-29 11:59:55', '2025-11-29 11:59:55'),
(627, 'audit', 'created', 'created', 'App\\Models\\EmployeeNominee', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":26,\"name\":\"MD MAYIN UDDIN\",\"relation\":\"Brother\",\"phone\":\"01999070234\",\"email\":null,\"address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\"}}', NULL, '2025-11-29 11:59:55', '2025-11-29 11:59:55'),
(628, 'audit', 'created', 'created', 'App\\Models\\Employee', 27, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":63,\"branch_id\":1,\"agent_id\":null,\"superior_id\":null,\"employee_code\":\"ED-0003\",\"rank\":\"ED\",\"full_name_en\":\"Monir mia\",\"full_name_bn\":\"Monir mia\",\"father_name\":\"Mosqur mia\",\"mother_name\":\"moeje\",\"mobile\":\"0199912313\",\"national_id\":\"12312312\",\"date_of_birth\":\"1997-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 12:01:58', '2025-11-29 12:01:58'),
(629, 'audit', 'created', 'created', 'App\\Models\\EmployeeEducation', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":27,\"level\":\"PSC\\/5 Pass\",\"institution\":null,\"subject\":\"cse\",\"result\":\"2.5\",\"passing_year\":\"2009\"}}', NULL, '2025-11-29 12:01:58', '2025-11-29 12:01:58'),
(630, 'audit', 'created', 'created', 'App\\Models\\EmployeeNominee', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":27,\"name\":\"MD MAYIN UDDIN\",\"relation\":\"sfsdf\",\"phone\":\"01999070234\",\"email\":null,\"address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\"}}', NULL, '2025-11-29 12:01:58', '2025-11-29 12:01:58'),
(631, 'audit', 'created', 'created', 'App\\Models\\Employee', 28, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":64,\"branch_id\":1,\"agent_id\":null,\"superior_id\":null,\"employee_code\":\"ED-00004\",\"rank\":\"ED\",\"full_name_en\":\"SIPBKU\",\"full_name_bn\":\"SIPBKU\",\"father_name\":\"shija\",\"mother_name\":\"shaji\",\"mobile\":\"01999012213\",\"national_id\":\"21313213\",\"date_of_birth\":\"1995-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 12:03:32', '2025-11-29 12:03:32'),
(632, 'audit', 'created', 'created', 'App\\Models\\EmployeeEducation', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":28,\"level\":\"SSC\\/O Level\\/Dakhil\",\"institution\":null,\"subject\":\"CS\",\"result\":\"3.5\",\"passing_year\":\"2011\"}}', NULL, '2025-11-29 12:03:32', '2025-11-29 12:03:32'),
(633, 'audit', 'created', 'created', 'App\\Models\\EmployeeNominee', 15, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":28,\"name\":\"MD MAYIN UDDIN\",\"relation\":\"sfsdf\",\"phone\":\"01999070234\",\"email\":null,\"address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\"}}', NULL, '2025-11-29 12:03:32', '2025-11-29 12:03:32'),
(634, 'audit', 'created', 'created', 'App\\Models\\Employee', 29, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":65,\"branch_id\":1,\"agent_id\":null,\"superior_id\":null,\"employee_code\":\"ED-0005\",\"rank\":\"ED\",\"full_name_en\":\"ESHAN\",\"full_name_bn\":\"ESHAN\",\"father_name\":\"esfiq\",\"mother_name\":\"eshana\",\"mobile\":\"01999072313\",\"national_id\":\"234324\",\"date_of_birth\":\"1985-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 12:05:07', '2025-11-29 12:05:07'),
(635, 'audit', 'created', 'created', 'App\\Models\\EmployeeEducation', 15, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":29,\"level\":\"JSC\\/JDC\\/8 Pass\",\"institution\":null,\"subject\":\"cS\",\"result\":\"3.2\",\"passing_year\":\"2010\"}}', NULL, '2025-11-29 12:05:07', '2025-11-29 12:05:07'),
(636, 'audit', 'created', 'created', 'App\\Models\\EmployeeNominee', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":29,\"name\":\"MD MAYIN UDDIN\",\"relation\":\"sfsdf\",\"phone\":\"01999070234\",\"email\":null,\"address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\"}}', NULL, '2025-11-29 12:05:07', '2025-11-29 12:05:07'),
(637, 'audit', 'created', 'created', 'App\\Models\\Employee', 30, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":66,\"branch_id\":1,\"agent_id\":null,\"superior_id\":null,\"employee_code\":\"ED-0006\",\"rank\":\"ED\",\"full_name_en\":\"Rehan\",\"full_name_bn\":\"Rehan\",\"father_name\":\"Reja mia\",\"mother_name\":\"remahi\",\"mobile\":\"01999123213\",\"national_id\":\"2133213\",\"date_of_birth\":\"1998-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 12:11:30', '2025-11-29 12:11:30'),
(638, 'audit', 'created', 'created', 'App\\Models\\EmployeeEducation', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":30,\"level\":\"PSC\\/5 Pass\",\"institution\":null,\"subject\":\"PS\",\"result\":\"3.5\",\"passing_year\":\"2010\"}}', NULL, '2025-11-29 12:11:30', '2025-11-29 12:11:30'),
(639, 'audit', 'created', 'created', 'App\\Models\\EmployeeNominee', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":30,\"name\":\"MD MAYIN UDDIN\",\"relation\":\"sfsdf\",\"phone\":\"01999070234\",\"email\":null,\"address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\"}}', NULL, '2025-11-29 12:11:30', '2025-11-29 12:11:30'),
(640, 'audit', 'created', 'created', 'App\\Models\\Employee', 31, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":67,\"branch_id\":2,\"agent_id\":null,\"superior_id\":26,\"employee_code\":\"G00002\",\"rank\":\"GM\",\"full_name_en\":\"SAW MIA\",\"full_name_bn\":\"SAW MIA\",\"father_name\":\"SABUJ\",\"mother_name\":\"SAKINA\",\"mobile\":\"01999073244\",\"national_id\":\"324324\",\"date_of_birth\":\"1995-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 12:23:37', '2025-11-29 12:23:37'),
(641, 'audit', 'created', 'created', 'App\\Models\\Employee', 32, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":68,\"branch_id\":2,\"agent_id\":null,\"superior_id\":26,\"employee_code\":\"GM-00003\",\"rank\":\"GM\",\"full_name_en\":\"KABIR SINGH\",\"full_name_bn\":\"KABIR SINGH\",\"father_name\":\"SAKIL\",\"mother_name\":\"SHAJEDA\",\"mobile\":\"01999070234\",\"national_id\":\"1234567890\",\"date_of_birth\":\"1998-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":null,\"post_code\":null}}', NULL, '2025-11-29 12:33:39', '2025-11-29 12:33:39'),
(642, 'audit', 'created', 'created', 'App\\Models\\Employee', 33, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":69,\"branch_id\":2,\"agent_id\":null,\"superior_id\":26,\"employee_code\":\"GM-00004\",\"rank\":\"GM\",\"full_name_en\":\"SOCRETIS\",\"full_name_bn\":\"SOCRETIS\",\"father_name\":\"sajal mia\",\"mother_name\":\"sakina\",\"mobile\":\"01999012121\",\"national_id\":\"13123213\",\"date_of_birth\":\"1995-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":null,\"post_code\":null}}', NULL, '2025-11-29 12:34:53', '2025-11-29 12:34:53'),
(643, 'audit', 'created', 'created', 'App\\Models\\Employee', 34, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":70,\"branch_id\":2,\"agent_id\":null,\"superior_id\":26,\"employee_code\":\"GM-00005\",\"rank\":\"GM\",\"full_name_en\":\"MIHILA\",\"full_name_bn\":\"MIHILA\",\"father_name\":\"Mijik\",\"mother_name\":\"mocena\",\"mobile\":\"01999031321\",\"national_id\":\"123123213\",\"date_of_birth\":\"1995-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 12:36:02', '2025-11-29 12:36:02'),
(644, 'audit', 'created', 'created', 'App\\Models\\Employee', 35, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":71,\"branch_id\":2,\"agent_id\":null,\"superior_id\":26,\"employee_code\":\"GM-00006\",\"rank\":\"GM\",\"full_name_en\":\"SJID\",\"full_name_bn\":\"SJID\",\"father_name\":\"samila\",\"mother_name\":\"samia\",\"mobile\":\"0199901231\",\"national_id\":\"3212123\",\"date_of_birth\":\"1995-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 12:37:24', '2025-11-29 12:37:24'),
(645, 'audit', 'created', 'created', 'App\\Models\\Employee', 36, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":72,\"branch_id\":3,\"agent_id\":null,\"superior_id\":26,\"employee_code\":\"GM-00007\",\"rank\":\"GM\",\"full_name_en\":\"FARUQ\",\"full_name_bn\":\"FARUQ\",\"father_name\":\"KARIQ\",\"mother_name\":\"khadiza\",\"mobile\":\"019990713213\",\"national_id\":\"2131321\",\"date_of_birth\":\"1998-05-01T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 12:39:54', '2025-11-29 12:39:54'),
(646, 'audit', 'created', 'created', 'App\\Models\\Employee', 37, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":73,\"branch_id\":2,\"agent_id\":null,\"superior_id\":26,\"employee_code\":\"GM-00008\",\"rank\":\"GM\",\"full_name_en\":\"ENUS\",\"full_name_bn\":\"ENUS\",\"father_name\":\"Eshaq\",\"mother_name\":\"eahana\",\"mobile\":\"019990123123\",\"national_id\":\"21321321\",\"date_of_birth\":\"1995-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 12:40:51', '2025-11-29 12:40:51'),
(647, 'audit', 'created', 'created', 'App\\Models\\Employee', 38, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":74,\"branch_id\":2,\"agent_id\":null,\"superior_id\":26,\"employee_code\":\"GM-00009\",\"rank\":\"GM\",\"full_name_en\":\"HABIB\",\"full_name_bn\":\"HABIB\",\"father_name\":\"Hafej ak\",\"mother_name\":\"hafeja\",\"mobile\":\"01999070234\",\"national_id\":\"09876522\",\"date_of_birth\":\"1995-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 12:41:59', '2025-11-29 12:41:59'),
(648, 'audit', 'created', 'created', 'App\\Models\\Employee', 39, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":75,\"branch_id\":2,\"agent_id\":null,\"superior_id\":26,\"employee_code\":\"GM-00010\",\"rank\":\"GM\",\"full_name_en\":\"Eshraj\",\"full_name_bn\":\"Eshraj\",\"father_name\":\"Ebj\",\"mother_name\":\"ehana\",\"mobile\":\"01999071231\",\"national_id\":\"213123213\",\"date_of_birth\":\"1995-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 12:43:19', '2025-11-29 12:43:19'),
(649, 'audit', 'created', 'created', 'App\\Models\\Employee', 40, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":76,\"branch_id\":2,\"agent_id\":null,\"superior_id\":26,\"employee_code\":\"GM-00011\",\"rank\":\"GM\",\"full_name_en\":\"SABBIR\",\"full_name_bn\":\"SABBIR\",\"father_name\":\"Shabj\",\"mother_name\":\"samja\",\"mobile\":\"01999072313\",\"national_id\":\"213213213\",\"date_of_birth\":\"1995-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 12:45:36', '2025-11-29 12:45:36'),
(650, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 18, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":77,\"employee_id\":26,\"source_me_id\":26,\"agent_id\":null,\"branch_id\":1,\"sales_type\":\"order\",\"rank\":\"ED\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-11-29 13:01:39', '2025-11-29 13:01:39'),
(651, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 18, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-11-29 13:01:39', '2025-11-29 13:01:39'),
(652, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 101, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"due_date\":\"2025-12-04T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-29 13:01:44', '2025-11-29 13:01:44'),
(653, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 102, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"due_date\":\"2026-01-03T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-29 13:01:44', '2025-11-29 13:01:44'),
(654, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 103, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"due_date\":\"2026-02-03T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-29 13:01:44', '2025-11-29 13:01:44'),
(655, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 104, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"due_date\":\"2026-03-05T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-29 13:01:44', '2025-11-29 13:01:44'),
(656, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 105, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"due_date\":\"2026-04-03T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-29 13:01:44', '2025-11-29 13:01:44'),
(657, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 106, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"due_date\":\"2026-05-04T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-29 13:01:44', '2025-11-29 13:01:44'),
(658, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 107, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"due_date\":\"2026-06-03T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-29 13:01:44', '2025-11-29 13:01:44'),
(659, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 108, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"due_date\":\"2026-07-04T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-29 13:01:44', '2025-11-29 13:01:44');
INSERT INTO `activity_log` (`id`, `log_name`, `event`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(660, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 109, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"due_date\":\"2026-08-03T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-29 13:01:44', '2025-11-29 13:01:44'),
(661, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 110, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"due_date\":\"2026-09-03T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-29 13:01:44', '2025-11-29 13:01:44'),
(662, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 111, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"due_date\":\"2026-10-04T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-29 13:01:44', '2025-11-29 13:01:44'),
(663, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 112, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"due_date\":\"2026-11-03T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-11-29 13:01:44', '2025-11-29 13:01:44'),
(664, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 137, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-20\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-29T00:00:00.000000Z\",\"meta\":{\"payment_id\":20,\"sales_order_id\":18,\"method\":\"cash\"}}}', NULL, '2025-11-29 15:02:10', '2025-11-29 15:02:10'),
(665, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 138, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-20\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-11-29T00:00:00.000000Z\",\"meta\":{\"payment_id\":20,\"sales_order_id\":18,\"method\":\"cash\"}}}', NULL, '2025-11-29 15:02:10', '2025-11-29 15:02:10'),
(666, 'audit', 'created', 'created', 'App\\Models\\Payment', 20, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":18,\"paid_at\":\"2025-11-29T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"45000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"123123213\"}}}', NULL, '2025-11-29 15:02:10', '2025-11-29 15:02:10'),
(667, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 20, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":20,\"customer_installment_id\":101,\"allocated\":\"0.00\"}}', NULL, '2025-11-29 15:02:10', '2025-11-29 15:02:10'),
(668, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 101, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-11-29 15:02:10', '2025-11-29 15:02:10'),
(669, 'audit', 'updated', 'updated', 'App\\Models\\DirectorFund', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"total_fund\":\"22350.00\",\"per_person_amount\":\"3725.00\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":558750.01,\"recipient_count\":6}},\"old\":{\"total_fund\":\"20550.00\",\"per_person_amount\":\"20550.00\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":513750.01,\"recipient_count\":1}}}', NULL, '2025-11-29 15:05:10', '2025-11-29 15:05:10'),
(670, 'audit', 'created', 'created', 'App\\Models\\DirectorFund', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":26,\"type\":\"ed\",\"period_start\":\"2025-11-01T00:00:00.000000Z\",\"period_end\":\"2025-11-30T00:00:00.000000Z\",\"percentage_used\":\"4.00\",\"total_fund\":\"22350.00\",\"per_person_amount\":\"3725.00\",\"status\":\"draft\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":558750.01,\"recipient_count\":6},\"processed_at\":null}}', NULL, '2025-11-29 15:05:10', '2025-11-29 15:05:10'),
(671, 'audit', 'created', 'created', 'App\\Models\\DirectorFund', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":27,\"type\":\"ed\",\"period_start\":\"2025-11-01T00:00:00.000000Z\",\"period_end\":\"2025-11-30T00:00:00.000000Z\",\"percentage_used\":\"4.00\",\"total_fund\":\"22350.00\",\"per_person_amount\":\"3725.00\",\"status\":\"draft\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":558750.01,\"recipient_count\":6},\"processed_at\":null}}', NULL, '2025-11-29 15:05:10', '2025-11-29 15:05:10'),
(672, 'audit', 'created', 'created', 'App\\Models\\DirectorFund', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":28,\"type\":\"ed\",\"period_start\":\"2025-11-01T00:00:00.000000Z\",\"period_end\":\"2025-11-30T00:00:00.000000Z\",\"percentage_used\":\"4.00\",\"total_fund\":\"22350.00\",\"per_person_amount\":\"3725.00\",\"status\":\"draft\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":558750.01,\"recipient_count\":6},\"processed_at\":null}}', NULL, '2025-11-29 15:05:10', '2025-11-29 15:05:10'),
(673, 'audit', 'created', 'created', 'App\\Models\\DirectorFund', 5, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":29,\"type\":\"ed\",\"period_start\":\"2025-11-01T00:00:00.000000Z\",\"period_end\":\"2025-11-30T00:00:00.000000Z\",\"percentage_used\":\"4.00\",\"total_fund\":\"22350.00\",\"per_person_amount\":\"3725.00\",\"status\":\"draft\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":558750.01,\"recipient_count\":6},\"processed_at\":null}}', NULL, '2025-11-29 15:05:10', '2025-11-29 15:05:10'),
(674, 'audit', 'created', 'created', 'App\\Models\\DirectorFund', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":30,\"type\":\"ed\",\"period_start\":\"2025-11-01T00:00:00.000000Z\",\"period_end\":\"2025-11-30T00:00:00.000000Z\",\"percentage_used\":\"4.00\",\"total_fund\":\"22350.00\",\"per_person_amount\":\"3725.00\",\"status\":\"draft\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":558750.01,\"recipient_count\":6},\"processed_at\":null}}', NULL, '2025-11-29 15:05:11', '2025-11-29 15:05:11'),
(675, 'audit', 'created', 'created', 'App\\Models\\DirectorFund', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":22,\"type\":\"ed\",\"period_start\":\"2025-10-01T00:00:00.000000Z\",\"period_end\":\"2025-10-31T00:00:00.000000Z\",\"percentage_used\":\"4.00\",\"total_fund\":\"0.00\",\"per_person_amount\":\"0.00\",\"status\":\"draft\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":0,\"recipient_count\":6},\"processed_at\":null}}', NULL, '2025-11-29 15:53:41', '2025-11-29 15:53:41'),
(676, 'audit', 'created', 'created', 'App\\Models\\DirectorFund', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":26,\"type\":\"ed\",\"period_start\":\"2025-10-01T00:00:00.000000Z\",\"period_end\":\"2025-10-31T00:00:00.000000Z\",\"percentage_used\":\"4.00\",\"total_fund\":\"0.00\",\"per_person_amount\":\"0.00\",\"status\":\"draft\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":0,\"recipient_count\":6},\"processed_at\":null}}', NULL, '2025-11-29 15:53:41', '2025-11-29 15:53:41'),
(677, 'audit', 'created', 'created', 'App\\Models\\DirectorFund', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":27,\"type\":\"ed\",\"period_start\":\"2025-10-01T00:00:00.000000Z\",\"period_end\":\"2025-10-31T00:00:00.000000Z\",\"percentage_used\":\"4.00\",\"total_fund\":\"0.00\",\"per_person_amount\":\"0.00\",\"status\":\"draft\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":0,\"recipient_count\":6},\"processed_at\":null}}', NULL, '2025-11-29 15:53:41', '2025-11-29 15:53:41'),
(678, 'audit', 'created', 'created', 'App\\Models\\DirectorFund', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":28,\"type\":\"ed\",\"period_start\":\"2025-10-01T00:00:00.000000Z\",\"period_end\":\"2025-10-31T00:00:00.000000Z\",\"percentage_used\":\"4.00\",\"total_fund\":\"0.00\",\"per_person_amount\":\"0.00\",\"status\":\"draft\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":0,\"recipient_count\":6},\"processed_at\":null}}', NULL, '2025-11-29 15:53:41', '2025-11-29 15:53:41'),
(679, 'audit', 'created', 'created', 'App\\Models\\DirectorFund', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":29,\"type\":\"ed\",\"period_start\":\"2025-10-01T00:00:00.000000Z\",\"period_end\":\"2025-10-31T00:00:00.000000Z\",\"percentage_used\":\"4.00\",\"total_fund\":\"0.00\",\"per_person_amount\":\"0.00\",\"status\":\"draft\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":0,\"recipient_count\":6},\"processed_at\":null}}', NULL, '2025-11-29 15:53:41', '2025-11-29 15:53:41'),
(680, 'audit', 'created', 'created', 'App\\Models\\DirectorFund', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"employee_id\":30,\"type\":\"ed\",\"period_start\":\"2025-10-01T00:00:00.000000Z\",\"period_end\":\"2025-10-31T00:00:00.000000Z\",\"percentage_used\":\"4.00\",\"total_fund\":\"0.00\",\"per_person_amount\":\"0.00\",\"status\":\"draft\",\"meta\":{\"frequency\":\"monthly\",\"total_sales\":0,\"recipient_count\":6},\"processed_at\":null}}', NULL, '2025-11-29 15:53:41', '2025-11-29 15:53:41'),
(681, 'audit', 'created', 'created', 'App\\Models\\Employee', 41, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":78,\"branch_id\":2,\"agent_id\":null,\"superior_id\":26,\"employee_code\":\"GM-000012\",\"rank\":\"GM\",\"full_name_en\":\"SHihab mia\",\"full_name_bn\":\"SHihab mia\",\"father_name\":\"Shakil mia\",\"mother_name\":\"shine\",\"mobile\":\"01999071212\",\"national_id\":\"21321321121\",\"date_of_birth\":\"1998-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 17:27:49', '2025-11-29 17:27:49'),
(682, 'audit', 'created', 'created', 'App\\Models\\Employee', 42, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":79,\"branch_id\":2,\"agent_id\":null,\"superior_id\":26,\"employee_code\":\"GM-00013\",\"rank\":\"GM\",\"full_name_en\":\"Shamina\",\"full_name_bn\":\"Shamina\",\"father_name\":\"shajid\",\"mother_name\":\"shajeda\",\"mobile\":\"01999070212211\",\"national_id\":\"213213123213\",\"date_of_birth\":\"1998-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":null}}', NULL, '2025-11-29 17:29:09', '2025-11-29 17:29:09'),
(683, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 139, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"DIRF-1\",\"account_id\":4,\"debit\":\"3725.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-29T17:30:07.000000Z\",\"meta\":{\"employee_id\":22,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(684, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 140, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"DIRF-1\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"3725.00\",\"occurred_at\":\"2025-11-29T17:30:07.000000Z\",\"meta\":{\"employee_id\":22,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(685, 'audit', 'updated', 'updated', 'App\\Models\\DirectorFund', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"processed_at\":\"2025-11-29T17:30:07.000000Z\"},\"old\":{\"status\":\"draft\",\"processed_at\":null}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(686, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 141, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"DIRF-2\",\"account_id\":4,\"debit\":\"3725.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-29T17:30:07.000000Z\",\"meta\":{\"employee_id\":26,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(687, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 142, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"DIRF-2\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"3725.00\",\"occurred_at\":\"2025-11-29T17:30:07.000000Z\",\"meta\":{\"employee_id\":26,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(688, 'audit', 'updated', 'updated', 'App\\Models\\DirectorFund', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"processed_at\":\"2025-11-29T17:30:07.000000Z\"},\"old\":{\"status\":\"draft\",\"processed_at\":null}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(689, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 143, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"DIRF-3\",\"account_id\":4,\"debit\":\"3725.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-29T17:30:07.000000Z\",\"meta\":{\"employee_id\":27,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(690, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 144, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"DIRF-3\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"3725.00\",\"occurred_at\":\"2025-11-29T17:30:07.000000Z\",\"meta\":{\"employee_id\":27,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(691, 'audit', 'updated', 'updated', 'App\\Models\\DirectorFund', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"processed_at\":\"2025-11-29T17:30:07.000000Z\"},\"old\":{\"status\":\"draft\",\"processed_at\":null}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(692, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 145, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"DIRF-4\",\"account_id\":4,\"debit\":\"3725.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-29T17:30:07.000000Z\",\"meta\":{\"employee_id\":28,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(693, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 146, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"DIRF-4\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"3725.00\",\"occurred_at\":\"2025-11-29T17:30:07.000000Z\",\"meta\":{\"employee_id\":28,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(694, 'audit', 'updated', 'updated', 'App\\Models\\DirectorFund', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"processed_at\":\"2025-11-29T17:30:07.000000Z\"},\"old\":{\"status\":\"draft\",\"processed_at\":null}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(695, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 147, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"DIRF-5\",\"account_id\":4,\"debit\":\"3725.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-29T17:30:07.000000Z\",\"meta\":{\"employee_id\":29,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(696, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 148, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"DIRF-5\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"3725.00\",\"occurred_at\":\"2025-11-29T17:30:07.000000Z\",\"meta\":{\"employee_id\":29,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(697, 'audit', 'updated', 'updated', 'App\\Models\\DirectorFund', 5, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"processed_at\":\"2025-11-29T17:30:07.000000Z\"},\"old\":{\"status\":\"draft\",\"processed_at\":null}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(698, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 149, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"DIRF-6\",\"account_id\":4,\"debit\":\"3725.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-11-29T17:30:07.000000Z\",\"meta\":{\"employee_id\":30,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(699, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 150, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"DIRF-6\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"3725.00\",\"occurred_at\":\"2025-11-29T17:30:07.000000Z\",\"meta\":{\"employee_id\":30,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(700, 'audit', 'updated', 'updated', 'App\\Models\\DirectorFund', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"processed_at\":\"2025-11-29T17:30:07.000000Z\"},\"old\":{\"status\":\"draft\",\"processed_at\":null}}', NULL, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(701, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"percentage\":\"5\",\"frequency\":\"monthly\"}},\"old\":{\"value\":{\"percentage\":4,\"frequency\":\"monthly\"}}}', NULL, '2025-11-29 18:04:43', '2025-11-29 18:04:43'),
(702, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"percentage\":\"5\",\"frequency\":\"yearly\"}},\"old\":{\"value\":{\"percentage\":\"5\",\"frequency\":\"monthly\"}}}', NULL, '2025-11-29 18:04:54', '2025-11-29 18:04:54'),
(703, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"percentage\":\"4\",\"frequency\":\"monthly\"}},\"old\":{\"value\":{\"percentage\":\"5\",\"frequency\":\"yearly\"}}}', NULL, '2025-11-29 18:05:04', '2025-11-29 18:05:04'),
(704, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"percentage\":\"3\",\"frequency\":\"quarterly\"}},\"old\":{\"value\":{\"percentage\":2,\"frequency\":\"quarterly\"}}}', NULL, '2025-11-29 18:05:12', '2025-11-29 18:05:12'),
(705, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"percentage\":\"2\",\"frequency\":\"quarterly\"}},\"old\":{\"value\":{\"percentage\":\"3\",\"frequency\":\"quarterly\"}}}', NULL, '2025-11-29 18:05:19', '2025-11-29 18:05:19'),
(706, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"down_payment\":\"6\",\"installment\":1}},\"old\":{\"value\":{\"down_payment\":5,\"installment\":1}}}', NULL, '2025-11-29 18:05:25', '2025-11-29 18:05:25'),
(707, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"down_payment\":\"5\",\"installment\":1}},\"old\":{\"value\":{\"down_payment\":\"6\",\"installment\":1}}}', NULL, '2025-11-29 18:05:33', '2025-11-29 18:05:33'),
(708, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"0.00\",\"total\":\"17500.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-01 18:03:24', '2025-12-01 18:03:24'),
(709, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":19,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Service\",\"qty\":1,\"unit_price\":\"17500.00\",\"line_total\":\"17500.00\"}}', NULL, '2025-12-01 18:03:24', '2025-12-01 18:03:24'),
(710, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 19, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"0.00\",\"total\":\"17500.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-01 18:04:50', '2025-12-01 18:04:50'),
(711, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 20, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"0.00\",\"total\":\"50000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-01 18:15:02', '2025-12-01 18:15:02'),
(712, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 20, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":20,\"itemable_id\":2,\"itemable_type\":\"App\\\\Models\\\\Service\",\"qty\":1,\"unit_price\":\"50000.00\",\"line_total\":\"50000.00\"}}', NULL, '2025-12-01 18:15:02', '2025-12-01 18:15:02'),
(713, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 21, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"service\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":null,\"total\":\"50000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-01 18:20:06', '2025-12-01 18:20:06'),
(714, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 21, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":21,\"itemable_id\":2,\"itemable_type\":\"App\\\\Models\\\\Service\",\"qty\":1,\"unit_price\":\"50000.00\",\"line_total\":\"50000.00\"}}', NULL, '2025-12-01 18:20:06', '2025-12-01 18:20:06'),
(715, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 22, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"service\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":null,\"total\":\"50000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-01 18:24:20', '2025-12-01 18:24:20'),
(716, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 22, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":22,\"itemable_id\":2,\"itemable_type\":\"App\\\\Models\\\\Service\",\"qty\":1,\"unit_price\":\"50000.00\",\"line_total\":\"50000.00\"}}', NULL, '2025-12-01 18:24:20', '2025-12-01 18:24:20'),
(717, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 151, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-21\",\"account_id\":1,\"debit\":\"5000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-02-12T00:00:00.000000Z\",\"meta\":{\"payment_id\":21,\"sales_order_id\":1,\"method\":\"cash\"}}}', NULL, '2025-12-01 18:58:12', '2025-12-01 18:58:12'),
(718, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 152, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-21\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"5000.00\",\"occurred_at\":\"2025-02-12T00:00:00.000000Z\",\"meta\":{\"payment_id\":21,\"sales_order_id\":1,\"method\":\"cash\"}}}', NULL, '2025-12-01 18:58:12', '2025-12-01 18:58:12'),
(719, 'audit', 'created', 'created', 'App\\Models\\Payment', 21, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"paid_at\":\"2025-02-12T00:00:00.000000Z\",\"amount\":\"5000.00\",\"commission_base_amount\":\"4500.00\",\"commission_processed_at\":null,\"type\":\"full_payment\",\"intent_type\":\"due_payment\",\"method\":null,\"meta\":null}}', NULL, '2025-12-01 18:58:12', '2025-12-01 18:58:12'),
(722, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 155, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-23\",\"account_id\":1,\"debit\":\"5000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-02-12T00:00:00.000000Z\",\"meta\":{\"payment_id\":23,\"sales_order_id\":1,\"method\":\"cash\"}}}', NULL, '2025-12-01 19:00:50', '2025-12-01 19:00:50'),
(723, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 156, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-23\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"5000.00\",\"occurred_at\":\"2025-02-12T00:00:00.000000Z\",\"meta\":{\"payment_id\":23,\"sales_order_id\":1,\"method\":\"cash\"}}}', NULL, '2025-12-01 19:00:50', '2025-12-01 19:00:50'),
(724, 'audit', 'created', 'created', 'App\\Models\\Payment', 23, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":1,\"paid_at\":\"2025-02-12T00:00:00.000000Z\",\"amount\":\"5000.00\",\"commission_base_amount\":\"4500.00\",\"commission_processed_at\":null,\"type\":\"full_payment\",\"intent_type\":\"due_payment\",\"method\":null,\"meta\":null}}', NULL, '2025-12-01 19:00:50', '2025-12-01 19:00:50'),
(733, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 165, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-28\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-01T00:00:00.000000Z\",\"meta\":{\"payment_id\":28,\"sales_order_id\":22,\"method\":\"cash\"}}}', NULL, '2025-12-01 19:16:55', '2025-12-01 19:16:55'),
(734, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 166, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-28\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-12-01T00:00:00.000000Z\",\"meta\":{\"payment_id\":28,\"sales_order_id\":22,\"method\":\"cash\"}}}', NULL, '2025-12-01 19:16:55', '2025-12-01 19:16:55'),
(735, 'audit', 'created', 'created', 'App\\Models\\Commission', 39, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":28,\"sales_order_id\":22,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"2500.00\",\"status\":\"unpaid\",\"paid_at\":null,\"meta\":{\"payment_amount\":50000,\"commission_percentage\":5,\"service_id\":2}}}', NULL, '2025-12-01 19:16:55', '2025-12-01 19:16:55'),
(736, 'audit', 'created', 'created', 'App\\Models\\Payment', 28, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":22,\"paid_at\":\"2025-12-01T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"50000.00\",\"commission_processed_at\":null,\"type\":\"full_payment\",\"intent_type\":\"due_payment\",\"method\":null,\"meta\":null}}', NULL, '2025-12-01 19:16:55', '2025-12-01 19:16:55'),
(737, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 167, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-29\",\"account_id\":1,\"debit\":\"5000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-01T00:00:00.000000Z\",\"meta\":{\"payment_id\":29,\"sales_order_id\":22,\"method\":\"cash\"}}}', NULL, '2025-12-01 19:24:11', '2025-12-01 19:24:11'),
(738, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 168, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-29\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"5000.00\",\"occurred_at\":\"2025-12-01T00:00:00.000000Z\",\"meta\":{\"payment_id\":29,\"sales_order_id\":22,\"method\":\"cash\"}}}', NULL, '2025-12-01 19:24:11', '2025-12-01 19:24:11'),
(739, 'audit', 'created', 'created', 'App\\Models\\Commission', 40, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":29,\"sales_order_id\":22,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"250.00\",\"status\":\"unpaid\",\"paid_at\":null,\"meta\":{\"payment_amount\":5000,\"commission_percentage\":5,\"service_id\":2}}}', NULL, '2025-12-01 19:24:11', '2025-12-01 19:24:11'),
(740, 'audit', 'created', 'created', 'App\\Models\\Payment', 29, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":22,\"paid_at\":\"2025-12-01T00:00:00.000000Z\",\"amount\":\"5000.00\",\"commission_base_amount\":\"5000.00\",\"commission_processed_at\":null,\"type\":\"partial_payment\",\"intent_type\":\"due_payment\",\"method\":null,\"meta\":null}}', NULL, '2025-12-01 19:24:11', '2025-12-01 19:24:11'),
(741, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 169, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-30\",\"account_id\":1,\"debit\":\"5000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-01T00:00:00.000000Z\",\"meta\":{\"payment_id\":30,\"sales_order_id\":21,\"method\":\"cash\"}}}', NULL, '2025-12-01 19:25:21', '2025-12-01 19:25:21'),
(742, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 170, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-30\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"5000.00\",\"occurred_at\":\"2025-12-01T00:00:00.000000Z\",\"meta\":{\"payment_id\":30,\"sales_order_id\":21,\"method\":\"cash\"}}}', NULL, '2025-12-01 19:25:21', '2025-12-01 19:25:21'),
(743, 'audit', 'created', 'created', 'App\\Models\\Commission', 41, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":30,\"sales_order_id\":21,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"amount\":\"250.00\",\"status\":\"unpaid\",\"paid_at\":null,\"meta\":{\"payment_amount\":5000,\"commission_percentage\":5,\"service_id\":2}}}', NULL, '2025-12-01 19:25:21', '2025-12-01 19:25:21'),
(744, 'audit', 'created', 'created', 'App\\Models\\Payment', 30, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":21,\"paid_at\":\"2025-12-01T00:00:00.000000Z\",\"amount\":\"5000.00\",\"commission_base_amount\":\"5000.00\",\"commission_processed_at\":null,\"type\":\"partial_payment\",\"intent_type\":\"due_payment\",\"method\":null,\"meta\":null}}', NULL, '2025-12-01 19:25:21', '2025-12-01 19:25:21'),
(745, 'audit', 'updated', 'updated', 'App\\Models\\Commission', 39, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"paid_at\":\"2025-12-01T19:30:48.000000Z\"},\"old\":{\"status\":\"unpaid\",\"paid_at\":null}}', NULL, '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(746, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 171, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-39\",\"account_id\":4,\"debit\":\"2500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-01T19:30:48.000000Z\",\"meta\":{\"commission_id\":39,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":22,\"payment_id\":28}}}', NULL, '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(747, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 172, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-39\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2500.00\",\"occurred_at\":\"2025-12-01T19:30:48.000000Z\",\"meta\":{\"commission_id\":39,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":22,\"payment_id\":28}}}', NULL, '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(748, 'audit', 'updated', 'updated', 'App\\Models\\Commission', 40, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"paid_at\":\"2025-12-01T19:30:48.000000Z\"},\"old\":{\"status\":\"unpaid\",\"paid_at\":null}}', NULL, '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(749, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 173, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-40\",\"account_id\":4,\"debit\":\"250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-01T19:30:48.000000Z\",\"meta\":{\"commission_id\":40,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":22,\"payment_id\":29}}}', NULL, '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(750, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 174, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-40\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"250.00\",\"occurred_at\":\"2025-12-01T19:30:48.000000Z\",\"meta\":{\"commission_id\":40,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":22,\"payment_id\":29}}}', NULL, '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(751, 'audit', 'updated', 'updated', 'App\\Models\\Commission', 41, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"paid_at\":\"2025-12-01T19:30:48.000000Z\"},\"old\":{\"status\":\"unpaid\",\"paid_at\":null}}', NULL, '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(752, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 175, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-41\",\"account_id\":4,\"debit\":\"250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-01T19:30:48.000000Z\",\"meta\":{\"commission_id\":41,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"sales_order_id\":21,\"payment_id\":30}}}', NULL, '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(753, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 176, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-41\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"250.00\",\"occurred_at\":\"2025-12-01T19:30:48.000000Z\",\"meta\":{\"commission_id\":41,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"sales_order_id\":21,\"payment_id\":30}}}', NULL, '2025-12-01 19:30:49', '2025-12-01 19:30:49'),
(754, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 177, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-31\",\"account_id\":1,\"debit\":\"5000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-01T00:00:00.000000Z\",\"meta\":{\"payment_id\":31,\"sales_order_id\":21,\"method\":\"cash\"}}}', NULL, '2025-12-01 19:37:26', '2025-12-01 19:37:26'),
(755, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 178, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-31\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"5000.00\",\"occurred_at\":\"2025-12-01T00:00:00.000000Z\",\"meta\":{\"payment_id\":31,\"sales_order_id\":21,\"method\":\"cash\"}}}', NULL, '2025-12-01 19:37:26', '2025-12-01 19:37:26'),
(756, 'audit', 'created', 'created', 'App\\Models\\Commission', 42, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":31,\"sales_order_id\":21,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"amount\":\"250.00\",\"status\":\"unpaid\",\"paid_at\":null,\"meta\":{\"payment_amount\":5000,\"commission_percentage\":5,\"service_id\":2}}}', NULL, '2025-12-01 19:37:26', '2025-12-01 19:37:26'),
(757, 'audit', 'created', 'created', 'App\\Models\\Payment', 31, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":21,\"paid_at\":\"2025-12-01T00:00:00.000000Z\",\"amount\":\"5000.00\",\"commission_base_amount\":\"5000.00\",\"commission_processed_at\":null,\"type\":\"partial_payment\",\"intent_type\":\"due_payment\",\"method\":null,\"meta\":null}}', NULL, '2025-12-01 19:37:26', '2025-12-01 19:37:26'),
(758, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 20, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-01T19:39:21.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-01 19:39:21', '2025-12-01 19:39:21'),
(759, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 23, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-01 19:51:22', '2025-12-01 19:51:22'),
(760, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 23, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-01 19:51:22', '2025-12-01 19:51:22'),
(761, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 113, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"due_date\":\"2025-12-06T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(762, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 114, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"due_date\":\"2026-01-06T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(763, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 115, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"due_date\":\"2026-02-06T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(764, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 116, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"due_date\":\"2026-03-06T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(765, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 117, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"due_date\":\"2026-04-06T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(766, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 118, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"due_date\":\"2026-05-06T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(767, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 119, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"due_date\":\"2026-06-06T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(768, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 120, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"due_date\":\"2026-07-06T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(769, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 121, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"due_date\":\"2026-08-06T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(770, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 122, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"due_date\":\"2026-09-06T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(771, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 123, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"due_date\":\"2026-10-06T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(772, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 124, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"due_date\":\"2026-11-06T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(773, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 179, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-32\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-01T00:00:00.000000Z\",\"meta\":{\"payment_id\":32,\"sales_order_id\":23,\"method\":\"cash\"}}}', NULL, '2025-12-01 19:51:35', '2025-12-01 19:51:35'),
(774, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 180, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-32\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-12-01T00:00:00.000000Z\",\"meta\":{\"payment_id\":32,\"sales_order_id\":23,\"method\":\"cash\"}}}', NULL, '2025-12-01 19:51:35', '2025-12-01 19:51:35'),
(775, 'audit', 'created', 'created', 'App\\Models\\Payment', 32, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":23,\"paid_at\":\"2025-12-01T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"45000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"423423\"}}}', NULL, '2025-12-01 19:51:35', '2025-12-01 19:51:35'),
(776, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 21, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":32,\"customer_installment_id\":113,\"allocated\":\"0.00\"}}', NULL, '2025-12-01 19:51:35', '2025-12-01 19:51:35'),
(777, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 113, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-01 19:51:35', '2025-12-01 19:51:35'),
(778, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 181, 'App\\Models\\User', 42, '{\"attributes\":{\"tx_id\":\"PMT-33\",\"account_id\":1,\"debit\":\"412500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-02T00:00:00.000000Z\",\"meta\":{\"payment_id\":33,\"sales_order_id\":23,\"method\":\"cash\"}}}', NULL, '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(779, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 182, 'App\\Models\\User', 42, '{\"attributes\":{\"tx_id\":\"PMT-33\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"412500.00\",\"occurred_at\":\"2025-12-02T00:00:00.000000Z\",\"meta\":{\"payment_id\":33,\"sales_order_id\":23,\"method\":\"cash\"}}}', NULL, '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(780, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 183, 'App\\Models\\User', 42, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-33-2\",\"account_id\":7,\"debit\":\"82500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-02T00:00:00.000000Z\",\"meta\":{\"payment_id\":33,\"sales_order_id\":23,\"supplier_id\":2}}}', NULL, '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(781, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 184, 'App\\Models\\User', 42, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-33-2\",\"account_id\":8,\"debit\":\"0.00\",\"credit\":\"82500.00\",\"occurred_at\":\"2025-12-02T00:00:00.000000Z\",\"meta\":{\"payment_id\":33,\"sales_order_id\":23,\"supplier_id\":2}}}', NULL, '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(782, 'audit', 'created', 'created', 'App\\Models\\Payment', 33, 'App\\Models\\User', 42, '{\"attributes\":{\"sales_order_id\":23,\"paid_at\":\"2025-12-02T00:00:00.000000Z\",\"amount\":\"412500.00\",\"commission_base_amount\":\"371250.00\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"343324\"}}}', NULL, '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(783, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 22, 'App\\Models\\User', 42, '{\"attributes\":{\"payment_id\":33,\"customer_installment_id\":113,\"allocated\":\"412500.00\"}}', NULL, '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(784, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 113, 'App\\Models\\User', 42, '{\"attributes\":{\"paid\":\"412500.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(785, 'audit', 'updated', 'updated', 'App\\Models\\Commission', 42, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"paid_at\":\"2025-12-02T16:17:17.000000Z\"},\"old\":{\"status\":\"unpaid\",\"paid_at\":null}}', NULL, '2025-12-02 16:17:17', '2025-12-02 16:17:17'),
(786, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 185, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-42\",\"account_id\":4,\"debit\":\"250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-02T16:17:17.000000Z\",\"meta\":{\"commission_id\":42,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"sales_order_id\":21,\"payment_id\":31}}}', NULL, '2025-12-02 16:17:17', '2025-12-02 16:17:17'),
(787, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 186, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-42\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"250.00\",\"occurred_at\":\"2025-12-02T16:17:17.000000Z\",\"meta\":{\"commission_id\":42,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"sales_order_id\":21,\"payment_id\":31}}}', NULL, '2025-12-02 16:17:17', '2025-12-02 16:17:17'),
(788, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 24, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"service\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":null,\"total\":\"17500.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-02 16:18:22', '2025-12-02 16:18:22'),
(789, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 24, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":24,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Service\",\"qty\":1,\"unit_price\":\"17500.00\",\"line_total\":\"17500.00\"}}', NULL, '2025-12-02 16:18:22', '2025-12-02 16:18:22'),
(790, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 187, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-34\",\"account_id\":1,\"debit\":\"17500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-02T00:00:00.000000Z\",\"meta\":{\"payment_id\":34,\"sales_order_id\":24,\"method\":\"cash\"}}}', NULL, '2025-12-02 16:19:50', '2025-12-02 16:19:50'),
(791, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 188, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-34\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"17500.00\",\"occurred_at\":\"2025-12-02T00:00:00.000000Z\",\"meta\":{\"payment_id\":34,\"sales_order_id\":24,\"method\":\"cash\"}}}', NULL, '2025-12-02 16:19:50', '2025-12-02 16:19:50'),
(792, 'audit', 'created', 'created', 'App\\Models\\Commission', 43, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":34,\"sales_order_id\":24,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"875.00\",\"status\":\"unpaid\",\"paid_at\":null,\"meta\":{\"payment_amount\":17500,\"commission_percentage\":5,\"service_id\":1}}}', NULL, '2025-12-02 16:19:50', '2025-12-02 16:19:50'),
(793, 'audit', 'created', 'created', 'App\\Models\\Payment', 34, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":24,\"paid_at\":\"2025-12-02T00:00:00.000000Z\",\"amount\":\"17500.00\",\"commission_base_amount\":\"17500.00\",\"commission_processed_at\":null,\"type\":\"full_payment\",\"intent_type\":\"due_payment\",\"method\":null,\"meta\":null}}', NULL, '2025-12-02 16:19:50', '2025-12-02 16:19:50'),
(794, 'audit', 'updated', 'updated', 'App\\Models\\Commission', 43, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"paid_at\":\"2025-12-02T16:59:53.000000Z\"},\"old\":{\"status\":\"unpaid\",\"paid_at\":null}}', NULL, '2025-12-02 16:59:53', '2025-12-02 16:59:53'),
(795, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 189, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-43\",\"account_id\":4,\"debit\":\"875.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-02T16:59:53.000000Z\",\"meta\":{\"commission_id\":43,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":24,\"payment_id\":34}}}', NULL, '2025-12-02 16:59:53', '2025-12-02 16:59:53'),
(796, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 190, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-43\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"875.00\",\"occurred_at\":\"2025-12-02T16:59:53.000000Z\",\"meta\":{\"commission_id\":43,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":24,\"payment_id\":34}}}', NULL, '2025-12-02 16:59:53', '2025-12-02 16:59:53'),
(797, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 25, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"service\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":null,\"total\":\"17500.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-03 17:57:27', '2025-12-03 17:57:27'),
(798, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 25, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":25,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Service\",\"qty\":1,\"unit_price\":\"17500.00\",\"line_total\":\"17500.00\"}}', NULL, '2025-12-03 17:57:27', '2025-12-03 17:57:27');
INSERT INTO `activity_log` (`id`, `log_name`, `event`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(799, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 191, 'App\\Models\\User', 44, '{\"attributes\":{\"tx_id\":\"PMT-35\",\"account_id\":1,\"debit\":\"17500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":35,\"sales_order_id\":25,\"method\":\"cash\"}}}', NULL, '2025-12-03 17:59:42', '2025-12-03 17:59:42'),
(800, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 192, 'App\\Models\\User', 44, '{\"attributes\":{\"tx_id\":\"PMT-35\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"17500.00\",\"occurred_at\":\"2025-12-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":35,\"sales_order_id\":25,\"method\":\"cash\"}}}', NULL, '2025-12-03 17:59:42', '2025-12-03 17:59:42'),
(801, 'audit', 'created', 'created', 'App\\Models\\Commission', 44, 'App\\Models\\User', 44, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":35,\"sales_order_id\":25,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"875.00\",\"status\":\"unpaid\",\"paid_at\":null,\"meta\":{\"payment_amount\":17500,\"commission_percentage\":5,\"service_id\":1}}}', NULL, '2025-12-03 17:59:42', '2025-12-03 17:59:42'),
(802, 'audit', 'created', 'created', 'App\\Models\\Payment', 35, 'App\\Models\\User', 44, '{\"attributes\":{\"sales_order_id\":25,\"paid_at\":\"2025-12-03T00:00:00.000000Z\",\"amount\":\"17500.00\",\"commission_base_amount\":\"17500.00\",\"commission_processed_at\":null,\"type\":\"full_payment\",\"intent_type\":\"due_payment\",\"method\":null,\"meta\":null}}', NULL, '2025-12-03 17:59:42', '2025-12-03 17:59:42'),
(803, 'audit', 'updated', 'updated', 'App\\Models\\Commission', 44, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"paid_at\":\"2025-12-03T18:01:12.000000Z\"},\"old\":{\"status\":\"unpaid\",\"paid_at\":null}}', NULL, '2025-12-03 18:01:12', '2025-12-03 18:01:12'),
(804, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 193, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-44\",\"account_id\":4,\"debit\":\"875.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-03T18:01:12.000000Z\",\"meta\":{\"commission_id\":44,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":25,\"payment_id\":35}}}', NULL, '2025-12-03 18:01:12', '2025-12-03 18:01:12'),
(805, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 194, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-44\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"875.00\",\"occurred_at\":\"2025-12-03T18:01:12.000000Z\",\"meta\":{\"commission_id\":44,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":25,\"payment_id\":35}}}', NULL, '2025-12-03 18:01:12', '2025-12-03 18:01:12'),
(806, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 26, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"service\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":null,\"total\":\"17500.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-03 18:07:34', '2025-12-03 18:07:34'),
(807, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 26, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":26,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Service\",\"qty\":1,\"unit_price\":\"17500.00\",\"line_total\":\"17500.00\"}}', NULL, '2025-12-03 18:07:34', '2025-12-03 18:07:34'),
(808, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 195, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-36\",\"account_id\":1,\"debit\":\"17500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":36,\"sales_order_id\":26,\"method\":\"cash\"}}}', NULL, '2025-12-03 18:09:13', '2025-12-03 18:09:13'),
(809, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 196, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-36\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"17500.00\",\"occurred_at\":\"2025-12-03T00:00:00.000000Z\",\"meta\":{\"payment_id\":36,\"sales_order_id\":26,\"method\":\"cash\"}}}', NULL, '2025-12-03 18:09:13', '2025-12-03 18:09:13'),
(810, 'audit', 'created', 'created', 'App\\Models\\Commission', 45, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":36,\"sales_order_id\":26,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"875.00\",\"status\":\"unpaid\",\"paid_at\":null,\"meta\":{\"payment_amount\":17500,\"commission_percentage\":5,\"service_id\":1}}}', NULL, '2025-12-03 18:09:13', '2025-12-03 18:09:13'),
(811, 'audit', 'created', 'created', 'App\\Models\\Payment', 36, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":26,\"paid_at\":\"2025-12-03T00:00:00.000000Z\",\"amount\":\"17500.00\",\"commission_base_amount\":\"17500.00\",\"commission_processed_at\":null,\"type\":\"full_payment\",\"intent_type\":\"due_payment\",\"method\":null,\"meta\":null}}', NULL, '2025-12-03 18:09:13', '2025-12-03 18:09:13'),
(812, 'audit', 'updated', 'updated', 'App\\Models\\Commission', 45, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"paid\",\"paid_at\":\"2025-12-03T18:10:27.000000Z\"},\"old\":{\"status\":\"unpaid\",\"paid_at\":null}}', NULL, '2025-12-03 18:10:27', '2025-12-03 18:10:27'),
(813, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 197, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-45\",\"account_id\":4,\"debit\":\"875.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-03T18:10:27.000000Z\",\"meta\":{\"commission_id\":45,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":26,\"payment_id\":36}}}', NULL, '2025-12-03 18:10:27', '2025-12-03 18:10:27'),
(814, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 198, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SVC-CMS-45\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"875.00\",\"occurred_at\":\"2025-12-03T18:10:27.000000Z\",\"meta\":{\"commission_id\":45,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":26,\"payment_id\":36}}}', NULL, '2025-12-03 18:10:27', '2025-12-03 18:10:27'),
(815, 'audit', 'updated', 'updated', 'App\\Models\\LedgerAccount', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"type\":\"liability\",\"meta\":{\"note\":\"abc\"}},\"old\":{\"type\":\"asset\",\"meta\":{\"key\":\"cash\"}}}', NULL, '2025-12-07 15:56:35', '2025-12-07 15:56:35'),
(816, 'audit', 'updated', 'updated', 'App\\Models\\LedgerAccount', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"type\":\"asset\"},\"old\":{\"type\":\"liability\"}}', NULL, '2025-12-07 15:56:41', '2025-12-07 15:56:41'),
(817, 'audit', 'created', 'created', 'App\\Models\\LedgerAccount', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"code\":\"610\",\"name\":\"Labber cost\",\"type\":\"liability\",\"meta\":{\"note\":\"abc\"}}}', NULL, '2025-12-07 15:57:34', '2025-12-07 15:57:34'),
(818, 'audit', 'created', 'created', 'App\\Models\\Journal', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"JRNL-EXT-001\",\"description\":null,\"occurred_at\":\"2025-01-15T12:00:00.000000Z\",\"meta\":{\"source\":\"manual\"}}}', NULL, '2025-12-07 16:01:51', '2025-12-07 16:01:51'),
(819, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 199, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":1,\"tx_id\":\"JRNL-EXT-001\",\"account_id\":1,\"debit\":\"1000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-01-15T12:00:00.000000Z\",\"meta\":{\"source\":\"manual\"}}}', NULL, '2025-12-07 16:01:51', '2025-12-07 16:01:51'),
(820, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 200, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":1,\"tx_id\":\"JRNL-EXT-001\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1000.00\",\"occurred_at\":\"2025-01-15T12:00:00.000000Z\",\"meta\":{\"source\":\"manual\"}}}', NULL, '2025-12-07 16:01:51', '2025-12-07 16:01:51'),
(821, 'audit', 'updated', 'updated', 'App\\Models\\Journal', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"description\":\"Manual adjustment\",\"occurred_at\":\"2025-12-07T16:01:51.000000Z\"},\"old\":{\"description\":null,\"occurred_at\":\"2025-01-15T12:00:00.000000Z\"}}', NULL, '2025-12-07 16:01:51', '2025-12-07 16:01:51'),
(822, 'audit', 'created', 'created', 'App\\Models\\Journal', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"JRNL-a0897f43-f1ca-4c8e-ae4d-7b686ba23a9a\",\"description\":null,\"occurred_at\":\"2025-12-07T12:00:00.000000Z\",\"meta\":{\"source\":\"manual\"}}}', NULL, '2025-12-07 16:14:21', '2025-12-07 16:14:21'),
(823, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 201, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":2,\"tx_id\":\"JRNL-a0897f43-f1ca-4c8e-ae4d-7b686ba23a9a\",\"account_id\":1,\"debit\":\"5000.00\",\"credit\":\"5000.00\",\"occurred_at\":\"2025-12-07T12:00:00.000000Z\",\"meta\":{\"source\":\"manual\"}}}', NULL, '2025-12-07 16:14:21', '2025-12-07 16:14:21'),
(824, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 202, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":2,\"tx_id\":\"JRNL-a0897f43-f1ca-4c8e-ae4d-7b686ba23a9a\",\"account_id\":1,\"debit\":\"1000.00\",\"credit\":\"1000.00\",\"occurred_at\":\"2025-12-07T12:00:00.000000Z\",\"meta\":{\"source\":\"manual\"}}}', NULL, '2025-12-07 16:14:21', '2025-12-07 16:14:21'),
(825, 'audit', 'updated', 'updated', 'App\\Models\\Journal', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"description\":\"abc\",\"occurred_at\":\"2025-12-07T16:14:21.000000Z\"},\"old\":{\"description\":null,\"occurred_at\":\"2025-12-07T12:00:00.000000Z\"}}', NULL, '2025-12-07 16:14:21', '2025-12-07 16:14:21'),
(826, 'audit', 'created', 'created', 'App\\Models\\Journal', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"JRNL-a0898134-6792-43cd-97f6-7c1871ee4fdf\",\"description\":null,\"occurred_at\":\"2025-12-07T12:00:00.000000Z\",\"meta\":{\"source\":\"manual\"}}}', NULL, '2025-12-07 16:19:46', '2025-12-07 16:19:46'),
(827, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 203, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":3,\"tx_id\":\"JRNL-a0898134-6792-43cd-97f6-7c1871ee4fdf\",\"account_id\":3,\"debit\":\"5000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-07T12:00:00.000000Z\",\"meta\":{\"source\":\"manual\"}}}', NULL, '2025-12-07 16:19:46', '2025-12-07 16:19:46'),
(828, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 204, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":3,\"tx_id\":\"JRNL-a0898134-6792-43cd-97f6-7c1871ee4fdf\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"5000.00\",\"occurred_at\":\"2025-12-07T12:00:00.000000Z\",\"meta\":{\"source\":\"manual\"}}}', NULL, '2025-12-07 16:19:46', '2025-12-07 16:19:46'),
(829, 'audit', 'updated', 'updated', 'App\\Models\\Journal', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"description\":\"abc\",\"occurred_at\":\"2025-12-07T16:19:46.000000Z\"},\"old\":{\"description\":null,\"occurred_at\":\"2025-12-07T12:00:00.000000Z\"}}', NULL, '2025-12-07 16:19:46', '2025-12-07 16:19:46'),
(830, 'audit', 'updated', 'updated', 'App\\Models\\LedgerAccount', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"code\":\"601\"},\"old\":{\"code\":\"610\"}}', NULL, '2025-12-07 17:07:41', '2025-12-07 17:07:41'),
(831, 'audit', 'created', 'created', 'App\\Models\\Journal', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PDSB-1\",\"description\":null,\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":12,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(832, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 205, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":4,\"tx_id\":\"PDSB-1\",\"account_id\":4,\"debit\":\"16040.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":12,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(833, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 206, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":4,\"tx_id\":\"PDSB-1\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"16040.00\",\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":12,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(834, 'audit', 'created', 'created', 'App\\Models\\Journal', 5, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PDSB-2\",\"description\":null,\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":13,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(835, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 207, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":5,\"tx_id\":\"PDSB-2\",\"account_id\":4,\"debit\":\"7260.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":13,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(836, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 208, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":5,\"tx_id\":\"PDSB-2\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"7260.00\",\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":13,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(837, 'audit', 'created', 'created', 'App\\Models\\Journal', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PDSB-3\",\"description\":null,\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":15,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(838, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 209, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":6,\"tx_id\":\"PDSB-3\",\"account_id\":4,\"debit\":\"4840.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":15,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(839, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 210, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":6,\"tx_id\":\"PDSB-3\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"4840.00\",\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":15,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(840, 'audit', 'created', 'created', 'App\\Models\\Journal', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PDSB-4\",\"description\":null,\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":16,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(841, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 211, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":7,\"tx_id\":\"PDSB-4\",\"account_id\":4,\"debit\":\"3630.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":16,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(842, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 212, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":7,\"tx_id\":\"PDSB-4\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"3630.00\",\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":16,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(843, 'audit', 'created', 'created', 'App\\Models\\Journal', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PDSB-5\",\"description\":null,\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":14,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(844, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 213, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":8,\"tx_id\":\"PDSB-5\",\"account_id\":4,\"debit\":\"4840.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":14,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(845, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 214, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":8,\"tx_id\":\"PDSB-5\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"4840.00\",\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":14,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(846, 'audit', 'created', 'created', 'App\\Models\\Journal', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PDSB-6\",\"description\":null,\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":20,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(847, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 215, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":9,\"tx_id\":\"PDSB-6\",\"account_id\":4,\"debit\":\"0.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":20,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(848, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 216, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":9,\"tx_id\":\"PDSB-6\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-08T18:54:49.000000Z\",\"meta\":{\"employee_id\":20,\"month\":\"2025-11\"}}}', NULL, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(849, 'audit', 'created', 'created', 'App\\Models\\Journal', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PDSB-7\",\"description\":null,\"occurred_at\":\"2025-12-09T17:19:32.000000Z\",\"meta\":{\"employee_id\":12,\"month\":\"2025-11\"}}}', NULL, '2025-12-09 17:19:32', '2025-12-09 17:19:32'),
(850, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 217, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":10,\"tx_id\":\"PDSB-7\",\"account_id\":4,\"debit\":\"16040.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-09T17:19:32.000000Z\",\"meta\":{\"employee_id\":12,\"month\":\"2025-11\"}}}', NULL, '2025-12-09 17:19:32', '2025-12-09 17:19:32'),
(851, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 218, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":10,\"tx_id\":\"PDSB-7\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"16040.00\",\"occurred_at\":\"2025-12-09T17:19:32.000000Z\",\"meta\":{\"employee_id\":12,\"month\":\"2025-11\"}}}', NULL, '2025-12-09 17:19:32', '2025-12-09 17:19:32'),
(852, 'audit', 'created', 'created', 'App\\Models\\Journal', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PDSB-8\",\"description\":null,\"occurred_at\":\"2025-12-09T17:19:32.000000Z\",\"meta\":{\"employee_id\":13,\"month\":\"2025-11\"}}}', NULL, '2025-12-09 17:19:32', '2025-12-09 17:19:32'),
(853, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 219, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":11,\"tx_id\":\"PDSB-8\",\"account_id\":4,\"debit\":\"4840.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-09T17:19:32.000000Z\",\"meta\":{\"employee_id\":13,\"month\":\"2025-11\"}}}', NULL, '2025-12-09 17:19:32', '2025-12-09 17:19:32'),
(854, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 220, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":11,\"tx_id\":\"PDSB-8\",\"account_id\":6,\"debit\":\"0.00\",\"credit\":\"4840.00\",\"occurred_at\":\"2025-12-09T17:19:32.000000Z\",\"meta\":{\"employee_id\":13,\"month\":\"2025-11\"}}}', NULL, '2025-12-09 17:19:32', '2025-12-09 17:19:32'),
(855, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 27, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-09 18:05:33', '2025-12-09 18:05:33'),
(856, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 27, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":27,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Service\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-12-09 18:05:33', '2025-12-09 18:05:33'),
(857, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 28, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"1000000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-09 18:11:36', '2025-12-09 18:11:36'),
(858, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 28, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"itemable_id\":3,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"1000000.00\",\"line_total\":\"1000000.00\"}}', NULL, '2025-12-09 18:11:36', '2025-12-09 18:11:36'),
(859, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 125, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"due_date\":\"2025-12-14T00:00:00.000000Z\",\"amount\":\"95000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(860, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 126, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"due_date\":\"2026-01-14T00:00:00.000000Z\",\"amount\":\"95000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(861, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 127, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"due_date\":\"2026-02-14T00:00:00.000000Z\",\"amount\":\"95000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(862, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 128, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"due_date\":\"2026-03-14T00:00:00.000000Z\",\"amount\":\"95000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(863, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 129, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"due_date\":\"2026-04-14T00:00:00.000000Z\",\"amount\":\"95000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(864, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 130, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"due_date\":\"2026-05-14T00:00:00.000000Z\",\"amount\":\"95000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(865, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 131, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"due_date\":\"2026-06-14T00:00:00.000000Z\",\"amount\":\"95000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(866, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 132, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"due_date\":\"2026-07-14T00:00:00.000000Z\",\"amount\":\"95000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(867, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 133, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"due_date\":\"2026-08-14T00:00:00.000000Z\",\"amount\":\"95000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(868, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 134, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"due_date\":\"2026-09-14T00:00:00.000000Z\",\"amount\":\"95000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(869, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 27, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-09 18:11:56', '2025-12-09 18:11:56'),
(870, 'audit', 'created', 'created', 'App\\Models\\Journal', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-37\",\"description\":null,\"occurred_at\":\"2025-12-09T00:00:00.000000Z\",\"meta\":{\"payment_id\":37,\"sales_order_id\":28,\"method\":\"cash\"}}}', NULL, '2025-12-09 18:12:08', '2025-12-09 18:12:08'),
(871, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 221, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":12,\"tx_id\":\"PMT-37\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-09T00:00:00.000000Z\",\"meta\":{\"payment_id\":37,\"sales_order_id\":28,\"method\":\"cash\"}}}', NULL, '2025-12-09 18:12:08', '2025-12-09 18:12:08'),
(872, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 222, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":12,\"tx_id\":\"PMT-37\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-12-09T00:00:00.000000Z\",\"meta\":{\"payment_id\":37,\"sales_order_id\":28,\"method\":\"cash\"}}}', NULL, '2025-12-09 18:12:08', '2025-12-09 18:12:08'),
(873, 'audit', 'created', 'created', 'App\\Models\\Payment', 37, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"paid_at\":\"2025-12-09T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"45000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"2322\"}}}', NULL, '2025-12-09 18:12:08', '2025-12-09 18:12:08'),
(874, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 23, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":37,\"customer_installment_id\":125,\"allocated\":\"0.00\"}}', NULL, '2025-12-09 18:12:08', '2025-12-09 18:12:08'),
(875, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 125, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-09 18:12:08', '2025-12-09 18:12:08'),
(876, 'audit', 'created', 'created', 'App\\Models\\Journal', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-38\",\"description\":null,\"occurred_at\":\"2025-12-09T00:00:00.000000Z\",\"meta\":{\"payment_id\":38,\"sales_order_id\":28,\"method\":\"cash\"}}}', NULL, '2025-12-09 18:12:45', '2025-12-09 18:12:45'),
(877, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 223, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":13,\"tx_id\":\"PMT-38\",\"account_id\":1,\"debit\":\"95000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-09T00:00:00.000000Z\",\"meta\":{\"payment_id\":38,\"sales_order_id\":28,\"method\":\"cash\"}}}', NULL, '2025-12-09 18:12:45', '2025-12-09 18:12:45'),
(878, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 224, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":13,\"tx_id\":\"PMT-38\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"95000.00\",\"occurred_at\":\"2025-12-09T00:00:00.000000Z\",\"meta\":{\"payment_id\":38,\"sales_order_id\":28,\"method\":\"cash\"}}}', NULL, '2025-12-09 18:12:45', '2025-12-09 18:12:45'),
(879, 'audit', 'created', 'created', 'App\\Models\\Journal', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-38-2\",\"description\":null,\"occurred_at\":\"2025-12-09T00:00:00.000000Z\",\"meta\":{\"payment_id\":38,\"sales_order_id\":28,\"supplier_id\":2}}}', NULL, '2025-12-09 18:12:46', '2025-12-09 18:12:46'),
(880, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 225, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":14,\"tx_id\":\"SUPP-PAYABLE-38-2\",\"account_id\":7,\"debit\":\"11400.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-09T00:00:00.000000Z\",\"meta\":{\"payment_id\":38,\"sales_order_id\":28,\"supplier_id\":2}}}', NULL, '2025-12-09 18:12:46', '2025-12-09 18:12:46'),
(881, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 226, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":14,\"tx_id\":\"SUPP-PAYABLE-38-2\",\"account_id\":8,\"debit\":\"0.00\",\"credit\":\"11400.00\",\"occurred_at\":\"2025-12-09T00:00:00.000000Z\",\"meta\":{\"payment_id\":38,\"sales_order_id\":28,\"supplier_id\":2}}}', NULL, '2025-12-09 18:12:46', '2025-12-09 18:12:46'),
(882, 'audit', 'created', 'created', 'App\\Models\\Payment', 38, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":28,\"paid_at\":\"2025-12-09T00:00:00.000000Z\",\"amount\":\"95000.00\",\"commission_base_amount\":\"85500.00\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"32434\"}}}', NULL, '2025-12-09 18:12:46', '2025-12-09 18:12:46'),
(883, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 24, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":38,\"customer_installment_id\":125,\"allocated\":\"95000.00\"}}', NULL, '2025-12-09 18:12:46', '2025-12-09 18:12:46'),
(884, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 125, 'App\\Models\\User', 10, '{\"attributes\":{\"paid\":\"95000.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-12-09 18:12:46', '2025-12-09 18:12:46'),
(885, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 29, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"100000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 15:51:05', '2025-12-10 15:51:05'),
(886, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 29, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":29,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-12-10 15:51:05', '2025-12-10 15:51:05'),
(887, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 135, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":29,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"40000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 15:51:10', '2025-12-10 15:51:10'),
(888, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 136, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":29,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"40000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 15:51:10', '2025-12-10 15:51:10'),
(889, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 137, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":29,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"40000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 15:51:10', '2025-12-10 15:51:10'),
(890, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 138, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":29,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"40000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 15:51:10', '2025-12-10 15:51:10'),
(891, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 139, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":29,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"40000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 15:51:10', '2025-12-10 15:51:10'),
(892, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 140, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":29,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"40000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 15:51:10', '2025-12-10 15:51:10'),
(893, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 141, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":29,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"40000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 15:51:10', '2025-12-10 15:51:10'),
(894, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 142, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":29,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"40000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 15:51:10', '2025-12-10 15:51:10'),
(895, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 143, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":29,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"40000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 15:51:10', '2025-12-10 15:51:10'),
(896, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 144, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":29,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"40000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 15:51:10', '2025-12-10 15:51:10'),
(897, 'audit', 'created', 'created', 'App\\Models\\Journal', 15, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-39\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":39,\"sales_order_id\":29,\"method\":\"cash\"}}}', NULL, '2025-12-10 15:51:50', '2025-12-10 15:51:50'),
(898, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 227, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":15,\"tx_id\":\"PMT-39\",\"account_id\":1,\"debit\":\"100000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":39,\"sales_order_id\":29,\"method\":\"cash\"}}}', NULL, '2025-12-10 15:51:50', '2025-12-10 15:51:50'),
(899, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 228, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":15,\"tx_id\":\"PMT-39\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"100000.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":39,\"sales_order_id\":29,\"method\":\"cash\"}}}', NULL, '2025-12-10 15:51:50', '2025-12-10 15:51:50'),
(900, 'audit', 'created', 'created', 'App\\Models\\Payment', 39, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":29,\"paid_at\":\"2025-12-10T00:00:00.000000Z\",\"amount\":\"100000.00\",\"commission_base_amount\":\"90000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"123123123\"}}}', NULL, '2025-12-10 15:51:50', '2025-12-10 15:51:50'),
(901, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 25, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":39,\"customer_installment_id\":135,\"allocated\":\"0.00\"}}', NULL, '2025-12-10 15:51:50', '2025-12-10 15:51:50'),
(902, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 135, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-10 15:51:50', '2025-12-10 15:51:50'),
(903, 'audit', 'created', 'created', 'App\\Models\\Commission', 46, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":32,\"sales_order_id\":23,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"amount\":\"6750.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"JAKARIA\",\"calculation_unit_id\":23,\"calculation_item_id\":41,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(904, 'audit', 'created', 'created', 'App\\Models\\Journal', 16, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-46\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":46,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(905, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 229, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":16,\"tx_id\":\"CMS-46\",\"account_id\":4,\"debit\":\"6750.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":46,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(906, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 230, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":16,\"tx_id\":\"CMS-46\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"6750.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":46,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(907, 'audit', 'created', 'created', 'App\\Models\\Commission', 47, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":32,\"sales_order_id\":23,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14,\"amount\":\"2250.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"AGM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"SABBIR RAHMAN\",\"calculation_unit_id\":23,\"calculation_item_id\":42,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(908, 'audit', 'created', 'created', 'App\\Models\\Journal', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-47\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":47,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(909, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 231, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":17,\"tx_id\":\"CMS-47\",\"account_id\":4,\"debit\":\"2250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":47,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(910, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 232, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":17,\"tx_id\":\"CMS-47\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2250.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":47,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(911, 'audit', 'created', 'created', 'App\\Models\\Commission', 48, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":32,\"sales_order_id\":23,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13,\"amount\":\"2250.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"DGM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"SAKIL AL\",\"calculation_unit_id\":23,\"calculation_item_id\":43,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(912, 'audit', 'created', 'created', 'App\\Models\\Journal', 18, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-48\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":48,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(913, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 233, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":18,\"tx_id\":\"CMS-48\",\"account_id\":4,\"debit\":\"2250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":48,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(914, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 234, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":18,\"tx_id\":\"CMS-48\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2250.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":48,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(915, 'audit', 'created', 'created', 'App\\Models\\Commission', 49, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":32,\"sales_order_id\":23,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"2250.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":23,\"calculation_item_id\":44,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(916, 'audit', 'created', 'created', 'App\\Models\\Journal', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-49\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":49,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(917, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 235, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":19,\"tx_id\":\"CMS-49\",\"account_id\":4,\"debit\":\"2250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":49,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(918, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 236, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":19,\"tx_id\":\"CMS-49\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2250.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":49,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(919, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 32, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T16:51:53.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(920, 'audit', 'created', 'created', 'App\\Models\\Commission', 50, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":33,\"sales_order_id\":23,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"amount\":\"18562.50\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"installment\",\"percentage\":5,\"recipient_name\":\"JAKARIA\",\"calculation_unit_id\":24,\"calculation_item_id\":45,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(921, 'audit', 'created', 'created', 'App\\Models\\Journal', 20, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-50\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":50,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(922, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 237, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":20,\"tx_id\":\"CMS-50\",\"account_id\":4,\"debit\":\"18562.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":50,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(923, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 238, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":20,\"tx_id\":\"CMS-50\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"18562.50\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":50,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(924, 'audit', 'created', 'created', 'App\\Models\\Commission', 51, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":33,\"sales_order_id\":23,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14,\"amount\":\"3712.50\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"AGM\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"SABBIR RAHMAN\",\"calculation_unit_id\":24,\"calculation_item_id\":46,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(925, 'audit', 'created', 'created', 'App\\Models\\Journal', 21, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-51\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":51,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(926, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 239, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":21,\"tx_id\":\"CMS-51\",\"account_id\":4,\"debit\":\"3712.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":51,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(927, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 240, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":21,\"tx_id\":\"CMS-51\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"3712.50\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":51,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(928, 'audit', 'created', 'created', 'App\\Models\\Commission', 52, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":33,\"sales_order_id\":23,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13,\"amount\":\"11137.50\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"DGM\",\"payment_type\":\"installment\",\"percentage\":3,\"recipient_name\":\"SAKIL AL\",\"calculation_unit_id\":24,\"calculation_item_id\":47,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(929, 'audit', 'created', 'created', 'App\\Models\\Journal', 22, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-52\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":52,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(930, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 241, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":22,\"tx_id\":\"CMS-52\",\"account_id\":4,\"debit\":\"11137.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":52,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(931, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 242, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":22,\"tx_id\":\"CMS-52\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"11137.50\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":52,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(932, 'audit', 'created', 'created', 'App\\Models\\Commission', 53, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":33,\"sales_order_id\":23,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"7425.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"installment\",\"percentage\":2,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":24,\"calculation_item_id\":48,\"order_created_by\":\"admin\",\"source_me_id\":16}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53');
INSERT INTO `activity_log` (`id`, `log_name`, `event`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(933, 'audit', 'created', 'created', 'App\\Models\\Journal', 23, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-53\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":53,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(934, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 243, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":23,\"tx_id\":\"CMS-53\",\"account_id\":4,\"debit\":\"7425.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":53,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(935, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 244, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":23,\"tx_id\":\"CMS-53\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"7425.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":53,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(936, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 33, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T16:51:53.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(937, 'audit', 'created', 'created', 'App\\Models\\Commission', 54, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":37,\"sales_order_id\":28,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"6750.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":25,\"calculation_item_id\":49,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(938, 'audit', 'created', 'created', 'App\\Models\\Journal', 24, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-54\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":54,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(939, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 245, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":24,\"tx_id\":\"CMS-54\",\"account_id\":4,\"debit\":\"6750.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":54,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(940, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 246, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":24,\"tx_id\":\"CMS-54\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"6750.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":54,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(941, 'audit', 'created', 'created', 'App\\Models\\Commission', 55, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":37,\"sales_order_id\":28,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"6750.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":25,\"calculation_item_id\":50,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(942, 'audit', 'created', 'created', 'App\\Models\\Journal', 25, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-55\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":55,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(943, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 247, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":25,\"tx_id\":\"CMS-55\",\"account_id\":4,\"debit\":\"6750.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":55,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(944, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 248, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":25,\"tx_id\":\"CMS-55\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"6750.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":55,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(945, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 37, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T16:51:53.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(946, 'audit', 'created', 'created', 'App\\Models\\Commission', 56, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":38,\"sales_order_id\":28,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"4275.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"installment\",\"percentage\":5,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":26,\"calculation_item_id\":51,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(947, 'audit', 'created', 'created', 'App\\Models\\Journal', 26, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-56\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":56,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(948, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 249, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":26,\"tx_id\":\"CMS-56\",\"account_id\":4,\"debit\":\"4275.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":56,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(949, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 250, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":26,\"tx_id\":\"CMS-56\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"4275.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":56,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(950, 'audit', 'created', 'created', 'App\\Models\\Commission', 57, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":38,\"sales_order_id\":28,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"5130.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"installment\",\"percentage\":6,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":26,\"calculation_item_id\":52,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(951, 'audit', 'created', 'created', 'App\\Models\\Journal', 27, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-57\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":57,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(952, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 251, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":27,\"tx_id\":\"CMS-57\",\"account_id\":4,\"debit\":\"5130.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":57,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 16:51:54', '2025-12-10 16:51:54'),
(953, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 252, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":27,\"tx_id\":\"CMS-57\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"5130.00\",\"occurred_at\":\"2025-12-10T16:51:53.000000Z\",\"meta\":{\"commission_id\":57,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 16:51:54', '2025-12-10 16:51:54'),
(954, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 38, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T16:51:53.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 16:51:54', '2025-12-10 16:51:54'),
(955, 'audit', 'created', 'created', 'App\\Models\\Commission', 58, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":39,\"sales_order_id\":29,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"4500.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:51:54.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":27,\"calculation_item_id\":53,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-10 16:51:54', '2025-12-10 16:51:54'),
(956, 'audit', 'created', 'created', 'App\\Models\\Journal', 28, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-58\",\"description\":null,\"occurred_at\":\"2025-12-10T16:51:54.000000Z\",\"meta\":{\"commission_id\":58,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 16:51:54', '2025-12-10 16:51:54'),
(957, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 253, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":28,\"tx_id\":\"CMS-58\",\"account_id\":4,\"debit\":\"4500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:51:54.000000Z\",\"meta\":{\"commission_id\":58,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 16:51:54', '2025-12-10 16:51:54'),
(958, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 254, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":28,\"tx_id\":\"CMS-58\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"4500.00\",\"occurred_at\":\"2025-12-10T16:51:54.000000Z\",\"meta\":{\"commission_id\":58,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 16:51:54', '2025-12-10 16:51:54'),
(959, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 39, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T16:51:54.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 16:51:54', '2025-12-10 16:51:54'),
(960, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 30, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 16:58:07', '2025-12-10 16:58:07'),
(961, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 30, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-10 16:58:07', '2025-12-10 16:58:07'),
(962, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 145, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 16:58:09', '2025-12-10 16:58:09'),
(963, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 146, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 16:58:09', '2025-12-10 16:58:09'),
(964, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 147, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 16:58:09', '2025-12-10 16:58:09'),
(965, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 148, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 16:58:09', '2025-12-10 16:58:09'),
(966, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 149, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 16:58:09', '2025-12-10 16:58:09'),
(967, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 150, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 16:58:09', '2025-12-10 16:58:09'),
(968, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 151, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 16:58:09', '2025-12-10 16:58:09'),
(969, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 152, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 16:58:09', '2025-12-10 16:58:09'),
(970, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 153, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 16:58:09', '2025-12-10 16:58:09'),
(971, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 154, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 16:58:09', '2025-12-10 16:58:09'),
(972, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 155, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"due_date\":\"2026-10-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 16:58:09', '2025-12-10 16:58:09'),
(973, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 156, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"due_date\":\"2026-11-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 16:58:09', '2025-12-10 16:58:09'),
(974, 'audit', 'created', 'created', 'App\\Models\\Journal', 29, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-40\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":40,\"sales_order_id\":30,\"method\":\"cash\"}}}', NULL, '2025-12-10 16:58:51', '2025-12-10 16:58:51'),
(975, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 255, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":29,\"tx_id\":\"PMT-40\",\"account_id\":1,\"debit\":\"1000000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":40,\"sales_order_id\":30,\"method\":\"cash\"}}}', NULL, '2025-12-10 16:58:51', '2025-12-10 16:58:51'),
(976, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 256, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":29,\"tx_id\":\"PMT-40\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"1000000.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":40,\"sales_order_id\":30,\"method\":\"cash\"}}}', NULL, '2025-12-10 16:58:51', '2025-12-10 16:58:51'),
(977, 'audit', 'created', 'created', 'App\\Models\\Payment', 40, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"paid_at\":\"2025-12-10T00:00:00.000000Z\",\"amount\":\"1000000.00\",\"commission_base_amount\":\"900000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"321321321\"}}}', NULL, '2025-12-10 16:58:51', '2025-12-10 16:58:51'),
(978, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 26, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":40,\"customer_installment_id\":145,\"allocated\":\"0.00\"}}', NULL, '2025-12-10 16:58:51', '2025-12-10 16:58:51'),
(979, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 145, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-10 16:58:51', '2025-12-10 16:58:51'),
(980, 'audit', 'created', 'created', 'App\\Models\\Journal', 30, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-41\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":41,\"sales_order_id\":30,\"method\":\"cash\"}}}', NULL, '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(981, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 257, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":30,\"tx_id\":\"PMT-41\",\"account_id\":1,\"debit\":\"333333.34\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":41,\"sales_order_id\":30,\"method\":\"cash\"}}}', NULL, '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(982, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 258, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":30,\"tx_id\":\"PMT-41\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"333333.34\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":41,\"sales_order_id\":30,\"method\":\"cash\"}}}', NULL, '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(983, 'audit', 'created', 'created', 'App\\Models\\Journal', 31, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-41-2\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":41,\"sales_order_id\":30,\"supplier_id\":2}}}', NULL, '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(984, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 259, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":31,\"tx_id\":\"SUPP-PAYABLE-41-2\",\"account_id\":7,\"debit\":\"66666.67\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":41,\"sales_order_id\":30,\"supplier_id\":2}}}', NULL, '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(985, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 260, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":31,\"tx_id\":\"SUPP-PAYABLE-41-2\",\"account_id\":8,\"debit\":\"0.00\",\"credit\":\"66666.67\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":41,\"sales_order_id\":30,\"supplier_id\":2}}}', NULL, '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(986, 'audit', 'created', 'created', 'App\\Models\\Payment', 41, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":30,\"paid_at\":\"2025-12-10T00:00:00.000000Z\",\"amount\":\"333333.34\",\"commission_base_amount\":\"300000.01\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"12321321\"}}}', NULL, '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(987, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 27, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":41,\"customer_installment_id\":145,\"allocated\":\"333333.34\"}}', NULL, '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(988, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 145, 'App\\Models\\User', 52, '{\"attributes\":{\"paid\":\"333333.34\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(989, 'audit', 'created', 'created', 'App\\Models\\Commission', 1, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":40,\"sales_order_id\":30,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"45000.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:59:33.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":1,\"calculation_item_id\":1,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(990, 'audit', 'created', 'created', 'App\\Models\\Journal', 32, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-1\",\"description\":null,\"occurred_at\":\"2025-12-10T16:59:33.000000Z\",\"meta\":{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(991, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 261, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":32,\"tx_id\":\"CMS-1\",\"account_id\":4,\"debit\":\"45000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:59:33.000000Z\",\"meta\":{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(992, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 262, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":32,\"tx_id\":\"CMS-1\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"45000.00\",\"occurred_at\":\"2025-12-10T16:59:33.000000Z\",\"meta\":{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(993, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 40, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T16:59:33.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(994, 'audit', 'created', 'created', 'App\\Models\\Commission', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":41,\"sales_order_id\":30,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"3000.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T16:59:33.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":2,\"calculation_item_id\":2,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(995, 'audit', 'created', 'created', 'App\\Models\\Journal', 33, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-2\",\"description\":null,\"occurred_at\":\"2025-12-10T16:59:33.000000Z\",\"meta\":{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(996, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 263, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":33,\"tx_id\":\"CMS-2\",\"account_id\":4,\"debit\":\"3000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T16:59:33.000000Z\",\"meta\":{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(997, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 264, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":33,\"tx_id\":\"CMS-2\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"3000.00\",\"occurred_at\":\"2025-12-10T16:59:33.000000Z\",\"meta\":{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(998, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 41, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T16:59:33.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(999, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 31, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"100000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:02:13', '2025-12-10 17:02:13'),
(1000, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 31, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":31,\"itemable_id\":4,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-12-10 17:02:13', '2025-12-10 17:02:13'),
(1001, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 32, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"100000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:03:29', '2025-12-10 17:03:29'),
(1002, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 32, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":32,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-12-10 17:03:29', '2025-12-10 17:03:29'),
(1003, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 33, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"10000.00\",\"total\":\"100000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:04:44', '2025-12-10 17:04:44'),
(1004, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 33, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":33,\"itemable_id\":3,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"100000.00\",\"line_total\":\"100000.00\"}}', NULL, '2025-12-10 17:04:44', '2025-12-10 17:04:44'),
(1005, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 34, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"100000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:06:04', '2025-12-10 17:06:04'),
(1006, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 34, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":34,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-12-10 17:06:04', '2025-12-10 17:06:04'),
(1007, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 34, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"100000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:08:08', '2025-12-10 17:08:08'),
(1008, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 33, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"10000.00\",\"total\":\"100000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:08:12', '2025-12-10 17:08:12'),
(1009, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 31, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"100000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:08:21', '2025-12-10 17:08:21'),
(1010, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 32, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"100000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:08:23', '2025-12-10 17:08:23'),
(1011, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 29, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"100000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:09:22', '2025-12-10 17:09:22'),
(1012, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 30, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:09:25', '2025-12-10 17:09:25'),
(1013, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 35, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-10 17:09:45', '2025-12-10 17:09:45'),
(1014, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 35, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-10 17:09:45', '2025-12-10 17:09:45'),
(1015, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 157, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:09:49', '2025-12-10 17:09:49'),
(1016, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 158, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:09:49', '2025-12-10 17:09:49'),
(1017, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 159, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:09:49', '2025-12-10 17:09:49'),
(1018, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 160, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:09:49', '2025-12-10 17:09:49'),
(1019, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 161, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:09:49', '2025-12-10 17:09:49'),
(1020, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 162, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:09:49', '2025-12-10 17:09:49'),
(1021, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 163, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:09:49', '2025-12-10 17:09:49'),
(1022, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 164, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:09:49', '2025-12-10 17:09:49'),
(1023, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 165, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:09:49', '2025-12-10 17:09:49'),
(1024, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 166, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:09:49', '2025-12-10 17:09:49'),
(1025, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 167, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"due_date\":\"2026-10-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:09:49', '2025-12-10 17:09:49'),
(1026, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 168, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":35,\"due_date\":\"2026-11-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:09:49', '2025-12-10 17:09:49'),
(1027, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 20, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"0.00\",\"total\":\"50000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-10 17:10:49', '2025-12-10 17:10:49'),
(1028, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 35, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-10 17:11:26', '2025-12-10 17:11:26'),
(1029, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 36, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":51,\"employee_id\":19,\"source_me_id\":19,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-10 17:14:51', '2025-12-10 17:14:51'),
(1030, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 36, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"itemable_id\":12,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-12-10 17:14:51', '2025-12-10 17:14:51'),
(1031, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 169, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(1032, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 170, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(1033, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 171, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(1034, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 172, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(1035, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 173, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(1036, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 174, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(1037, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 175, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(1038, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 176, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(1039, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 177, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(1040, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 178, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(1041, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 179, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"due_date\":\"2026-10-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(1042, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 180, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"due_date\":\"2026-11-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(1043, 'audit', 'created', 'created', 'App\\Models\\Journal', 34, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"PMT-42\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":42,\"sales_order_id\":36,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:15:10', '2025-12-10 17:15:10'),
(1044, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 265, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":34,\"tx_id\":\"PMT-42\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":42,\"sales_order_id\":36,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:15:10', '2025-12-10 17:15:10'),
(1045, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 266, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":34,\"tx_id\":\"PMT-42\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":42,\"sales_order_id\":36,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:15:10', '2025-12-10 17:15:10'),
(1046, 'audit', 'created', 'created', 'App\\Models\\Payment', 42, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":36,\"paid_at\":\"2025-12-10T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"40000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"3123213213\"}}}', NULL, '2025-12-10 17:15:10', '2025-12-10 17:15:10'),
(1047, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 28, 'App\\Models\\User', 10, '{\"attributes\":{\"payment_id\":42,\"customer_installment_id\":169,\"allocated\":\"0.00\"}}', NULL, '2025-12-10 17:15:10', '2025-12-10 17:15:10'),
(1048, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 169, 'App\\Models\\User', 10, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-10 17:15:10', '2025-12-10 17:15:10'),
(1049, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 18, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":77,\"employee_id\":26,\"source_me_id\":26,\"agent_id\":null,\"branch_id\":1,\"sales_type\":\"order\",\"rank\":\"ED\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-10 17:19:17', '2025-12-10 17:19:17'),
(1050, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 3, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"71000.00\",\"total\":\"700000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-10 17:19:41', '2025-12-10 17:19:41'),
(1051, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 37, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":48,\"employee_id\":16,\"source_me_id\":16,\"agent_id\":null,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"MM\",\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-10 17:20:54', '2025-12-10 17:20:54'),
(1052, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 37, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-10 17:20:54', '2025-12-10 17:20:54'),
(1053, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 181, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(1054, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 182, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(1055, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 183, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(1056, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 184, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(1057, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 185, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(1058, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 186, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(1059, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 187, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(1060, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 188, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(1061, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 189, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(1062, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 190, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(1063, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 191, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"due_date\":\"2026-10-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(1064, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 192, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":37,\"due_date\":\"2026-11-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(1065, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 38, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:21:24', '2025-12-10 17:21:24'),
(1066, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 38, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-10 17:21:24', '2025-12-10 17:21:24'),
(1067, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 193, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(1068, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 194, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(1069, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 195, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(1070, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 196, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"333333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:22:53', '2025-12-10 17:22:53');
INSERT INTO `activity_log` (`id`, `log_name`, `event`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(1071, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 197, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(1072, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 198, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(1073, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 199, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(1074, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 200, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(1075, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 201, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(1076, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 202, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(1077, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 203, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"due_date\":\"2026-10-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(1078, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 204, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":38,\"due_date\":\"2026-11-15T00:00:00.000000Z\",\"amount\":\"333333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(1079, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 39, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:24:18', '2025-12-10 17:24:18'),
(1080, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 39, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"itemable_id\":10,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-12-10 17:24:18', '2025-12-10 17:24:18'),
(1081, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 205, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(1082, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 206, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(1083, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 207, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(1084, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 208, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(1085, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 209, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(1086, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 210, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(1087, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 211, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(1088, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 212, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(1089, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 213, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(1090, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 214, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(1091, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 215, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"due_date\":\"2026-10-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(1092, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 216, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":39,\"due_date\":\"2026-11-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(1093, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 40, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:28:07', '2025-12-10 17:28:07'),
(1094, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 40, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-10 17:28:07', '2025-12-10 17:28:07'),
(1095, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 217, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(1096, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 218, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(1097, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 219, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(1098, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 220, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(1099, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 221, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(1100, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 222, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(1101, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 223, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(1102, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 224, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(1103, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 225, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(1104, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 226, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(1105, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 227, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"due_date\":\"2026-10-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(1106, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 228, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":40,\"due_date\":\"2026-11-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(1107, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 41, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:29:12', '2025-12-10 17:29:12'),
(1108, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 41, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"itemable_id\":11,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-10 17:29:12', '2025-12-10 17:29:12'),
(1109, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 229, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(1110, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 230, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(1111, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 231, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(1112, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 232, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(1113, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 233, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(1114, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 234, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(1115, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 235, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(1116, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 236, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(1117, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 237, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(1118, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 238, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(1119, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 239, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"due_date\":\"2026-10-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(1120, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 240, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"due_date\":\"2026-11-15T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(1121, 'audit', 'created', 'created', 'App\\Models\\Journal', 35, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-43\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":43,\"sales_order_id\":41,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:29:52', '2025-12-10 17:29:52'),
(1122, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 267, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":35,\"tx_id\":\"PMT-43\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":43,\"sales_order_id\":41,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:29:52', '2025-12-10 17:29:52'),
(1123, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 268, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":35,\"tx_id\":\"PMT-43\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":43,\"sales_order_id\":41,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:29:52', '2025-12-10 17:29:52'),
(1124, 'audit', 'created', 'created', 'App\\Models\\Payment', 43, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"paid_at\":\"2025-12-10T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"35000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":null}}}', NULL, '2025-12-10 17:29:52', '2025-12-10 17:29:52'),
(1125, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 29, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":43,\"customer_installment_id\":229,\"allocated\":\"0.00\"}}', NULL, '2025-12-10 17:29:52', '2025-12-10 17:29:52'),
(1126, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 229, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-10 17:29:52', '2025-12-10 17:29:52'),
(1127, 'audit', 'created', 'created', 'App\\Models\\Journal', 36, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-44\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":44,\"sales_order_id\":41,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(1128, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 269, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":36,\"tx_id\":\"PMT-44\",\"account_id\":1,\"debit\":\"412500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":44,\"sales_order_id\":41,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(1129, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 270, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":36,\"tx_id\":\"PMT-44\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"412500.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":44,\"sales_order_id\":41,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(1130, 'audit', 'created', 'created', 'App\\Models\\Journal', 37, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-44-1\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":44,\"sales_order_id\":41,\"supplier_id\":1}}}', NULL, '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(1131, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 271, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":37,\"tx_id\":\"SUPP-PAYABLE-44-1\",\"account_id\":7,\"debit\":\"82500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":44,\"sales_order_id\":41,\"supplier_id\":1}}}', NULL, '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(1132, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 272, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":37,\"tx_id\":\"SUPP-PAYABLE-44-1\",\"account_id\":8,\"debit\":\"0.00\",\"credit\":\"82500.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":44,\"sales_order_id\":41,\"supplier_id\":1}}}', NULL, '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(1133, 'audit', 'created', 'created', 'App\\Models\\Payment', 44, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":41,\"paid_at\":\"2025-12-10T00:00:00.000000Z\",\"amount\":\"412500.00\",\"commission_base_amount\":\"288750.00\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"2222\"}}}', NULL, '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(1134, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 30, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":44,\"customer_installment_id\":229,\"allocated\":\"412500.00\"}}', NULL, '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(1135, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 229, 'App\\Models\\User', 52, '{\"attributes\":{\"paid\":\"412500.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(1136, 'audit', 'created', 'created', 'App\\Models\\Commission', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":42,\"sales_order_id\":36,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"amount\":\"6000.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":3,\"calculation_item_id\":3,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1137, 'audit', 'created', 'created', 'App\\Models\\Journal', 38, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-3\",\"description\":null,\"occurred_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1138, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 273, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":38,\"tx_id\":\"CMS-3\",\"account_id\":4,\"debit\":\"6000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1139, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 274, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":38,\"tx_id\":\"CMS-3\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"6000.00\",\"occurred_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1140, 'audit', 'created', 'created', 'App\\Models\\Commission', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":42,\"sales_order_id\":36,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"6000.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":3,\"calculation_item_id\":4,\"order_created_by\":\"admin\",\"source_me_id\":19}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1141, 'audit', 'created', 'created', 'App\\Models\\Journal', 39, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-4\",\"description\":null,\"occurred_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1142, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 275, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":39,\"tx_id\":\"CMS-4\",\"account_id\":4,\"debit\":\"6000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1143, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 276, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":39,\"tx_id\":\"CMS-4\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"6000.00\",\"occurred_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1144, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 42, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T17:30:54.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1145, 'audit', 'created', 'created', 'App\\Models\\Commission', 5, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":43,\"sales_order_id\":41,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"1750.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":4,\"calculation_item_id\":5,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1146, 'audit', 'created', 'created', 'App\\Models\\Journal', 40, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-5\",\"description\":null,\"occurred_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"commission_id\":5,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1147, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 277, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":40,\"tx_id\":\"CMS-5\",\"account_id\":4,\"debit\":\"1750.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"commission_id\":5,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1148, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 278, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":40,\"tx_id\":\"CMS-5\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1750.00\",\"occurred_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"commission_id\":5,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1149, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 43, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T17:30:54.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1150, 'audit', 'created', 'created', 'App\\Models\\Commission', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":44,\"sales_order_id\":41,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"2887.50\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":5,\"calculation_item_id\":6,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1151, 'audit', 'created', 'created', 'App\\Models\\Journal', 41, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-6\",\"description\":null,\"occurred_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"commission_id\":6,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1152, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 279, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":41,\"tx_id\":\"CMS-6\",\"account_id\":4,\"debit\":\"2887.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"commission_id\":6,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1153, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 280, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":41,\"tx_id\":\"CMS-6\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2887.50\",\"occurred_at\":\"2025-12-10T17:30:54.000000Z\",\"meta\":{\"commission_id\":6,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1154, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 44, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T17:30:54.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(1155, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 42, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"500000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:44:36', '2025-12-10 17:44:36'),
(1156, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 42, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"itemable_id\":10,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"500000.00\",\"line_total\":\"500000.00\"}}', NULL, '2025-12-10 17:44:36', '2025-12-10 17:44:36'),
(1157, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 241, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(1158, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 242, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(1159, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 243, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(1160, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 244, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(1161, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 245, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(1162, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 246, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(1163, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 247, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(1164, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 248, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(1165, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 249, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(1166, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 250, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(1167, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 251, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"due_date\":\"2026-10-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(1168, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 252, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":42,\"due_date\":\"2026-11-15T00:00:00.000000Z\",\"amount\":\"37500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(1169, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 43, 'App\\Models\\User', 10, '{\"attributes\":{\"customer_id\":77,\"employee_id\":26,\"source_me_id\":26,\"agent_id\":null,\"branch_id\":1,\"sales_type\":\"order\",\"rank\":\"ED\",\"introducer_id\":null,\"down_payment\":\"200000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"admin\"}}', NULL, '2025-12-10 17:47:04', '2025-12-10 17:47:04'),
(1170, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 43, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"itemable_id\":4,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-10 17:47:04', '2025-12-10 17:47:04'),
(1171, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 253, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"400000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(1172, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 254, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"400000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(1173, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 255, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"400000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(1174, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 256, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"400000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(1175, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 257, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"400000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(1176, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 258, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"400000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(1177, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 259, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"400000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(1178, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 260, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"400000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(1179, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 261, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"400000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(1180, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 262, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"400000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(1181, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 263, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"due_date\":\"2026-10-15T00:00:00.000000Z\",\"amount\":\"400000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(1182, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 264, 'App\\Models\\User', 10, '{\"attributes\":{\"sales_order_id\":43,\"due_date\":\"2026-11-15T00:00:00.000000Z\",\"amount\":\"400000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(1183, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 44, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"5000.00\",\"total\":\"50000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 17:50:13', '2025-12-10 17:50:13'),
(1184, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 44, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"itemable_id\":6,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"50000.00\",\"line_total\":\"50000.00\"}}', NULL, '2025-12-10 17:50:13', '2025-12-10 17:50:13'),
(1185, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 265, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"3750.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(1186, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 266, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"3750.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(1187, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 267, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"3750.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(1188, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 268, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"3750.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(1189, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 269, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"3750.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(1190, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 270, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"3750.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(1191, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 271, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"3750.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(1192, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 272, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"3750.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(1193, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 273, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"3750.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(1194, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 274, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"3750.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(1195, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 275, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"due_date\":\"2026-10-15T00:00:00.000000Z\",\"amount\":\"3750.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(1196, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 276, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"due_date\":\"2026-11-15T00:00:00.000000Z\",\"amount\":\"3750.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(1197, 'audit', 'created', 'created', 'App\\Models\\Journal', 42, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-45\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":45,\"sales_order_id\":44,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:50:44', '2025-12-10 17:50:44'),
(1198, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 281, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":42,\"tx_id\":\"PMT-45\",\"account_id\":1,\"debit\":\"5000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":45,\"sales_order_id\":44,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:50:44', '2025-12-10 17:50:44'),
(1199, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 282, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":42,\"tx_id\":\"PMT-45\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"5000.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":45,\"sales_order_id\":44,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:50:44', '2025-12-10 17:50:44'),
(1200, 'audit', 'created', 'created', 'App\\Models\\Payment', 45, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"paid_at\":\"2025-12-10T00:00:00.000000Z\",\"amount\":\"5000.00\",\"commission_base_amount\":\"4500.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":null}}}', NULL, '2025-12-10 17:50:44', '2025-12-10 17:50:44'),
(1201, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 31, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":45,\"customer_installment_id\":265,\"allocated\":\"0.00\"}}', NULL, '2025-12-10 17:50:44', '2025-12-10 17:50:44'),
(1202, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 265, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-10 17:50:44', '2025-12-10 17:50:44'),
(1203, 'audit', 'created', 'created', 'App\\Models\\Journal', 43, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-46\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":46,\"sales_order_id\":44,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:50:49', '2025-12-10 17:50:49'),
(1204, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 283, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":43,\"tx_id\":\"PMT-46\",\"account_id\":1,\"debit\":\"3750.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":46,\"sales_order_id\":44,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(1205, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 284, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":43,\"tx_id\":\"PMT-46\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"3750.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":46,\"sales_order_id\":44,\"method\":\"cash\"}}}', NULL, '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(1206, 'audit', 'created', 'created', 'App\\Models\\Journal', 44, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-46-2\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":46,\"sales_order_id\":44,\"supplier_id\":2}}}', NULL, '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(1207, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 285, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":44,\"tx_id\":\"SUPP-PAYABLE-46-2\",\"account_id\":7,\"debit\":\"562.50\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":46,\"sales_order_id\":44,\"supplier_id\":2}}}', NULL, '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(1208, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 286, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":44,\"tx_id\":\"SUPP-PAYABLE-46-2\",\"account_id\":8,\"debit\":\"0.00\",\"credit\":\"562.50\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":46,\"sales_order_id\":44,\"supplier_id\":2}}}', NULL, '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(1209, 'audit', 'created', 'created', 'App\\Models\\Payment', 46, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":44,\"paid_at\":\"2025-12-10T00:00:00.000000Z\",\"amount\":\"3750.00\",\"commission_base_amount\":\"3375.00\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment_payment\",\"method\":\"cash\",\"meta\":{\"reference\":null}}}', NULL, '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(1210, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 32, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":46,\"customer_installment_id\":265,\"allocated\":\"3750.00\"}}', NULL, '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(1211, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 265, 'App\\Models\\User', 52, '{\"attributes\":{\"paid\":\"3750.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(1212, 'audit', 'created', 'created', 'App\\Models\\Agent', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":80,\"branch_id\":1,\"agent_code\":\"AG-1002\",\"mobile\":\"+880123456789\",\"address\":\"House 10, Road 12, Dhaka\"}}', NULL, '2025-12-10 18:03:20', '2025-12-10 18:03:20'),
(1213, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 45, 'App\\Models\\User', 80, '{\"attributes\":{\"customer_id\":81,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":7,\"branch_id\":1,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-10 18:10:25', '2025-12-10 18:10:25'),
(1214, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 45, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-10 18:10:25', '2025-12-10 18:10:25'),
(1215, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 277, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2025-12-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1216, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 278, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2026-01-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1217, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 279, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2026-02-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1218, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 280, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2026-03-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37');
INSERT INTO `activity_log` (`id`, `log_name`, `event`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(1219, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 281, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2026-04-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1220, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 282, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2026-05-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1221, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 283, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2026-06-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1222, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 284, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2026-07-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1223, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 285, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2026-08-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1224, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 286, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2026-09-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1225, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 287, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2026-10-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1226, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 288, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2026-11-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1227, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 289, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2026-12-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1228, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 290, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2027-01-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1229, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 291, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2027-02-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1230, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 292, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2027-03-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1231, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 293, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2027-04-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1232, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 294, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2027-05-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1233, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 295, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2027-06-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1234, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 296, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"due_date\":\"2027-07-15T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(1235, 'audit', 'created', 'created', 'App\\Models\\Journal', 45, 'App\\Models\\User', 80, '{\"attributes\":{\"tx_id\":\"PMT-47\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":47,\"sales_order_id\":45,\"method\":\"cash\"}}}', NULL, '2025-12-10 18:15:24', '2025-12-10 18:15:24'),
(1236, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 287, 'App\\Models\\User', 80, '{\"attributes\":{\"journal_id\":45,\"tx_id\":\"PMT-47\",\"account_id\":1,\"debit\":\"1000000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":47,\"sales_order_id\":45,\"method\":\"cash\"}}}', NULL, '2025-12-10 18:15:24', '2025-12-10 18:15:24'),
(1237, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 288, 'App\\Models\\User', 80, '{\"attributes\":{\"journal_id\":45,\"tx_id\":\"PMT-47\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"1000000.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":47,\"sales_order_id\":45,\"method\":\"cash\"}}}', NULL, '2025-12-10 18:15:24', '2025-12-10 18:15:24'),
(1238, 'audit', 'created', 'created', 'App\\Models\\Payment', 47, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"paid_at\":\"2025-12-10T00:00:00.000000Z\",\"amount\":\"1000000.00\",\"commission_base_amount\":\"900000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"123\"}}}', NULL, '2025-12-10 18:15:24', '2025-12-10 18:15:24'),
(1239, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 33, 'App\\Models\\User', 80, '{\"attributes\":{\"payment_id\":47,\"customer_installment_id\":277,\"allocated\":\"0.00\"}}', NULL, '2025-12-10 18:15:24', '2025-12-10 18:15:24'),
(1240, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 277, 'App\\Models\\User', 80, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-10 18:15:24', '2025-12-10 18:15:24'),
(1241, 'audit', 'created', 'created', 'App\\Models\\Journal', 46, 'App\\Models\\User', 80, '{\"attributes\":{\"tx_id\":\"PMT-48\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":48,\"sales_order_id\":45,\"method\":\"cash\"}}}', NULL, '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(1242, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 289, 'App\\Models\\User', 80, '{\"attributes\":{\"journal_id\":46,\"tx_id\":\"PMT-48\",\"account_id\":1,\"debit\":\"200000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":48,\"sales_order_id\":45,\"method\":\"cash\"}}}', NULL, '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(1243, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 290, 'App\\Models\\User', 80, '{\"attributes\":{\"journal_id\":46,\"tx_id\":\"PMT-48\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"200000.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":48,\"sales_order_id\":45,\"method\":\"cash\"}}}', NULL, '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(1244, 'audit', 'created', 'created', 'App\\Models\\Journal', 47, 'App\\Models\\User', 80, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-48-2\",\"description\":null,\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":48,\"sales_order_id\":45,\"supplier_id\":2}}}', NULL, '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(1245, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 291, 'App\\Models\\User', 80, '{\"attributes\":{\"journal_id\":47,\"tx_id\":\"SUPP-PAYABLE-48-2\",\"account_id\":7,\"debit\":\"40000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":48,\"sales_order_id\":45,\"supplier_id\":2}}}', NULL, '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(1246, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 292, 'App\\Models\\User', 80, '{\"attributes\":{\"journal_id\":47,\"tx_id\":\"SUPP-PAYABLE-48-2\",\"account_id\":8,\"debit\":\"0.00\",\"credit\":\"40000.00\",\"occurred_at\":\"2025-12-10T00:00:00.000000Z\",\"meta\":{\"payment_id\":48,\"sales_order_id\":45,\"supplier_id\":2}}}', NULL, '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(1247, 'audit', 'created', 'created', 'App\\Models\\Payment', 48, 'App\\Models\\User', 80, '{\"attributes\":{\"sales_order_id\":45,\"paid_at\":\"2025-12-10T00:00:00.000000Z\",\"amount\":\"200000.00\",\"commission_base_amount\":\"180000.00\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"123\"}}}', NULL, '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(1248, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 34, 'App\\Models\\User', 80, '{\"attributes\":{\"payment_id\":48,\"customer_installment_id\":277,\"allocated\":\"200000.00\"}}', NULL, '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(1249, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 277, 'App\\Models\\User', 80, '{\"attributes\":{\"paid\":\"200000.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-12-10 18:16:51', '2025-12-10 18:16:51'),
(1250, 'audit', 'created', 'created', 'App\\Models\\Commission', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":45,\"sales_order_id\":44,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"225.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":6,\"calculation_item_id\":7,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1251, 'audit', 'created', 'created', 'App\\Models\\Journal', 48, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-7\",\"description\":null,\"occurred_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"commission_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1252, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 293, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":48,\"tx_id\":\"CMS-7\",\"account_id\":4,\"debit\":\"225.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"commission_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1253, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 294, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":48,\"tx_id\":\"CMS-7\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"225.00\",\"occurred_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"commission_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1254, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 45, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T18:21:21.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1255, 'audit', 'created', 'created', 'App\\Models\\Commission', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":46,\"sales_order_id\":44,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"33.75\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":7,\"calculation_item_id\":8,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1256, 'audit', 'created', 'created', 'App\\Models\\Journal', 49, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-8\",\"description\":null,\"occurred_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1257, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 295, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":49,\"tx_id\":\"CMS-8\",\"account_id\":4,\"debit\":\"33.75\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1258, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 296, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":49,\"tx_id\":\"CMS-8\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"33.75\",\"occurred_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1259, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 46, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T18:21:21.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1260, 'audit', 'created', 'created', 'App\\Models\\Commission', 9, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":47,\"sales_order_id\":45,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7,\"amount\":\"45000.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"Liton\",\"calculation_unit_id\":8,\"calculation_item_id\":9,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1261, 'audit', 'created', 'created', 'App\\Models\\Journal', 50, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-9\",\"description\":null,\"occurred_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1262, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 297, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":50,\"tx_id\":\"CMS-9\",\"account_id\":4,\"debit\":\"45000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1263, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 298, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":50,\"tx_id\":\"CMS-9\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"45000.00\",\"occurred_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1264, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 47, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T18:21:21.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1265, 'audit', 'created', 'created', 'App\\Models\\Commission', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":48,\"sales_order_id\":45,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7,\"amount\":\"1800.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"Liton\",\"calculation_unit_id\":9,\"calculation_item_id\":10,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1266, 'audit', 'created', 'created', 'App\\Models\\Journal', 51, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-10\",\"description\":null,\"occurred_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1267, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 299, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":51,\"tx_id\":\"CMS-10\",\"account_id\":4,\"debit\":\"1800.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1268, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 300, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":51,\"tx_id\":\"CMS-10\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1800.00\",\"occurred_at\":\"2025-12-10T18:21:21.000000Z\",\"meta\":{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7}}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1269, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 48, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-10T18:21:21.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(1270, 'audit', 'created', 'created', 'App\\Models\\Employee', 43, 'App\\Models\\User', 81, '{\"attributes\":{\"user_id\":82,\"branch_id\":2,\"agent_id\":null,\"superior_id\":12,\"employee_code\":\"2346\",\"rank\":\"ME\",\"full_name_en\":\"sumi\",\"full_name_bn\":\"sumi\",\"father_name\":\"ghh\",\"mother_name\":\"hjj\",\"mobile\":\"12334\",\"national_id\":\"5677\",\"date_of_birth\":\"2000-02-03T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Female\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"ghhhh\",\"permanent_address\":\"ghhh\",\"post_code\":null}}', NULL, '2025-12-10 18:31:11', '2025-12-10 18:31:11'),
(1271, 'audit', 'created', 'created', 'App\\Models\\Agent', 8, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":83,\"branch_id\":2,\"agent_code\":\"AGT-0002\",\"mobile\":\"23456\",\"address\":\"sdf\"}}', NULL, '2025-12-11 17:56:59', '2025-12-11 17:56:59'),
(1272, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 46, 'App\\Models\\User', 83, '{\"attributes\":{\"customer_id\":84,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":8,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-11 18:07:34', '2025-12-11 18:07:34'),
(1273, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 46, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"itemable_id\":4,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-11 18:07:34', '2025-12-11 18:07:34'),
(1274, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 297, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2025-12-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1275, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 298, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2026-01-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1276, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 299, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2026-02-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1277, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 300, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2026-03-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1278, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 301, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2026-04-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1279, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 302, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2026-05-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1280, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 303, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2026-06-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1281, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 304, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2026-07-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1282, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 305, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2026-08-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1283, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 306, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2026-09-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1284, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 307, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2026-10-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1285, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 308, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2026-11-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1286, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 309, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2026-12-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1287, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 310, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2027-01-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1288, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 311, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2027-02-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1289, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 312, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2027-03-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1290, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 313, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2027-04-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1291, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 314, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2027-05-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1292, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 315, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2027-06-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1293, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 316, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"due_date\":\"2027-07-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:08:33', '2025-12-11 18:08:33'),
(1294, 'audit', 'created', 'created', 'App\\Models\\Journal', 52, 'App\\Models\\User', 83, '{\"attributes\":{\"tx_id\":\"PMT-49\",\"description\":null,\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":49,\"sales_order_id\":46,\"method\":\"cash\"}}}', NULL, '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(1295, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 301, 'App\\Models\\User', 83, '{\"attributes\":{\"journal_id\":52,\"tx_id\":\"PMT-49\",\"account_id\":1,\"debit\":\"200000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":49,\"sales_order_id\":46,\"method\":\"cash\"}}}', NULL, '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(1296, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 302, 'App\\Models\\User', 83, '{\"attributes\":{\"journal_id\":52,\"tx_id\":\"PMT-49\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"200000.00\",\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":49,\"sales_order_id\":46,\"method\":\"cash\"}}}', NULL, '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(1297, 'audit', 'created', 'created', 'App\\Models\\Journal', 53, 'App\\Models\\User', 83, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-49-1\",\"description\":null,\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":49,\"sales_order_id\":46,\"supplier_id\":1}}}', NULL, '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(1298, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 303, 'App\\Models\\User', 83, '{\"attributes\":{\"journal_id\":53,\"tx_id\":\"SUPP-PAYABLE-49-1\",\"account_id\":7,\"debit\":\"40000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":49,\"sales_order_id\":46,\"supplier_id\":1}}}', NULL, '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(1299, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 304, 'App\\Models\\User', 83, '{\"attributes\":{\"journal_id\":53,\"tx_id\":\"SUPP-PAYABLE-49-1\",\"account_id\":8,\"debit\":\"0.00\",\"credit\":\"40000.00\",\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":49,\"sales_order_id\":46,\"supplier_id\":1}}}', NULL, '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(1300, 'audit', 'created', 'created', 'App\\Models\\Payment', 49, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":46,\"paid_at\":\"2025-12-11T00:00:00.000000Z\",\"amount\":\"200000.00\",\"commission_base_amount\":\"140000.00\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"2334\"}}}', NULL, '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(1301, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 35, 'App\\Models\\User', 83, '{\"attributes\":{\"payment_id\":49,\"customer_installment_id\":297,\"allocated\":\"200000.00\"}}', NULL, '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(1302, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 297, 'App\\Models\\User', 83, '{\"attributes\":{\"paid\":\"200000.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(1303, 'audit', 'created', 'created', 'App\\Models\\Commission', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":49,\"sales_order_id\":46,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8,\"amount\":\"1400.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-11T18:20:19.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"fusion\",\"calculation_unit_id\":10,\"calculation_item_id\":11,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-11 18:20:19', '2025-12-11 18:20:19'),
(1304, 'audit', 'created', 'created', 'App\\Models\\Journal', 54, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-11\",\"description\":null,\"occurred_at\":\"2025-12-11T18:20:19.000000Z\",\"meta\":{\"commission_id\":11,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}}}', NULL, '2025-12-11 18:20:19', '2025-12-11 18:20:19'),
(1305, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 305, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":54,\"tx_id\":\"CMS-11\",\"account_id\":4,\"debit\":\"1400.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-11T18:20:19.000000Z\",\"meta\":{\"commission_id\":11,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}}}', NULL, '2025-12-11 18:20:19', '2025-12-11 18:20:19'),
(1306, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 306, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":54,\"tx_id\":\"CMS-11\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1400.00\",\"occurred_at\":\"2025-12-11T18:20:19.000000Z\",\"meta\":{\"commission_id\":11,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}}}', NULL, '2025-12-11 18:20:19', '2025-12-11 18:20:19'),
(1307, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 49, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-11T18:20:19.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-11 18:20:19', '2025-12-11 18:20:19'),
(1308, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 47, 'App\\Models\\User', 83, '{\"attributes\":{\"customer_id\":84,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":8,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-11 18:45:01', '2025-12-11 18:45:01'),
(1309, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 47, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-11 18:45:01', '2025-12-11 18:45:01'),
(1310, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 317, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2025-12-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1311, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 318, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2026-01-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1312, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 319, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2026-02-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1313, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 320, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2026-03-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1314, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 321, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2026-04-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1315, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 322, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2026-05-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1316, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 323, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2026-06-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1317, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 324, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2026-07-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1318, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 325, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2026-08-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1319, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 326, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2026-09-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1320, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 327, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2026-10-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1321, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 328, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2026-11-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1322, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 329, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2026-12-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1323, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 330, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2027-01-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1324, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 331, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2027-02-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1325, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 332, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2027-03-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1326, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 333, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2027-04-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1327, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 334, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2027-05-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1328, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 335, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2027-06-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1329, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 336, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":47,\"due_date\":\"2027-07-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 18:45:20', '2025-12-11 18:45:20'),
(1330, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 47, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":84,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":8,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-11 18:52:43', '2025-12-11 18:52:43'),
(1331, 'audit', 'deleted', 'deleted', 'App\\Models\\SalesOrder', 46, 'App\\Models\\User', 10, '{\"old\":{\"customer_id\":84,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":8,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-11 18:52:47', '2025-12-11 18:52:47'),
(1332, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 48, 'App\\Models\\User', 83, '{\"attributes\":{\"customer_id\":84,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":8,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-11 19:33:42', '2025-12-11 19:33:42'),
(1333, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 48, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"itemable_id\":4,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-11 19:33:42', '2025-12-11 19:33:42'),
(1334, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 337, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2025-12-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1335, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 338, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2026-01-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1336, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 339, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2026-02-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1337, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 340, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2026-03-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1338, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 341, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2026-04-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1339, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 342, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2026-05-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1340, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 343, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2026-06-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1341, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 344, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2026-07-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1342, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 345, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2026-08-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1343, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 346, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2026-09-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1344, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 347, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2026-10-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1345, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 348, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2026-11-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1346, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 349, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2026-12-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1347, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 350, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2027-01-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1348, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 351, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2027-02-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1349, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 352, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2027-03-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1350, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 353, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2027-04-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1351, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 354, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2027-05-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1352, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 355, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2027-06-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1353, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 356, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"due_date\":\"2027-07-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(1354, 'audit', 'created', 'created', 'App\\Models\\Journal', 55, 'App\\Models\\User', 83, '{\"attributes\":{\"tx_id\":\"PMT-50\",\"description\":null,\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":50,\"sales_order_id\":48,\"method\":\"cash\"}}}', NULL, '2025-12-11 19:35:20', '2025-12-11 19:35:20'),
(1355, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 307, 'App\\Models\\User', 83, '{\"attributes\":{\"journal_id\":55,\"tx_id\":\"PMT-50\",\"account_id\":1,\"debit\":\"1000000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":50,\"sales_order_id\":48,\"method\":\"cash\"}}}', NULL, '2025-12-11 19:35:20', '2025-12-11 19:35:20'),
(1356, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 308, 'App\\Models\\User', 83, '{\"attributes\":{\"journal_id\":55,\"tx_id\":\"PMT-50\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"1000000.00\",\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":50,\"sales_order_id\":48,\"method\":\"cash\"}}}', NULL, '2025-12-11 19:35:20', '2025-12-11 19:35:20'),
(1357, 'audit', 'created', 'created', 'App\\Models\\Payment', 50, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"paid_at\":\"2025-12-11T00:00:00.000000Z\",\"amount\":\"1000000.00\",\"commission_base_amount\":\"700000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"344\"}}}', NULL, '2025-12-11 19:35:20', '2025-12-11 19:35:20'),
(1358, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 36, 'App\\Models\\User', 83, '{\"attributes\":{\"payment_id\":50,\"customer_installment_id\":337,\"allocated\":\"0.00\"}}', NULL, '2025-12-11 19:35:20', '2025-12-11 19:35:20'),
(1359, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 337, 'App\\Models\\User', 83, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-11 19:35:21', '2025-12-11 19:35:21'),
(1360, 'audit', 'created', 'created', 'App\\Models\\Journal', 56, 'App\\Models\\User', 83, '{\"attributes\":{\"tx_id\":\"PMT-51\",\"description\":null,\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":51,\"sales_order_id\":48,\"method\":\"cash\"}}}', NULL, '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(1361, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 309, 'App\\Models\\User', 83, '{\"attributes\":{\"journal_id\":56,\"tx_id\":\"PMT-51\",\"account_id\":1,\"debit\":\"200000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":51,\"sales_order_id\":48,\"method\":\"cash\"}}}', NULL, '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(1362, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 310, 'App\\Models\\User', 83, '{\"attributes\":{\"journal_id\":56,\"tx_id\":\"PMT-51\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"200000.00\",\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":51,\"sales_order_id\":48,\"method\":\"cash\"}}}', NULL, '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(1363, 'audit', 'created', 'created', 'App\\Models\\Journal', 57, 'App\\Models\\User', 83, '{\"attributes\":{\"tx_id\":\"SUPP-PAYABLE-51-1\",\"description\":null,\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":51,\"sales_order_id\":48,\"supplier_id\":1}}}', NULL, '2025-12-11 19:36:20', '2025-12-11 19:36:20');
INSERT INTO `activity_log` (`id`, `log_name`, `event`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(1364, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 311, 'App\\Models\\User', 83, '{\"attributes\":{\"journal_id\":57,\"tx_id\":\"SUPP-PAYABLE-51-1\",\"account_id\":7,\"debit\":\"40000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":51,\"sales_order_id\":48,\"supplier_id\":1}}}', NULL, '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(1365, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 312, 'App\\Models\\User', 83, '{\"attributes\":{\"journal_id\":57,\"tx_id\":\"SUPP-PAYABLE-51-1\",\"account_id\":8,\"debit\":\"0.00\",\"credit\":\"40000.00\",\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":51,\"sales_order_id\":48,\"supplier_id\":1}}}', NULL, '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(1366, 'audit', 'created', 'created', 'App\\Models\\Payment', 51, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":48,\"paid_at\":\"2025-12-11T00:00:00.000000Z\",\"amount\":\"200000.00\",\"commission_base_amount\":\"140000.00\",\"commission_processed_at\":null,\"type\":\"installment\",\"intent_type\":\"installment_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"344\"}}}', NULL, '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(1367, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 37, 'App\\Models\\User', 83, '{\"attributes\":{\"payment_id\":51,\"customer_installment_id\":337,\"allocated\":\"200000.00\"}}', NULL, '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(1368, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 337, 'App\\Models\\User', 83, '{\"attributes\":{\"paid\":\"200000.00\",\"status\":\"paid\"},\"old\":{\"paid\":\"0.00\",\"status\":\"partial\"}}', NULL, '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(1369, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 49, 'App\\Models\\User', 83, '{\"attributes\":{\"customer_id\":84,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":8,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-11 19:41:42', '2025-12-11 19:41:42'),
(1370, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 49, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":49,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-11 19:41:42', '2025-12-11 19:41:42'),
(1371, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 50, 'App\\Models\\User', 83, '{\"attributes\":{\"customer_id\":84,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":8,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"1000000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-11 19:42:40', '2025-12-11 19:42:40'),
(1372, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 50, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-11 19:42:40', '2025-12-11 19:42:40'),
(1373, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 357, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2025-12-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1374, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 358, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2026-01-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1375, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 359, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2026-02-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1376, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 360, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2026-03-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1377, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 361, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2026-04-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1378, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 362, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2026-05-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1379, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 363, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2026-06-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1380, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 364, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2026-07-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1381, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 365, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2026-08-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1382, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 366, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2026-09-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1383, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 367, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2026-10-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1384, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 368, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2026-11-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1385, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 369, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2026-12-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1386, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 370, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2027-01-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1387, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 371, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2027-02-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1388, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 372, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2027-03-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1389, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 373, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2027-04-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1390, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 374, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2027-05-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(1391, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 375, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2027-06-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:57', '2025-12-11 19:42:57'),
(1392, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 376, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"due_date\":\"2027-07-16T00:00:00.000000Z\",\"amount\":\"200000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-11 19:42:57', '2025-12-11 19:42:57'),
(1393, 'audit', 'created', 'created', 'App\\Models\\Journal', 58, 'App\\Models\\User', 83, '{\"attributes\":{\"tx_id\":\"PMT-52\",\"description\":null,\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":52,\"sales_order_id\":50,\"method\":\"cash\"}}}', NULL, '2025-12-11 19:44:22', '2025-12-11 19:44:22'),
(1394, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 313, 'App\\Models\\User', 83, '{\"attributes\":{\"journal_id\":58,\"tx_id\":\"PMT-52\",\"account_id\":1,\"debit\":\"1000000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":52,\"sales_order_id\":50,\"method\":\"cash\"}}}', NULL, '2025-12-11 19:44:22', '2025-12-11 19:44:22'),
(1395, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 314, 'App\\Models\\User', 83, '{\"attributes\":{\"journal_id\":58,\"tx_id\":\"PMT-52\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"1000000.00\",\"occurred_at\":\"2025-12-11T00:00:00.000000Z\",\"meta\":{\"payment_id\":52,\"sales_order_id\":50,\"method\":\"cash\"}}}', NULL, '2025-12-11 19:44:22', '2025-12-11 19:44:22'),
(1396, 'audit', 'created', 'created', 'App\\Models\\Payment', 52, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":50,\"paid_at\":\"2025-12-11T00:00:00.000000Z\",\"amount\":\"1000000.00\",\"commission_base_amount\":\"900000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":null}}}', NULL, '2025-12-11 19:44:22', '2025-12-11 19:44:22'),
(1397, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 38, 'App\\Models\\User', 83, '{\"attributes\":{\"payment_id\":52,\"customer_installment_id\":357,\"allocated\":\"0.00\"}}', NULL, '2025-12-11 19:44:22', '2025-12-11 19:44:22'),
(1398, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 357, 'App\\Models\\User', 83, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-11 19:44:22', '2025-12-11 19:44:22'),
(1399, 'audit', 'created', 'created', 'App\\Models\\Commission', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":50,\"sales_order_id\":48,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8,\"amount\":\"35000.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-11T19:45:39.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"fusion\",\"calculation_unit_id\":11,\"calculation_item_id\":12,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1400, 'audit', 'created', 'created', 'App\\Models\\Journal', 59, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-12\",\"description\":null,\"occurred_at\":\"2025-12-11T19:45:39.000000Z\",\"meta\":{\"commission_id\":12,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1401, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 315, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":59,\"tx_id\":\"CMS-12\",\"account_id\":4,\"debit\":\"35000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-11T19:45:39.000000Z\",\"meta\":{\"commission_id\":12,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1402, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 316, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":59,\"tx_id\":\"CMS-12\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"35000.00\",\"occurred_at\":\"2025-12-11T19:45:39.000000Z\",\"meta\":{\"commission_id\":12,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1403, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 50, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-11T19:45:39.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1404, 'audit', 'created', 'created', 'App\\Models\\Commission', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":51,\"sales_order_id\":48,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8,\"amount\":\"1400.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-11T19:45:39.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"fusion\",\"calculation_unit_id\":12,\"calculation_item_id\":13,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1405, 'audit', 'created', 'created', 'App\\Models\\Journal', 60, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-13\",\"description\":null,\"occurred_at\":\"2025-12-11T19:45:39.000000Z\",\"meta\":{\"commission_id\":13,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1406, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 317, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":60,\"tx_id\":\"CMS-13\",\"account_id\":4,\"debit\":\"1400.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-11T19:45:39.000000Z\",\"meta\":{\"commission_id\":13,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1407, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 318, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":60,\"tx_id\":\"CMS-13\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"1400.00\",\"occurred_at\":\"2025-12-11T19:45:39.000000Z\",\"meta\":{\"commission_id\":13,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1408, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 51, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-11T19:45:39.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1409, 'audit', 'created', 'created', 'App\\Models\\Commission', 14, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":52,\"sales_order_id\":50,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8,\"amount\":\"45000.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-11T19:45:39.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"fusion\",\"calculation_unit_id\":13,\"calculation_item_id\":14,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1410, 'audit', 'created', 'created', 'App\\Models\\Journal', 61, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-14\",\"description\":null,\"occurred_at\":\"2025-12-11T19:45:39.000000Z\",\"meta\":{\"commission_id\":14,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1411, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 319, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":61,\"tx_id\":\"CMS-14\",\"account_id\":4,\"debit\":\"45000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-11T19:45:39.000000Z\",\"meta\":{\"commission_id\":14,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1412, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 320, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":61,\"tx_id\":\"CMS-14\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"45000.00\",\"occurred_at\":\"2025-12-11T19:45:39.000000Z\",\"meta\":{\"commission_id\":14,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1413, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 52, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-11T19:45:39.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(1414, 'audit', 'created', 'created', 'App\\Models\\LedgerAccount', 10, 'App\\Models\\User', 10, '{\"attributes\":{\"code\":\"employee_wallet\",\"name\":\"Employee Wallet Payable\",\"type\":\"liability\",\"meta\":null}}', NULL, '2025-12-14 16:01:18', '2025-12-14 16:01:18'),
(1415, 'audit', 'created', 'created', 'App\\Models\\LedgerAccount', 11, 'App\\Models\\User', 10, '{\"attributes\":{\"code\":\"bkash\",\"name\":\"Bkash Payout\",\"type\":\"asset\",\"meta\":null}}', NULL, '2025-12-14 16:01:18', '2025-12-14 16:01:18'),
(1416, 'audit', 'created', 'created', 'App\\Models\\Journal', 62, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"wallet_withdrawal_1\",\"description\":null,\"occurred_at\":\"2025-12-14T16:01:18.000000Z\",\"meta\":{\"withdraw_request_id\":1,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}}}', NULL, '2025-12-14 16:01:18', '2025-12-14 16:01:18'),
(1417, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 321, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":62,\"tx_id\":\"wallet_withdrawal_1\",\"account_id\":10,\"debit\":\"500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-14T16:01:18.000000Z\",\"meta\":{\"withdraw_request_id\":1,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}}}', NULL, '2025-12-14 16:01:18', '2025-12-14 16:01:18'),
(1418, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 322, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":62,\"tx_id\":\"wallet_withdrawal_1\",\"account_id\":11,\"debit\":\"0.00\",\"credit\":\"500.00\",\"occurred_at\":\"2025-12-14T16:01:18.000000Z\",\"meta\":{\"withdraw_request_id\":1,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}}}', NULL, '2025-12-14 16:01:18', '2025-12-14 16:01:18'),
(1419, 'audit', 'created', 'created', 'App\\Models\\Journal', 63, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"wallet_withdrawal_4\",\"description\":null,\"occurred_at\":\"2025-12-14T16:19:54.000000Z\",\"meta\":{\"withdraw_request_id\":4,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}}}', NULL, '2025-12-14 16:19:54', '2025-12-14 16:19:54'),
(1420, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 323, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":63,\"tx_id\":\"wallet_withdrawal_4\",\"account_id\":10,\"debit\":\"500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-14T16:19:54.000000Z\",\"meta\":{\"withdraw_request_id\":4,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}}}', NULL, '2025-12-14 16:19:54', '2025-12-14 16:19:54'),
(1421, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 324, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":63,\"tx_id\":\"wallet_withdrawal_4\",\"account_id\":11,\"debit\":\"0.00\",\"credit\":\"500.00\",\"occurred_at\":\"2025-12-14T16:19:54.000000Z\",\"meta\":{\"withdraw_request_id\":4,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}}}', NULL, '2025-12-14 16:19:54', '2025-12-14 16:19:54'),
(1422, 'audit', 'created', 'created', 'App\\Models\\Journal', 64, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"wallet_withdrawal_7\",\"description\":null,\"occurred_at\":\"2025-12-14T19:14:59.000000Z\",\"meta\":{\"withdraw_request_id\":7,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}}}', NULL, '2025-12-14 19:14:59', '2025-12-14 19:14:59'),
(1423, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 325, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":64,\"tx_id\":\"wallet_withdrawal_7\",\"account_id\":10,\"debit\":\"500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-14T19:14:59.000000Z\",\"meta\":{\"withdraw_request_id\":7,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}}}', NULL, '2025-12-14 19:14:59', '2025-12-14 19:14:59'),
(1424, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 326, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":64,\"tx_id\":\"wallet_withdrawal_7\",\"account_id\":11,\"debit\":\"0.00\",\"credit\":\"500.00\",\"occurred_at\":\"2025-12-14T19:14:59.000000Z\",\"meta\":{\"withdraw_request_id\":7,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}}}', NULL, '2025-12-14 19:14:59', '2025-12-14 19:14:59'),
(1425, 'audit', 'created', 'created', 'App\\Models\\Journal', 65, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"wallet_withdrawal_5\",\"description\":null,\"occurred_at\":\"2025-12-14T19:17:37.000000Z\",\"meta\":{\"withdraw_request_id\":5,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}}}', NULL, '2025-12-14 19:17:37', '2025-12-14 19:17:37'),
(1426, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 327, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":65,\"tx_id\":\"wallet_withdrawal_5\",\"account_id\":10,\"debit\":\"4001.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-14T19:17:37.000000Z\",\"meta\":{\"withdraw_request_id\":5,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}}}', NULL, '2025-12-14 19:17:37', '2025-12-14 19:17:37'),
(1427, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 328, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":65,\"tx_id\":\"wallet_withdrawal_5\",\"account_id\":11,\"debit\":\"0.00\",\"credit\":\"4001.00\",\"occurred_at\":\"2025-12-14T19:17:37.000000Z\",\"meta\":{\"withdraw_request_id\":5,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}}}', NULL, '2025-12-14 19:17:37', '2025-12-14 19:17:37'),
(1428, 'audit', 'created', 'created', 'App\\Models\\LedgerAccount', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"code\":\"agent_wallet\",\"name\":\"Agent Wallet Payable\",\"type\":\"liability\",\"meta\":null}}', NULL, '2025-12-14 19:18:36', '2025-12-14 19:18:36'),
(1429, 'audit', 'created', 'created', 'App\\Models\\Journal', 66, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"wallet_withdrawal_6\",\"description\":null,\"occurred_at\":\"2025-12-14T19:18:36.000000Z\",\"meta\":{\"withdraw_request_id\":6,\"user_type\":\"agent\",\"user_id\":6,\"method\":\"bkash\"}}}', NULL, '2025-12-14 19:18:36', '2025-12-14 19:18:36'),
(1430, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 329, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":66,\"tx_id\":\"wallet_withdrawal_6\",\"account_id\":12,\"debit\":\"500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-14T19:18:36.000000Z\",\"meta\":{\"withdraw_request_id\":6,\"user_type\":\"agent\",\"user_id\":6,\"method\":\"bkash\"}}}', NULL, '2025-12-14 19:18:36', '2025-12-14 19:18:36'),
(1431, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 330, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":66,\"tx_id\":\"wallet_withdrawal_6\",\"account_id\":11,\"debit\":\"0.00\",\"credit\":\"500.00\",\"occurred_at\":\"2025-12-14T19:18:36.000000Z\",\"meta\":{\"withdraw_request_id\":6,\"user_type\":\"agent\",\"user_id\":6,\"method\":\"bkash\"}}}', NULL, '2025-12-14 19:18:36', '2025-12-14 19:18:36'),
(1432, 'audit', 'updated', 'updated', 'App\\Models\\Rank', 6, 'App\\Models\\User', 10, '{\"attributes\":{\"name\":\"Director Marketing\",\"code\":\"DM\"},\"old\":{\"name\":\"Project Director\",\"code\":\"PD\"}}', NULL, '2025-12-17 17:20:28', '2025-12-17 17:20:28'),
(1433, 'audit', 'updated', 'updated', 'App\\Models\\Rank', 13, 'App\\Models\\User', 10, '{\"attributes\":{\"name\":\"Vice Chairman\",\"code\":\"VC\"},\"old\":{\"name\":\"Assistant Managind Director\",\"code\":\"AMD\"}}', NULL, '2025-12-17 17:23:41', '2025-12-17 17:23:41'),
(1434, 'audit', 'updated', 'updated', 'App\\Models\\Rank', 7, 'App\\Models\\User', 10, '{\"attributes\":{\"name\":\"Assistant Managing Director\",\"code\":\"AMD\"},\"old\":{\"name\":\"Executive Director\",\"code\":\"ED\"}}', NULL, '2025-12-17 17:24:46', '2025-12-17 17:24:46'),
(1435, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 4, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"ME\":{\"down_payment\":\"12\",\"installment\":\"5\"},\"MM\":{\"down_payment\":\"17\",\"installment\":\"6\"},\"AGM\":{\"down_payment\":\"22\",\"installment\":\"7\"},\"DGM\":{\"down_payment\":\"26\",\"installment\":\"8\"},\"GM\":{\"down_payment\":\"30\",\"installment\":\"9\"}}},\"old\":{\"value\":{\"ME\":{\"down_payment\":10,\"installment\":4},\"MM\":{\"down_payment\":15,\"installment\":5},\"AGM\":{\"down_payment\":20,\"installment\":6},\"DGM\":{\"down_payment\":25,\"installment\":9},\"GM\":{\"down_payment\":30,\"installment\":11}}}}', NULL, '2025-12-17 17:31:20', '2025-12-17 17:31:20'),
(1436, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"DM\":{\"share_target\":\"6\",\"gm_target\":\"2\"},\"AMD\":{\"share_target\":\"8\",\"gm_target\":\"3\"},\"DMD\":{\"share_target\":\"8\",\"gm_target\":\"4\"},\"DIR\":{\"share_target\":\"8\",\"gm_target\":\"5\"}}},\"old\":{\"value\":{\"ED\":{\"share_target\":10,\"gm_target\":10},\"AMD\":{\"share_target\":20,\"gm_target\":20},\"DMD\":{\"share_target\":25,\"gm_target\":25},\"DIR\":{\"share_target\":30,\"gm_target\":30}}}}', NULL, '2025-12-17 17:37:05', '2025-12-17 17:37:05'),
(1437, 'audit', 'created', 'created', 'App\\Models\\Employee', 44, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":86,\"branch_id\":2,\"agent_id\":null,\"superior_id\":43,\"employee_code\":\"1345\",\"rank\":\"ME\",\"full_name_en\":\"mamun\",\"full_name_bn\":\"dff\",\"father_name\":\"ss\",\"mother_name\":\"fgg\",\"mobile\":\"12345673\",\"national_id\":\"555\",\"date_of_birth\":\"2000-04-12T00:00:00.000000Z\",\"marital_status\":\"Married\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":null,\"upazila\":null,\"present_address\":\"asdd\",\"permanent_address\":\"dddd\",\"post_code\":null}}', NULL, '2025-12-17 17:57:03', '2025-12-17 17:57:03'),
(1438, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 51, 'App\\Models\\User', 83, '{\"attributes\":{\"customer_id\":84,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":8,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"500000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-17 18:06:23', '2025-12-17 18:06:23'),
(1439, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 51, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-17 18:06:23', '2025-12-17 18:06:23'),
(1440, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 377, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"due_date\":\"2025-12-22T00:00:00.000000Z\",\"amount\":\"375000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(1441, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 378, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"due_date\":\"2026-01-22T00:00:00.000000Z\",\"amount\":\"375000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(1442, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 379, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"due_date\":\"2026-02-22T00:00:00.000000Z\",\"amount\":\"375000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(1443, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 380, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"due_date\":\"2026-03-22T00:00:00.000000Z\",\"amount\":\"375000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(1444, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 381, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"due_date\":\"2026-04-22T00:00:00.000000Z\",\"amount\":\"375000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(1445, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 382, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"due_date\":\"2026-05-22T00:00:00.000000Z\",\"amount\":\"375000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(1446, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 383, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"due_date\":\"2026-06-22T00:00:00.000000Z\",\"amount\":\"375000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(1447, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 384, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"due_date\":\"2026-07-22T00:00:00.000000Z\",\"amount\":\"375000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(1448, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 385, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"due_date\":\"2026-08-22T00:00:00.000000Z\",\"amount\":\"375000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(1449, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 386, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"due_date\":\"2026-09-22T00:00:00.000000Z\",\"amount\":\"375000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(1450, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 387, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"due_date\":\"2026-10-22T00:00:00.000000Z\",\"amount\":\"375000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(1451, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 388, 'App\\Models\\User', 83, '{\"attributes\":{\"sales_order_id\":51,\"due_date\":\"2026-11-22T00:00:00.000000Z\",\"amount\":\"375000.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(1452, 'audit', 'created', 'created', 'App\\Models\\Employee', 45, 'App\\Models\\User', 10, '{\"attributes\":{\"user_id\":88,\"branch_id\":2,\"agent_id\":null,\"superior_id\":12,\"employee_code\":\"EMP-Q76CXH\",\"rank\":\"ME\",\"full_name_en\":\"ABDULLAH\",\"full_name_bn\":\"ABDULLAH\",\"father_name\":\"Kamrul Chowdhury\",\"mother_name\":\"Aysas\",\"mobile\":\"019991231312\",\"national_id\":\"123213213\",\"date_of_birth\":\"1998-05-02T00:00:00.000000Z\",\"marital_status\":\"Single\",\"religion\":null,\"gender\":null,\"nationality\":null,\"district\":\"Chittagong\",\"upazila\":\"fdsfds\",\"present_address\":\"300\\/A, North Sahajanpur,Dhaka\",\"permanent_address\":null,\"post_code\":\"12313\"}}', NULL, '2025-12-22 16:20:56', '2025-12-22 16:20:56'),
(1453, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"down_payment\":\"6\",\"installment\":1}},\"old\":{\"value\":{\"down_payment\":\"5\",\"installment\":1}}}', NULL, '2025-12-22 17:41:20', '2025-12-22 17:41:20'),
(1454, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"down_payment\":\"6\",\"installment\":\"2\"}},\"old\":{\"value\":{\"down_payment\":\"6\",\"installment\":1}}}', NULL, '2025-12-22 17:41:36', '2025-12-22 17:41:36'),
(1455, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 2, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"down_payment\":\"5\",\"installment\":\"1\"}},\"old\":{\"value\":{\"down_payment\":\"6\",\"installment\":\"2\"}}}', NULL, '2025-12-22 17:41:44', '2025-12-22 17:41:44'),
(1456, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"DM\":{\"share_target\":\"6\",\"gm_target\":\"3\"},\"AMD\":{\"share_target\":\"8\",\"gm_target\":\"3\"},\"DMD\":{\"share_target\":\"8\",\"gm_target\":\"4\"},\"DIR\":{\"share_target\":\"8\",\"gm_target\":\"5\"}}},\"old\":{\"value\":{\"DM\":{\"share_target\":\"6\",\"gm_target\":\"2\"},\"AMD\":{\"share_target\":\"8\",\"gm_target\":\"3\"},\"DMD\":{\"share_target\":\"8\",\"gm_target\":\"4\"},\"DIR\":{\"share_target\":\"8\",\"gm_target\":\"5\"}}}}', NULL, '2025-12-22 17:42:22', '2025-12-22 17:42:22'),
(1457, 'audit', 'updated', 'updated', 'App\\Models\\CommissionSetting', 12, 'App\\Models\\User', 10, '{\"attributes\":{\"value\":{\"DM\":{\"share_target\":\"6\",\"gm_target\":\"2\"},\"AMD\":{\"share_target\":\"8\",\"gm_target\":\"3\"},\"DMD\":{\"share_target\":\"8\",\"gm_target\":\"4\"},\"DIR\":{\"share_target\":\"8\",\"gm_target\":\"5\"}}},\"old\":{\"value\":{\"DM\":{\"share_target\":\"6\",\"gm_target\":\"3\"},\"AMD\":{\"share_target\":\"8\",\"gm_target\":\"3\"},\"DMD\":{\"share_target\":\"8\",\"gm_target\":\"4\"},\"DIR\":{\"share_target\":\"8\",\"gm_target\":\"5\"}}}}', NULL, '2025-12-22 17:42:28', '2025-12-22 17:42:28'),
(1458, 'audit', 'updated', 'updated', 'App\\Models\\RankRequirement', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"meta\":{\"shares_required\":4,\"minimum_share_per_period\":1,\"period_months\":4,\"monthly_incentive\":20000}},\"old\":{\"meta\":{\"shares_required\":5,\"minimum_share_per_period\":1,\"period_months\":4,\"monthly_incentive\":20000}}}', NULL, '2025-12-22 17:44:27', '2025-12-22 17:44:27'),
(1459, 'audit', 'updated', 'updated', 'App\\Models\\RankRequirement', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"meta\":{\"shares_required\":4,\"minimum_share_per_period\":1,\"period_months\":5,\"monthly_incentive\":20000}},\"old\":{\"meta\":{\"shares_required\":4,\"minimum_share_per_period\":1,\"period_months\":4,\"monthly_incentive\":20000}}}', NULL, '2025-12-22 17:44:33', '2025-12-22 17:44:33'),
(1460, 'audit', 'updated', 'updated', 'App\\Models\\RankRequirement', 3, 'App\\Models\\User', 10, '{\"attributes\":{\"meta\":{\"shares_required\":5,\"minimum_share_per_period\":1,\"period_months\":5,\"monthly_incentive\":20000}},\"old\":{\"meta\":{\"shares_required\":4,\"minimum_share_per_period\":1,\"period_months\":5,\"monthly_incentive\":20000}}}', NULL, '2025-12-22 17:44:47', '2025-12-22 17:44:47'),
(1461, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 52, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":89,\"employee_id\":12,\"source_me_id\":12,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"GM\",\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-22 18:26:49', '2025-12-22 18:26:49'),
(1462, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 52, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-22 18:26:49', '2025-12-22 18:26:49'),
(1463, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 389, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"due_date\":\"2025-12-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(1464, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 390, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"due_date\":\"2026-01-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(1465, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 391, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"due_date\":\"2026-02-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(1466, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 392, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"due_date\":\"2026-03-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(1467, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 393, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"due_date\":\"2026-04-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(1468, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 394, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"due_date\":\"2026-05-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(1469, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 395, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"due_date\":\"2026-06-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(1470, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 396, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"due_date\":\"2026-07-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(1471, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 397, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"due_date\":\"2026-08-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(1472, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 398, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"due_date\":\"2026-09-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(1473, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 399, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"due_date\":\"2026-10-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(1474, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 400, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"due_date\":\"2026-11-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(1475, 'audit', 'created', 'created', 'App\\Models\\Journal', 67, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-53\",\"description\":null,\"occurred_at\":\"2025-12-22T00:00:00.000000Z\",\"meta\":{\"payment_id\":53,\"sales_order_id\":52,\"method\":\"cash\"}}}', NULL, '2025-12-22 18:27:16', '2025-12-22 18:27:16'),
(1476, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 331, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":67,\"tx_id\":\"PMT-53\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T00:00:00.000000Z\",\"meta\":{\"payment_id\":53,\"sales_order_id\":52,\"method\":\"cash\"}}}', NULL, '2025-12-22 18:27:16', '2025-12-22 18:27:16'),
(1477, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 332, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":67,\"tx_id\":\"PMT-53\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-12-22T00:00:00.000000Z\",\"meta\":{\"payment_id\":53,\"sales_order_id\":52,\"method\":\"cash\"}}}', NULL, '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(1478, 'audit', 'created', 'created', 'App\\Models\\Commission', 15, 'App\\Models\\User', 52, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":53,\"sales_order_id\":52,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"2250.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-22T18:27:17.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"order_created_by\":\"agent\",\"source_me_id\":12}}}', NULL, '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(1479, 'audit', 'created', 'created', 'App\\Models\\Journal', 68, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"CMS-15\",\"description\":null,\"occurred_at\":\"2025-12-22T18:27:17.000000Z\",\"meta\":{\"commission_id\":15,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(1480, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 333, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":68,\"tx_id\":\"CMS-15\",\"account_id\":4,\"debit\":\"2250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T18:27:17.000000Z\",\"meta\":{\"commission_id\":15,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(1481, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 334, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":68,\"tx_id\":\"CMS-15\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2250.00\",\"occurred_at\":\"2025-12-22T18:27:17.000000Z\",\"meta\":{\"commission_id\":15,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(1482, 'audit', 'created', 'created', 'App\\Models\\Payment', 53, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":52,\"paid_at\":\"2025-12-22T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"45000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"123213213\"}}}', NULL, '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(1483, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 39, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":53,\"customer_installment_id\":389,\"allocated\":\"0.00\"}}', NULL, '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(1484, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 389, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(1485, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 53, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":53,\"employee_id\":null,\"source_me_id\":null,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":null,\"introducer_id\":null,\"down_payment\":\"50000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-22 18:32:33', '2025-12-22 18:32:33'),
(1486, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 53, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-22 18:32:33', '2025-12-22 18:32:33'),
(1487, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 401, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"due_date\":\"2025-12-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(1488, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 402, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"due_date\":\"2026-01-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(1489, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 403, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"due_date\":\"2026-02-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(1490, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 404, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"due_date\":\"2026-03-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(1491, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 405, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"due_date\":\"2026-04-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(1492, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 406, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"due_date\":\"2026-05-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(1493, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 407, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"due_date\":\"2026-06-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(1494, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 408, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"due_date\":\"2026-07-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(1495, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 409, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"due_date\":\"2026-08-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(1496, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 410, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"due_date\":\"2026-09-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(1497, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 411, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"due_date\":\"2026-10-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(1498, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 412, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"due_date\":\"2026-11-27T00:00:00.000000Z\",\"amount\":\"412500.00\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(1499, 'audit', 'created', 'created', 'App\\Models\\Journal', 69, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-54\",\"description\":null,\"occurred_at\":\"2025-12-22T00:00:00.000000Z\",\"meta\":{\"payment_id\":54,\"sales_order_id\":53,\"method\":\"cash\"}}}', NULL, '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(1500, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 335, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":69,\"tx_id\":\"PMT-54\",\"account_id\":1,\"debit\":\"50000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T00:00:00.000000Z\",\"meta\":{\"payment_id\":54,\"sales_order_id\":53,\"method\":\"cash\"}}}', NULL, '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(1501, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 336, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":69,\"tx_id\":\"PMT-54\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"50000.00\",\"occurred_at\":\"2025-12-22T00:00:00.000000Z\",\"meta\":{\"payment_id\":54,\"sales_order_id\":53,\"method\":\"cash\"}}}', NULL, '2025-12-22 18:33:48', '2025-12-22 18:33:48');
INSERT INTO `activity_log` (`id`, `log_name`, `event`, `description`, `subject_type`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(1502, 'audit', 'created', 'created', 'App\\Models\\Commission', 16, 'App\\Models\\User', 52, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":54,\"sales_order_id\":53,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"2250.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-22T18:33:48.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"order_created_by\":\"agent\"}}}', NULL, '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(1503, 'audit', 'created', 'created', 'App\\Models\\Journal', 70, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"CMS-16\",\"description\":null,\"occurred_at\":\"2025-12-22T18:33:48.000000Z\",\"meta\":{\"commission_id\":16,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(1504, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 337, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":70,\"tx_id\":\"CMS-16\",\"account_id\":4,\"debit\":\"2250.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T18:33:48.000000Z\",\"meta\":{\"commission_id\":16,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(1505, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 338, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":70,\"tx_id\":\"CMS-16\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"2250.00\",\"occurred_at\":\"2025-12-22T18:33:48.000000Z\",\"meta\":{\"commission_id\":16,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(1506, 'audit', 'created', 'created', 'App\\Models\\Payment', 54, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":53,\"paid_at\":\"2025-12-22T00:00:00.000000Z\",\"amount\":\"50000.00\",\"commission_base_amount\":\"45000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"21212\"}}}', NULL, '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(1507, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 40, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":54,\"customer_installment_id\":401,\"allocated\":\"0.00\"}}', NULL, '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(1508, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 401, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(1509, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 54, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":89,\"employee_id\":12,\"source_me_id\":12,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"GM\",\"introducer_id\":null,\"down_payment\":\"100000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-22 18:36:32', '2025-12-22 18:36:32'),
(1510, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 54, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-22 18:36:32', '2025-12-22 18:36:32'),
(1511, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 413, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"due_date\":\"2025-12-27T00:00:00.000000Z\",\"amount\":\"408333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(1512, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 414, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"due_date\":\"2026-01-27T00:00:00.000000Z\",\"amount\":\"408333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(1513, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 415, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"due_date\":\"2026-02-27T00:00:00.000000Z\",\"amount\":\"408333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(1514, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 416, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"due_date\":\"2026-03-27T00:00:00.000000Z\",\"amount\":\"408333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(1515, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 417, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"due_date\":\"2026-04-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(1516, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 418, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"due_date\":\"2026-05-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(1517, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 419, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"due_date\":\"2026-06-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(1518, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 420, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"due_date\":\"2026-07-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(1519, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 421, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"due_date\":\"2026-08-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(1520, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 422, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"due_date\":\"2026-09-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(1521, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 423, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"due_date\":\"2026-10-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(1522, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 424, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"due_date\":\"2026-11-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(1523, 'audit', 'created', 'created', 'App\\Models\\Journal', 71, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-55\",\"description\":null,\"occurred_at\":\"2025-12-22T00:00:00.000000Z\",\"meta\":{\"payment_id\":55,\"sales_order_id\":54,\"method\":\"cash\"}}}', NULL, '2025-12-22 18:36:43', '2025-12-22 18:36:43'),
(1524, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 339, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":71,\"tx_id\":\"PMT-55\",\"account_id\":1,\"debit\":\"100000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T00:00:00.000000Z\",\"meta\":{\"payment_id\":55,\"sales_order_id\":54,\"method\":\"cash\"}}}', NULL, '2025-12-22 18:36:43', '2025-12-22 18:36:43'),
(1525, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 340, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":71,\"tx_id\":\"PMT-55\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"100000.00\",\"occurred_at\":\"2025-12-22T00:00:00.000000Z\",\"meta\":{\"payment_id\":55,\"sales_order_id\":54,\"method\":\"cash\"}}}', NULL, '2025-12-22 18:36:43', '2025-12-22 18:36:43'),
(1526, 'audit', 'created', 'created', 'App\\Models\\Payment', 55, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":54,\"paid_at\":\"2025-12-22T00:00:00.000000Z\",\"amount\":\"100000.00\",\"commission_base_amount\":\"90000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"21313213\"}}}', NULL, '2025-12-22 18:36:43', '2025-12-22 18:36:43'),
(1527, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 41, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":55,\"customer_installment_id\":413,\"allocated\":\"0.00\"}}', NULL, '2025-12-22 18:36:43', '2025-12-22 18:36:43'),
(1528, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 413, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-22 18:36:43', '2025-12-22 18:36:43'),
(1529, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 55, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":89,\"employee_id\":17,\"source_me_id\":17,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"ME\",\"introducer_id\":null,\"down_payment\":\"100000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-22 18:44:04', '2025-12-22 18:44:04'),
(1530, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 55, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-22 18:44:04', '2025-12-22 18:44:04'),
(1531, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 425, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"due_date\":\"2025-12-27T00:00:00.000000Z\",\"amount\":\"408333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(1532, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 426, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"due_date\":\"2026-01-27T00:00:00.000000Z\",\"amount\":\"408333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(1533, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 427, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"due_date\":\"2026-02-27T00:00:00.000000Z\",\"amount\":\"408333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(1534, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 428, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"due_date\":\"2026-03-27T00:00:00.000000Z\",\"amount\":\"408333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(1535, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 429, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"due_date\":\"2026-04-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(1536, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 430, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"due_date\":\"2026-05-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(1537, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 431, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"due_date\":\"2026-06-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(1538, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 432, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"due_date\":\"2026-07-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(1539, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 433, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"due_date\":\"2026-08-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(1540, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 434, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"due_date\":\"2026-09-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(1541, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 435, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"due_date\":\"2026-10-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(1542, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 436, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"due_date\":\"2026-11-27T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(1543, 'audit', 'created', 'created', 'App\\Models\\Journal', 72, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-56\",\"description\":null,\"occurred_at\":\"2025-12-22T00:00:00.000000Z\",\"meta\":{\"payment_id\":56,\"sales_order_id\":55,\"method\":\"cash\"}}}', NULL, '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(1544, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 341, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":72,\"tx_id\":\"PMT-56\",\"account_id\":1,\"debit\":\"100000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T00:00:00.000000Z\",\"meta\":{\"payment_id\":56,\"sales_order_id\":55,\"method\":\"cash\"}}}', NULL, '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(1545, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 342, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":72,\"tx_id\":\"PMT-56\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"100000.00\",\"occurred_at\":\"2025-12-22T00:00:00.000000Z\",\"meta\":{\"payment_id\":56,\"sales_order_id\":55,\"method\":\"cash\"}}}', NULL, '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(1546, 'audit', 'updated', 'updated', 'App\\Models\\Employee', 16, 'App\\Models\\User', 52, '{\"attributes\":{\"rank\":\"AGM\"},\"old\":{\"rank\":\"MM\"}}', NULL, '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(1547, 'audit', 'created', 'created', 'App\\Models\\Payment', 56, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":55,\"paid_at\":\"2025-12-22T00:00:00.000000Z\",\"amount\":\"100000.00\",\"commission_base_amount\":\"90000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"213213123\"}}}', NULL, '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(1548, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 42, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":56,\"customer_installment_id\":425,\"allocated\":\"0.00\"}}', NULL, '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(1549, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 425, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(1550, 'audit', 'created', 'created', 'App\\Models\\Commission', 17, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":53,\"sales_order_id\":52,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"13500.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":30,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":14,\"calculation_item_id\":15,\"order_created_by\":\"agent\",\"source_me_id\":12}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1551, 'audit', 'created', 'created', 'App\\Models\\Journal', 73, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-17\",\"description\":null,\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":17,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1552, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 343, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":73,\"tx_id\":\"CMS-17\",\"account_id\":4,\"debit\":\"13500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":17,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1553, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 344, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":73,\"tx_id\":\"CMS-17\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"13500.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":17,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1554, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 53, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-22T18:45:22.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1555, 'audit', 'created', 'created', 'App\\Models\\Commission', 18, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":55,\"sales_order_id\":54,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"4500.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":15,\"calculation_item_id\":16,\"order_created_by\":\"agent\",\"source_me_id\":12}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1556, 'audit', 'created', 'created', 'App\\Models\\Journal', 74, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-18\",\"description\":null,\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":18,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1557, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 345, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":74,\"tx_id\":\"CMS-18\",\"account_id\":4,\"debit\":\"4500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":18,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1558, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 346, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":74,\"tx_id\":\"CMS-18\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"4500.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":18,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1559, 'audit', 'created', 'created', 'App\\Models\\Commission', 19, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":55,\"sales_order_id\":54,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"27000.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":30,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":15,\"calculation_item_id\":17,\"order_created_by\":\"agent\",\"source_me_id\":12}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1560, 'audit', 'created', 'created', 'App\\Models\\Journal', 75, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-19\",\"description\":null,\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":19,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1561, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 347, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":75,\"tx_id\":\"CMS-19\",\"account_id\":4,\"debit\":\"27000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":19,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1562, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 348, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":75,\"tx_id\":\"CMS-19\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"27000.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":19,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1563, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 55, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-22T18:45:22.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1564, 'audit', 'created', 'created', 'App\\Models\\Commission', 20, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":56,\"sales_order_id\":55,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"4500.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":16,\"calculation_item_id\":18,\"order_created_by\":\"agent\",\"source_me_id\":17}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1565, 'audit', 'created', 'created', 'App\\Models\\Journal', 76, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-20\",\"description\":null,\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":20,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1566, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 349, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":76,\"tx_id\":\"CMS-20\",\"account_id\":4,\"debit\":\"4500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":20,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1567, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 350, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":76,\"tx_id\":\"CMS-20\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"4500.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":20,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1568, 'audit', 'created', 'created', 'App\\Models\\Commission', 21, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":56,\"sales_order_id\":55,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":17,\"amount\":\"10800.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":12,\"recipient_name\":\"ABDULLAH\",\"calculation_unit_id\":16,\"calculation_item_id\":19,\"order_created_by\":\"agent\",\"source_me_id\":17}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1569, 'audit', 'created', 'created', 'App\\Models\\Journal', 77, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-21\",\"description\":null,\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":21,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":17}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1570, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 351, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":77,\"tx_id\":\"CMS-21\",\"account_id\":4,\"debit\":\"10800.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":21,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":17}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1571, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 352, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":77,\"tx_id\":\"CMS-21\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"10800.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":21,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":17}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1572, 'audit', 'created', 'created', 'App\\Models\\Commission', 22, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":56,\"sales_order_id\":55,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"amount\":\"9000.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"AGM\",\"payment_type\":\"down_payment\",\"percentage\":10,\"recipient_name\":\"JAKARIA\",\"calculation_unit_id\":16,\"calculation_item_id\":20,\"order_created_by\":\"agent\",\"source_me_id\":17}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1573, 'audit', 'created', 'created', 'App\\Models\\Journal', 78, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-22\",\"description\":null,\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":22,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1574, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 353, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":78,\"tx_id\":\"CMS-22\",\"account_id\":4,\"debit\":\"9000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":22,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1575, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 354, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":78,\"tx_id\":\"CMS-22\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"9000.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":22,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1576, 'audit', 'created', 'created', 'App\\Models\\Commission', 23, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":56,\"sales_order_id\":55,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13,\"amount\":\"3600.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"DGM\",\"payment_type\":\"down_payment\",\"percentage\":4,\"recipient_name\":\"SAKIL AL\",\"calculation_unit_id\":16,\"calculation_item_id\":21,\"order_created_by\":\"agent\",\"source_me_id\":17}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1577, 'audit', 'created', 'created', 'App\\Models\\Journal', 79, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-23\",\"description\":null,\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":23,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1578, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 355, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":79,\"tx_id\":\"CMS-23\",\"account_id\":4,\"debit\":\"3600.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":23,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1579, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 356, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":79,\"tx_id\":\"CMS-23\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"3600.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":23,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1580, 'audit', 'created', 'created', 'App\\Models\\Commission', 24, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":56,\"sales_order_id\":55,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"3600.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":4,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":16,\"calculation_item_id\":22,\"order_created_by\":\"agent\",\"source_me_id\":17}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1581, 'audit', 'created', 'created', 'App\\Models\\Journal', 80, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-24\",\"description\":null,\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":24,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1582, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 357, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":80,\"tx_id\":\"CMS-24\",\"account_id\":4,\"debit\":\"3600.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":24,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1583, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 358, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":80,\"tx_id\":\"CMS-24\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"3600.00\",\"occurred_at\":\"2025-12-22T18:45:22.000000Z\",\"meta\":{\"commission_id\":24,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(1584, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 56, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-22T18:45:22.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-22 18:45:23', '2025-12-22 18:45:23'),
(1585, 'audit', 'created', 'created', 'App\\Models\\SalesOrder', 56, 'App\\Models\\User', 52, '{\"attributes\":{\"customer_id\":96,\"employee_id\":12,\"source_me_id\":12,\"agent_id\":6,\"branch_id\":2,\"sales_type\":\"order\",\"rank\":\"GM\",\"introducer_id\":null,\"down_payment\":\"100000.00\",\"total\":\"5000000.00\",\"status\":\"active\",\"created_by\":\"agent\"}}', NULL, '2025-12-23 04:27:39', '2025-12-23 04:27:39'),
(1586, 'audit', 'created', 'created', 'App\\Models\\OrderItem', 56, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"itemable_id\":1,\"itemable_type\":\"App\\\\Models\\\\Product\",\"qty\":1,\"unit_price\":\"5000000.00\",\"line_total\":\"5000000.00\"}}', NULL, '2025-12-23 04:27:39', '2025-12-23 04:27:39'),
(1587, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 437, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"due_date\":\"2025-12-28T00:00:00.000000Z\",\"amount\":\"408333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(1588, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 438, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"due_date\":\"2026-01-28T00:00:00.000000Z\",\"amount\":\"408333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(1589, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 439, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"due_date\":\"2026-02-28T00:00:00.000000Z\",\"amount\":\"408333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(1590, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 440, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"due_date\":\"2026-03-28T00:00:00.000000Z\",\"amount\":\"408333.34\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(1591, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 441, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"due_date\":\"2026-04-28T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(1592, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 442, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"due_date\":\"2026-05-28T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(1593, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 443, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"due_date\":\"2026-06-28T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(1594, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 444, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"due_date\":\"2026-07-28T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(1595, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 445, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"due_date\":\"2026-08-28T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(1596, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 446, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"due_date\":\"2026-09-28T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(1597, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 447, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"due_date\":\"2026-10-28T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(1598, 'audit', 'created', 'created', 'App\\Models\\CustomerInstallment', 448, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"due_date\":\"2026-11-28T00:00:00.000000Z\",\"amount\":\"408333.33\",\"paid\":\"0.00\",\"status\":\"due\"}}', NULL, '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(1599, 'audit', 'created', 'created', 'App\\Models\\Journal', 81, 'App\\Models\\User', 52, '{\"attributes\":{\"tx_id\":\"PMT-57\",\"description\":null,\"occurred_at\":\"2025-12-23T00:00:00.000000Z\",\"meta\":{\"payment_id\":57,\"sales_order_id\":56,\"method\":\"cash\"}}}', NULL, '2025-12-23 04:27:57', '2025-12-23 04:27:57'),
(1600, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 359, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":81,\"tx_id\":\"PMT-57\",\"account_id\":1,\"debit\":\"100000.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-23T00:00:00.000000Z\",\"meta\":{\"payment_id\":57,\"sales_order_id\":56,\"method\":\"cash\"}}}', NULL, '2025-12-23 04:27:57', '2025-12-23 04:27:57'),
(1601, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 360, 'App\\Models\\User', 52, '{\"attributes\":{\"journal_id\":81,\"tx_id\":\"PMT-57\",\"account_id\":3,\"debit\":\"0.00\",\"credit\":\"100000.00\",\"occurred_at\":\"2025-12-23T00:00:00.000000Z\",\"meta\":{\"payment_id\":57,\"sales_order_id\":56,\"method\":\"cash\"}}}', NULL, '2025-12-23 04:27:57', '2025-12-23 04:27:57'),
(1602, 'audit', 'updated', 'updated', 'App\\Models\\Employee', 12, 'App\\Models\\User', 52, '{\"attributes\":{\"rank\":\"MM\"},\"old\":{\"rank\":\"GM\"}}', NULL, '2025-12-23 04:27:57', '2025-12-23 04:27:57'),
(1603, 'audit', 'created', 'created', 'App\\Models\\Payment', 57, 'App\\Models\\User', 52, '{\"attributes\":{\"sales_order_id\":56,\"paid_at\":\"2025-12-23T00:00:00.000000Z\",\"amount\":\"100000.00\",\"commission_base_amount\":\"90000.00\",\"commission_processed_at\":null,\"type\":\"down_payment\",\"intent_type\":\"down_payment\",\"method\":\"cash\",\"meta\":{\"reference\":\"11111\"}}}', NULL, '2025-12-23 04:27:57', '2025-12-23 04:27:57'),
(1604, 'audit', 'created', 'created', 'App\\Models\\PaymentAllocation', 43, 'App\\Models\\User', 52, '{\"attributes\":{\"payment_id\":57,\"customer_installment_id\":437,\"allocated\":\"0.00\"}}', NULL, '2025-12-23 04:27:57', '2025-12-23 04:27:57'),
(1605, 'audit', 'updated', 'updated', 'App\\Models\\CustomerInstallment', 437, 'App\\Models\\User', 52, '{\"attributes\":{\"status\":\"partial\"},\"old\":{\"status\":\"due\"}}', NULL, '2025-12-23 04:27:57', '2025-12-23 04:27:57'),
(1606, 'audit', 'created', 'created', 'App\\Models\\Commission', 25, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":57,\"sales_order_id\":56,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6,\"amount\":\"4500.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-23T04:29:13.000000Z\",\"meta\":{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":17,\"calculation_item_id\":23,\"order_created_by\":\"agent\",\"source_me_id\":12}}}', NULL, '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(1607, 'audit', 'created', 'created', 'App\\Models\\Journal', 82, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-25\",\"description\":null,\"occurred_at\":\"2025-12-23T04:29:13.000000Z\",\"meta\":{\"commission_id\":25,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(1608, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 361, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":82,\"tx_id\":\"CMS-25\",\"account_id\":4,\"debit\":\"4500.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-23T04:29:13.000000Z\",\"meta\":{\"commission_id\":25,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(1609, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 362, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":82,\"tx_id\":\"CMS-25\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"4500.00\",\"occurred_at\":\"2025-12-23T04:29:13.000000Z\",\"meta\":{\"commission_id\":25,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}}}', NULL, '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(1610, 'audit', 'created', 'created', 'App\\Models\\Commission', 26, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_rule_id\":null,\"payment_id\":57,\"sales_order_id\":56,\"category\":\"general\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12,\"amount\":\"15300.00\",\"status\":\"paid\",\"paid_at\":\"2025-12-23T04:29:13.000000Z\",\"meta\":{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":17,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":17,\"calculation_item_id\":24,\"order_created_by\":\"agent\",\"source_me_id\":12}}}', NULL, '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(1611, 'audit', 'created', 'created', 'App\\Models\\Journal', 83, 'App\\Models\\User', 10, '{\"attributes\":{\"tx_id\":\"CMS-26\",\"description\":null,\"occurred_at\":\"2025-12-23T04:29:13.000000Z\",\"meta\":{\"commission_id\":26,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(1612, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 363, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":83,\"tx_id\":\"CMS-26\",\"account_id\":4,\"debit\":\"15300.00\",\"credit\":\"0.00\",\"occurred_at\":\"2025-12-23T04:29:13.000000Z\",\"meta\":{\"commission_id\":26,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(1613, 'audit', 'created', 'created', 'App\\Models\\LedgerEntry', 364, 'App\\Models\\User', 10, '{\"attributes\":{\"journal_id\":83,\"tx_id\":\"CMS-26\",\"account_id\":5,\"debit\":\"0.00\",\"credit\":\"15300.00\",\"occurred_at\":\"2025-12-23T04:29:13.000000Z\",\"meta\":{\"commission_id\":26,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}}}', NULL, '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(1614, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 57, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-12-23T04:29:13.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-12-23 04:29:13', '2025-12-23 04:29:13');

-- --------------------------------------------------------

--
-- Table structure for table `agents`
--

CREATE TABLE `agents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `agent_code` varchar(255) NOT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `agents`
--

INSERT INTO `agents` (`id`, `user_id`, `branch_id`, `agent_code`, `mobile`, `address`, `created_at`, `updated_at`) VALUES
(6, 52, 2, 'AGT-0001', '01999070234', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-04 16:35:54', '2025-11-04 16:35:54'),
(7, 80, 1, 'AG-1002', '+880123456789', 'House 10, Road 12, Dhaka', '2025-12-10 18:03:20', '2025-12-10 18:03:20'),
(8, 83, 2, 'AGT-0002', '23456', 'sdf', '2025-12-11 17:56:59', '2025-12-11 17:56:59');

-- --------------------------------------------------------

--
-- Table structure for table `agent_wallets`
--

CREATE TABLE `agent_wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `agent_id` bigint(20) UNSIGNED NOT NULL,
  `balance` decimal(14,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `agent_wallets`
--

INSERT INTO `agent_wallets` (`id`, `agent_id`, `balance`, `created_at`, `updated_at`) VALUES
(1, 6, 70396.25, '2025-11-05 06:12:33', '2025-12-23 04:29:13'),
(2, 7, 46800.00, '2025-12-10 18:04:24', '2025-12-10 18:21:21'),
(3, 8, 82800.00, '2025-12-11 18:00:26', '2025-12-11 19:45:39');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `code`, `address`, `created_at`, `updated_at`) VALUES
(1, 'Dhaka Head Office', 'DHK-HQ', 'Level 12, Al-Hamra Tower, Gulshan-2, Dhaka', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(2, 'Chattogram Central', 'CTG-CEN', 'Bayazid Bostami Road, Chattogram', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(3, 'Sylhet Hill View', 'SYL-HILL', 'Zindabazar, Sylhet', '2025-10-20 13:59:03', '2025-10-20 13:59:03');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('product','service') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `type`, `created_at`, `updated_at`) VALUES
(1, 'Land & Plot', 'product', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(2, 'Residential Apartment', 'product', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(3, 'Construction Material', 'product', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(4, 'Share Investment', 'product', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(5, 'Hospitality Service', 'service', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(6, 'Healthcare Service', 'service', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(7, 'Transport Logistics', 'service', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(8, 'Hajj & Umrah Package', 'service', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(9, 'Tourism Package', 'service', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(10, 'flat', 'product', '2025-10-31 17:38:04', '2025-10-31 17:38:04');

-- --------------------------------------------------------

--
-- Table structure for table `commissions`
--

CREATE TABLE `commissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `commission_rule_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sales_order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `category` varchar(255) NOT NULL DEFAULT 'general',
  `recipient_type` varchar(255) NOT NULL,
  `recipient_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` decimal(14,2) NOT NULL,
  `status` enum('unpaid','paid') NOT NULL DEFAULT 'unpaid',
  `paid_at` timestamp NULL DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `commissions`
--

INSERT INTO `commissions` (`id`, `commission_rule_id`, `payment_id`, `sales_order_id`, `category`, `recipient_type`, `recipient_id`, `amount`, `status`, `paid_at`, `meta`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, 'general', 'App\\Models\\Agent', 6, 45000.00, 'paid', '2025-12-10 16:59:33', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":1,\"calculation_item_id\":1,\"order_created_by\":\"agent\"}', '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(2, NULL, NULL, NULL, 'general', 'App\\Models\\Agent', 6, 3000.00, 'paid', '2025-12-10 16:59:33', '{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":2,\"calculation_item_id\":2,\"order_created_by\":\"agent\"}', '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(3, NULL, 42, 36, 'general', 'App\\Models\\Employee', 19, 6000.00, 'paid', '2025-12-10 17:30:54', '{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":3,\"calculation_item_id\":3,\"order_created_by\":\"admin\",\"source_me_id\":19}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(4, NULL, 42, 36, 'general', 'App\\Models\\Employee', 12, 6000.00, 'paid', '2025-12-10 17:30:54', '{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":3,\"calculation_item_id\":4,\"order_created_by\":\"admin\",\"source_me_id\":19}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(5, NULL, 43, 41, 'general', 'App\\Models\\Agent', 6, 1750.00, 'paid', '2025-12-10 17:30:54', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":4,\"calculation_item_id\":5,\"order_created_by\":\"agent\"}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(6, NULL, 44, 41, 'general', 'App\\Models\\Agent', 6, 2887.50, 'paid', '2025-12-10 17:30:54', '{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":5,\"calculation_item_id\":6,\"order_created_by\":\"agent\"}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(7, NULL, 45, 44, 'general', 'App\\Models\\Agent', 6, 225.00, 'paid', '2025-12-10 18:21:21', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":6,\"calculation_item_id\":7,\"order_created_by\":\"agent\"}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(8, NULL, 46, 44, 'general', 'App\\Models\\Agent', 6, 33.75, 'paid', '2025-12-10 18:21:21', '{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":7,\"calculation_item_id\":8,\"order_created_by\":\"agent\"}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(9, NULL, 47, 45, 'general', 'App\\Models\\Agent', 7, 45000.00, 'paid', '2025-12-10 18:21:21', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"Liton\",\"calculation_unit_id\":8,\"calculation_item_id\":9,\"order_created_by\":\"agent\"}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(10, NULL, 48, 45, 'general', 'App\\Models\\Agent', 7, 1800.00, 'paid', '2025-12-10 18:21:21', '{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"Liton\",\"calculation_unit_id\":9,\"calculation_item_id\":10,\"order_created_by\":\"agent\"}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(11, NULL, NULL, NULL, 'general', 'App\\Models\\Agent', 8, 1400.00, 'paid', '2025-12-11 18:20:19', '{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"fusion\",\"calculation_unit_id\":10,\"calculation_item_id\":11,\"order_created_by\":\"agent\"}', '2025-12-11 18:20:19', '2025-12-11 18:20:19'),
(12, NULL, 50, 48, 'general', 'App\\Models\\Agent', 8, 35000.00, 'paid', '2025-12-11 19:45:39', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"fusion\",\"calculation_unit_id\":11,\"calculation_item_id\":12,\"order_created_by\":\"agent\"}', '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(13, NULL, 51, 48, 'general', 'App\\Models\\Agent', 8, 1400.00, 'paid', '2025-12-11 19:45:39', '{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"fusion\",\"calculation_unit_id\":12,\"calculation_item_id\":13,\"order_created_by\":\"agent\"}', '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(14, NULL, 52, 50, 'general', 'App\\Models\\Agent', 8, 45000.00, 'paid', '2025-12-11 19:45:39', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"fusion\",\"calculation_unit_id\":13,\"calculation_item_id\":14,\"order_created_by\":\"agent\"}', '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(15, NULL, 53, 52, 'general', 'App\\Models\\Agent', 6, 2250.00, 'paid', '2025-12-22 18:27:17', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"order_created_by\":\"agent\",\"source_me_id\":12}', '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(16, NULL, 54, 53, 'general', 'App\\Models\\Agent', 6, 2250.00, 'paid', '2025-12-22 18:33:48', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"order_created_by\":\"agent\"}', '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(17, NULL, 53, 52, 'general', 'App\\Models\\Employee', 12, 13500.00, 'paid', '2025-12-22 18:45:22', '{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":30,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":14,\"calculation_item_id\":15,\"order_created_by\":\"agent\",\"source_me_id\":12}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(18, NULL, 55, 54, 'general', 'App\\Models\\Agent', 6, 4500.00, 'paid', '2025-12-22 18:45:22', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":15,\"calculation_item_id\":16,\"order_created_by\":\"agent\",\"source_me_id\":12}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(19, NULL, 55, 54, 'general', 'App\\Models\\Employee', 12, 27000.00, 'paid', '2025-12-22 18:45:22', '{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":30,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":15,\"calculation_item_id\":17,\"order_created_by\":\"agent\",\"source_me_id\":12}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(20, NULL, 56, 55, 'general', 'App\\Models\\Agent', 6, 4500.00, 'paid', '2025-12-22 18:45:22', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":16,\"calculation_item_id\":18,\"order_created_by\":\"agent\",\"source_me_id\":17}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(21, NULL, 56, 55, 'general', 'App\\Models\\Employee', 17, 10800.00, 'paid', '2025-12-22 18:45:22', '{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":12,\"recipient_name\":\"ABDULLAH\",\"calculation_unit_id\":16,\"calculation_item_id\":19,\"order_created_by\":\"agent\",\"source_me_id\":17}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(22, NULL, 56, 55, 'general', 'App\\Models\\Employee', 16, 9000.00, 'paid', '2025-12-22 18:45:22', '{\"category\":\"development_bonus\",\"rank\":\"AGM\",\"payment_type\":\"down_payment\",\"percentage\":10,\"recipient_name\":\"JAKARIA\",\"calculation_unit_id\":16,\"calculation_item_id\":20,\"order_created_by\":\"agent\",\"source_me_id\":17}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(23, NULL, 56, 55, 'general', 'App\\Models\\Employee', 13, 3600.00, 'paid', '2025-12-22 18:45:22', '{\"category\":\"development_bonus\",\"rank\":\"DGM\",\"payment_type\":\"down_payment\",\"percentage\":4,\"recipient_name\":\"SAKIL AL\",\"calculation_unit_id\":16,\"calculation_item_id\":21,\"order_created_by\":\"agent\",\"source_me_id\":17}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(24, NULL, 56, 55, 'general', 'App\\Models\\Employee', 12, 3600.00, 'paid', '2025-12-22 18:45:22', '{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":4,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":16,\"calculation_item_id\":22,\"order_created_by\":\"agent\",\"source_me_id\":17}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(25, NULL, 57, 56, 'general', 'App\\Models\\Agent', 6, 4500.00, 'paid', '2025-12-23 04:29:13', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":17,\"calculation_item_id\":23,\"order_created_by\":\"agent\",\"source_me_id\":12}', '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(26, NULL, 57, 56, 'general', 'App\\Models\\Employee', 12, 15300.00, 'paid', '2025-12-23 04:29:13', '{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":17,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":17,\"calculation_item_id\":24,\"order_created_by\":\"agent\",\"source_me_id\":12}', '2025-12-23 04:29:13', '2025-12-23 04:29:13');

-- --------------------------------------------------------

--
-- Table structure for table `commission_calculation_items`
--

CREATE TABLE `commission_calculation_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `commission_calculation_unit_id` bigint(20) UNSIGNED NOT NULL,
  `recipient_type` varchar(255) NOT NULL,
  `recipient_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` decimal(14,2) NOT NULL DEFAULT 0.00,
  `percentage` decimal(6,3) DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `commission_calculation_items`
--

INSERT INTO `commission_calculation_items` (`id`, `commission_calculation_unit_id`, `recipient_type`, `recipient_id`, `amount`, `percentage`, `meta`, `created_at`, `updated_at`) VALUES
(3, 3, 'App\\Models\\Employee', 19, 6000.00, 15.000, '{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"SABBIR MIA\"}', '2025-12-10 17:15:10', '2025-12-10 17:15:10'),
(4, 3, 'App\\Models\\Employee', 12, 6000.00, 15.000, '{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":15,\"recipient_name\":\"ZAMAN MIA\"}', '2025-12-10 17:15:10', '2025-12-10 17:15:10'),
(5, 4, 'App\\Models\\Agent', 6, 1750.00, 5.000, '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\"}', '2025-12-10 17:29:52', '2025-12-10 17:29:52'),
(6, 5, 'App\\Models\\Agent', 6, 2887.50, 1.000, '{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"MD MAYIN UDDIN\"}', '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(7, 6, 'App\\Models\\Agent', 6, 225.00, 5.000, '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\"}', '2025-12-10 17:50:44', '2025-12-10 17:50:44'),
(8, 7, 'App\\Models\\Agent', 6, 33.75, 1.000, '{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"MD MAYIN UDDIN\"}', '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(9, 8, 'App\\Models\\Agent', 7, 45000.00, 5.000, '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"Liton\"}', '2025-12-10 18:15:24', '2025-12-10 18:15:24'),
(10, 9, 'App\\Models\\Agent', 7, 1800.00, 1.000, '{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"Liton\"}', '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(12, 11, 'App\\Models\\Agent', 8, 35000.00, 5.000, '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"fusion\"}', '2025-12-11 19:35:20', '2025-12-11 19:35:20'),
(13, 12, 'App\\Models\\Agent', 8, 1400.00, 1.000, '{\"category\":\"agent_commission\",\"payment_type\":\"installment\",\"percentage\":1,\"recipient_name\":\"fusion\"}', '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(14, 13, 'App\\Models\\Agent', 8, 45000.00, 5.000, '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"fusion\"}', '2025-12-11 19:44:22', '2025-12-11 19:44:22'),
(15, 14, 'App\\Models\\Employee', 12, 13500.00, 30.000, '{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":30,\"recipient_name\":\"ZAMAN MIA\"}', '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(16, 15, 'App\\Models\\Agent', 6, 4500.00, 5.000, '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\"}', '2025-12-22 18:36:43', '2025-12-22 18:36:43'),
(17, 15, 'App\\Models\\Employee', 12, 27000.00, 30.000, '{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":30,\"recipient_name\":\"ZAMAN MIA\"}', '2025-12-22 18:36:43', '2025-12-22 18:36:43'),
(18, 16, 'App\\Models\\Agent', 6, 4500.00, 5.000, '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\"}', '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(19, 16, 'App\\Models\\Employee', 17, 10800.00, 12.000, '{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":12,\"recipient_name\":\"ABDULLAH\"}', '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(20, 16, 'App\\Models\\Employee', 16, 9000.00, 10.000, '{\"category\":\"development_bonus\",\"rank\":\"AGM\",\"payment_type\":\"down_payment\",\"percentage\":10,\"recipient_name\":\"JAKARIA\"}', '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(21, 16, 'App\\Models\\Employee', 13, 3600.00, 4.000, '{\"category\":\"development_bonus\",\"rank\":\"DGM\",\"payment_type\":\"down_payment\",\"percentage\":4,\"recipient_name\":\"SAKIL AL\"}', '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(22, 16, 'App\\Models\\Employee', 12, 3600.00, 4.000, '{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":4,\"recipient_name\":\"ZAMAN MIA\"}', '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(23, 17, 'App\\Models\\Agent', 6, 4500.00, 5.000, '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\"}', '2025-12-23 04:27:57', '2025-12-23 04:27:57'),
(24, 17, 'App\\Models\\Employee', 12, 15300.00, 17.000, '{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":17,\"recipient_name\":\"ZAMAN MIA\"}', '2025-12-23 04:27:57', '2025-12-23 04:27:57');

-- --------------------------------------------------------

--
-- Table structure for table `commission_calculation_units`
--

CREATE TABLE `commission_calculation_units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` bigint(20) UNSIGNED NOT NULL,
  `sales_order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('draft','paid') NOT NULL DEFAULT 'draft',
  `calculated_at` timestamp NULL DEFAULT NULL,
  `processed_at` timestamp NULL DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `commission_calculation_units`
--

INSERT INTO `commission_calculation_units` (`id`, `payment_id`, `sales_order_id`, `status`, `calculated_at`, `processed_at`, `meta`, `created_at`, `updated_at`) VALUES
(3, 42, 36, 'paid', '2025-12-10 17:15:10', '2025-12-10 17:30:54', '{\"commissionable_amount\":40000,\"payment_type\":\"down_payment\",\"order_created_by\":\"admin\"}', '2025-12-10 17:15:10', '2025-12-10 17:30:54'),
(4, 43, 41, 'paid', '2025-12-10 17:29:52', '2025-12-10 17:30:54', '{\"commissionable_amount\":35000,\"payment_type\":\"down_payment\",\"order_created_by\":\"agent\"}', '2025-12-10 17:29:52', '2025-12-10 17:30:54'),
(5, 44, 41, 'paid', '2025-12-10 17:30:13', '2025-12-10 17:30:54', '{\"commissionable_amount\":288750,\"payment_type\":\"installment\",\"order_created_by\":\"agent\"}', '2025-12-10 17:30:13', '2025-12-10 17:30:54'),
(6, 45, 44, 'paid', '2025-12-10 17:50:44', '2025-12-10 18:21:21', '{\"commissionable_amount\":4500,\"payment_type\":\"down_payment\",\"order_created_by\":\"agent\"}', '2025-12-10 17:50:44', '2025-12-10 18:21:21'),
(7, 46, 44, 'paid', '2025-12-10 17:50:50', '2025-12-10 18:21:21', '{\"commissionable_amount\":3375,\"payment_type\":\"installment\",\"order_created_by\":\"agent\"}', '2025-12-10 17:50:50', '2025-12-10 18:21:21'),
(8, 47, 45, 'paid', '2025-12-10 18:15:24', '2025-12-10 18:21:21', '{\"commissionable_amount\":900000,\"payment_type\":\"down_payment\",\"order_created_by\":\"agent\"}', '2025-12-10 18:15:24', '2025-12-10 18:21:21'),
(9, 48, 45, 'paid', '2025-12-10 18:16:50', '2025-12-10 18:21:21', '{\"commissionable_amount\":180000,\"payment_type\":\"installment\",\"order_created_by\":\"agent\"}', '2025-12-10 18:16:50', '2025-12-10 18:21:21'),
(11, 50, 48, 'paid', '2025-12-11 19:35:20', '2025-12-11 19:45:39', '{\"commissionable_amount\":700000,\"payment_type\":\"down_payment\",\"order_created_by\":\"agent\"}', '2025-12-11 19:35:20', '2025-12-11 19:45:39'),
(12, 51, 48, 'paid', '2025-12-11 19:36:20', '2025-12-11 19:45:39', '{\"commissionable_amount\":140000,\"payment_type\":\"installment\",\"order_created_by\":\"agent\"}', '2025-12-11 19:36:20', '2025-12-11 19:45:39'),
(13, 52, 50, 'paid', '2025-12-11 19:44:22', '2025-12-11 19:45:39', '{\"commissionable_amount\":900000,\"payment_type\":\"down_payment\",\"order_created_by\":\"agent\"}', '2025-12-11 19:44:22', '2025-12-11 19:45:39'),
(14, 53, 52, 'paid', '2025-12-22 18:27:17', '2025-12-22 18:45:22', '{\"commissionable_amount\":45000,\"payment_type\":\"down_payment\",\"order_created_by\":\"agent\"}', '2025-12-22 18:27:17', '2025-12-22 18:45:22'),
(15, 55, 54, 'paid', '2025-12-22 18:36:43', '2025-12-22 18:45:22', '{\"commissionable_amount\":90000,\"payment_type\":\"down_payment\",\"order_created_by\":\"agent\"}', '2025-12-22 18:36:43', '2025-12-22 18:45:22'),
(16, 56, 55, 'paid', '2025-12-22 18:44:18', '2025-12-22 18:45:22', '{\"commissionable_amount\":90000,\"payment_type\":\"down_payment\",\"order_created_by\":\"agent\"}', '2025-12-22 18:44:18', '2025-12-22 18:45:22'),
(17, 57, 56, 'paid', '2025-12-23 04:27:57', '2025-12-23 04:29:13', '{\"commissionable_amount\":90000,\"payment_type\":\"down_payment\",\"order_created_by\":\"agent\"}', '2025-12-23 04:27:57', '2025-12-23 04:29:13');

-- --------------------------------------------------------

--
-- Table structure for table `commission_rules`
--

CREATE TABLE `commission_rules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `scope` varchar(255) NOT NULL,
  `trigger` varchar(255) NOT NULL DEFAULT 'on_payment',
  `recipient_type` varchar(255) NOT NULL,
  `recipient_id` bigint(20) UNSIGNED DEFAULT NULL,
  `percentage` decimal(5,2) DEFAULT NULL,
  `flat_amount` decimal(14,2) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `commission_rules`
--

INSERT INTO `commission_rules` (`id`, `name`, `scope`, `trigger`, `recipient_type`, `recipient_id`, `percentage`, `flat_amount`, `active`, `meta`, `created_at`, `updated_at`) VALUES
(1, 'Agent Down Payment Commission', 'any', 'on_payment', 'App\\Models\\Agent', NULL, 5.00, NULL, 1, '{\"applies_to\":\"down_payment\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(2, 'Agent Installment Commission', 'any', 'on_payment', 'App\\Models\\Agent', NULL, 1.00, NULL, 1, '{\"applies_to\":\"installment\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(5, 'Director Marketing Down Payment Bonus', 'any', 'on_payment', 'App\\Models\\User', 5, 5.00, NULL, 1, '{\"applies_to\":\"down_payment\",\"role\":\"director\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:06'),
(6, 'Owner 01 Down Payment Share', 'down_payment', 'on_payment', 'App\\Models\\User', 6, 2.50, NULL, 1, '{\"commission_base\":\"amount\",\"applies_to\":\"down_payment\"}', '2025-10-20 13:59:03', '2025-11-18 19:06:44'),
(7, 'Owner 02 Down Payment Share', 'any', 'on_payment', 'App\\Models\\User', 7, 2.50, NULL, 1, '{\"applies_to\":\"down_payment\",\"owner_position\":\"owner_02\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:06');

-- --------------------------------------------------------

--
-- Table structure for table `commission_settings`
--

CREATE TABLE `commission_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`value`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `commission_settings`
--

INSERT INTO `commission_settings` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'share_value', '100000', '2025-10-20 13:59:03', '2025-11-03 17:35:31'),
(2, 'agent_rates', '{\"down_payment\":\"5\",\"installment\":\"1\"}', '2025-10-20 13:59:03', '2025-12-22 17:41:44'),
(3, 'branch_rates', '{\"down_payment\":5,\"installment\":1}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(4, 'development_bonus', '{\"ME\":{\"down_payment\":\"12\",\"installment\":\"5\"},\"MM\":{\"down_payment\":\"17\",\"installment\":\"6\"},\"AGM\":{\"down_payment\":\"22\",\"installment\":\"7\"},\"DGM\":{\"down_payment\":\"26\",\"installment\":\"8\"},\"GM\":{\"down_payment\":\"30\",\"installment\":\"9\"}}', '2025-10-20 13:59:03', '2025-12-17 17:31:20'),
(5, 'monthly_incentives', '{\"MM\":10000,\"AGM\":20000,\"DGM\":40000,\"GM\":100000,\"PD\":200000,\"ED\":200000,\"DMD\":200000,\"DIR\":200000}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(7, 'service_sales', '{\"percentage\":15}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(8, 'monthly_incentive_settings', '{\"down_payment\":1,\"installment\":7,\"percentage\":\"1\",\"max_levels\":\"5\"}', '2025-11-16 17:26:55', '2025-11-26 11:11:00'),
(9, 'ed_fund_settings', '{\"percentage\":\"4\",\"frequency\":\"monthly\"}', '2025-11-28 16:58:14', '2025-11-29 18:05:04'),
(10, 'amd_fund_settings', '{\"percentage\":\"2\",\"frequency\":\"quarterly\"}', '2025-11-28 16:58:34', '2025-11-29 18:05:19'),
(11, 'dmd_fund_settings', '{\"percentage\":10,\"frequency\":\"yearly\"}', '2025-11-28 16:58:47', '2025-11-28 16:58:47'),
(12, 'director_rank_settings', '{\"DM\":{\"share_target\":\"6\",\"gm_target\":\"2\"},\"AMD\":{\"share_target\":\"8\",\"gm_target\":\"3\"},\"DMD\":{\"share_target\":\"8\",\"gm_target\":\"4\"},\"DIR\":{\"share_target\":\"8\",\"gm_target\":\"5\"}}', '2025-11-28 17:04:15', '2025-12-22 17:42:28');

-- --------------------------------------------------------

--
-- Table structure for table `customer_installments`
--

CREATE TABLE `customer_installments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sales_order_id` bigint(20) UNSIGNED NOT NULL,
  `due_date` date NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `paid` decimal(14,2) NOT NULL DEFAULT 0.00,
  `status` enum('due','partial','paid') NOT NULL DEFAULT 'due',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_installments`
--

INSERT INTO `customer_installments` (`id`, `sales_order_id`, `due_date`, `amount`, `paid`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-11-09', 540000.00, 0.00, 'partial', '2025-11-04 17:33:50', '2025-11-04 17:34:00'),
(3, 4, '2025-11-09', 180000.00, 0.00, 'partial', '2025-11-04 18:10:15', '2025-11-04 18:10:29'),
(4, 5, '2025-11-09', 270000.00, 0.00, 'partial', '2025-11-04 18:13:05', '2025-11-04 18:13:15'),
(5, 6, '2025-11-09', 180000.00, 0.00, 'partial', '2025-11-04 18:48:02', '2025-11-04 18:48:21'),
(6, 7, '2025-11-10', 450000.00, 0.00, 'partial', '2025-11-05 06:11:44', '2025-11-05 06:11:59'),
(7, 9, '2025-11-15', 56000.00, 0.00, 'due', '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(8, 9, '2025-12-15', 56000.00, 0.00, 'due', '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(9, 9, '2026-01-15', 56000.00, 0.00, 'due', '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(10, 9, '2026-02-15', 56000.00, 0.00, 'due', '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(11, 9, '2026-03-15', 56000.00, 0.00, 'due', '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(12, 9, '2026-04-15', 56000.00, 0.00, 'due', '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(13, 9, '2026-05-15', 56000.00, 0.00, 'due', '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(14, 9, '2026-06-15', 56000.00, 0.00, 'due', '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(15, 9, '2026-07-15', 56000.00, 0.00, 'due', '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(16, 9, '2026-08-15', 56000.00, 0.00, 'due', '2025-11-10 15:28:57', '2025-11-10 15:28:57'),
(17, 10, '2025-11-16', 37500.00, 37500.00, 'paid', '2025-11-11 15:59:34', '2025-11-11 16:02:14'),
(18, 10, '2025-12-16', 37500.00, 0.00, 'due', '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(19, 10, '2026-01-16', 37500.00, 0.00, 'due', '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(20, 10, '2026-02-16', 37500.00, 0.00, 'due', '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(21, 10, '2026-03-16', 37500.00, 0.00, 'due', '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(22, 10, '2026-04-16', 37500.00, 0.00, 'due', '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(23, 10, '2026-05-16', 37500.00, 0.00, 'due', '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(24, 10, '2026-06-16', 37500.00, 0.00, 'due', '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(25, 10, '2026-07-16', 37500.00, 0.00, 'due', '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(26, 10, '2026-08-16', 37500.00, 0.00, 'due', '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(27, 10, '2026-09-16', 37500.00, 0.00, 'due', '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(28, 10, '2026-10-16', 37500.00, 0.00, 'due', '2025-11-11 15:59:34', '2025-11-11 15:59:34'),
(29, 11, '2025-11-16', 37500.00, 37500.00, 'paid', '2025-11-11 16:08:02', '2025-11-11 16:11:45'),
(30, 11, '2025-12-16', 37500.00, 0.00, 'due', '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(31, 11, '2026-01-16', 37500.00, 0.00, 'due', '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(32, 11, '2026-02-16', 37500.00, 0.00, 'due', '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(33, 11, '2026-03-16', 37500.00, 0.00, 'due', '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(34, 11, '2026-04-16', 37500.00, 0.00, 'due', '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(35, 11, '2026-05-16', 37500.00, 0.00, 'due', '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(36, 11, '2026-06-16', 37500.00, 0.00, 'due', '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(37, 11, '2026-07-16', 37500.00, 0.00, 'due', '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(38, 11, '2026-08-16', 37500.00, 0.00, 'due', '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(39, 11, '2026-09-16', 37500.00, 0.00, 'due', '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(40, 11, '2026-10-16', 37500.00, 0.00, 'due', '2025-11-11 16:08:02', '2025-11-11 16:08:02'),
(41, 12, '2025-11-16', 37500.00, 37500.00, 'paid', '2025-11-11 17:01:16', '2025-11-11 17:03:52'),
(42, 12, '2025-12-16', 37500.00, 0.00, 'due', '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(43, 12, '2026-01-16', 37500.00, 0.00, 'due', '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(44, 12, '2026-02-16', 37500.00, 0.00, 'due', '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(45, 12, '2026-03-16', 37500.00, 0.00, 'due', '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(46, 12, '2026-04-16', 37500.00, 0.00, 'due', '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(47, 12, '2026-05-16', 37500.00, 0.00, 'due', '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(48, 12, '2026-06-16', 37500.00, 0.00, 'due', '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(49, 12, '2026-07-16', 37500.00, 0.00, 'due', '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(50, 12, '2026-08-16', 37500.00, 0.00, 'due', '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(51, 12, '2026-09-16', 37500.00, 0.00, 'due', '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(52, 12, '2026-10-16', 37500.00, 0.00, 'due', '2025-11-11 17:01:16', '2025-11-11 17:01:16'),
(53, 14, '2025-11-17', 37500.00, 37500.00, 'paid', '2025-11-12 18:38:54', '2025-11-12 18:39:25'),
(54, 14, '2025-12-17', 37500.00, 0.00, 'due', '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(55, 14, '2026-01-17', 37500.00, 0.00, 'due', '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(56, 14, '2026-02-17', 37500.00, 0.00, 'due', '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(57, 14, '2026-03-17', 37500.00, 0.00, 'due', '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(58, 14, '2026-04-17', 37500.00, 0.00, 'due', '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(59, 14, '2026-05-17', 37500.00, 0.00, 'due', '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(60, 14, '2026-06-17', 37500.00, 0.00, 'due', '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(61, 14, '2026-07-17', 37500.00, 0.00, 'due', '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(62, 14, '2026-08-17', 37500.00, 0.00, 'due', '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(63, 14, '2026-09-17', 37500.00, 0.00, 'due', '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(64, 14, '2026-10-17', 37500.00, 0.00, 'due', '2025-11-12 18:38:54', '2025-11-12 18:38:54'),
(65, 15, '2025-11-18', 37500.00, 37500.00, 'paid', '2025-11-13 04:32:17', '2025-11-13 04:33:28'),
(66, 15, '2025-12-18', 37500.00, 0.00, 'due', '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(67, 15, '2026-01-18', 37500.00, 0.00, 'due', '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(68, 15, '2026-02-18', 37500.00, 0.00, 'due', '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(69, 15, '2026-03-18', 37500.00, 0.00, 'due', '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(70, 15, '2026-04-18', 37500.00, 0.00, 'due', '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(71, 15, '2026-05-18', 37500.00, 0.00, 'due', '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(72, 15, '2026-06-18', 37500.00, 0.00, 'due', '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(73, 15, '2026-07-18', 37500.00, 0.00, 'due', '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(74, 15, '2026-08-18', 37500.00, 0.00, 'due', '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(75, 15, '2026-09-18', 37500.00, 0.00, 'due', '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(76, 15, '2026-10-18', 37500.00, 0.00, 'due', '2025-11-13 04:32:17', '2025-11-13 04:32:17'),
(77, 16, '2025-11-21', 37500.00, 0.00, 'partial', '2025-11-16 16:12:05', '2025-11-16 16:12:17'),
(78, 16, '2025-12-21', 37500.00, 0.00, 'due', '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(79, 16, '2026-01-21', 37500.00, 0.00, 'due', '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(80, 16, '2026-02-21', 37500.00, 0.00, 'due', '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(81, 16, '2026-03-21', 37500.00, 0.00, 'due', '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(82, 16, '2026-04-21', 37500.00, 0.00, 'due', '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(83, 16, '2026-05-21', 37500.00, 0.00, 'due', '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(84, 16, '2026-06-21', 37500.00, 0.00, 'due', '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(85, 16, '2026-07-21', 37500.00, 0.00, 'due', '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(86, 16, '2026-08-21', 37500.00, 0.00, 'due', '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(87, 16, '2026-09-21', 37500.00, 0.00, 'due', '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(88, 16, '2026-10-21', 37500.00, 0.00, 'due', '2025-11-16 16:12:05', '2025-11-16 16:12:05'),
(89, 17, '2025-11-24', 33333.34, 33333.34, 'paid', '2025-11-19 09:23:47', '2025-11-19 09:25:14'),
(90, 17, '2025-12-24', 33333.34, 0.00, 'due', '2025-11-19 09:23:47', '2025-11-19 09:23:47'),
(91, 17, '2026-01-24', 33333.34, 0.00, 'due', '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(92, 17, '2026-02-24', 33333.34, 0.00, 'due', '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(93, 17, '2026-03-24', 33333.33, 0.00, 'due', '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(94, 17, '2026-04-24', 33333.33, 0.00, 'due', '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(95, 17, '2026-05-24', 33333.33, 0.00, 'due', '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(96, 17, '2026-06-24', 33333.33, 0.00, 'due', '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(97, 17, '2026-07-24', 33333.33, 0.00, 'due', '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(98, 17, '2026-08-24', 33333.33, 0.00, 'due', '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(99, 17, '2026-09-24', 33333.33, 0.00, 'due', '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(100, 17, '2026-10-24', 33333.33, 0.00, 'due', '2025-11-19 09:23:48', '2025-11-19 09:23:48'),
(113, 23, '2025-12-06', 412500.00, 412500.00, 'paid', '2025-12-01 19:51:25', '2025-12-02 10:48:40'),
(114, 23, '2026-01-06', 412500.00, 0.00, 'due', '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(115, 23, '2026-02-06', 412500.00, 0.00, 'due', '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(116, 23, '2026-03-06', 412500.00, 0.00, 'due', '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(117, 23, '2026-04-06', 412500.00, 0.00, 'due', '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(118, 23, '2026-05-06', 412500.00, 0.00, 'due', '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(119, 23, '2026-06-06', 412500.00, 0.00, 'due', '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(120, 23, '2026-07-06', 412500.00, 0.00, 'due', '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(121, 23, '2026-08-06', 412500.00, 0.00, 'due', '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(122, 23, '2026-09-06', 412500.00, 0.00, 'due', '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(123, 23, '2026-10-06', 412500.00, 0.00, 'due', '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(124, 23, '2026-11-06', 412500.00, 0.00, 'due', '2025-12-01 19:51:25', '2025-12-01 19:51:25'),
(125, 28, '2025-12-14', 95000.00, 95000.00, 'paid', '2025-12-09 18:11:45', '2025-12-09 18:12:46'),
(126, 28, '2026-01-14', 95000.00, 0.00, 'due', '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(127, 28, '2026-02-14', 95000.00, 0.00, 'due', '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(128, 28, '2026-03-14', 95000.00, 0.00, 'due', '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(129, 28, '2026-04-14', 95000.00, 0.00, 'due', '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(130, 28, '2026-05-14', 95000.00, 0.00, 'due', '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(131, 28, '2026-06-14', 95000.00, 0.00, 'due', '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(132, 28, '2026-07-14', 95000.00, 0.00, 'due', '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(133, 28, '2026-08-14', 95000.00, 0.00, 'due', '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(134, 28, '2026-09-14', 95000.00, 0.00, 'due', '2025-12-09 18:11:45', '2025-12-09 18:11:45'),
(169, 36, '2025-12-15', 37500.00, 0.00, 'partial', '2025-12-10 17:14:54', '2025-12-10 17:15:10'),
(170, 36, '2026-01-15', 37500.00, 0.00, 'due', '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(171, 36, '2026-02-15', 37500.00, 0.00, 'due', '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(172, 36, '2026-03-15', 37500.00, 0.00, 'due', '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(173, 36, '2026-04-15', 37500.00, 0.00, 'due', '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(174, 36, '2026-05-15', 37500.00, 0.00, 'due', '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(175, 36, '2026-06-15', 37500.00, 0.00, 'due', '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(176, 36, '2026-07-15', 37500.00, 0.00, 'due', '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(177, 36, '2026-08-15', 37500.00, 0.00, 'due', '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(178, 36, '2026-09-15', 37500.00, 0.00, 'due', '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(179, 36, '2026-10-15', 37500.00, 0.00, 'due', '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(180, 36, '2026-11-15', 37500.00, 0.00, 'due', '2025-12-10 17:14:54', '2025-12-10 17:14:54'),
(181, 37, '2025-12-15', 333333.34, 0.00, 'due', '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(182, 37, '2026-01-15', 333333.34, 0.00, 'due', '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(183, 37, '2026-02-15', 333333.34, 0.00, 'due', '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(184, 37, '2026-03-15', 333333.34, 0.00, 'due', '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(185, 37, '2026-04-15', 333333.33, 0.00, 'due', '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(186, 37, '2026-05-15', 333333.33, 0.00, 'due', '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(187, 37, '2026-06-15', 333333.33, 0.00, 'due', '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(188, 37, '2026-07-15', 333333.33, 0.00, 'due', '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(189, 37, '2026-08-15', 333333.33, 0.00, 'due', '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(190, 37, '2026-09-15', 333333.33, 0.00, 'due', '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(191, 37, '2026-10-15', 333333.33, 0.00, 'due', '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(192, 37, '2026-11-15', 333333.33, 0.00, 'due', '2025-12-10 17:20:56', '2025-12-10 17:20:56'),
(193, 38, '2025-12-15', 333333.34, 0.00, 'due', '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(194, 38, '2026-01-15', 333333.34, 0.00, 'due', '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(195, 38, '2026-02-15', 333333.34, 0.00, 'due', '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(196, 38, '2026-03-15', 333333.34, 0.00, 'due', '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(197, 38, '2026-04-15', 333333.33, 0.00, 'due', '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(198, 38, '2026-05-15', 333333.33, 0.00, 'due', '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(199, 38, '2026-06-15', 333333.33, 0.00, 'due', '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(200, 38, '2026-07-15', 333333.33, 0.00, 'due', '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(201, 38, '2026-08-15', 333333.33, 0.00, 'due', '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(202, 38, '2026-09-15', 333333.33, 0.00, 'due', '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(203, 38, '2026-10-15', 333333.33, 0.00, 'due', '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(204, 38, '2026-11-15', 333333.33, 0.00, 'due', '2025-12-10 17:22:53', '2025-12-10 17:22:53'),
(205, 39, '2025-12-15', 37500.00, 0.00, 'due', '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(206, 39, '2026-01-15', 37500.00, 0.00, 'due', '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(207, 39, '2026-02-15', 37500.00, 0.00, 'due', '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(208, 39, '2026-03-15', 37500.00, 0.00, 'due', '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(209, 39, '2026-04-15', 37500.00, 0.00, 'due', '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(210, 39, '2026-05-15', 37500.00, 0.00, 'due', '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(211, 39, '2026-06-15', 37500.00, 0.00, 'due', '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(212, 39, '2026-07-15', 37500.00, 0.00, 'due', '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(213, 39, '2026-08-15', 37500.00, 0.00, 'due', '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(214, 39, '2026-09-15', 37500.00, 0.00, 'due', '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(215, 39, '2026-10-15', 37500.00, 0.00, 'due', '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(216, 39, '2026-11-15', 37500.00, 0.00, 'due', '2025-12-10 17:24:42', '2025-12-10 17:24:42'),
(217, 40, '2025-12-15', 412500.00, 0.00, 'due', '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(218, 40, '2026-01-15', 412500.00, 0.00, 'due', '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(219, 40, '2026-02-15', 412500.00, 0.00, 'due', '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(220, 40, '2026-03-15', 412500.00, 0.00, 'due', '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(221, 40, '2026-04-15', 412500.00, 0.00, 'due', '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(222, 40, '2026-05-15', 412500.00, 0.00, 'due', '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(223, 40, '2026-06-15', 412500.00, 0.00, 'due', '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(224, 40, '2026-07-15', 412500.00, 0.00, 'due', '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(225, 40, '2026-08-15', 412500.00, 0.00, 'due', '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(226, 40, '2026-09-15', 412500.00, 0.00, 'due', '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(227, 40, '2026-10-15', 412500.00, 0.00, 'due', '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(228, 40, '2026-11-15', 412500.00, 0.00, 'due', '2025-12-10 17:28:39', '2025-12-10 17:28:39'),
(229, 41, '2025-12-15', 412500.00, 412500.00, 'paid', '2025-12-10 17:29:19', '2025-12-10 17:30:13'),
(230, 41, '2026-01-15', 412500.00, 0.00, 'due', '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(231, 41, '2026-02-15', 412500.00, 0.00, 'due', '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(232, 41, '2026-03-15', 412500.00, 0.00, 'due', '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(233, 41, '2026-04-15', 412500.00, 0.00, 'due', '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(234, 41, '2026-05-15', 412500.00, 0.00, 'due', '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(235, 41, '2026-06-15', 412500.00, 0.00, 'due', '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(236, 41, '2026-07-15', 412500.00, 0.00, 'due', '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(237, 41, '2026-08-15', 412500.00, 0.00, 'due', '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(238, 41, '2026-09-15', 412500.00, 0.00, 'due', '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(239, 41, '2026-10-15', 412500.00, 0.00, 'due', '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(240, 41, '2026-11-15', 412500.00, 0.00, 'due', '2025-12-10 17:29:19', '2025-12-10 17:29:19'),
(241, 42, '2025-12-15', 37500.00, 0.00, 'due', '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(242, 42, '2026-01-15', 37500.00, 0.00, 'due', '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(243, 42, '2026-02-15', 37500.00, 0.00, 'due', '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(244, 42, '2026-03-15', 37500.00, 0.00, 'due', '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(245, 42, '2026-04-15', 37500.00, 0.00, 'due', '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(246, 42, '2026-05-15', 37500.00, 0.00, 'due', '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(247, 42, '2026-06-15', 37500.00, 0.00, 'due', '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(248, 42, '2026-07-15', 37500.00, 0.00, 'due', '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(249, 42, '2026-08-15', 37500.00, 0.00, 'due', '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(250, 42, '2026-09-15', 37500.00, 0.00, 'due', '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(251, 42, '2026-10-15', 37500.00, 0.00, 'due', '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(252, 42, '2026-11-15', 37500.00, 0.00, 'due', '2025-12-10 17:44:42', '2025-12-10 17:44:42'),
(253, 43, '2025-12-15', 400000.00, 0.00, 'due', '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(254, 43, '2026-01-15', 400000.00, 0.00, 'due', '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(255, 43, '2026-02-15', 400000.00, 0.00, 'due', '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(256, 43, '2026-03-15', 400000.00, 0.00, 'due', '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(257, 43, '2026-04-15', 400000.00, 0.00, 'due', '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(258, 43, '2026-05-15', 400000.00, 0.00, 'due', '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(259, 43, '2026-06-15', 400000.00, 0.00, 'due', '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(260, 43, '2026-07-15', 400000.00, 0.00, 'due', '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(261, 43, '2026-08-15', 400000.00, 0.00, 'due', '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(262, 43, '2026-09-15', 400000.00, 0.00, 'due', '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(263, 43, '2026-10-15', 400000.00, 0.00, 'due', '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(264, 43, '2026-11-15', 400000.00, 0.00, 'due', '2025-12-10 17:47:12', '2025-12-10 17:47:12'),
(265, 44, '2025-12-15', 3750.00, 3750.00, 'paid', '2025-12-10 17:50:16', '2025-12-10 17:50:50'),
(266, 44, '2026-01-15', 3750.00, 0.00, 'due', '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(267, 44, '2026-02-15', 3750.00, 0.00, 'due', '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(268, 44, '2026-03-15', 3750.00, 0.00, 'due', '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(269, 44, '2026-04-15', 3750.00, 0.00, 'due', '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(270, 44, '2026-05-15', 3750.00, 0.00, 'due', '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(271, 44, '2026-06-15', 3750.00, 0.00, 'due', '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(272, 44, '2026-07-15', 3750.00, 0.00, 'due', '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(273, 44, '2026-08-15', 3750.00, 0.00, 'due', '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(274, 44, '2026-09-15', 3750.00, 0.00, 'due', '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(275, 44, '2026-10-15', 3750.00, 0.00, 'due', '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(276, 44, '2026-11-15', 3750.00, 0.00, 'due', '2025-12-10 17:50:16', '2025-12-10 17:50:16'),
(277, 45, '2025-12-15', 200000.00, 200000.00, 'paid', '2025-12-10 18:11:37', '2025-12-10 18:16:50'),
(278, 45, '2026-01-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(279, 45, '2026-02-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(280, 45, '2026-03-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(281, 45, '2026-04-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(282, 45, '2026-05-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(283, 45, '2026-06-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(284, 45, '2026-07-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(285, 45, '2026-08-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(286, 45, '2026-09-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(287, 45, '2026-10-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(288, 45, '2026-11-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(289, 45, '2026-12-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(290, 45, '2027-01-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(291, 45, '2027-02-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(292, 45, '2027-03-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(293, 45, '2027-04-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(294, 45, '2027-05-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(295, 45, '2027-06-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(296, 45, '2027-07-15', 200000.00, 0.00, 'due', '2025-12-10 18:11:37', '2025-12-10 18:11:37'),
(337, 48, '2025-12-16', 200000.00, 200000.00, 'paid', '2025-12-11 19:34:02', '2025-12-11 19:36:20'),
(338, 48, '2026-01-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(339, 48, '2026-02-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(340, 48, '2026-03-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(341, 48, '2026-04-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(342, 48, '2026-05-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(343, 48, '2026-06-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(344, 48, '2026-07-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(345, 48, '2026-08-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(346, 48, '2026-09-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(347, 48, '2026-10-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(348, 48, '2026-11-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(349, 48, '2026-12-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(350, 48, '2027-01-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(351, 48, '2027-02-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(352, 48, '2027-03-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(353, 48, '2027-04-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(354, 48, '2027-05-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(355, 48, '2027-06-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(356, 48, '2027-07-16', 200000.00, 0.00, 'due', '2025-12-11 19:34:02', '2025-12-11 19:34:02'),
(357, 50, '2025-12-16', 200000.00, 0.00, 'partial', '2025-12-11 19:42:56', '2025-12-11 19:44:22'),
(358, 50, '2026-01-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(359, 50, '2026-02-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(360, 50, '2026-03-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(361, 50, '2026-04-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(362, 50, '2026-05-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(363, 50, '2026-06-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(364, 50, '2026-07-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(365, 50, '2026-08-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(366, 50, '2026-09-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(367, 50, '2026-10-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(368, 50, '2026-11-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(369, 50, '2026-12-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(370, 50, '2027-01-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(371, 50, '2027-02-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(372, 50, '2027-03-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(373, 50, '2027-04-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(374, 50, '2027-05-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(375, 50, '2027-06-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:56', '2025-12-11 19:42:56'),
(376, 50, '2027-07-16', 200000.00, 0.00, 'due', '2025-12-11 19:42:57', '2025-12-11 19:42:57'),
(377, 51, '2025-12-22', 375000.00, 0.00, 'due', '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(378, 51, '2026-01-22', 375000.00, 0.00, 'due', '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(379, 51, '2026-02-22', 375000.00, 0.00, 'due', '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(380, 51, '2026-03-22', 375000.00, 0.00, 'due', '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(381, 51, '2026-04-22', 375000.00, 0.00, 'due', '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(382, 51, '2026-05-22', 375000.00, 0.00, 'due', '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(383, 51, '2026-06-22', 375000.00, 0.00, 'due', '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(384, 51, '2026-07-22', 375000.00, 0.00, 'due', '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(385, 51, '2026-08-22', 375000.00, 0.00, 'due', '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(386, 51, '2026-09-22', 375000.00, 0.00, 'due', '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(387, 51, '2026-10-22', 375000.00, 0.00, 'due', '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(388, 51, '2026-11-22', 375000.00, 0.00, 'due', '2025-12-17 18:06:36', '2025-12-17 18:06:36'),
(389, 52, '2025-12-27', 412500.00, 0.00, 'partial', '2025-12-22 18:26:52', '2025-12-22 18:27:17'),
(390, 52, '2026-01-27', 412500.00, 0.00, 'due', '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(391, 52, '2026-02-27', 412500.00, 0.00, 'due', '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(392, 52, '2026-03-27', 412500.00, 0.00, 'due', '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(393, 52, '2026-04-27', 412500.00, 0.00, 'due', '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(394, 52, '2026-05-27', 412500.00, 0.00, 'due', '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(395, 52, '2026-06-27', 412500.00, 0.00, 'due', '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(396, 52, '2026-07-27', 412500.00, 0.00, 'due', '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(397, 52, '2026-08-27', 412500.00, 0.00, 'due', '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(398, 52, '2026-09-27', 412500.00, 0.00, 'due', '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(399, 52, '2026-10-27', 412500.00, 0.00, 'due', '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(400, 52, '2026-11-27', 412500.00, 0.00, 'due', '2025-12-22 18:26:52', '2025-12-22 18:26:52'),
(401, 53, '2025-12-27', 412500.00, 0.00, 'partial', '2025-12-22 18:32:35', '2025-12-22 18:33:48'),
(402, 53, '2026-01-27', 412500.00, 0.00, 'due', '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(403, 53, '2026-02-27', 412500.00, 0.00, 'due', '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(404, 53, '2026-03-27', 412500.00, 0.00, 'due', '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(405, 53, '2026-04-27', 412500.00, 0.00, 'due', '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(406, 53, '2026-05-27', 412500.00, 0.00, 'due', '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(407, 53, '2026-06-27', 412500.00, 0.00, 'due', '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(408, 53, '2026-07-27', 412500.00, 0.00, 'due', '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(409, 53, '2026-08-27', 412500.00, 0.00, 'due', '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(410, 53, '2026-09-27', 412500.00, 0.00, 'due', '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(411, 53, '2026-10-27', 412500.00, 0.00, 'due', '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(412, 53, '2026-11-27', 412500.00, 0.00, 'due', '2025-12-22 18:32:35', '2025-12-22 18:32:35'),
(413, 54, '2025-12-27', 408333.34, 0.00, 'partial', '2025-12-22 18:36:33', '2025-12-22 18:36:43'),
(414, 54, '2026-01-27', 408333.34, 0.00, 'due', '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(415, 54, '2026-02-27', 408333.34, 0.00, 'due', '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(416, 54, '2026-03-27', 408333.34, 0.00, 'due', '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(417, 54, '2026-04-27', 408333.33, 0.00, 'due', '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(418, 54, '2026-05-27', 408333.33, 0.00, 'due', '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(419, 54, '2026-06-27', 408333.33, 0.00, 'due', '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(420, 54, '2026-07-27', 408333.33, 0.00, 'due', '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(421, 54, '2026-08-27', 408333.33, 0.00, 'due', '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(422, 54, '2026-09-27', 408333.33, 0.00, 'due', '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(423, 54, '2026-10-27', 408333.33, 0.00, 'due', '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(424, 54, '2026-11-27', 408333.33, 0.00, 'due', '2025-12-22 18:36:33', '2025-12-22 18:36:33'),
(425, 55, '2025-12-27', 408333.34, 0.00, 'partial', '2025-12-22 18:44:05', '2025-12-22 18:44:18'),
(426, 55, '2026-01-27', 408333.34, 0.00, 'due', '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(427, 55, '2026-02-27', 408333.34, 0.00, 'due', '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(428, 55, '2026-03-27', 408333.34, 0.00, 'due', '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(429, 55, '2026-04-27', 408333.33, 0.00, 'due', '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(430, 55, '2026-05-27', 408333.33, 0.00, 'due', '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(431, 55, '2026-06-27', 408333.33, 0.00, 'due', '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(432, 55, '2026-07-27', 408333.33, 0.00, 'due', '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(433, 55, '2026-08-27', 408333.33, 0.00, 'due', '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(434, 55, '2026-09-27', 408333.33, 0.00, 'due', '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(435, 55, '2026-10-27', 408333.33, 0.00, 'due', '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(436, 55, '2026-11-27', 408333.33, 0.00, 'due', '2025-12-22 18:44:05', '2025-12-22 18:44:05'),
(437, 56, '2025-12-28', 408333.34, 0.00, 'partial', '2025-12-23 04:27:42', '2025-12-23 04:27:57'),
(438, 56, '2026-01-28', 408333.34, 0.00, 'due', '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(439, 56, '2026-02-28', 408333.34, 0.00, 'due', '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(440, 56, '2026-03-28', 408333.34, 0.00, 'due', '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(441, 56, '2026-04-28', 408333.33, 0.00, 'due', '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(442, 56, '2026-05-28', 408333.33, 0.00, 'due', '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(443, 56, '2026-06-28', 408333.33, 0.00, 'due', '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(444, 56, '2026-07-28', 408333.33, 0.00, 'due', '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(445, 56, '2026-08-28', 408333.33, 0.00, 'due', '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(446, 56, '2026-09-28', 408333.33, 0.00, 'due', '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(447, 56, '2026-10-28', 408333.33, 0.00, 'due', '2025-12-23 04:27:42', '2025-12-23 04:27:42'),
(448, 56, '2026-11-28', 408333.33, 0.00, 'due', '2025-12-23 04:27:42', '2025-12-23 04:27:42');

-- --------------------------------------------------------

--
-- Table structure for table `director_funds`
--

CREATE TABLE `director_funds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `percentage_used` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total_fund` decimal(15,2) NOT NULL DEFAULT 0.00,
  `per_person_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `status` varchar(255) NOT NULL DEFAULT 'draft',
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `processed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `director_funds`
--

INSERT INTO `director_funds` (`id`, `employee_id`, `type`, `period_start`, `period_end`, `percentage_used`, `total_fund`, `per_person_amount`, `status`, `meta`, `processed_at`, `created_at`, `updated_at`) VALUES
(1, 22, 'ed', '2025-11-01', '2025-11-30', 4.00, 22350.00, 3725.00, 'paid', '{\"frequency\":\"monthly\",\"total_sales\":558750.01,\"recipient_count\":6}', '2025-11-29 17:30:07', '2025-11-29 08:03:00', '2025-11-29 17:30:07'),
(2, 26, 'ed', '2025-11-01', '2025-11-30', 4.00, 22350.00, 3725.00, 'paid', '{\"frequency\":\"monthly\",\"total_sales\":558750.01,\"recipient_count\":6}', '2025-11-29 17:30:07', '2025-11-29 15:05:10', '2025-11-29 17:30:07'),
(3, 27, 'ed', '2025-11-01', '2025-11-30', 4.00, 22350.00, 3725.00, 'paid', '{\"frequency\":\"monthly\",\"total_sales\":558750.01,\"recipient_count\":6}', '2025-11-29 17:30:07', '2025-11-29 15:05:10', '2025-11-29 17:30:07'),
(4, 28, 'ed', '2025-11-01', '2025-11-30', 4.00, 22350.00, 3725.00, 'paid', '{\"frequency\":\"monthly\",\"total_sales\":558750.01,\"recipient_count\":6}', '2025-11-29 17:30:07', '2025-11-29 15:05:10', '2025-11-29 17:30:07'),
(5, 29, 'ed', '2025-11-01', '2025-11-30', 4.00, 22350.00, 3725.00, 'paid', '{\"frequency\":\"monthly\",\"total_sales\":558750.01,\"recipient_count\":6}', '2025-11-29 17:30:07', '2025-11-29 15:05:10', '2025-11-29 17:30:07'),
(6, 30, 'ed', '2025-11-01', '2025-11-30', 4.00, 22350.00, 3725.00, 'paid', '{\"frequency\":\"monthly\",\"total_sales\":558750.01,\"recipient_count\":6}', '2025-11-29 17:30:07', '2025-11-29 15:05:11', '2025-11-29 17:30:07');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `documentable_type` varchar(255) NOT NULL,
  `documentable_id` bigint(20) UNSIGNED NOT NULL,
  `category` varchar(255) NOT NULL,
  `disk` varchar(255) NOT NULL DEFAULT 'local',
  `path` varchar(255) NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `size` bigint(20) UNSIGNED DEFAULT NULL,
  `uploaded_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `documentable_type`, `documentable_id`, `category`, `disk`, `path`, `original_name`, `mime_type`, `size`, `uploaded_by`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\SalesOrder', 1, 'contract', 'local', 'contracts/so-2025-0001.pdf', 'SO-2025-0001.pdf', 'application/pdf', 245760, NULL, '2025-10-20 13:59:06', '2025-10-20 13:59:06'),
(2, 'App\\Models\\Employee', 4, 'photo', 'local', 'documents/employees/photo/0zcNb5fYQJfX6JNehJxSTu0xHidTKYCRdNTSKx08.png', 'motorcycle.png', 'image/png', 18579, 10, '2025-10-27 18:03:35', '2025-10-27 18:03:35'),
(3, 'App\\Models\\Employee', 4, 'signature', 'local', 'documents/employees/signature/8HVcxWavKfOZjzjOQb1WsfLJbzAvYuFksNu9Qrr4.png', 'cng.png', 'image/png', 28929, 10, '2025-10-27 18:03:35', '2025-10-27 18:03:35'),
(4, 'App\\Models\\Employee', 8, 'photo', 'local', 'documents/employees/photo/xHy1cidbeCKMRfW1oyuxSs0cUlBdGggi1ew8hu23.png', 'motorcycle.png', 'image/png', 18579, 10, '2025-10-31 17:00:26', '2025-10-31 17:00:26'),
(5, 'App\\Models\\Employee', 8, 'signature', 'local', 'documents/employees/signature/vLkMTpdrLBOvPgogtj967nKO2NcyMRwooYgTXmuB.png', 'motorcycle.png', 'image/png', 18579, 10, '2025-10-31 17:00:26', '2025-10-31 17:00:26'),
(6, 'App\\Models\\Employee', 12, 'photo', 'local', 'documents/employees/photo/KQJrXpEP9Whp88V3iltj9aZQAIsl5vhJmebD7uJF.png', 'cng.png', 'image/png', 28929, 10, '2025-11-03 15:36:33', '2025-11-03 15:36:33'),
(7, 'App\\Models\\Employee', 12, 'signature', 'local', 'documents/employees/signature/pPp6KmZy89Mv6hQiO2BRxtMFmViPgdpn4ETZMxub.png', 'motorcycle.png', 'image/png', 18579, 10, '2025-11-03 15:36:33', '2025-11-03 15:36:33'),
(8, 'App\\Models\\Employee', 13, 'photo', 'local', 'documents/employees/photo/P2LAtOyGpFrZzvqdHSpPfkrmIrV1e51TRSMzMJoQ.png', 'motorcycle.png', 'image/png', 18579, 10, '2025-11-03 15:38:47', '2025-11-03 15:38:47'),
(9, 'App\\Models\\Employee', 13, 'signature', 'local', 'documents/employees/signature/eulhHMpEw9Ul3PenNGMCfNc6xMZFaPxdMciAyl3r.png', 'cng.png', 'image/png', 28929, 10, '2025-11-03 15:38:47', '2025-11-03 15:38:47'),
(10, 'App\\Models\\Employee', 19, 'photo', 'local', 'documents/employees/photo/gJfsZSYmdnC9OwR5QDOMzDYmQFFx3zeDEv19nLEL.png', 'cng.png', 'image/png', 28929, 10, '2025-11-04 15:52:07', '2025-11-04 15:52:07'),
(11, 'App\\Models\\Employee', 19, 'signature', 'local', 'documents/employees/signature/JDnjmnCjCSLjgRj4CztgS92rNaQIrjA3p8qeEek2.png', 'cng.png', 'image/png', 28929, 10, '2025-11-04 15:52:07', '2025-11-04 15:52:07');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_code` varchar(255) NOT NULL,
  `full_name_en` varchar(255) NOT NULL,
  `full_name_bn` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `national_id` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `marital_status` varchar(255) DEFAULT NULL,
  `religion` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `upazila` varchar(255) DEFAULT NULL,
  `present_address` text DEFAULT NULL,
  `permanent_address` text DEFAULT NULL,
  `post_code` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `agent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `superior_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rank` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `employee_code`, `full_name_en`, `full_name_bn`, `father_name`, `mother_name`, `mobile`, `national_id`, `date_of_birth`, `marital_status`, `religion`, `gender`, `nationality`, `district`, `upazila`, `present_address`, `permanent_address`, `post_code`, `user_id`, `branch_id`, `agent_id`, `superior_id`, `rank`, `created_at`, `updated_at`) VALUES
(12, 'AL-0001', 'ZAMAN MIA', 'ZAMAN MIA', 'JAEHR', 'JAHURA', '01999070431', '12321312321', '1997-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, NULL, NULL, NULL, 42, 2, NULL, NULL, 'MM', '2025-11-03 15:36:33', '2025-12-23 04:27:57'),
(13, 'AL-00004', 'SAKIL AL', 'SAKIL AL', 'SHAJAHAN', 'SHAJEDA', '01999072133123', '123123123', '1997-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, NULL, NULL, NULL, 43, 2, NULL, 12, 'DGM', '2025-11-03 15:38:47', '2025-11-03 15:38:47'),
(14, 'AL-0005', 'SABBIR RAHMAN', 'SABBIR RAHMAN', 'SHAKIA', 'SHAJEDA', '019990123123', '213123123123', '1997-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, NULL, NULL, NULL, 44, 2, NULL, 13, 'AGM', '2025-11-03 15:40:57', '2025-11-03 15:40:57'),
(15, 'AL-0006', 'MOJAHID', 'MOJAHID', 'Mohkka', 'Mosada', '019990723333', '23324324', '1998-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, NULL, NULL, NULL, 45, 2, NULL, 14, 'MM', '2025-11-03 15:42:10', '2025-11-03 15:42:10'),
(16, 'AL-0007', 'JAKARIA', 'JAKARIA', 'Jafor mia', 'Sajeda', '01999071213', '21321321321', '1997-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, NULL, NULL, NULL, 46, 2, NULL, 15, 'AGM', '2025-11-03 15:44:14', '2025-12-22 18:44:18'),
(17, 'AL-00008', 'ABDULLAH', 'ABDULLAH', 'SAKIN', 'SHAKINA BIBI', '01999071222', '12345678122', '1998-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, NULL, NULL, NULL, 47, 2, NULL, 16, 'ME', '2025-11-03 15:50:44', '2025-11-03 15:50:44'),
(19, 'AL-00010', 'SABBIR MIA', 'SABBIR MIA', 'SAJED', 'SHAJEDA BEGUM', '0199222121', '13123123123', '1998-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 50, 2, NULL, 12, 'MM', '2025-11-04 15:52:07', '2025-11-11 17:02:08'),
(20, '0044', 'sumi', 'sumi', 'sdee', 'hhh', '01766686301', '3455', '2000-02-22', 'Married', 'Islam', 'Female', 'Bangladeshi', NULL, NULL, 'dddd', 'bbbb', NULL, 55, 1, NULL, 16, 'MM', '2025-11-19 08:08:06', '2025-11-19 08:08:06'),
(21, '2244', 'mizan', 'mizan', 'dff', 'hjhj', '01766686301', '2345', '2000-12-04', 'Married', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'dxc', 'ggg', NULL, 56, 1, NULL, NULL, 'MM', '2025-11-19 08:15:46', '2025-11-19 08:15:46'),
(22, 'ED-0001', 'SAD MIA', 'SAD MIA', 'Amjad', 'Fatema', '01999111111', '1234567111', '1998-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 58, 1, NULL, NULL, 'ED', '2025-11-28 16:30:52', '2025-11-28 16:30:52'),
(23, 'AMD-0001', 'SAPLA', 'SAPLA', 'sapila', 'sapeda', '0199902222', '21213123', '1997-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 59, 1, NULL, NULL, 'AMD', '2025-11-28 16:33:55', '2025-11-28 16:33:55'),
(24, 'D-00001', 'FAJLE', 'FAJLE', 'SAPILA', 'Nasima Begum', '0199907021', '12313123', '1997-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 60, 1, NULL, NULL, 'DIR', '2025-11-28 16:35:55', '2025-11-28 16:35:55'),
(25, 'DMD-0002', 'MOSJA', 'MOSJA', 'Sakil', 'sakina', '01992222112', '21313123', '1997-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 61, 1, NULL, NULL, 'DMD', '2025-11-28 16:37:39', '2025-11-28 16:37:39'),
(26, 'ED-00002', 'MIZANUR RAHMAN', 'MIZANUR RAHMAN', 'MOSHIUR RAHMAN', 'mosejda', '01521565478', '1234567123', '1998-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 62, 1, NULL, NULL, 'ED', '2025-11-29 11:59:55', '2025-11-29 11:59:55'),
(27, 'ED-0003', 'Monir mia', 'Monir mia', 'Mosqur mia', 'moeje', '0199912313', '12312312', '1997-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 63, 1, NULL, NULL, 'ED', '2025-11-29 12:01:58', '2025-11-29 12:01:58'),
(28, 'ED-00004', 'SIPBKU', 'SIPBKU', 'shija', 'shaji', '01999012213', '21313213', '1995-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 64, 1, NULL, NULL, 'ED', '2025-11-29 12:03:32', '2025-11-29 12:03:32'),
(29, 'ED-0005', 'ESHAN', 'ESHAN', 'esfiq', 'eshana', '01999072313', '234324', '1985-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 65, 1, NULL, NULL, 'ED', '2025-11-29 12:05:07', '2025-11-29 12:05:07'),
(30, 'ED-0006', 'Rehan', 'Rehan', 'Reja mia', 'remahi', '01999123213', '2133213', '1998-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 66, 1, NULL, NULL, 'ED', '2025-11-29 12:11:30', '2025-11-29 12:11:30'),
(31, 'G00002', 'SAW MIA', 'SAW MIA', 'SABUJ', 'SAKINA', '01999073244', '324324', '1995-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 67, 2, NULL, 26, 'GM', '2025-11-29 12:23:37', '2025-11-29 12:23:37'),
(32, 'GM-00003', 'KABIR SINGH', 'KABIR SINGH', 'SAKIL', 'SHAJEDA', '01999070234', '1234567890', '1998-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, NULL, 68, 2, NULL, 26, 'GM', '2025-11-29 12:33:39', '2025-11-29 12:33:39'),
(33, 'GM-00004', 'SOCRETIS', 'SOCRETIS', 'sajal mia', 'sakina', '01999012121', '13123213', '1995-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, NULL, 69, 2, NULL, 26, 'GM', '2025-11-29 12:34:53', '2025-11-29 12:34:53'),
(34, 'GM-00005', 'MIHILA', 'MIHILA', 'Mijik', 'mocena', '01999031321', '123123213', '1995-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 70, 2, NULL, 26, 'GM', '2025-11-29 12:36:02', '2025-11-29 12:36:02'),
(35, 'GM-00006', 'SJID', 'SJID', 'samila', 'samia', '0199901231', '3212123', '1995-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 71, 2, NULL, 26, 'GM', '2025-11-29 12:37:24', '2025-11-29 12:37:24'),
(36, 'GM-00007', 'FARUQ', 'FARUQ', 'KARIQ', 'khadiza', '019990713213', '2131321', '1998-05-01', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 72, 3, NULL, 26, 'GM', '2025-11-29 12:39:54', '2025-11-29 12:39:54'),
(37, 'GM-00008', 'ENUS', 'ENUS', 'Eshaq', 'eahana', '019990123123', '21321321', '1995-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 73, 2, NULL, 26, 'GM', '2025-11-29 12:40:51', '2025-11-29 12:40:51'),
(38, 'GM-00009', 'HABIB', 'HABIB', 'Hafej ak', 'hafeja', '01999070234', '09876522', '1995-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 74, 2, NULL, 26, 'GM', '2025-11-29 12:41:59', '2025-11-29 12:41:59'),
(39, 'GM-00010', 'Eshraj', 'Eshraj', 'Ebj', 'ehana', '01999071231', '213123213', '1995-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 75, 2, NULL, 26, 'GM', '2025-11-29 12:43:19', '2025-11-29 12:43:19'),
(40, 'GM-00011', 'SABBIR', 'SABBIR', 'Shabj', 'samja', '01999072313', '213213213', '1995-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 76, 2, NULL, 26, 'GM', '2025-11-29 12:45:36', '2025-11-29 12:45:36'),
(41, 'GM-000012', 'SHihab mia', 'SHihab mia', 'Shakil mia', 'shine', '01999071212', '21321321121', '1998-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 78, 2, NULL, 26, 'GM', '2025-11-29 17:27:49', '2025-11-29 17:27:49'),
(42, 'GM-00013', 'Shamina', 'Shamina', 'shajid', 'shajeda', '01999070212211', '213213123213', '1998-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 79, 2, NULL, 26, 'GM', '2025-11-29 17:29:09', '2025-11-29 17:29:09'),
(43, '2346', 'sumi', 'sumi', 'ghh', 'hjj', '12334', '5677', '2000-02-03', 'Single', 'Islam', 'Female', 'Bangladeshi', NULL, NULL, 'ghhhh', 'ghhh', NULL, 82, 2, NULL, 12, 'ME', '2025-12-10 18:31:11', '2025-12-10 18:31:11'),
(44, '1345', 'mamun', 'dff', 'ss', 'fgg', '12345673', '555', '2000-04-12', 'Married', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'asdd', 'dddd', NULL, 86, 2, NULL, 43, 'ME', '2025-12-17 17:57:03', '2025-12-17 17:57:03'),
(45, 'EMP-Q76CXH', 'ABDULLAH', 'ABDULLAH', 'Kamrul Chowdhury', 'Aysas', '019991231312', '123213213', '1998-05-02', 'Single', NULL, NULL, NULL, 'Chittagong', 'fdsfds', '300/A, North Sahajanpur,Dhaka', NULL, '12313', 88, 2, NULL, 12, 'ME', '2025-12-22 16:20:56', '2025-12-22 16:20:56');

-- --------------------------------------------------------

--
-- Table structure for table `employee_activities`
--

CREATE TABLE `employee_activities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `activity_date` date NOT NULL,
  `title` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sales_order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_educations`
--

CREATE TABLE `employee_educations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `level` varchar(255) NOT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `passing_year` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_educations`
--

INSERT INTO `employee_educations` (`id`, `employee_id`, `level`, `institution`, `subject`, `result`, `passing_year`, `created_at`, `updated_at`) VALUES
(4, 12, 'PSC/5 Pass', NULL, 'CSE', '3.5', '2016', '2025-11-03 15:36:33', '2025-11-03 15:36:33'),
(5, 13, 'PSC/5 Pass', NULL, 'CSE', '3.5', '2013', '2025-11-03 15:38:47', '2025-11-03 15:38:47'),
(6, 14, 'JSC/JDC/8 Pass', NULL, 'CSS', '3.5', '2010', '2025-11-03 15:40:57', '2025-11-03 15:40:57'),
(7, 19, 'Bachelor/Honours', NULL, 'CSE', '3.56', '2025', '2025-11-04 15:52:07', '2025-11-04 15:52:07'),
(8, 22, 'PSC/5 Pass', NULL, 'cs', '3.5', '2007', '2025-11-28 16:30:52', '2025-11-28 16:30:52'),
(9, 23, 'PSC/5 Pass', NULL, 'CSE', '3.5', '2024', '2025-11-28 16:33:55', '2025-11-28 16:33:55'),
(10, 24, 'PSC/5 Pass', NULL, 'CS', '3.75', '2025', '2025-11-28 16:35:55', '2025-11-28 16:35:55'),
(11, 25, 'PSC/5 Pass', NULL, 'cs', '3.56', '2025', '2025-11-28 16:37:39', '2025-11-28 16:37:39'),
(12, 26, 'HSC/A Level/Alim', NULL, 'CSE', '3.5', '2009', '2025-11-29 11:59:55', '2025-11-29 11:59:55'),
(13, 27, 'PSC/5 Pass', NULL, 'cse', '2.5', '2009', '2025-11-29 12:01:58', '2025-11-29 12:01:58'),
(14, 28, 'SSC/O Level/Dakhil', NULL, 'CS', '3.5', '2011', '2025-11-29 12:03:32', '2025-11-29 12:03:32'),
(15, 29, 'JSC/JDC/8 Pass', NULL, 'cS', '3.2', '2010', '2025-11-29 12:05:07', '2025-11-29 12:05:07'),
(16, 30, 'PSC/5 Pass', NULL, 'PS', '3.5', '2010', '2025-11-29 12:11:30', '2025-11-29 12:11:30');

-- --------------------------------------------------------

--
-- Table structure for table `employee_nominees`
--

CREATE TABLE `employee_nominees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `relation` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_nominees`
--

INSERT INTO `employee_nominees` (`id`, `employee_id`, `name`, `relation`, `phone`, `email`, `address`, `created_at`, `updated_at`) VALUES
(4, 12, 'MD MAYIN UDDIN', 'Brother', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-03 15:36:33', '2025-11-03 15:36:33'),
(5, 13, 'MD MAYIN UDDIN', 'Brother', '019990324324', NULL, '300/A, North Sahajanpur,Dhaka', '2025-11-03 15:38:47', '2025-11-03 15:38:47'),
(6, 14, 'MD MAYIN UDDIN', 'aaaa', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-03 15:40:57', '2025-11-03 15:40:57'),
(7, 19, 'MD MAYIN UDDIN', 'Brother', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-04 15:52:07', '2025-11-04 15:52:07'),
(8, 19, 'MD MAYIN UDDIN', 'Brother', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-04 15:52:07', '2025-11-04 15:52:07'),
(9, 22, 'MD MAYIN UDDIN', 'dsfsfd', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-28 16:30:52', '2025-11-28 16:30:52'),
(10, 23, 'MD MAYIN UDDIN', 'sfsdf', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-28 16:33:55', '2025-11-28 16:33:55'),
(11, 24, 'MD MAYIN UDDIN', 'sfsdf', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-28 16:35:55', '2025-11-28 16:35:55'),
(12, 25, 'MD MAYIN UDDIN', 'brother', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-28 16:37:39', '2025-11-28 16:37:39'),
(13, 26, 'MD MAYIN UDDIN', 'Brother', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-29 11:59:55', '2025-11-29 11:59:55'),
(14, 27, 'MD MAYIN UDDIN', 'sfsdf', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-29 12:01:58', '2025-11-29 12:01:58'),
(15, 28, 'MD MAYIN UDDIN', 'sfsdf', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-29 12:03:32', '2025-11-29 12:03:32'),
(16, 29, 'MD MAYIN UDDIN', 'sfsdf', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-29 12:05:07', '2025-11-29 12:05:07'),
(17, 30, 'MD MAYIN UDDIN', 'sfsdf', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-29 12:11:30', '2025-11-29 12:11:30');

-- --------------------------------------------------------

--
-- Table structure for table `employee_recruit_requests`
--

CREATE TABLE `employee_recruit_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `requested_by_employee_id` bigint(20) UNSIGNED NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `reviewed_by_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_employee_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rejection_reason` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_recruit_requests`
--

INSERT INTO `employee_recruit_requests` (`id`, `requested_by_employee_id`, `data`, `status`, `reviewed_by_user_id`, `created_employee_id`, `rejection_reason`, `created_at`, `updated_at`) VALUES
(1, 12, '{\"branch_id\":2,\"agent_id\":null,\"superior_id\":12,\"full_name_en\":\"ABDULLAH\",\"full_name_bn\":\"ABDULLAH\",\"father_name\":\"Kamrul Chowdhury\",\"mother_name\":\"Aysas\",\"email\":\"abk@gmail.com\",\"mobile\":\"019991231312\",\"national_id\":\"123213213\",\"date_of_birth\":\"1998-05-02\",\"marital_status\":\"Single\",\"religion\":null,\"gender\":null,\"nationality\":null,\"district\":\"Chittagong\",\"upazila\":\"fdsfds\",\"present_address\":\"300\\/A, North Sahajanpur,Dhaka\",\"permanent_address\":null,\"post_code\":\"12313\",\"rank\":\"ME\"}', 'approved', 10, 45, NULL, '2025-12-22 15:53:25', '2025-12-22 16:20:58'),
(2, 12, '{\"branch_id\":\"1\",\"agent_id\":null,\"superior_id\":12,\"full_name_en\":\"Mojahid\",\"full_name_bn\":\"Mojahid\",\"father_name\":\"adadasd\",\"mother_name\":\"sadad\",\"email\":\"mojahid@gmail.com\",\"mobile\":\"0199912321321\",\"national_id\":\"3423432432\",\"date_of_birth\":\"1998-05-02\",\"marital_status\":\"Single\",\"religion\":\"Islam\",\"gender\":\"Male\",\"nationality\":\"Bangladeshi\",\"district\":\"Dhaka\",\"upazila\":\"fdsfds\",\"present_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"permanent_address\":\"CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503\",\"post_code\":\"3503\",\"rank\":\"ME\"}', 'rejected', 10, NULL, NULL, '2025-12-22 16:32:07', '2025-12-22 16:36:28');

-- --------------------------------------------------------

--
-- Table structure for table `employee_wallets`
--

CREATE TABLE `employee_wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `balance` decimal(14,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employee_wallets`
--

INSERT INTO `employee_wallets` (`id`, `employee_id`, `balance`, `created_at`, `updated_at`) VALUES
(1, 19, 6000.00, '2025-11-04 18:28:53', '2025-12-10 17:30:54'),
(2, 16, 9000.00, '2025-11-04 18:29:25', '2025-12-22 18:45:22'),
(3, 15, 0.00, '2025-11-04 18:29:25', '2025-12-08 18:54:49'),
(4, 14, 0.00, '2025-11-04 18:29:25', '2025-12-10 16:51:53'),
(5, 13, 3600.00, '2025-11-04 18:29:25', '2025-12-22 18:45:22'),
(6, 12, 73099.00, '2025-11-04 18:29:25', '2025-12-23 04:29:13'),
(7, 22, 0.00, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(8, 26, 0.00, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(9, 27, 0.00, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(10, 28, 0.00, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(11, 29, 0.00, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(12, 30, 0.00, '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(13, 20, 0.00, '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(14, 17, 10800.00, '2025-12-22 18:45:22', '2025-12-22 18:45:22');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `journals`
--

CREATE TABLE `journals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tx_id` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `occurred_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `journals`
--

INSERT INTO `journals` (`id`, `tx_id`, `description`, `occurred_at`, `meta`, `created_at`, `updated_at`) VALUES
(1, 'JRNL-EXT-001', 'Manual adjustment', '2025-12-07 16:01:51', '{\"source\":\"manual\"}', '2025-12-07 16:01:51', '2025-12-07 16:01:51'),
(2, 'JRNL-a0897f43-f1ca-4c8e-ae4d-7b686ba23a9a', 'abc', '2025-12-07 16:14:21', '{\"source\":\"manual\"}', '2025-12-07 16:14:21', '2025-12-07 16:14:21'),
(3, 'JRNL-a0898134-6792-43cd-97f6-7c1871ee4fdf', 'abc', '2025-12-07 16:19:46', '{\"source\":\"manual\"}', '2025-12-07 16:19:46', '2025-12-07 16:19:46'),
(4, 'PDSB-1', NULL, '2025-12-08 18:54:49', '{\"employee_id\":12,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(5, 'PDSB-2', NULL, '2025-12-08 18:54:49', '{\"employee_id\":13,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(6, 'PDSB-3', NULL, '2025-12-08 18:54:49', '{\"employee_id\":15,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(7, 'PDSB-4', NULL, '2025-12-08 18:54:49', '{\"employee_id\":16,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(8, 'PDSB-5', NULL, '2025-12-08 18:54:49', '{\"employee_id\":14,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(9, 'PDSB-6', NULL, '2025-12-08 18:54:49', '{\"employee_id\":20,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(10, 'PDSB-7', NULL, '2025-12-09 17:19:32', '{\"employee_id\":12,\"month\":\"2025-11\"}', '2025-12-09 17:19:32', '2025-12-09 17:19:32'),
(11, 'PDSB-8', NULL, '2025-12-09 17:19:32', '{\"employee_id\":13,\"month\":\"2025-11\"}', '2025-12-09 17:19:32', '2025-12-09 17:19:32'),
(12, 'PMT-37', NULL, '2025-12-09 00:00:00', '{\"payment_id\":37,\"sales_order_id\":28,\"method\":\"cash\"}', '2025-12-09 18:12:08', '2025-12-09 18:12:08'),
(13, 'PMT-38', NULL, '2025-12-09 00:00:00', '{\"payment_id\":38,\"sales_order_id\":28,\"method\":\"cash\"}', '2025-12-09 18:12:45', '2025-12-09 18:12:45'),
(14, 'SUPP-PAYABLE-38-2', NULL, '2025-12-09 00:00:00', '{\"payment_id\":38,\"sales_order_id\":28,\"supplier_id\":2}', '2025-12-09 18:12:46', '2025-12-09 18:12:46'),
(15, 'PMT-39', NULL, '2025-12-10 00:00:00', '{\"payment_id\":39,\"sales_order_id\":29,\"method\":\"cash\"}', '2025-12-10 15:51:50', '2025-12-10 15:51:50'),
(16, 'CMS-46', NULL, '2025-12-10 16:51:53', '{\"commission_id\":46,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(17, 'CMS-47', NULL, '2025-12-10 16:51:53', '{\"commission_id\":47,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(18, 'CMS-48', NULL, '2025-12-10 16:51:53', '{\"commission_id\":48,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(19, 'CMS-49', NULL, '2025-12-10 16:51:53', '{\"commission_id\":49,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(20, 'CMS-50', NULL, '2025-12-10 16:51:53', '{\"commission_id\":50,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(21, 'CMS-51', NULL, '2025-12-10 16:51:53', '{\"commission_id\":51,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(22, 'CMS-52', NULL, '2025-12-10 16:51:53', '{\"commission_id\":52,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(23, 'CMS-53', NULL, '2025-12-10 16:51:53', '{\"commission_id\":53,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(24, 'CMS-54', NULL, '2025-12-10 16:51:53', '{\"commission_id\":54,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(25, 'CMS-55', NULL, '2025-12-10 16:51:53', '{\"commission_id\":55,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(26, 'CMS-56', NULL, '2025-12-10 16:51:53', '{\"commission_id\":56,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(27, 'CMS-57', NULL, '2025-12-10 16:51:53', '{\"commission_id\":57,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(28, 'CMS-58', NULL, '2025-12-10 16:51:54', '{\"commission_id\":58,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 16:51:54', '2025-12-10 16:51:54'),
(29, 'PMT-40', NULL, '2025-12-10 00:00:00', '{\"payment_id\":40,\"sales_order_id\":30,\"method\":\"cash\"}', '2025-12-10 16:58:51', '2025-12-10 16:58:51'),
(30, 'PMT-41', NULL, '2025-12-10 00:00:00', '{\"payment_id\":41,\"sales_order_id\":30,\"method\":\"cash\"}', '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(31, 'SUPP-PAYABLE-41-2', NULL, '2025-12-10 00:00:00', '{\"payment_id\":41,\"sales_order_id\":30,\"supplier_id\":2}', '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(32, 'CMS-1', NULL, '2025-12-10 16:59:33', '{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(33, 'CMS-2', NULL, '2025-12-10 16:59:33', '{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(34, 'PMT-42', NULL, '2025-12-10 00:00:00', '{\"payment_id\":42,\"sales_order_id\":36,\"method\":\"cash\"}', '2025-12-10 17:15:10', '2025-12-10 17:15:10'),
(35, 'PMT-43', NULL, '2025-12-10 00:00:00', '{\"payment_id\":43,\"sales_order_id\":41,\"method\":\"cash\"}', '2025-12-10 17:29:52', '2025-12-10 17:29:52'),
(36, 'PMT-44', NULL, '2025-12-10 00:00:00', '{\"payment_id\":44,\"sales_order_id\":41,\"method\":\"cash\"}', '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(37, 'SUPP-PAYABLE-44-1', NULL, '2025-12-10 00:00:00', '{\"payment_id\":44,\"sales_order_id\":41,\"supplier_id\":1}', '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(38, 'CMS-3', NULL, '2025-12-10 17:30:54', '{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(39, 'CMS-4', NULL, '2025-12-10 17:30:54', '{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(40, 'CMS-5', NULL, '2025-12-10 17:30:54', '{\"commission_id\":5,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(41, 'CMS-6', NULL, '2025-12-10 17:30:54', '{\"commission_id\":6,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(42, 'PMT-45', NULL, '2025-12-10 00:00:00', '{\"payment_id\":45,\"sales_order_id\":44,\"method\":\"cash\"}', '2025-12-10 17:50:44', '2025-12-10 17:50:44'),
(43, 'PMT-46', NULL, '2025-12-10 00:00:00', '{\"payment_id\":46,\"sales_order_id\":44,\"method\":\"cash\"}', '2025-12-10 17:50:49', '2025-12-10 17:50:49'),
(44, 'SUPP-PAYABLE-46-2', NULL, '2025-12-10 00:00:00', '{\"payment_id\":46,\"sales_order_id\":44,\"supplier_id\":2}', '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(45, 'PMT-47', NULL, '2025-12-10 00:00:00', '{\"payment_id\":47,\"sales_order_id\":45,\"method\":\"cash\"}', '2025-12-10 18:15:24', '2025-12-10 18:15:24'),
(46, 'PMT-48', NULL, '2025-12-10 00:00:00', '{\"payment_id\":48,\"sales_order_id\":45,\"method\":\"cash\"}', '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(47, 'SUPP-PAYABLE-48-2', NULL, '2025-12-10 00:00:00', '{\"payment_id\":48,\"sales_order_id\":45,\"supplier_id\":2}', '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(48, 'CMS-7', NULL, '2025-12-10 18:21:21', '{\"commission_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(49, 'CMS-8', NULL, '2025-12-10 18:21:21', '{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(50, 'CMS-9', NULL, '2025-12-10 18:21:21', '{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(51, 'CMS-10', NULL, '2025-12-10 18:21:21', '{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(52, 'PMT-49', NULL, '2025-12-11 00:00:00', '{\"payment_id\":49,\"sales_order_id\":46,\"method\":\"cash\"}', '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(53, 'SUPP-PAYABLE-49-1', NULL, '2025-12-11 00:00:00', '{\"payment_id\":49,\"sales_order_id\":46,\"supplier_id\":1}', '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(54, 'CMS-11', NULL, '2025-12-11 18:20:19', '{\"commission_id\":11,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}', '2025-12-11 18:20:19', '2025-12-11 18:20:19'),
(55, 'PMT-50', NULL, '2025-12-11 00:00:00', '{\"payment_id\":50,\"sales_order_id\":48,\"method\":\"cash\"}', '2025-12-11 19:35:20', '2025-12-11 19:35:20'),
(56, 'PMT-51', NULL, '2025-12-11 00:00:00', '{\"payment_id\":51,\"sales_order_id\":48,\"method\":\"cash\"}', '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(57, 'SUPP-PAYABLE-51-1', NULL, '2025-12-11 00:00:00', '{\"payment_id\":51,\"sales_order_id\":48,\"supplier_id\":1}', '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(58, 'PMT-52', NULL, '2025-12-11 00:00:00', '{\"payment_id\":52,\"sales_order_id\":50,\"method\":\"cash\"}', '2025-12-11 19:44:22', '2025-12-11 19:44:22'),
(59, 'CMS-12', NULL, '2025-12-11 19:45:39', '{\"commission_id\":12,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}', '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(60, 'CMS-13', NULL, '2025-12-11 19:45:39', '{\"commission_id\":13,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}', '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(61, 'CMS-14', NULL, '2025-12-11 19:45:39', '{\"commission_id\":14,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}', '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(62, 'wallet_withdrawal_1', NULL, '2025-12-14 16:01:18', '{\"withdraw_request_id\":1,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}', '2025-12-14 16:01:18', '2025-12-14 16:01:18'),
(63, 'wallet_withdrawal_4', NULL, '2025-12-14 16:19:54', '{\"withdraw_request_id\":4,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}', '2025-12-14 16:19:54', '2025-12-14 16:19:54'),
(64, 'wallet_withdrawal_7', NULL, '2025-12-14 19:14:59', '{\"withdraw_request_id\":7,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}', '2025-12-14 19:14:59', '2025-12-14 19:14:59'),
(65, 'wallet_withdrawal_5', NULL, '2025-12-14 19:17:37', '{\"withdraw_request_id\":5,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}', '2025-12-14 19:17:37', '2025-12-14 19:17:37'),
(66, 'wallet_withdrawal_6', NULL, '2025-12-14 19:18:36', '{\"withdraw_request_id\":6,\"user_type\":\"agent\",\"user_id\":6,\"method\":\"bkash\"}', '2025-12-14 19:18:36', '2025-12-14 19:18:36'),
(67, 'PMT-53', NULL, '2025-12-22 00:00:00', '{\"payment_id\":53,\"sales_order_id\":52,\"method\":\"cash\"}', '2025-12-22 18:27:16', '2025-12-22 18:27:16'),
(68, 'CMS-15', NULL, '2025-12-22 18:27:17', '{\"commission_id\":15,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(69, 'PMT-54', NULL, '2025-12-22 00:00:00', '{\"payment_id\":54,\"sales_order_id\":53,\"method\":\"cash\"}', '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(70, 'CMS-16', NULL, '2025-12-22 18:33:48', '{\"commission_id\":16,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(71, 'PMT-55', NULL, '2025-12-22 00:00:00', '{\"payment_id\":55,\"sales_order_id\":54,\"method\":\"cash\"}', '2025-12-22 18:36:43', '2025-12-22 18:36:43'),
(72, 'PMT-56', NULL, '2025-12-22 00:00:00', '{\"payment_id\":56,\"sales_order_id\":55,\"method\":\"cash\"}', '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(73, 'CMS-17', NULL, '2025-12-22 18:45:22', '{\"commission_id\":17,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(74, 'CMS-18', NULL, '2025-12-22 18:45:22', '{\"commission_id\":18,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(75, 'CMS-19', NULL, '2025-12-22 18:45:22', '{\"commission_id\":19,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(76, 'CMS-20', NULL, '2025-12-22 18:45:22', '{\"commission_id\":20,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(77, 'CMS-21', NULL, '2025-12-22 18:45:22', '{\"commission_id\":21,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":17}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(78, 'CMS-22', NULL, '2025-12-22 18:45:22', '{\"commission_id\":22,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(79, 'CMS-23', NULL, '2025-12-22 18:45:22', '{\"commission_id\":23,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(80, 'CMS-24', NULL, '2025-12-22 18:45:22', '{\"commission_id\":24,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(81, 'PMT-57', NULL, '2025-12-23 00:00:00', '{\"payment_id\":57,\"sales_order_id\":56,\"method\":\"cash\"}', '2025-12-23 04:27:57', '2025-12-23 04:27:57'),
(82, 'CMS-25', NULL, '2025-12-23 04:29:13', '{\"commission_id\":25,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(83, 'CMS-26', NULL, '2025-12-23 04:29:13', '{\"commission_id\":26,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-23 04:29:13', '2025-12-23 04:29:13');

-- --------------------------------------------------------

--
-- Table structure for table `land_lots`
--

CREATE TABLE `land_lots` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ledger_accounts`
--

CREATE TABLE `ledger_accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ledger_accounts`
--

INSERT INTO `ledger_accounts` (`id`, `code`, `name`, `type`, `meta`, `created_at`, `updated_at`) VALUES
(1, '101', 'Cash', 'asset', '{\"note\":\"abc\"}', '2025-10-20 13:59:03', '2025-12-07 15:56:41'),
(2, '102', 'Bank', 'asset', '{\"key\":\"bank\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(3, '110', 'Accounts Receivable', 'asset', '{\"key\":\"accounts_receivable\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(4, '510', 'Commission Expense', 'expense', '{\"key\":\"commission_expense\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(5, '210', 'Commission Payable', 'liability', '{\"key\":\"commission_payable\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(6, '220', 'Incentive Fund Payable', 'liability', '{\"key\":\"incentive_fund\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(7, '520', 'Supplier Cost Expense', 'expense', NULL, '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(8, '230', 'Supplier Payable', 'liability', NULL, '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(9, '601', 'Labber cost', 'liability', '{\"note\":\"abc\"}', '2025-12-07 15:57:34', '2025-12-07 17:07:41'),
(10, 'employee_wallet', 'Employee Wallet Payable', 'liability', NULL, '2025-12-14 16:01:18', '2025-12-14 16:01:18'),
(11, 'bkash', 'Bkash Payout', 'asset', NULL, '2025-12-14 16:01:18', '2025-12-14 16:01:18'),
(12, 'agent_wallet', 'Agent Wallet Payable', 'liability', NULL, '2025-12-14 19:18:36', '2025-12-14 19:18:36');

-- --------------------------------------------------------

--
-- Table structure for table `ledger_entries`
--

CREATE TABLE `ledger_entries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `journal_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tx_id` varchar(255) NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `debit` decimal(14,2) NOT NULL DEFAULT 0.00,
  `credit` decimal(14,2) NOT NULL DEFAULT 0.00,
  `occurred_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ledger_entries`
--

INSERT INTO `ledger_entries` (`id`, `journal_id`, `tx_id`, `account_id`, `debit`, `credit`, `occurred_at`, `meta`, `created_at`, `updated_at`) VALUES
(1, NULL, 'PMT-1', 1, 60000.00, 0.00, '2025-11-04 00:00:00', '{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"cash\"}', '2025-11-04 17:33:59', '2025-11-04 17:33:59'),
(2, NULL, 'PMT-1', 3, 0.00, 60000.00, '2025-11-04 00:00:00', '{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"cash\"}', '2025-11-04 17:33:59', '2025-11-04 17:33:59'),
(3, NULL, 'PMT-2', 1, 71000.00, 0.00, '2025-11-04 00:00:00', '{\"payment_id\":2,\"sales_order_id\":3,\"method\":\"cash\"}', '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(4, NULL, 'PMT-2', 3, 0.00, 71000.00, '2025-11-04 00:00:00', '{\"payment_id\":2,\"sales_order_id\":3,\"method\":\"cash\"}', '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(5, NULL, 'PMT-3', 1, 20000.00, 0.00, '2025-11-04 00:00:00', '{\"payment_id\":3,\"sales_order_id\":4,\"method\":\"cash\"}', '2025-11-04 18:10:28', '2025-11-04 18:10:28'),
(6, NULL, 'PMT-3', 3, 0.00, 20000.00, '2025-11-04 00:00:00', '{\"payment_id\":3,\"sales_order_id\":4,\"method\":\"cash\"}', '2025-11-04 18:10:29', '2025-11-04 18:10:29'),
(7, NULL, 'PMT-4', 1, 30000.00, 0.00, '2025-11-04 00:00:00', '{\"payment_id\":4,\"sales_order_id\":5,\"method\":\"cash\"}', '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(8, NULL, 'PMT-4', 3, 0.00, 30000.00, '2025-11-04 00:00:00', '{\"payment_id\":4,\"sales_order_id\":5,\"method\":\"cash\"}', '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(9, NULL, 'CMS-1', 4, 3000.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(10, NULL, 'CMS-1', 5, 0.00, 3000.00, '2025-11-04 18:29:25', '{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(11, NULL, 'CMS-2', 4, 7100.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(12, NULL, 'CMS-2', 5, 0.00, 7100.00, '2025-11-04 18:29:25', '{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(13, NULL, 'CMS-3', 4, 3550.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":15}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(14, NULL, 'CMS-3', 5, 0.00, 3550.00, '2025-11-04 18:29:25', '{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":15}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(15, NULL, 'CMS-4', 4, 3550.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(16, NULL, 'CMS-4', 5, 0.00, 3550.00, '2025-11-04 18:29:25', '{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(17, NULL, 'CMS-5', 4, 3550.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":5,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(18, NULL, 'CMS-5', 5, 0.00, 3550.00, '2025-11-04 18:29:25', '{\"commission_id\":5,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(19, NULL, 'CMS-6', 4, 3550.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":6,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(20, NULL, 'CMS-6', 5, 0.00, 3550.00, '2025-11-04 18:29:25', '{\"commission_id\":6,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(21, NULL, 'CMS-7', 4, 1000.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(22, NULL, 'CMS-7', 5, 0.00, 1000.00, '2025-11-04 18:29:25', '{\"commission_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(23, NULL, 'CMS-8', 4, 3000.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(24, NULL, 'CMS-8', 5, 0.00, 3000.00, '2025-11-04 18:29:25', '{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(25, NULL, 'CMS-9', 4, 6000.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(26, NULL, 'CMS-9', 5, 0.00, 6000.00, '2025-11-04 18:29:25', '{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(27, NULL, 'PMT-5', 1, 20000.00, 0.00, '2025-11-04 00:00:00', '{\"payment_id\":5,\"sales_order_id\":6,\"method\":\"cash\"}', '2025-11-04 18:48:21', '2025-11-04 18:48:21'),
(28, NULL, 'PMT-5', 3, 0.00, 20000.00, '2025-11-04 00:00:00', '{\"payment_id\":5,\"sales_order_id\":6,\"method\":\"cash\"}', '2025-11-04 18:48:21', '2025-11-04 18:48:21'),
(29, NULL, 'CMS-10', 4, 1000.00, 0.00, '2025-11-04 18:49:15', '{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-04 18:49:15', '2025-11-04 18:49:15'),
(30, NULL, 'CMS-10', 5, 0.00, 1000.00, '2025-11-04 18:49:15', '{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-04 18:49:15', '2025-11-04 18:49:15'),
(31, NULL, 'PMT-6', 1, 50000.00, 0.00, '2025-11-05 00:00:00', '{\"payment_id\":6,\"sales_order_id\":7,\"method\":\"cash\"}', '2025-11-05 06:11:59', '2025-11-05 06:11:59'),
(32, NULL, 'PMT-6', 3, 0.00, 50000.00, '2025-11-05 00:00:00', '{\"payment_id\":6,\"sales_order_id\":7,\"method\":\"cash\"}', '2025-11-05 06:11:59', '2025-11-05 06:11:59'),
(33, NULL, 'CMS-11', 4, 2500.00, 0.00, '2025-11-05 06:13:27', '{\"commission_id\":11,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-05 06:13:27', '2025-11-05 06:13:27'),
(34, NULL, 'CMS-11', 5, 0.00, 2500.00, '2025-11-05 06:13:27', '{\"commission_id\":11,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-05 06:13:27', '2025-11-05 06:13:27'),
(35, NULL, 'PMT-7', 1, 50000.00, 0.00, '2025-11-11 00:00:00', '{\"payment_id\":7,\"sales_order_id\":10,\"method\":\"cash\"}', '2025-11-11 15:59:49', '2025-11-11 15:59:49'),
(36, NULL, 'PMT-7', 3, 0.00, 50000.00, '2025-11-11 00:00:00', '{\"payment_id\":7,\"sales_order_id\":10,\"method\":\"cash\"}', '2025-11-11 15:59:49', '2025-11-11 15:59:49'),
(37, NULL, 'PMT-8', 1, 37500.00, 0.00, '2025-11-11 00:00:00', '{\"payment_id\":8,\"sales_order_id\":10,\"method\":\"bank_transfer\"}', '2025-11-11 16:02:14', '2025-11-11 16:02:14'),
(38, NULL, 'PMT-8', 3, 0.00, 37500.00, '2025-11-11 00:00:00', '{\"payment_id\":8,\"sales_order_id\":10,\"method\":\"bank_transfer\"}', '2025-11-11 16:02:14', '2025-11-11 16:02:14'),
(39, NULL, 'PMT-9', 1, 50000.00, 0.00, '2025-11-11 00:00:00', '{\"payment_id\":9,\"sales_order_id\":11,\"method\":\"cash\"}', '2025-11-11 16:08:16', '2025-11-11 16:08:16'),
(40, NULL, 'PMT-9', 3, 0.00, 50000.00, '2025-11-11 00:00:00', '{\"payment_id\":9,\"sales_order_id\":11,\"method\":\"cash\"}', '2025-11-11 16:08:16', '2025-11-11 16:08:16'),
(41, NULL, 'PMT-10', 1, 37500.00, 0.00, '2025-11-11 00:00:00', '{\"payment_id\":10,\"sales_order_id\":11,\"method\":\"cash\"}', '2025-11-11 16:11:45', '2025-11-11 16:11:45'),
(42, NULL, 'PMT-10', 3, 0.00, 37500.00, '2025-11-11 00:00:00', '{\"payment_id\":10,\"sales_order_id\":11,\"method\":\"cash\"}', '2025-11-11 16:11:45', '2025-11-11 16:11:45'),
(43, NULL, 'PMT-11', 1, 50000.00, 0.00, '2025-11-11 00:00:00', '{\"payment_id\":11,\"sales_order_id\":12,\"method\":\"cash\"}', '2025-11-11 17:02:08', '2025-11-11 17:02:08'),
(44, NULL, 'PMT-11', 3, 0.00, 50000.00, '2025-11-11 00:00:00', '{\"payment_id\":11,\"sales_order_id\":12,\"method\":\"cash\"}', '2025-11-11 17:02:08', '2025-11-11 17:02:08'),
(45, NULL, 'PMT-12', 1, 37500.00, 0.00, '2025-11-11 00:00:00', '{\"payment_id\":12,\"sales_order_id\":12,\"method\":\"cash\"}', '2025-11-11 17:03:52', '2025-11-11 17:03:52'),
(46, NULL, 'PMT-12', 3, 0.00, 37500.00, '2025-11-11 00:00:00', '{\"payment_id\":12,\"sales_order_id\":12,\"method\":\"cash\"}', '2025-11-11 17:03:52', '2025-11-11 17:03:52'),
(47, NULL, 'PMT-13', 1, 50000.00, 0.00, '2025-11-12 00:00:00', '{\"payment_id\":13,\"sales_order_id\":14,\"method\":\"cash\"}', '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(48, NULL, 'PMT-13', 3, 0.00, 50000.00, '2025-11-12 00:00:00', '{\"payment_id\":13,\"sales_order_id\":14,\"method\":\"cash\"}', '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(49, NULL, 'SUPP-PAYABLE-13-1', 7, 10000.00, 0.00, '2025-11-12 00:00:00', '{\"payment_id\":13,\"sales_order_id\":14,\"supplier_id\":1}', '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(50, NULL, 'SUPP-PAYABLE-13-1', 8, 0.00, 10000.00, '2025-11-12 00:00:00', '{\"payment_id\":13,\"sales_order_id\":14,\"supplier_id\":1}', '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(51, NULL, 'PMT-14', 1, 37500.00, 0.00, '2025-11-12 00:00:00', '{\"payment_id\":14,\"sales_order_id\":14,\"method\":\"cash\"}', '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(52, NULL, 'PMT-14', 3, 0.00, 37500.00, '2025-11-12 00:00:00', '{\"payment_id\":14,\"sales_order_id\":14,\"method\":\"cash\"}', '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(53, NULL, 'SUPP-PAYABLE-14-1', 7, 7500.00, 0.00, '2025-11-12 00:00:00', '{\"payment_id\":14,\"sales_order_id\":14,\"supplier_id\":1}', '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(54, NULL, 'SUPP-PAYABLE-14-1', 8, 0.00, 7500.00, '2025-11-12 00:00:00', '{\"payment_id\":14,\"sales_order_id\":14,\"supplier_id\":1}', '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(55, NULL, 'PMT-15', 1, 50000.00, 0.00, '2025-11-13 00:00:00', '{\"payment_id\":15,\"sales_order_id\":15,\"method\":\"cash\"}', '2025-11-13 04:33:17', '2025-11-13 04:33:17'),
(56, NULL, 'PMT-15', 3, 0.00, 50000.00, '2025-11-13 00:00:00', '{\"payment_id\":15,\"sales_order_id\":15,\"method\":\"cash\"}', '2025-11-13 04:33:17', '2025-11-13 04:33:17'),
(57, NULL, 'PMT-16', 1, 37500.00, 0.00, '2025-11-13 00:00:00', '{\"payment_id\":16,\"sales_order_id\":15,\"method\":\"cash\"}', '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(58, NULL, 'PMT-16', 3, 0.00, 37500.00, '2025-11-13 00:00:00', '{\"payment_id\":16,\"sales_order_id\":15,\"method\":\"cash\"}', '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(59, NULL, 'SUPP-PAYABLE-16-1', 7, 7500.00, 0.00, '2025-11-13 00:00:00', '{\"payment_id\":16,\"sales_order_id\":15,\"supplier_id\":1}', '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(60, NULL, 'SUPP-PAYABLE-16-1', 8, 0.00, 7500.00, '2025-11-13 00:00:00', '{\"payment_id\":16,\"sales_order_id\":15,\"supplier_id\":1}', '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(61, NULL, 'PMT-17', 1, 50000.00, 0.00, '2025-11-16 00:00:00', '{\"payment_id\":17,\"sales_order_id\":16,\"method\":\"cash\"}', '2025-11-16 16:12:17', '2025-11-16 16:12:17'),
(62, NULL, 'PMT-17', 3, 0.00, 50000.00, '2025-11-16 00:00:00', '{\"payment_id\":17,\"sales_order_id\":16,\"method\":\"cash\"}', '2025-11-16 16:12:17', '2025-11-16 16:12:17'),
(63, NULL, 'PMT-18', 1, 100000.00, 0.00, '2025-11-19 00:00:00', '{\"payment_id\":18,\"sales_order_id\":17,\"method\":\"cash\"}', '2025-11-19 09:24:32', '2025-11-19 09:24:32'),
(64, NULL, 'PMT-18', 3, 0.00, 100000.00, '2025-11-19 00:00:00', '{\"payment_id\":18,\"sales_order_id\":17,\"method\":\"cash\"}', '2025-11-19 09:24:32', '2025-11-19 09:24:32'),
(65, NULL, 'PMT-19', 1, 33333.34, 0.00, '2025-11-19 00:00:00', '{\"payment_id\":19,\"sales_order_id\":17,\"method\":\"cheque\"}', '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(66, NULL, 'PMT-19', 3, 0.00, 33333.34, '2025-11-19 00:00:00', '{\"payment_id\":19,\"sales_order_id\":17,\"method\":\"cheque\"}', '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(67, NULL, 'SUPP-PAYABLE-19-2', 7, 5000.00, 0.00, '2025-11-19 00:00:00', '{\"payment_id\":19,\"sales_order_id\":17,\"supplier_id\":2}', '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(68, NULL, 'SUPP-PAYABLE-19-2', 8, 0.00, 5000.00, '2025-11-19 00:00:00', '{\"payment_id\":19,\"sales_order_id\":17,\"supplier_id\":2}', '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(69, NULL, 'CMS-12', 4, 6750.00, 0.00, '2025-11-19 09:26:40', '{\"commission_id\":12,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-11-19 09:26:40', '2025-11-19 09:26:40'),
(70, NULL, 'CMS-12', 5, 0.00, 6750.00, '2025-11-19 09:26:40', '{\"commission_id\":12,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-11-19 09:26:40', '2025-11-19 09:26:40'),
(71, NULL, 'CMS-13', 4, 2250.00, 0.00, '2025-11-19 09:26:40', '{\"commission_id\":13,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-11-19 09:26:40', '2025-11-19 09:26:40'),
(72, NULL, 'CMS-13', 5, 0.00, 2250.00, '2025-11-19 09:26:40', '{\"commission_id\":13,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(73, NULL, 'CMS-14', 4, 2250.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":14,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(74, NULL, 'CMS-14', 5, 0.00, 2250.00, '2025-11-19 09:26:41', '{\"commission_id\":14,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(75, NULL, 'CMS-15', 4, 2250.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":15,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(76, NULL, 'CMS-15', 5, 0.00, 2250.00, '2025-11-19 09:26:41', '{\"commission_id\":15,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(77, NULL, 'CMS-16', 4, 1687.50, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":16,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(78, NULL, 'CMS-16', 5, 0.00, 1687.50, '2025-11-19 09:26:41', '{\"commission_id\":16,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(79, NULL, 'CMS-17', 4, 337.50, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":17,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(80, NULL, 'CMS-17', 5, 0.00, 337.50, '2025-11-19 09:26:41', '{\"commission_id\":17,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(81, NULL, 'CMS-18', 4, 1012.50, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":18,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(82, NULL, 'CMS-18', 5, 0.00, 1012.50, '2025-11-19 09:26:41', '{\"commission_id\":18,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(83, NULL, 'CMS-19', 4, 675.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":19,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(84, NULL, 'CMS-19', 5, 0.00, 675.00, '2025-11-19 09:26:41', '{\"commission_id\":19,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(85, NULL, 'CMS-20', 4, 4500.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":20,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(86, NULL, 'CMS-20', 5, 0.00, 4500.00, '2025-11-19 09:26:41', '{\"commission_id\":20,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(87, NULL, 'CMS-21', 4, 9000.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":21,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(88, NULL, 'CMS-21', 5, 0.00, 9000.00, '2025-11-19 09:26:41', '{\"commission_id\":21,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(89, NULL, 'CMS-22', 4, 1350.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":22,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(90, NULL, 'CMS-22', 5, 0.00, 1350.00, '2025-11-19 09:26:41', '{\"commission_id\":22,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(91, NULL, 'CMS-23', 4, 2362.50, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":23,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(92, NULL, 'CMS-23', 5, 0.00, 2362.50, '2025-11-19 09:26:41', '{\"commission_id\":23,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(93, NULL, 'CMS-24', 4, 6000.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":24,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(94, NULL, 'CMS-24', 5, 0.00, 6000.00, '2025-11-19 09:26:41', '{\"commission_id\":24,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(95, NULL, 'CMS-25', 4, 6000.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":25,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(96, NULL, 'CMS-25', 5, 0.00, 6000.00, '2025-11-19 09:26:41', '{\"commission_id\":25,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(97, NULL, 'CMS-26', 4, 1500.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":26,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(98, NULL, 'CMS-26', 5, 0.00, 1500.00, '2025-11-19 09:26:41', '{\"commission_id\":26,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(99, NULL, 'CMS-27', 4, 1800.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":27,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(100, NULL, 'CMS-27', 5, 0.00, 1800.00, '2025-11-19 09:26:41', '{\"commission_id\":27,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(101, NULL, 'CMS-28', 4, 5250.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":28,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(102, NULL, 'CMS-28', 5, 0.00, 5250.00, '2025-11-19 09:26:41', '{\"commission_id\":28,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(103, NULL, 'CMS-29', 4, 5250.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":29,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(104, NULL, 'CMS-29', 5, 0.00, 5250.00, '2025-11-19 09:26:41', '{\"commission_id\":29,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(105, NULL, 'CMS-30', 4, 1312.50, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":30,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(106, NULL, 'CMS-30', 5, 0.00, 1312.50, '2025-11-19 09:26:41', '{\"commission_id\":30,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(107, NULL, 'CMS-31', 4, 1575.00, 0.00, '2025-11-19 09:26:41', '{\"commission_id\":31,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(108, NULL, 'CMS-31', 5, 0.00, 1575.00, '2025-11-19 09:26:41', '{\"commission_id\":31,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:41', '2025-11-19 09:26:41'),
(109, NULL, 'CMS-32', 4, 6000.00, 0.00, '2025-11-19 09:26:42', '{\"commission_id\":32,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(110, NULL, 'CMS-32', 5, 0.00, 6000.00, '2025-11-19 09:26:42', '{\"commission_id\":32,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(111, NULL, 'CMS-33', 4, 6000.00, 0.00, '2025-11-19 09:26:42', '{\"commission_id\":33,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(112, NULL, 'CMS-33', 5, 0.00, 6000.00, '2025-11-19 09:26:42', '{\"commission_id\":33,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(113, NULL, 'CMS-34', 4, 1500.00, 0.00, '2025-11-19 09:26:42', '{\"commission_id\":34,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(114, NULL, 'CMS-34', 5, 0.00, 1500.00, '2025-11-19 09:26:42', '{\"commission_id\":34,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(115, NULL, 'CMS-35', 4, 1800.00, 0.00, '2025-11-19 09:26:42', '{\"commission_id\":35,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(116, NULL, 'CMS-35', 5, 0.00, 1800.00, '2025-11-19 09:26:42', '{\"commission_id\":35,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(117, NULL, 'CMS-36', 4, 10500.00, 0.00, '2025-11-19 09:26:42', '{\"commission_id\":36,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(118, NULL, 'CMS-36', 5, 0.00, 10500.00, '2025-11-19 09:26:42', '{\"commission_id\":36,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(119, NULL, 'CMS-37', 4, 4500.00, 0.00, '2025-11-19 09:26:42', '{\"commission_id\":37,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(120, NULL, 'CMS-37', 5, 0.00, 4500.00, '2025-11-19 09:26:42', '{\"commission_id\":37,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(121, NULL, 'CMS-38', 4, 300.00, 0.00, '2025-11-19 09:26:42', '{\"commission_id\":38,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(122, NULL, 'CMS-38', 5, 0.00, 300.00, '2025-11-19 09:26:42', '{\"commission_id\":38,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-19 09:26:42', '2025-11-19 09:26:42'),
(123, NULL, 'INC-9', 4, 3587.50, 0.00, '2025-11-25 16:25:32', '{\"employee_id\":12,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-25 16:25:32', '2025-11-25 16:25:32'),
(124, NULL, 'INC-9', 6, 0.00, 3587.50, '2025-11-25 16:25:32', '{\"employee_id\":12,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-25 16:25:32', '2025-11-25 16:25:32'),
(125, NULL, 'INC-10', 4, 787.50, 0.00, '2025-11-25 16:58:20', '{\"employee_id\":13,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-25 16:58:20', '2025-11-25 16:58:20'),
(126, NULL, 'INC-10', 6, 0.00, 787.50, '2025-11-25 16:58:20', '{\"employee_id\":13,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-25 16:58:20', '2025-11-25 16:58:20'),
(127, NULL, 'INC-11', 4, 787.50, 0.00, '2025-11-25 16:58:47', '{\"employee_id\":14,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-25 16:58:47', '2025-11-25 16:58:47'),
(128, NULL, 'INC-11', 6, 0.00, 787.50, '2025-11-25 16:58:47', '{\"employee_id\":14,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-25 16:58:47', '2025-11-25 16:58:47'),
(129, NULL, 'INC-13', 4, 3587.50, 0.00, '2025-11-25 17:02:35', '{\"employee_id\":12,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-25 17:02:35', '2025-11-25 17:02:35'),
(130, NULL, 'INC-13', 6, 0.00, 3587.50, '2025-11-25 17:02:35', '{\"employee_id\":12,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-25 17:02:35', '2025-11-25 17:02:35'),
(131, NULL, 'INC-17', 4, 3587.50, 0.00, '2025-11-26 11:11:07', '{\"employee_id\":12,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-26 11:11:07', '2025-11-26 11:11:07'),
(132, NULL, 'INC-17', 6, 0.00, 3587.50, '2025-11-26 11:11:07', '{\"employee_id\":12,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-26 11:11:07', '2025-11-26 11:11:07'),
(133, NULL, 'INC-18', 4, 787.50, 0.00, '2025-11-26 11:11:07', '{\"employee_id\":13,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-26 11:11:07', '2025-11-26 11:11:07'),
(134, NULL, 'INC-18', 6, 0.00, 787.50, '2025-11-26 11:11:07', '{\"employee_id\":13,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-26 11:11:07', '2025-11-26 11:11:07'),
(135, NULL, 'INC-20', 4, 787.50, 0.00, '2025-11-26 11:11:07', '{\"employee_id\":15,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-26 11:11:07', '2025-11-26 11:11:07'),
(136, NULL, 'INC-20', 6, 0.00, 787.50, '2025-11-26 11:11:07', '{\"employee_id\":15,\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\"}', '2025-11-26 11:11:07', '2025-11-26 11:11:07'),
(137, NULL, 'PMT-20', 1, 50000.00, 0.00, '2025-11-29 00:00:00', '{\"payment_id\":20,\"sales_order_id\":18,\"method\":\"cash\"}', '2025-11-29 15:02:10', '2025-11-29 15:02:10'),
(138, NULL, 'PMT-20', 3, 0.00, 50000.00, '2025-11-29 00:00:00', '{\"payment_id\":20,\"sales_order_id\":18,\"method\":\"cash\"}', '2025-11-29 15:02:10', '2025-11-29 15:02:10'),
(139, NULL, 'DIRF-1', 4, 3725.00, 0.00, '2025-11-29 17:30:07', '{\"employee_id\":22,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}', '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(140, NULL, 'DIRF-1', 6, 0.00, 3725.00, '2025-11-29 17:30:07', '{\"employee_id\":22,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}', '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(141, NULL, 'DIRF-2', 4, 3725.00, 0.00, '2025-11-29 17:30:07', '{\"employee_id\":26,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}', '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(142, NULL, 'DIRF-2', 6, 0.00, 3725.00, '2025-11-29 17:30:07', '{\"employee_id\":26,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}', '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(143, NULL, 'DIRF-3', 4, 3725.00, 0.00, '2025-11-29 17:30:07', '{\"employee_id\":27,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}', '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(144, NULL, 'DIRF-3', 6, 0.00, 3725.00, '2025-11-29 17:30:07', '{\"employee_id\":27,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}', '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(145, NULL, 'DIRF-4', 4, 3725.00, 0.00, '2025-11-29 17:30:07', '{\"employee_id\":28,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}', '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(146, NULL, 'DIRF-4', 6, 0.00, 3725.00, '2025-11-29 17:30:07', '{\"employee_id\":28,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}', '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(147, NULL, 'DIRF-5', 4, 3725.00, 0.00, '2025-11-29 17:30:07', '{\"employee_id\":29,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}', '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(148, NULL, 'DIRF-5', 6, 0.00, 3725.00, '2025-11-29 17:30:07', '{\"employee_id\":29,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}', '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(149, NULL, 'DIRF-6', 4, 3725.00, 0.00, '2025-11-29 17:30:07', '{\"employee_id\":30,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}', '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(150, NULL, 'DIRF-6', 6, 0.00, 3725.00, '2025-11-29 17:30:07', '{\"employee_id\":30,\"type\":\"ed\",\"period_start\":\"2025-11-01\",\"period_end\":\"2025-11-30\",\"percentage_used\":\"4.00\"}', '2025-11-29 17:30:07', '2025-11-29 17:30:07'),
(151, NULL, 'PMT-21', 1, 5000.00, 0.00, '2025-02-12 00:00:00', '{\"payment_id\":21,\"sales_order_id\":1,\"method\":\"cash\"}', '2025-12-01 18:58:12', '2025-12-01 18:58:12'),
(152, NULL, 'PMT-21', 3, 0.00, 5000.00, '2025-02-12 00:00:00', '{\"payment_id\":21,\"sales_order_id\":1,\"method\":\"cash\"}', '2025-12-01 18:58:12', '2025-12-01 18:58:12'),
(155, NULL, 'PMT-23', 1, 5000.00, 0.00, '2025-02-12 00:00:00', '{\"payment_id\":23,\"sales_order_id\":1,\"method\":\"cash\"}', '2025-12-01 19:00:50', '2025-12-01 19:00:50'),
(156, NULL, 'PMT-23', 3, 0.00, 5000.00, '2025-02-12 00:00:00', '{\"payment_id\":23,\"sales_order_id\":1,\"method\":\"cash\"}', '2025-12-01 19:00:50', '2025-12-01 19:00:50'),
(165, NULL, 'PMT-28', 1, 50000.00, 0.00, '2025-12-01 00:00:00', '{\"payment_id\":28,\"sales_order_id\":22,\"method\":\"cash\"}', '2025-12-01 19:16:55', '2025-12-01 19:16:55'),
(166, NULL, 'PMT-28', 3, 0.00, 50000.00, '2025-12-01 00:00:00', '{\"payment_id\":28,\"sales_order_id\":22,\"method\":\"cash\"}', '2025-12-01 19:16:55', '2025-12-01 19:16:55'),
(167, NULL, 'PMT-29', 1, 5000.00, 0.00, '2025-12-01 00:00:00', '{\"payment_id\":29,\"sales_order_id\":22,\"method\":\"cash\"}', '2025-12-01 19:24:11', '2025-12-01 19:24:11'),
(168, NULL, 'PMT-29', 3, 0.00, 5000.00, '2025-12-01 00:00:00', '{\"payment_id\":29,\"sales_order_id\":22,\"method\":\"cash\"}', '2025-12-01 19:24:11', '2025-12-01 19:24:11'),
(169, NULL, 'PMT-30', 1, 5000.00, 0.00, '2025-12-01 00:00:00', '{\"payment_id\":30,\"sales_order_id\":21,\"method\":\"cash\"}', '2025-12-01 19:25:21', '2025-12-01 19:25:21'),
(170, NULL, 'PMT-30', 3, 0.00, 5000.00, '2025-12-01 00:00:00', '{\"payment_id\":30,\"sales_order_id\":21,\"method\":\"cash\"}', '2025-12-01 19:25:21', '2025-12-01 19:25:21'),
(171, NULL, 'SVC-CMS-39', 4, 2500.00, 0.00, '2025-12-01 19:30:48', '{\"commission_id\":39,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":22,\"payment_id\":28}', '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(172, NULL, 'SVC-CMS-39', 5, 0.00, 2500.00, '2025-12-01 19:30:48', '{\"commission_id\":39,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":22,\"payment_id\":28}', '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(173, NULL, 'SVC-CMS-40', 4, 250.00, 0.00, '2025-12-01 19:30:48', '{\"commission_id\":40,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":22,\"payment_id\":29}', '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(174, NULL, 'SVC-CMS-40', 5, 0.00, 250.00, '2025-12-01 19:30:48', '{\"commission_id\":40,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":22,\"payment_id\":29}', '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(175, NULL, 'SVC-CMS-41', 4, 250.00, 0.00, '2025-12-01 19:30:48', '{\"commission_id\":41,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"sales_order_id\":21,\"payment_id\":30}', '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(176, NULL, 'SVC-CMS-41', 5, 0.00, 250.00, '2025-12-01 19:30:48', '{\"commission_id\":41,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"sales_order_id\":21,\"payment_id\":30}', '2025-12-01 19:30:48', '2025-12-01 19:30:48'),
(177, NULL, 'PMT-31', 1, 5000.00, 0.00, '2025-12-01 00:00:00', '{\"payment_id\":31,\"sales_order_id\":21,\"method\":\"cash\"}', '2025-12-01 19:37:26', '2025-12-01 19:37:26'),
(178, NULL, 'PMT-31', 3, 0.00, 5000.00, '2025-12-01 00:00:00', '{\"payment_id\":31,\"sales_order_id\":21,\"method\":\"cash\"}', '2025-12-01 19:37:26', '2025-12-01 19:37:26'),
(179, NULL, 'PMT-32', 1, 50000.00, 0.00, '2025-12-01 00:00:00', '{\"payment_id\":32,\"sales_order_id\":23,\"method\":\"cash\"}', '2025-12-01 19:51:35', '2025-12-01 19:51:35'),
(180, NULL, 'PMT-32', 3, 0.00, 50000.00, '2025-12-01 00:00:00', '{\"payment_id\":32,\"sales_order_id\":23,\"method\":\"cash\"}', '2025-12-01 19:51:35', '2025-12-01 19:51:35'),
(181, NULL, 'PMT-33', 1, 412500.00, 0.00, '2025-12-02 00:00:00', '{\"payment_id\":33,\"sales_order_id\":23,\"method\":\"cash\"}', '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(182, NULL, 'PMT-33', 3, 0.00, 412500.00, '2025-12-02 00:00:00', '{\"payment_id\":33,\"sales_order_id\":23,\"method\":\"cash\"}', '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(183, NULL, 'SUPP-PAYABLE-33-2', 7, 82500.00, 0.00, '2025-12-02 00:00:00', '{\"payment_id\":33,\"sales_order_id\":23,\"supplier_id\":2}', '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(184, NULL, 'SUPP-PAYABLE-33-2', 8, 0.00, 82500.00, '2025-12-02 00:00:00', '{\"payment_id\":33,\"sales_order_id\":23,\"supplier_id\":2}', '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(185, NULL, 'SVC-CMS-42', 4, 250.00, 0.00, '2025-12-02 16:17:17', '{\"commission_id\":42,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"sales_order_id\":21,\"payment_id\":31}', '2025-12-02 16:17:17', '2025-12-02 16:17:17'),
(186, NULL, 'SVC-CMS-42', 5, 0.00, 250.00, '2025-12-02 16:17:17', '{\"commission_id\":42,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16,\"sales_order_id\":21,\"payment_id\":31}', '2025-12-02 16:17:17', '2025-12-02 16:17:17'),
(187, NULL, 'PMT-34', 1, 17500.00, 0.00, '2025-12-02 00:00:00', '{\"payment_id\":34,\"sales_order_id\":24,\"method\":\"cash\"}', '2025-12-02 16:19:50', '2025-12-02 16:19:50'),
(188, NULL, 'PMT-34', 3, 0.00, 17500.00, '2025-12-02 00:00:00', '{\"payment_id\":34,\"sales_order_id\":24,\"method\":\"cash\"}', '2025-12-02 16:19:50', '2025-12-02 16:19:50'),
(189, NULL, 'SVC-CMS-43', 4, 875.00, 0.00, '2025-12-02 16:59:53', '{\"commission_id\":43,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":24,\"payment_id\":34}', '2025-12-02 16:59:53', '2025-12-02 16:59:53'),
(190, NULL, 'SVC-CMS-43', 5, 0.00, 875.00, '2025-12-02 16:59:53', '{\"commission_id\":43,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":24,\"payment_id\":34}', '2025-12-02 16:59:53', '2025-12-02 16:59:53'),
(191, NULL, 'PMT-35', 1, 17500.00, 0.00, '2025-12-03 00:00:00', '{\"payment_id\":35,\"sales_order_id\":25,\"method\":\"cash\"}', '2025-12-03 17:59:42', '2025-12-03 17:59:42'),
(192, NULL, 'PMT-35', 3, 0.00, 17500.00, '2025-12-03 00:00:00', '{\"payment_id\":35,\"sales_order_id\":25,\"method\":\"cash\"}', '2025-12-03 17:59:42', '2025-12-03 17:59:42'),
(193, NULL, 'SVC-CMS-44', 4, 875.00, 0.00, '2025-12-03 18:01:12', '{\"commission_id\":44,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":25,\"payment_id\":35}', '2025-12-03 18:01:12', '2025-12-03 18:01:12'),
(194, NULL, 'SVC-CMS-44', 5, 0.00, 875.00, '2025-12-03 18:01:12', '{\"commission_id\":44,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":25,\"payment_id\":35}', '2025-12-03 18:01:12', '2025-12-03 18:01:12'),
(195, NULL, 'PMT-36', 1, 17500.00, 0.00, '2025-12-03 00:00:00', '{\"payment_id\":36,\"sales_order_id\":26,\"method\":\"cash\"}', '2025-12-03 18:09:13', '2025-12-03 18:09:13'),
(196, NULL, 'PMT-36', 3, 0.00, 17500.00, '2025-12-03 00:00:00', '{\"payment_id\":36,\"sales_order_id\":26,\"method\":\"cash\"}', '2025-12-03 18:09:13', '2025-12-03 18:09:13'),
(197, NULL, 'SVC-CMS-45', 4, 875.00, 0.00, '2025-12-03 18:10:27', '{\"commission_id\":45,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":26,\"payment_id\":36}', '2025-12-03 18:10:27', '2025-12-03 18:10:27'),
(198, NULL, 'SVC-CMS-45', 5, 0.00, 875.00, '2025-12-03 18:10:27', '{\"commission_id\":45,\"category\":\"service\",\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19,\"sales_order_id\":26,\"payment_id\":36}', '2025-12-03 18:10:27', '2025-12-03 18:10:27'),
(199, 1, 'JRNL-EXT-001', 1, 1000.00, 0.00, '2025-01-15 12:00:00', '{\"source\":\"manual\"}', '2025-12-07 16:01:51', '2025-12-07 16:01:51'),
(200, 1, 'JRNL-EXT-001', 5, 0.00, 1000.00, '2025-01-15 12:00:00', '{\"source\":\"manual\"}', '2025-12-07 16:01:51', '2025-12-07 16:01:51'),
(201, 2, 'JRNL-a0897f43-f1ca-4c8e-ae4d-7b686ba23a9a', 1, 5000.00, 5000.00, '2025-12-07 12:00:00', '{\"source\":\"manual\"}', '2025-12-07 16:14:21', '2025-12-07 16:14:21'),
(202, 2, 'JRNL-a0897f43-f1ca-4c8e-ae4d-7b686ba23a9a', 1, 1000.00, 1000.00, '2025-12-07 12:00:00', '{\"source\":\"manual\"}', '2025-12-07 16:14:21', '2025-12-07 16:14:21'),
(203, 3, 'JRNL-a0898134-6792-43cd-97f6-7c1871ee4fdf', 3, 5000.00, 0.00, '2025-12-07 12:00:00', '{\"source\":\"manual\"}', '2025-12-07 16:19:46', '2025-12-07 16:19:46'),
(204, 3, 'JRNL-a0898134-6792-43cd-97f6-7c1871ee4fdf', 5, 0.00, 5000.00, '2025-12-07 12:00:00', '{\"source\":\"manual\"}', '2025-12-07 16:19:46', '2025-12-07 16:19:46'),
(205, 4, 'PDSB-1', 4, 16040.00, 0.00, '2025-12-08 18:54:49', '{\"employee_id\":12,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(206, 4, 'PDSB-1', 6, 0.00, 16040.00, '2025-12-08 18:54:49', '{\"employee_id\":12,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(207, 5, 'PDSB-2', 4, 7260.00, 0.00, '2025-12-08 18:54:49', '{\"employee_id\":13,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(208, 5, 'PDSB-2', 6, 0.00, 7260.00, '2025-12-08 18:54:49', '{\"employee_id\":13,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(209, 6, 'PDSB-3', 4, 4840.00, 0.00, '2025-12-08 18:54:49', '{\"employee_id\":15,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(210, 6, 'PDSB-3', 6, 0.00, 4840.00, '2025-12-08 18:54:49', '{\"employee_id\":15,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(211, 7, 'PDSB-4', 4, 3630.00, 0.00, '2025-12-08 18:54:49', '{\"employee_id\":16,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(212, 7, 'PDSB-4', 6, 0.00, 3630.00, '2025-12-08 18:54:49', '{\"employee_id\":16,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(213, 8, 'PDSB-5', 4, 4840.00, 0.00, '2025-12-08 18:54:49', '{\"employee_id\":14,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(214, 8, 'PDSB-5', 6, 0.00, 4840.00, '2025-12-08 18:54:49', '{\"employee_id\":14,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(215, 9, 'PDSB-6', 4, 0.00, 0.00, '2025-12-08 18:54:49', '{\"employee_id\":20,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(216, 9, 'PDSB-6', 6, 0.00, 0.00, '2025-12-08 18:54:49', '{\"employee_id\":20,\"month\":\"2025-11\"}', '2025-12-08 18:54:49', '2025-12-08 18:54:49'),
(217, 10, 'PDSB-7', 4, 16040.00, 0.00, '2025-12-09 17:19:32', '{\"employee_id\":12,\"month\":\"2025-11\"}', '2025-12-09 17:19:32', '2025-12-09 17:19:32'),
(218, 10, 'PDSB-7', 6, 0.00, 16040.00, '2025-12-09 17:19:32', '{\"employee_id\":12,\"month\":\"2025-11\"}', '2025-12-09 17:19:32', '2025-12-09 17:19:32'),
(219, 11, 'PDSB-8', 4, 4840.00, 0.00, '2025-12-09 17:19:32', '{\"employee_id\":13,\"month\":\"2025-11\"}', '2025-12-09 17:19:32', '2025-12-09 17:19:32'),
(220, 11, 'PDSB-8', 6, 0.00, 4840.00, '2025-12-09 17:19:32', '{\"employee_id\":13,\"month\":\"2025-11\"}', '2025-12-09 17:19:32', '2025-12-09 17:19:32'),
(221, 12, 'PMT-37', 1, 50000.00, 0.00, '2025-12-09 00:00:00', '{\"payment_id\":37,\"sales_order_id\":28,\"method\":\"cash\"}', '2025-12-09 18:12:08', '2025-12-09 18:12:08'),
(222, 12, 'PMT-37', 3, 0.00, 50000.00, '2025-12-09 00:00:00', '{\"payment_id\":37,\"sales_order_id\":28,\"method\":\"cash\"}', '2025-12-09 18:12:08', '2025-12-09 18:12:08'),
(223, 13, 'PMT-38', 1, 95000.00, 0.00, '2025-12-09 00:00:00', '{\"payment_id\":38,\"sales_order_id\":28,\"method\":\"cash\"}', '2025-12-09 18:12:45', '2025-12-09 18:12:45'),
(224, 13, 'PMT-38', 3, 0.00, 95000.00, '2025-12-09 00:00:00', '{\"payment_id\":38,\"sales_order_id\":28,\"method\":\"cash\"}', '2025-12-09 18:12:45', '2025-12-09 18:12:45'),
(225, 14, 'SUPP-PAYABLE-38-2', 7, 11400.00, 0.00, '2025-12-09 00:00:00', '{\"payment_id\":38,\"sales_order_id\":28,\"supplier_id\":2}', '2025-12-09 18:12:46', '2025-12-09 18:12:46'),
(226, 14, 'SUPP-PAYABLE-38-2', 8, 0.00, 11400.00, '2025-12-09 00:00:00', '{\"payment_id\":38,\"sales_order_id\":28,\"supplier_id\":2}', '2025-12-09 18:12:46', '2025-12-09 18:12:46'),
(227, 15, 'PMT-39', 1, 100000.00, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":39,\"sales_order_id\":29,\"method\":\"cash\"}', '2025-12-10 15:51:50', '2025-12-10 15:51:50'),
(228, 15, 'PMT-39', 3, 0.00, 100000.00, '2025-12-10 00:00:00', '{\"payment_id\":39,\"sales_order_id\":29,\"method\":\"cash\"}', '2025-12-10 15:51:50', '2025-12-10 15:51:50'),
(229, 16, 'CMS-46', 4, 6750.00, 0.00, '2025-12-10 16:51:53', '{\"commission_id\":46,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(230, 16, 'CMS-46', 5, 0.00, 6750.00, '2025-12-10 16:51:53', '{\"commission_id\":46,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(231, 17, 'CMS-47', 4, 2250.00, 0.00, '2025-12-10 16:51:53', '{\"commission_id\":47,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(232, 17, 'CMS-47', 5, 0.00, 2250.00, '2025-12-10 16:51:53', '{\"commission_id\":47,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(233, 18, 'CMS-48', 4, 2250.00, 0.00, '2025-12-10 16:51:53', '{\"commission_id\":48,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(234, 18, 'CMS-48', 5, 0.00, 2250.00, '2025-12-10 16:51:53', '{\"commission_id\":48,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(235, 19, 'CMS-49', 4, 2250.00, 0.00, '2025-12-10 16:51:53', '{\"commission_id\":49,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(236, 19, 'CMS-49', 5, 0.00, 2250.00, '2025-12-10 16:51:53', '{\"commission_id\":49,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(237, 20, 'CMS-50', 4, 18562.50, 0.00, '2025-12-10 16:51:53', '{\"commission_id\":50,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(238, 20, 'CMS-50', 5, 0.00, 18562.50, '2025-12-10 16:51:53', '{\"commission_id\":50,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(239, 21, 'CMS-51', 4, 3712.50, 0.00, '2025-12-10 16:51:53', '{\"commission_id\":51,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(240, 21, 'CMS-51', 5, 0.00, 3712.50, '2025-12-10 16:51:53', '{\"commission_id\":51,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(241, 22, 'CMS-52', 4, 11137.50, 0.00, '2025-12-10 16:51:53', '{\"commission_id\":52,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(242, 22, 'CMS-52', 5, 0.00, 11137.50, '2025-12-10 16:51:53', '{\"commission_id\":52,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(243, 23, 'CMS-53', 4, 7425.00, 0.00, '2025-12-10 16:51:53', '{\"commission_id\":53,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(244, 23, 'CMS-53', 5, 0.00, 7425.00, '2025-12-10 16:51:53', '{\"commission_id\":53,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(245, 24, 'CMS-54', 4, 6750.00, 0.00, '2025-12-10 16:51:53', '{\"commission_id\":54,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(246, 24, 'CMS-54', 5, 0.00, 6750.00, '2025-12-10 16:51:53', '{\"commission_id\":54,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(247, 25, 'CMS-55', 4, 6750.00, 0.00, '2025-12-10 16:51:53', '{\"commission_id\":55,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(248, 25, 'CMS-55', 5, 0.00, 6750.00, '2025-12-10 16:51:53', '{\"commission_id\":55,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(249, 26, 'CMS-56', 4, 4275.00, 0.00, '2025-12-10 16:51:53', '{\"commission_id\":56,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(250, 26, 'CMS-56', 5, 0.00, 4275.00, '2025-12-10 16:51:53', '{\"commission_id\":56,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(251, 27, 'CMS-57', 4, 5130.00, 0.00, '2025-12-10 16:51:53', '{\"commission_id\":57,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 16:51:53', '2025-12-10 16:51:53'),
(252, 27, 'CMS-57', 5, 0.00, 5130.00, '2025-12-10 16:51:53', '{\"commission_id\":57,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 16:51:54', '2025-12-10 16:51:54'),
(253, 28, 'CMS-58', 4, 4500.00, 0.00, '2025-12-10 16:51:54', '{\"commission_id\":58,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 16:51:54', '2025-12-10 16:51:54'),
(254, 28, 'CMS-58', 5, 0.00, 4500.00, '2025-12-10 16:51:54', '{\"commission_id\":58,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 16:51:54', '2025-12-10 16:51:54'),
(255, 29, 'PMT-40', 1, 1000000.00, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":40,\"sales_order_id\":30,\"method\":\"cash\"}', '2025-12-10 16:58:51', '2025-12-10 16:58:51'),
(256, 29, 'PMT-40', 3, 0.00, 1000000.00, '2025-12-10 00:00:00', '{\"payment_id\":40,\"sales_order_id\":30,\"method\":\"cash\"}', '2025-12-10 16:58:51', '2025-12-10 16:58:51'),
(257, 30, 'PMT-41', 1, 333333.34, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":41,\"sales_order_id\":30,\"method\":\"cash\"}', '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(258, 30, 'PMT-41', 3, 0.00, 333333.34, '2025-12-10 00:00:00', '{\"payment_id\":41,\"sales_order_id\":30,\"method\":\"cash\"}', '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(259, 31, 'SUPP-PAYABLE-41-2', 7, 66666.67, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":41,\"sales_order_id\":30,\"supplier_id\":2}', '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(260, 31, 'SUPP-PAYABLE-41-2', 8, 0.00, 66666.67, '2025-12-10 00:00:00', '{\"payment_id\":41,\"sales_order_id\":30,\"supplier_id\":2}', '2025-12-10 16:59:07', '2025-12-10 16:59:07'),
(261, 32, 'CMS-1', 4, 45000.00, 0.00, '2025-12-10 16:59:33', '{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(262, 32, 'CMS-1', 5, 0.00, 45000.00, '2025-12-10 16:59:33', '{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(263, 33, 'CMS-2', 4, 3000.00, 0.00, '2025-12-10 16:59:33', '{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(264, 33, 'CMS-2', 5, 0.00, 3000.00, '2025-12-10 16:59:33', '{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 16:59:33', '2025-12-10 16:59:33'),
(265, 34, 'PMT-42', 1, 50000.00, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":42,\"sales_order_id\":36,\"method\":\"cash\"}', '2025-12-10 17:15:10', '2025-12-10 17:15:10'),
(266, 34, 'PMT-42', 3, 0.00, 50000.00, '2025-12-10 00:00:00', '{\"payment_id\":42,\"sales_order_id\":36,\"method\":\"cash\"}', '2025-12-10 17:15:10', '2025-12-10 17:15:10'),
(267, 35, 'PMT-43', 1, 50000.00, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":43,\"sales_order_id\":41,\"method\":\"cash\"}', '2025-12-10 17:29:52', '2025-12-10 17:29:52'),
(268, 35, 'PMT-43', 3, 0.00, 50000.00, '2025-12-10 00:00:00', '{\"payment_id\":43,\"sales_order_id\":41,\"method\":\"cash\"}', '2025-12-10 17:29:52', '2025-12-10 17:29:52');
INSERT INTO `ledger_entries` (`id`, `journal_id`, `tx_id`, `account_id`, `debit`, `credit`, `occurred_at`, `meta`, `created_at`, `updated_at`) VALUES
(269, 36, 'PMT-44', 1, 412500.00, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":44,\"sales_order_id\":41,\"method\":\"cash\"}', '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(270, 36, 'PMT-44', 3, 0.00, 412500.00, '2025-12-10 00:00:00', '{\"payment_id\":44,\"sales_order_id\":41,\"method\":\"cash\"}', '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(271, 37, 'SUPP-PAYABLE-44-1', 7, 82500.00, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":44,\"sales_order_id\":41,\"supplier_id\":1}', '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(272, 37, 'SUPP-PAYABLE-44-1', 8, 0.00, 82500.00, '2025-12-10 00:00:00', '{\"payment_id\":44,\"sales_order_id\":41,\"supplier_id\":1}', '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(273, 38, 'CMS-3', 4, 6000.00, 0.00, '2025-12-10 17:30:54', '{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(274, 38, 'CMS-3', 5, 0.00, 6000.00, '2025-12-10 17:30:54', '{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(275, 39, 'CMS-4', 4, 6000.00, 0.00, '2025-12-10 17:30:54', '{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(276, 39, 'CMS-4', 5, 0.00, 6000.00, '2025-12-10 17:30:54', '{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(277, 40, 'CMS-5', 4, 1750.00, 0.00, '2025-12-10 17:30:54', '{\"commission_id\":5,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(278, 40, 'CMS-5', 5, 0.00, 1750.00, '2025-12-10 17:30:54', '{\"commission_id\":5,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(279, 41, 'CMS-6', 4, 2887.50, 0.00, '2025-12-10 17:30:54', '{\"commission_id\":6,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(280, 41, 'CMS-6', 5, 0.00, 2887.50, '2025-12-10 17:30:54', '{\"commission_id\":6,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 17:30:54', '2025-12-10 17:30:54'),
(281, 42, 'PMT-45', 1, 5000.00, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":45,\"sales_order_id\":44,\"method\":\"cash\"}', '2025-12-10 17:50:44', '2025-12-10 17:50:44'),
(282, 42, 'PMT-45', 3, 0.00, 5000.00, '2025-12-10 00:00:00', '{\"payment_id\":45,\"sales_order_id\":44,\"method\":\"cash\"}', '2025-12-10 17:50:44', '2025-12-10 17:50:44'),
(283, 43, 'PMT-46', 1, 3750.00, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":46,\"sales_order_id\":44,\"method\":\"cash\"}', '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(284, 43, 'PMT-46', 3, 0.00, 3750.00, '2025-12-10 00:00:00', '{\"payment_id\":46,\"sales_order_id\":44,\"method\":\"cash\"}', '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(285, 44, 'SUPP-PAYABLE-46-2', 7, 562.50, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":46,\"sales_order_id\":44,\"supplier_id\":2}', '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(286, 44, 'SUPP-PAYABLE-46-2', 8, 0.00, 562.50, '2025-12-10 00:00:00', '{\"payment_id\":46,\"sales_order_id\":44,\"supplier_id\":2}', '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(287, 45, 'PMT-47', 1, 1000000.00, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":47,\"sales_order_id\":45,\"method\":\"cash\"}', '2025-12-10 18:15:24', '2025-12-10 18:15:24'),
(288, 45, 'PMT-47', 3, 0.00, 1000000.00, '2025-12-10 00:00:00', '{\"payment_id\":47,\"sales_order_id\":45,\"method\":\"cash\"}', '2025-12-10 18:15:24', '2025-12-10 18:15:24'),
(289, 46, 'PMT-48', 1, 200000.00, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":48,\"sales_order_id\":45,\"method\":\"cash\"}', '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(290, 46, 'PMT-48', 3, 0.00, 200000.00, '2025-12-10 00:00:00', '{\"payment_id\":48,\"sales_order_id\":45,\"method\":\"cash\"}', '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(291, 47, 'SUPP-PAYABLE-48-2', 7, 40000.00, 0.00, '2025-12-10 00:00:00', '{\"payment_id\":48,\"sales_order_id\":45,\"supplier_id\":2}', '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(292, 47, 'SUPP-PAYABLE-48-2', 8, 0.00, 40000.00, '2025-12-10 00:00:00', '{\"payment_id\":48,\"sales_order_id\":45,\"supplier_id\":2}', '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(293, 48, 'CMS-7', 4, 225.00, 0.00, '2025-12-10 18:21:21', '{\"commission_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(294, 48, 'CMS-7', 5, 0.00, 225.00, '2025-12-10 18:21:21', '{\"commission_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(295, 49, 'CMS-8', 4, 33.75, 0.00, '2025-12-10 18:21:21', '{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(296, 49, 'CMS-8', 5, 0.00, 33.75, '2025-12-10 18:21:21', '{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(297, 50, 'CMS-9', 4, 45000.00, 0.00, '2025-12-10 18:21:21', '{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(298, 50, 'CMS-9', 5, 0.00, 45000.00, '2025-12-10 18:21:21', '{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(299, 51, 'CMS-10', 4, 1800.00, 0.00, '2025-12-10 18:21:21', '{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(300, 51, 'CMS-10', 5, 0.00, 1800.00, '2025-12-10 18:21:21', '{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":7}', '2025-12-10 18:21:21', '2025-12-10 18:21:21'),
(301, 52, 'PMT-49', 1, 200000.00, 0.00, '2025-12-11 00:00:00', '{\"payment_id\":49,\"sales_order_id\":46,\"method\":\"cash\"}', '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(302, 52, 'PMT-49', 3, 0.00, 200000.00, '2025-12-11 00:00:00', '{\"payment_id\":49,\"sales_order_id\":46,\"method\":\"cash\"}', '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(303, 53, 'SUPP-PAYABLE-49-1', 7, 40000.00, 0.00, '2025-12-11 00:00:00', '{\"payment_id\":49,\"sales_order_id\":46,\"supplier_id\":1}', '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(304, 53, 'SUPP-PAYABLE-49-1', 8, 0.00, 40000.00, '2025-12-11 00:00:00', '{\"payment_id\":49,\"sales_order_id\":46,\"supplier_id\":1}', '2025-12-11 18:09:34', '2025-12-11 18:09:34'),
(305, 54, 'CMS-11', 4, 1400.00, 0.00, '2025-12-11 18:20:19', '{\"commission_id\":11,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}', '2025-12-11 18:20:19', '2025-12-11 18:20:19'),
(306, 54, 'CMS-11', 5, 0.00, 1400.00, '2025-12-11 18:20:19', '{\"commission_id\":11,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}', '2025-12-11 18:20:19', '2025-12-11 18:20:19'),
(307, 55, 'PMT-50', 1, 1000000.00, 0.00, '2025-12-11 00:00:00', '{\"payment_id\":50,\"sales_order_id\":48,\"method\":\"cash\"}', '2025-12-11 19:35:20', '2025-12-11 19:35:20'),
(308, 55, 'PMT-50', 3, 0.00, 1000000.00, '2025-12-11 00:00:00', '{\"payment_id\":50,\"sales_order_id\":48,\"method\":\"cash\"}', '2025-12-11 19:35:20', '2025-12-11 19:35:20'),
(309, 56, 'PMT-51', 1, 200000.00, 0.00, '2025-12-11 00:00:00', '{\"payment_id\":51,\"sales_order_id\":48,\"method\":\"cash\"}', '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(310, 56, 'PMT-51', 3, 0.00, 200000.00, '2025-12-11 00:00:00', '{\"payment_id\":51,\"sales_order_id\":48,\"method\":\"cash\"}', '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(311, 57, 'SUPP-PAYABLE-51-1', 7, 40000.00, 0.00, '2025-12-11 00:00:00', '{\"payment_id\":51,\"sales_order_id\":48,\"supplier_id\":1}', '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(312, 57, 'SUPP-PAYABLE-51-1', 8, 0.00, 40000.00, '2025-12-11 00:00:00', '{\"payment_id\":51,\"sales_order_id\":48,\"supplier_id\":1}', '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(313, 58, 'PMT-52', 1, 1000000.00, 0.00, '2025-12-11 00:00:00', '{\"payment_id\":52,\"sales_order_id\":50,\"method\":\"cash\"}', '2025-12-11 19:44:22', '2025-12-11 19:44:22'),
(314, 58, 'PMT-52', 3, 0.00, 1000000.00, '2025-12-11 00:00:00', '{\"payment_id\":52,\"sales_order_id\":50,\"method\":\"cash\"}', '2025-12-11 19:44:22', '2025-12-11 19:44:22'),
(315, 59, 'CMS-12', 4, 35000.00, 0.00, '2025-12-11 19:45:39', '{\"commission_id\":12,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}', '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(316, 59, 'CMS-12', 5, 0.00, 35000.00, '2025-12-11 19:45:39', '{\"commission_id\":12,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}', '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(317, 60, 'CMS-13', 4, 1400.00, 0.00, '2025-12-11 19:45:39', '{\"commission_id\":13,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}', '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(318, 60, 'CMS-13', 5, 0.00, 1400.00, '2025-12-11 19:45:39', '{\"commission_id\":13,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}', '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(319, 61, 'CMS-14', 4, 45000.00, 0.00, '2025-12-11 19:45:39', '{\"commission_id\":14,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}', '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(320, 61, 'CMS-14', 5, 0.00, 45000.00, '2025-12-11 19:45:39', '{\"commission_id\":14,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":8}', '2025-12-11 19:45:39', '2025-12-11 19:45:39'),
(321, 62, 'wallet_withdrawal_1', 10, 500.00, 0.00, '2025-12-14 16:01:18', '{\"withdraw_request_id\":1,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}', '2025-12-14 16:01:18', '2025-12-14 16:01:18'),
(322, 62, 'wallet_withdrawal_1', 11, 0.00, 500.00, '2025-12-14 16:01:18', '{\"withdraw_request_id\":1,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}', '2025-12-14 16:01:18', '2025-12-14 16:01:18'),
(323, 63, 'wallet_withdrawal_4', 10, 500.00, 0.00, '2025-12-14 16:19:54', '{\"withdraw_request_id\":4,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}', '2025-12-14 16:19:54', '2025-12-14 16:19:54'),
(324, 63, 'wallet_withdrawal_4', 11, 0.00, 500.00, '2025-12-14 16:19:54', '{\"withdraw_request_id\":4,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}', '2025-12-14 16:19:54', '2025-12-14 16:19:54'),
(325, 64, 'wallet_withdrawal_7', 10, 500.00, 0.00, '2025-12-14 19:14:59', '{\"withdraw_request_id\":7,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}', '2025-12-14 19:14:59', '2025-12-14 19:14:59'),
(326, 64, 'wallet_withdrawal_7', 11, 0.00, 500.00, '2025-12-14 19:14:59', '{\"withdraw_request_id\":7,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}', '2025-12-14 19:14:59', '2025-12-14 19:14:59'),
(327, 65, 'wallet_withdrawal_5', 10, 4001.00, 0.00, '2025-12-14 19:17:37', '{\"withdraw_request_id\":5,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}', '2025-12-14 19:17:37', '2025-12-14 19:17:37'),
(328, 65, 'wallet_withdrawal_5', 11, 0.00, 4001.00, '2025-12-14 19:17:37', '{\"withdraw_request_id\":5,\"user_type\":\"employee\",\"user_id\":12,\"method\":\"bkash\"}', '2025-12-14 19:17:37', '2025-12-14 19:17:37'),
(329, 66, 'wallet_withdrawal_6', 12, 500.00, 0.00, '2025-12-14 19:18:36', '{\"withdraw_request_id\":6,\"user_type\":\"agent\",\"user_id\":6,\"method\":\"bkash\"}', '2025-12-14 19:18:36', '2025-12-14 19:18:36'),
(330, 66, 'wallet_withdrawal_6', 11, 0.00, 500.00, '2025-12-14 19:18:36', '{\"withdraw_request_id\":6,\"user_type\":\"agent\",\"user_id\":6,\"method\":\"bkash\"}', '2025-12-14 19:18:36', '2025-12-14 19:18:36'),
(331, 67, 'PMT-53', 1, 50000.00, 0.00, '2025-12-22 00:00:00', '{\"payment_id\":53,\"sales_order_id\":52,\"method\":\"cash\"}', '2025-12-22 18:27:16', '2025-12-22 18:27:16'),
(332, 67, 'PMT-53', 3, 0.00, 50000.00, '2025-12-22 00:00:00', '{\"payment_id\":53,\"sales_order_id\":52,\"method\":\"cash\"}', '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(333, 68, 'CMS-15', 4, 2250.00, 0.00, '2025-12-22 18:27:17', '{\"commission_id\":15,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(334, 68, 'CMS-15', 5, 0.00, 2250.00, '2025-12-22 18:27:17', '{\"commission_id\":15,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(335, 69, 'PMT-54', 1, 50000.00, 0.00, '2025-12-22 00:00:00', '{\"payment_id\":54,\"sales_order_id\":53,\"method\":\"cash\"}', '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(336, 69, 'PMT-54', 3, 0.00, 50000.00, '2025-12-22 00:00:00', '{\"payment_id\":54,\"sales_order_id\":53,\"method\":\"cash\"}', '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(337, 70, 'CMS-16', 4, 2250.00, 0.00, '2025-12-22 18:33:48', '{\"commission_id\":16,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(338, 70, 'CMS-16', 5, 0.00, 2250.00, '2025-12-22 18:33:48', '{\"commission_id\":16,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(339, 71, 'PMT-55', 1, 100000.00, 0.00, '2025-12-22 00:00:00', '{\"payment_id\":55,\"sales_order_id\":54,\"method\":\"cash\"}', '2025-12-22 18:36:43', '2025-12-22 18:36:43'),
(340, 71, 'PMT-55', 3, 0.00, 100000.00, '2025-12-22 00:00:00', '{\"payment_id\":55,\"sales_order_id\":54,\"method\":\"cash\"}', '2025-12-22 18:36:43', '2025-12-22 18:36:43'),
(341, 72, 'PMT-56', 1, 100000.00, 0.00, '2025-12-22 00:00:00', '{\"payment_id\":56,\"sales_order_id\":55,\"method\":\"cash\"}', '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(342, 72, 'PMT-56', 3, 0.00, 100000.00, '2025-12-22 00:00:00', '{\"payment_id\":56,\"sales_order_id\":55,\"method\":\"cash\"}', '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(343, 73, 'CMS-17', 4, 13500.00, 0.00, '2025-12-22 18:45:22', '{\"commission_id\":17,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(344, 73, 'CMS-17', 5, 0.00, 13500.00, '2025-12-22 18:45:22', '{\"commission_id\":17,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(345, 74, 'CMS-18', 4, 4500.00, 0.00, '2025-12-22 18:45:22', '{\"commission_id\":18,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(346, 74, 'CMS-18', 5, 0.00, 4500.00, '2025-12-22 18:45:22', '{\"commission_id\":18,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(347, 75, 'CMS-19', 4, 27000.00, 0.00, '2025-12-22 18:45:22', '{\"commission_id\":19,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(348, 75, 'CMS-19', 5, 0.00, 27000.00, '2025-12-22 18:45:22', '{\"commission_id\":19,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(349, 76, 'CMS-20', 4, 4500.00, 0.00, '2025-12-22 18:45:22', '{\"commission_id\":20,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(350, 76, 'CMS-20', 5, 0.00, 4500.00, '2025-12-22 18:45:22', '{\"commission_id\":20,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(351, 77, 'CMS-21', 4, 10800.00, 0.00, '2025-12-22 18:45:22', '{\"commission_id\":21,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":17}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(352, 77, 'CMS-21', 5, 0.00, 10800.00, '2025-12-22 18:45:22', '{\"commission_id\":21,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":17}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(353, 78, 'CMS-22', 4, 9000.00, 0.00, '2025-12-22 18:45:22', '{\"commission_id\":22,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(354, 78, 'CMS-22', 5, 0.00, 9000.00, '2025-12-22 18:45:22', '{\"commission_id\":22,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(355, 79, 'CMS-23', 4, 3600.00, 0.00, '2025-12-22 18:45:22', '{\"commission_id\":23,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(356, 79, 'CMS-23', 5, 0.00, 3600.00, '2025-12-22 18:45:22', '{\"commission_id\":23,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(357, 80, 'CMS-24', 4, 3600.00, 0.00, '2025-12-22 18:45:22', '{\"commission_id\":24,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(358, 80, 'CMS-24', 5, 0.00, 3600.00, '2025-12-22 18:45:22', '{\"commission_id\":24,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-22 18:45:22', '2025-12-22 18:45:22'),
(359, 81, 'PMT-57', 1, 100000.00, 0.00, '2025-12-23 00:00:00', '{\"payment_id\":57,\"sales_order_id\":56,\"method\":\"cash\"}', '2025-12-23 04:27:57', '2025-12-23 04:27:57'),
(360, 81, 'PMT-57', 3, 0.00, 100000.00, '2025-12-23 00:00:00', '{\"payment_id\":57,\"sales_order_id\":56,\"method\":\"cash\"}', '2025-12-23 04:27:57', '2025-12-23 04:27:57'),
(361, 82, 'CMS-25', 4, 4500.00, 0.00, '2025-12-23 04:29:13', '{\"commission_id\":25,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(362, 82, 'CMS-25', 5, 0.00, 4500.00, '2025-12-23 04:29:13', '{\"commission_id\":25,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(363, 83, 'CMS-26', 4, 15300.00, 0.00, '2025-12-23 04:29:13', '{\"commission_id\":26,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-23 04:29:13', '2025-12-23 04:29:13'),
(364, 83, 'CMS-26', 5, 0.00, 15300.00, '2025-12-23 04:29:13', '{\"commission_id\":26,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-12-23 04:29:13', '2025-12-23 04:29:13');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_10_06_112305_create_ranks_table', 1),
(6, '2025_10_06_112307_create_branches_table', 1),
(7, '2025_10_06_112308_create_agents_table', 1),
(8, '2025_10_06_112309_create_categories_table', 1),
(9, '2025_10_06_112310_create_products_table', 1),
(10, '2025_10_06_112310_create_services_table', 1),
(11, '2025_10_06_112311_create_land_lots_table', 1),
(12, '2025_10_06_112311_create_sales_orders_table', 1),
(13, '2025_10_06_112312_create_order_items_table', 1),
(14, '2025_10_06_112313_create_customer_installments_table', 1),
(15, '2025_10_06_112313_create_payments_table', 1),
(16, '2025_10_06_112314_create_payment_allocations_table', 1),
(17, '2025_10_06_112315_create_commission_rules_table', 1),
(18, '2025_10_06_112316_create_commissions_table', 1),
(19, '2025_10_06_112317_create_rank_requirements_table', 1),
(20, '2025_10_06_112318_create_rank_memberships_table', 1),
(21, '2025_10_06_112319_create_ledger_accounts_table', 1),
(22, '2025_10_06_112320_create_ledger_entries_table', 1),
(23, '2025_10_06_112321_create_documents_table', 1),
(24, '2025_10_06_112500_add_intent_type_to_payments_table', 1),
(25, '2025_10_06_112600_create_payment_intents_table', 1),
(26, '2025_10_06_112938_create_permission_tables', 1),
(27, '2025_10_07_000000_add_role_to_users_table', 1),
(28, '2025_10_07_010000_create_employees_table', 1),
(29, '2025_10_07_010100_add_context_to_sales_orders_table', 1),
(30, '2025_10_07_010200_create_activity_log_table', 1),
(31, '2025_10_07_020000_add_stock_fields_to_products_table', 1),
(32, '2025_10_07_020100_create_stock_movements_table', 1),
(33, '2025_10_07_020200_add_created_by_and_source_me_to_sales_orders_table', 1),
(34, '2025_10_09_000000_add_details_to_employees_table', 1),
(35, '2025_10_09_000100_create_employee_educations_table', 1),
(36, '2025_10_09_000200_create_employee_nominees_table', 1),
(37, '2025_10_10_000001_add_contact_fields_to_agents_table', 1),
(38, '2025_10_15_000001_add_commission_base_amount_to_payments_table', 1),
(39, '2025_10_20_000000_create_commission_settings_table', 1),
(40, '2025_10_30_000000_add_commission_processed_at_to_payments_table', 1),
(41, '2025_10_30_000001_create_employee_wallets_table', 1),
(42, '2025_10_09_010000_add_customer_details_to_users_table', 2),
(43, '2025_10_30_000002_add_source_me_to_users_table', 3),
(44, '2025_10_31_000000_create_commission_calculation_units_table', 4),
(45, '2025_11_01_000000_create_employee_activities_table', 5),
(46, '2025_11_05_120000_create_agent_wallets_table', 6),
(47, '2025_11_05_000000_add_ccu_percentage_to_products_table', 7),
(48, '2025_11_10_000000_create_suppliers_and_supplier_payables_tables', 8),
(49, '2025_11_20_000000_create_monthly_incentives_table', 9),
(50, '2025_11_23_000000_update_monthly_incentives_add_review_fields', 10),
(51, '2025_11_30_000000_create_director_funds_table', 11),
(52, '2025_10_10_000000_add_service_fields', 12),
(53, '2025_10_06_112321_create_journals_table', 13),
(54, '2025_12_02_000001_extend_payments_type_enum', 13),
(55, '2025_12_05_000000_create_pd_special_selections_table', 14),
(56, '2025_12_05_000001_create_pd_special_bonuses_table', 14),
(57, '2025_12_05_000002_create_pd_special_month_locks_table', 14),
(58, '2024_10_07_000000_create_wallet_withdraw_requests_table', 15),
(59, '2025_12_01_000000_create_employee_recruit_requests_table', 16),
(60, '2025_12_02_000000_add_rejection_reason_to_employee_recruit_requests_table', 17);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 3),
(5, 'App\\Models\\User', 4),
(5, 'App\\Models\\User', 19),
(5, 'App\\Models\\User', 21),
(5, 'App\\Models\\User', 22),
(5, 'App\\Models\\User', 52),
(5, 'App\\Models\\User', 80),
(5, 'App\\Models\\User', 83),
(6, 'App\\Models\\User', 5),
(6, 'App\\Models\\User', 9),
(7, 'App\\Models\\User', 6),
(7, 'App\\Models\\User', 7),
(8, 'App\\Models\\User', 8),
(9, 'App\\Models\\User', 16),
(9, 'App\\Models\\User', 25),
(9, 'App\\Models\\User', 26),
(9, 'App\\Models\\User', 27),
(9, 'App\\Models\\User', 29),
(9, 'App\\Models\\User', 30),
(9, 'App\\Models\\User', 38),
(9, 'App\\Models\\User', 39),
(9, 'App\\Models\\User', 42),
(9, 'App\\Models\\User', 43),
(9, 'App\\Models\\User', 44),
(9, 'App\\Models\\User', 45),
(9, 'App\\Models\\User', 46),
(9, 'App\\Models\\User', 47),
(9, 'App\\Models\\User', 49),
(9, 'App\\Models\\User', 50),
(9, 'App\\Models\\User', 55),
(9, 'App\\Models\\User', 56),
(9, 'App\\Models\\User', 58),
(9, 'App\\Models\\User', 59),
(9, 'App\\Models\\User', 60),
(9, 'App\\Models\\User', 61),
(9, 'App\\Models\\User', 62),
(9, 'App\\Models\\User', 63),
(9, 'App\\Models\\User', 64),
(9, 'App\\Models\\User', 65),
(9, 'App\\Models\\User', 66),
(9, 'App\\Models\\User', 67),
(9, 'App\\Models\\User', 68),
(9, 'App\\Models\\User', 69),
(9, 'App\\Models\\User', 70),
(9, 'App\\Models\\User', 71),
(9, 'App\\Models\\User', 72),
(9, 'App\\Models\\User', 73),
(9, 'App\\Models\\User', 74),
(9, 'App\\Models\\User', 75),
(9, 'App\\Models\\User', 76),
(9, 'App\\Models\\User', 78),
(9, 'App\\Models\\User', 79),
(9, 'App\\Models\\User', 82),
(9, 'App\\Models\\User', 86),
(9, 'App\\Models\\User', 88);

-- --------------------------------------------------------

--
-- Table structure for table `monthly_incentives`
--

CREATE TABLE `monthly_incentives` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `total_commissionable_sales` decimal(15,2) NOT NULL DEFAULT 0.00,
  `incentive_rate` decimal(5,2) NOT NULL DEFAULT 1.00,
  `amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `status` varchar(255) NOT NULL DEFAULT 'draft',
  `reviewed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `review_note` varchar(255) DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `processed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `monthly_incentives`
--

INSERT INTO `monthly_incentives` (`id`, `employee_id`, `period_start`, `period_end`, `total_commissionable_sales`, `incentive_rate`, `amount`, `status`, `reviewed_by`, `reviewed_at`, `review_note`, `meta`, `processed_at`, `created_at`, `updated_at`) VALUES
(17, 12, '2025-11-01', '2025-11-30', 358750.00, 1.00, 3587.50, 'paid', 10, '2025-11-26 11:09:28', NULL, '{\"subordinate_ids\":[13,19,14,15,16,17,20],\"subordinate_steps\":{\"13\":1,\"19\":1,\"14\":2,\"15\":3,\"16\":4,\"17\":5,\"20\":5},\"subordinate_count\":7,\"max_levels\":5,\"step_counts\":{\"1\":2,\"2\":1,\"3\":1,\"4\":1,\"5\":2},\"step_sales\":{\"1\":280000,\"2\":0,\"3\":0,\"4\":78750,\"5\":0}}', '2025-11-26 11:11:07', '2025-11-25 17:07:06', '2025-11-26 11:11:07'),
(18, 13, '2025-11-01', '2025-11-30', 78750.00, 1.00, 787.50, 'paid', 10, '2025-11-26 11:09:34', NULL, '{\"subordinate_ids\":[14,15,16,17,20],\"subordinate_steps\":{\"14\":1,\"15\":2,\"16\":3,\"17\":4,\"20\":4},\"subordinate_count\":5,\"max_levels\":5,\"step_counts\":{\"1\":1,\"2\":1,\"3\":1,\"4\":2,\"5\":0},\"step_sales\":{\"1\":0,\"2\":0,\"3\":78750,\"4\":0,\"5\":0}}', '2025-11-26 11:11:07', '2025-11-25 17:07:06', '2025-11-26 11:11:07'),
(19, 14, '2025-11-01', '2025-11-30', 78750.00, 1.00, 787.50, 'rejected', 10, '2025-11-26 11:09:31', NULL, '{\"subordinate_ids\":[15,16,17,20],\"subordinate_steps\":{\"15\":1,\"16\":2,\"17\":3,\"20\":3},\"subordinate_count\":4,\"max_levels\":5,\"step_counts\":{\"1\":1,\"2\":1,\"3\":2,\"4\":0,\"5\":0},\"step_sales\":{\"1\":0,\"2\":78750,\"3\":0,\"4\":0,\"5\":0}}', NULL, '2025-11-25 17:07:06', '2025-11-26 11:09:31'),
(20, 15, '2025-11-01', '2025-11-30', 78750.00, 1.00, 787.50, 'paid', 10, '2025-11-26 11:09:36', NULL, '{\"subordinate_ids\":[16,17,20],\"subordinate_steps\":{\"16\":1,\"17\":2,\"20\":2},\"subordinate_count\":3,\"max_levels\":5,\"step_counts\":{\"1\":1,\"2\":2,\"3\":0,\"4\":0,\"5\":0},\"step_sales\":{\"1\":78750,\"2\":0,\"3\":0,\"4\":0,\"5\":0}}', '2025-11-26 11:11:07', '2025-11-25 17:07:06', '2025-11-26 11:11:07');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sales_order_id` bigint(20) UNSIGNED NOT NULL,
  `itemable_type` varchar(255) NOT NULL,
  `itemable_id` bigint(20) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL,
  `unit_price` decimal(14,2) NOT NULL,
  `line_total` decimal(14,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `sales_order_id`, `itemable_type`, `itemable_id`, `qty`, `unit_price`, `line_total`, `created_at`, `updated_at`) VALUES
(1, 1, 'App\\Models\\Product', 1, 1, 600000.00, 600000.00, '2025-11-04 17:33:46', '2025-11-04 17:33:46'),
(4, 4, 'App\\Models\\Product', 1, 1, 200000.00, 200000.00, '2025-11-04 18:10:10', '2025-11-04 18:10:10'),
(5, 5, 'App\\Models\\Product', 1, 1, 300000.00, 300000.00, '2025-11-04 18:13:01', '2025-11-04 18:13:01'),
(6, 6, 'App\\Models\\Product', 1, 1, 200000.00, 200000.00, '2025-11-04 18:47:58', '2025-11-04 18:47:58'),
(7, 7, 'App\\Models\\Product', 1, 1, 500000.00, 500000.00, '2025-11-05 06:11:39', '2025-11-05 06:11:39'),
(9, 9, 'App\\Models\\Product', 2, 1, 600000.00, 600000.00, '2025-11-10 15:28:48', '2025-11-10 15:28:48'),
(10, 10, 'App\\Models\\Product', 6, 1, 500000.00, 500000.00, '2025-11-11 15:59:28', '2025-11-11 15:59:28'),
(11, 11, 'App\\Models\\Product', 6, 1, 500000.00, 500000.00, '2025-11-11 16:07:51', '2025-11-11 16:07:51'),
(12, 12, 'App\\Models\\Product', 10, 1, 500000.00, 500000.00, '2025-11-11 17:00:43', '2025-11-11 17:00:43'),
(13, 13, 'App\\Models\\Product', 10, 1, 500000.00, 500000.00, '2025-11-11 17:16:35', '2025-11-11 17:16:35'),
(14, 14, 'App\\Models\\Product', 11, 1, 500000.00, 500000.00, '2025-11-12 18:38:51', '2025-11-12 18:38:51'),
(15, 15, 'App\\Models\\Product', 12, 1, 500000.00, 500000.00, '2025-11-13 04:32:14', '2025-11-13 04:32:14'),
(16, 16, 'App\\Models\\Product', 11, 1, 500000.00, 500000.00, '2025-11-16 16:12:02', '2025-11-16 16:12:02'),
(17, 17, 'App\\Models\\Product', 6, 1, 500000.00, 500000.00, '2025-11-19 09:23:37', '2025-11-19 09:23:37'),
(21, 21, 'App\\Models\\Service', 2, 1, 50000.00, 50000.00, '2025-12-01 18:20:06', '2025-12-01 18:20:06'),
(22, 22, 'App\\Models\\Service', 2, 1, 50000.00, 50000.00, '2025-12-01 18:24:20', '2025-12-01 18:24:20'),
(23, 23, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-01 19:51:22', '2025-12-01 19:51:22'),
(24, 24, 'App\\Models\\Service', 1, 1, 17500.00, 17500.00, '2025-12-02 16:18:22', '2025-12-02 16:18:22'),
(25, 25, 'App\\Models\\Service', 1, 1, 17500.00, 17500.00, '2025-12-03 17:57:27', '2025-12-03 17:57:27'),
(26, 26, 'App\\Models\\Service', 1, 1, 17500.00, 17500.00, '2025-12-03 18:07:34', '2025-12-03 18:07:34'),
(28, 28, 'App\\Models\\Product', 3, 1, 1000000.00, 1000000.00, '2025-12-09 18:11:36', '2025-12-09 18:11:36'),
(36, 36, 'App\\Models\\Product', 12, 1, 500000.00, 500000.00, '2025-12-10 17:14:51', '2025-12-10 17:14:51'),
(37, 37, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-10 17:20:54', '2025-12-10 17:20:54'),
(38, 38, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-10 17:21:24', '2025-12-10 17:21:24'),
(39, 39, 'App\\Models\\Product', 10, 1, 500000.00, 500000.00, '2025-12-10 17:24:18', '2025-12-10 17:24:18'),
(40, 40, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-10 17:28:07', '2025-12-10 17:28:07'),
(41, 41, 'App\\Models\\Product', 11, 1, 5000000.00, 5000000.00, '2025-12-10 17:29:12', '2025-12-10 17:29:12'),
(42, 42, 'App\\Models\\Product', 10, 1, 500000.00, 500000.00, '2025-12-10 17:44:36', '2025-12-10 17:44:36'),
(43, 43, 'App\\Models\\Product', 4, 1, 5000000.00, 5000000.00, '2025-12-10 17:47:04', '2025-12-10 17:47:04'),
(44, 44, 'App\\Models\\Product', 6, 1, 50000.00, 50000.00, '2025-12-10 17:50:13', '2025-12-10 17:50:13'),
(45, 45, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-10 18:10:25', '2025-12-10 18:10:25'),
(48, 48, 'App\\Models\\Product', 4, 1, 5000000.00, 5000000.00, '2025-12-11 19:33:42', '2025-12-11 19:33:42'),
(49, 49, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-11 19:41:42', '2025-12-11 19:41:42'),
(50, 50, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-11 19:42:40', '2025-12-11 19:42:40'),
(51, 51, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-17 18:06:23', '2025-12-17 18:06:23'),
(52, 52, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-22 18:26:49', '2025-12-22 18:26:49'),
(53, 53, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-22 18:32:33', '2025-12-22 18:32:33'),
(54, 54, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-22 18:36:32', '2025-12-22 18:36:32'),
(55, 55, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-22 18:44:04', '2025-12-22 18:44:04'),
(56, 56, 'App\\Models\\Product', 1, 1, 5000000.00, 5000000.00, '2025-12-23 04:27:39', '2025-12-23 04:27:39');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sales_order_id` bigint(20) UNSIGNED NOT NULL,
  `paid_at` date NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `commission_base_amount` decimal(14,2) DEFAULT NULL,
  `commission_processed_at` timestamp NULL DEFAULT NULL,
  `type` enum('down_payment','installment','full_payment','partial_payment') DEFAULT 'installment',
  `intent_type` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `sales_order_id`, `paid_at`, `amount`, `commission_base_amount`, `commission_processed_at`, `type`, `intent_type`, `method`, `meta`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-11-04', 60000.00, NULL, '2025-11-04 18:29:25', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"232424\"}', '2025-11-04 17:33:59', '2025-11-04 18:29:25'),
(3, 4, '2025-11-04', 20000.00, NULL, '2025-11-04 18:29:25', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"111111\"}', '2025-11-04 18:10:28', '2025-11-04 18:29:25'),
(4, 5, '2025-11-04', 30000.00, NULL, '2025-11-04 18:29:25', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"2121\"}', '2025-11-04 18:13:15', '2025-11-04 18:29:25'),
(5, 6, '2025-11-04', 20000.00, NULL, '2025-11-04 18:49:15', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"11212\"}', '2025-11-04 18:48:21', '2025-11-04 18:49:15'),
(6, 7, '2025-11-05', 50000.00, NULL, '2025-11-05 06:13:27', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"afasdfasdfsd\"}', '2025-11-05 06:11:59', '2025-11-05 06:13:27'),
(7, 10, '2025-11-11', 50000.00, 45000.00, '2025-11-19 09:26:40', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"sdfdsfdsf\"}', '2025-11-11 15:59:49', '2025-11-19 09:26:41'),
(8, 10, '2025-11-11', 37500.00, 33750.00, '2025-11-19 09:26:41', 'installment', 'installment', 'bank_transfer', '{\"reference\":\"345345435\"}', '2025-11-11 16:02:14', '2025-11-19 09:26:41'),
(9, 11, '2025-11-11', 50000.00, 45000.00, '2025-11-19 09:26:41', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"123123123\"}', '2025-11-11 16:08:16', '2025-11-19 09:26:41'),
(10, 11, '2025-11-11', 37500.00, 33750.00, '2025-11-19 09:26:41', 'installment', 'installment', 'cash', '{\"reference\":\"4324324324\"}', '2025-11-11 16:11:44', '2025-11-19 09:26:41'),
(11, 12, '2025-11-11', 50000.00, 40000.00, '2025-11-19 09:26:41', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"01999070235\"}', '2025-11-11 17:02:08', '2025-11-19 09:26:41'),
(12, 12, '2025-11-11', 37500.00, 30000.00, '2025-11-19 09:26:41', 'installment', 'installment', 'cash', '{\"reference\":\"4345435\"}', '2025-11-11 17:03:52', '2025-11-19 09:26:41'),
(13, 14, '2025-11-12', 50000.00, 35000.00, '2025-11-19 09:26:41', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"32432432\"}', '2025-11-12 18:39:11', '2025-11-19 09:26:41'),
(14, 14, '2025-11-12', 37500.00, 26250.00, '2025-11-19 09:26:41', 'installment', 'installment', 'cash', '{\"reference\":\"23234324\"}', '2025-11-12 18:39:25', '2025-11-19 09:26:41'),
(15, 15, '2025-11-13', 50000.00, 40000.00, '2025-11-19 09:26:42', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"111\"}', '2025-11-13 04:33:17', '2025-11-19 09:26:42'),
(16, 15, '2025-11-13', 37500.00, 30000.00, '2025-11-19 09:26:42', 'installment', 'installment', 'cash', '{\"reference\":\"1111\"}', '2025-11-13 04:33:28', '2025-11-19 09:26:42'),
(17, 16, '2025-11-16', 50000.00, 35000.00, '2025-11-19 09:26:42', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"12323123213\"}', '2025-11-16 16:12:17', '2025-11-19 09:26:42'),
(18, 17, '2025-11-19', 100000.00, 90000.00, '2025-11-19 09:26:42', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"11111\"}', '2025-11-19 09:24:32', '2025-11-19 09:26:42'),
(19, 17, '2025-11-19', 33333.34, 30000.01, '2025-11-19 09:26:42', 'installment', 'installment', 'cheque', '{\"reference\":\"11111\"}', '2025-11-19 09:25:14', '2025-11-19 09:26:42'),
(28, 22, '2025-12-01', 50000.00, 50000.00, NULL, 'full_payment', 'due_payment', NULL, NULL, '2025-12-01 19:16:55', '2025-12-01 19:16:55'),
(29, 22, '2025-12-01', 5000.00, 5000.00, NULL, 'partial_payment', 'due_payment', NULL, NULL, '2025-12-01 19:24:11', '2025-12-01 19:24:11'),
(30, 21, '2025-12-01', 5000.00, 5000.00, NULL, 'partial_payment', 'due_payment', NULL, NULL, '2025-12-01 19:25:21', '2025-12-01 19:25:21'),
(31, 21, '2025-12-01', 5000.00, 5000.00, NULL, 'partial_payment', 'due_payment', NULL, NULL, '2025-12-01 19:37:26', '2025-12-01 19:37:26'),
(32, 23, '2025-12-01', 50000.00, 45000.00, '2025-12-10 16:51:53', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"423423\"}', '2025-12-01 19:51:35', '2025-12-10 16:51:53'),
(33, 23, '2025-12-02', 412500.00, 371250.00, '2025-12-10 16:51:53', 'installment', 'installment_payment', 'cash', '{\"reference\":\"343324\"}', '2025-12-02 10:48:40', '2025-12-10 16:51:53'),
(34, 24, '2025-12-02', 17500.00, 17500.00, NULL, 'full_payment', 'due_payment', NULL, NULL, '2025-12-02 16:19:50', '2025-12-02 16:19:50'),
(35, 25, '2025-12-03', 17500.00, 17500.00, NULL, 'full_payment', 'due_payment', NULL, NULL, '2025-12-03 17:59:42', '2025-12-03 17:59:42'),
(36, 26, '2025-12-03', 17500.00, 17500.00, NULL, 'full_payment', 'due_payment', NULL, NULL, '2025-12-03 18:09:13', '2025-12-03 18:09:13'),
(37, 28, '2025-12-09', 50000.00, 45000.00, '2025-12-10 16:51:53', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"2322\"}', '2025-12-09 18:12:08', '2025-12-10 16:51:53'),
(38, 28, '2025-12-09', 95000.00, 85500.00, '2025-12-10 16:51:53', 'installment', 'installment_payment', 'cash', '{\"reference\":\"32434\"}', '2025-12-09 18:12:45', '2025-12-10 16:51:54'),
(42, 36, '2025-12-10', 50000.00, 40000.00, '2025-12-10 17:30:54', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"3123213213\"}', '2025-12-10 17:15:10', '2025-12-10 17:30:54'),
(43, 41, '2025-12-10', 50000.00, 35000.00, '2025-12-10 17:30:54', 'down_payment', 'down_payment', 'cash', '{\"reference\":null}', '2025-12-10 17:29:51', '2025-12-10 17:30:54'),
(44, 41, '2025-12-10', 412500.00, 288750.00, '2025-12-10 17:30:54', 'installment', 'installment_payment', 'cash', '{\"reference\":\"2222\"}', '2025-12-10 17:30:13', '2025-12-10 17:30:54'),
(45, 44, '2025-12-10', 5000.00, 4500.00, '2025-12-10 18:21:21', 'down_payment', 'down_payment', 'cash', '{\"reference\":null}', '2025-12-10 17:50:44', '2025-12-10 18:21:21'),
(46, 44, '2025-12-10', 3750.00, 3375.00, '2025-12-10 18:21:21', 'installment', 'installment_payment', 'cash', '{\"reference\":null}', '2025-12-10 17:50:49', '2025-12-10 18:21:21'),
(47, 45, '2025-12-10', 1000000.00, 900000.00, '2025-12-10 18:21:21', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"123\"}', '2025-12-10 18:15:24', '2025-12-10 18:21:21'),
(48, 45, '2025-12-10', 200000.00, 180000.00, '2025-12-10 18:21:21', 'installment', 'installment_payment', 'cash', '{\"reference\":\"123\"}', '2025-12-10 18:16:50', '2025-12-10 18:21:21'),
(50, 48, '2025-12-11', 1000000.00, 700000.00, '2025-12-11 19:45:39', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"344\"}', '2025-12-11 19:35:20', '2025-12-11 19:45:39'),
(51, 48, '2025-12-11', 200000.00, 140000.00, '2025-12-11 19:45:39', 'installment', 'installment_payment', 'cash', '{\"reference\":\"344\"}', '2025-12-11 19:36:20', '2025-12-11 19:45:39'),
(52, 50, '2025-12-11', 1000000.00, 900000.00, '2025-12-11 19:45:39', 'down_payment', 'down_payment', 'cash', '{\"reference\":null}', '2025-12-11 19:44:22', '2025-12-11 19:45:39'),
(53, 52, '2025-12-22', 50000.00, 45000.00, '2025-12-22 18:45:22', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"123213213\"}', '2025-12-22 18:27:16', '2025-12-22 18:45:22'),
(54, 53, '2025-12-22', 50000.00, 45000.00, NULL, 'down_payment', 'down_payment', 'cash', '{\"reference\":\"21212\"}', '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(55, 54, '2025-12-22', 100000.00, 90000.00, '2025-12-22 18:45:22', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"21313213\"}', '2025-12-22 18:36:43', '2025-12-22 18:45:22'),
(56, 55, '2025-12-22', 100000.00, 90000.00, '2025-12-22 18:45:22', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"213213123\"}', '2025-12-22 18:44:18', '2025-12-22 18:45:22'),
(57, 56, '2025-12-23', 100000.00, 90000.00, '2025-12-23 04:29:13', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"11111\"}', '2025-12-23 04:27:57', '2025-12-23 04:29:13');

-- --------------------------------------------------------

--
-- Table structure for table `payment_allocations`
--

CREATE TABLE `payment_allocations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` bigint(20) UNSIGNED NOT NULL,
  `customer_installment_id` bigint(20) UNSIGNED NOT NULL,
  `allocated` decimal(14,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_allocations`
--

INSERT INTO `payment_allocations` (`id`, `payment_id`, `customer_installment_id`, `allocated`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 0.00, '2025-11-04 17:33:59', '2025-11-04 17:33:59'),
(3, 3, 3, 0.00, '2025-11-04 18:10:29', '2025-11-04 18:10:29'),
(4, 4, 4, 0.00, '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(5, 5, 5, 0.00, '2025-11-04 18:48:21', '2025-11-04 18:48:21'),
(6, 6, 6, 0.00, '2025-11-05 06:11:59', '2025-11-05 06:11:59'),
(7, 7, 17, 0.00, '2025-11-11 15:59:49', '2025-11-11 15:59:49'),
(8, 8, 17, 37500.00, '2025-11-11 16:02:14', '2025-11-11 16:02:14'),
(9, 9, 29, 0.00, '2025-11-11 16:08:16', '2025-11-11 16:08:16'),
(10, 10, 29, 37500.00, '2025-11-11 16:11:45', '2025-11-11 16:11:45'),
(11, 11, 41, 0.00, '2025-11-11 17:02:09', '2025-11-11 17:02:09'),
(12, 12, 41, 37500.00, '2025-11-11 17:03:52', '2025-11-11 17:03:52'),
(13, 13, 53, 0.00, '2025-11-12 18:39:11', '2025-11-12 18:39:11'),
(14, 14, 53, 37500.00, '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(15, 15, 65, 0.00, '2025-11-13 04:33:17', '2025-11-13 04:33:17'),
(16, 16, 65, 37500.00, '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(17, 17, 77, 0.00, '2025-11-16 16:12:17', '2025-11-16 16:12:17'),
(18, 18, 89, 0.00, '2025-11-19 09:24:32', '2025-11-19 09:24:32'),
(19, 19, 89, 33333.34, '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(21, 32, 113, 0.00, '2025-12-01 19:51:35', '2025-12-01 19:51:35'),
(22, 33, 113, 412500.00, '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(23, 37, 125, 0.00, '2025-12-09 18:12:08', '2025-12-09 18:12:08'),
(24, 38, 125, 95000.00, '2025-12-09 18:12:46', '2025-12-09 18:12:46'),
(28, 42, 169, 0.00, '2025-12-10 17:15:10', '2025-12-10 17:15:10'),
(29, 43, 229, 0.00, '2025-12-10 17:29:52', '2025-12-10 17:29:52'),
(30, 44, 229, 412500.00, '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(31, 45, 265, 0.00, '2025-12-10 17:50:44', '2025-12-10 17:50:44'),
(32, 46, 265, 3750.00, '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(33, 47, 277, 0.00, '2025-12-10 18:15:24', '2025-12-10 18:15:24'),
(34, 48, 277, 200000.00, '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(36, 50, 337, 0.00, '2025-12-11 19:35:20', '2025-12-11 19:35:20'),
(37, 51, 337, 200000.00, '2025-12-11 19:36:20', '2025-12-11 19:36:20'),
(38, 52, 357, 0.00, '2025-12-11 19:44:22', '2025-12-11 19:44:22'),
(39, 53, 389, 0.00, '2025-12-22 18:27:17', '2025-12-22 18:27:17'),
(40, 54, 401, 0.00, '2025-12-22 18:33:48', '2025-12-22 18:33:48'),
(41, 55, 413, 0.00, '2025-12-22 18:36:43', '2025-12-22 18:36:43'),
(42, 56, 425, 0.00, '2025-12-22 18:44:18', '2025-12-22 18:44:18'),
(43, 57, 437, 0.00, '2025-12-23 04:27:57', '2025-12-23 04:27:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_intents`
--

CREATE TABLE `payment_intents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sales_order_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `customer_installment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` decimal(14,2) NOT NULL,
  `currency` varchar(3) NOT NULL DEFAULT 'BDT',
  `type` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `gateway` varchar(255) NOT NULL DEFAULT 'sslcommerz',
  `gateway_transaction_id` varchar(255) DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pd_special_bonuses`
--

CREATE TABLE `pd_special_bonuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `month` varchar(7) NOT NULL,
  `total_dp` decimal(15,2) NOT NULL DEFAULT 0.00,
  `percentage` decimal(5,2) NOT NULL DEFAULT 4.00,
  `amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `status` varchar(255) NOT NULL DEFAULT 'draft',
  `processed_at` datetime DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pd_special_bonuses`
--

INSERT INTO `pd_special_bonuses` (`id`, `employee_id`, `month`, `total_dp`, `percentage`, `amount`, `status`, `processed_at`, `meta`, `created_at`, `updated_at`) VALUES
(1, 12, '2025-11', 330000.00, 4.00, 13200.00, 'paid', '2025-12-17 18:18:00', '{\"subtree_employee_ids\":[12,13,19,43,14,44,15,16,17,20]}', '2025-12-17 18:17:20', '2025-12-17 18:18:00');

-- --------------------------------------------------------

--
-- Table structure for table `pd_special_month_locks`
--

CREATE TABLE `pd_special_month_locks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `month` varchar(7) NOT NULL,
  `locked_at` datetime NOT NULL,
  `locked_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pd_special_month_locks`
--

INSERT INTO `pd_special_month_locks` (`id`, `month`, `locked_at`, `locked_by`, `created_at`, `updated_at`) VALUES
(1, '2025-11', '2025-12-17 18:18:00', 10, '2025-12-17 18:18:00', '2025-12-17 18:18:00');

-- --------------------------------------------------------

--
-- Table structure for table `pd_special_selections`
--

CREATE TABLE `pd_special_selections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `month` varchar(7) NOT NULL,
  `percentage` decimal(5,2) NOT NULL DEFAULT 4.00,
  `selected_by` bigint(20) UNSIGNED NOT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pd_special_selections`
--

INSERT INTO `pd_special_selections` (`id`, `employee_id`, `month`, `percentage`, `selected_by`, `meta`, `created_at`, `updated_at`) VALUES
(1, 12, '2025-11', 4.00, 10, '[]', '2025-12-17 18:16:59', '2025-12-17 18:16:59');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'manage users', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(2, 'manage branches', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(3, 'manage agents', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(4, 'manage products', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(5, 'manage services', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(6, 'manage sales orders', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(7, 'manage payments', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(8, 'manage commissions', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(9, 'manage ranks', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(10, 'manage accounting', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(11, 'view reports', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 10, 'api_token', '1043f13c310d2bf5db6c481b821d9a4e8a6007b6107f7bea54d258b29d45c4db', '[\"*\"]', '2025-10-20 14:15:47', NULL, '2025-10-20 14:06:56', '2025-10-20 14:15:47'),
(2, 'App\\Models\\User', 10, 'api_token', '0f9f9a5082b57b8c3c0b02972e500a3c972e97695f42416e44ef4720fbe35074', '[\"*\"]', '2025-10-21 18:31:01', NULL, '2025-10-21 14:37:57', '2025-10-21 18:31:01'),
(3, 'App\\Models\\User', 10, 'api_token', '765fad09e810aea49b0cbb395e974c30ea9568c5c70b88e6d69f5189acae903f', '[\"*\"]', '2025-10-21 17:09:33', NULL, '2025-10-21 14:41:22', '2025-10-21 17:09:33'),
(4, 'App\\Models\\User', 10, 'api_token', '261ec3141794e88ba4be25aa7096405db6865bef418b64f2130bdd459b811e00', '[\"*\"]', '2025-10-21 19:39:28', NULL, '2025-10-21 17:11:34', '2025-10-21 19:39:28'),
(5, 'App\\Models\\User', 10, 'api_token', '59f01c3a47fadf6be8ee3d83bd4f241353585e7dcc858774773b7f828e149a3e', '[\"*\"]', '2025-10-21 19:18:10', NULL, '2025-10-21 18:59:56', '2025-10-21 19:18:10'),
(6, 'App\\Models\\User', 10, 'api_token', '629cc2d258944bccce76629afc9775a675bdf912136f89504e09bc1acf0de27e', '[\"*\"]', '2025-10-22 16:33:46', NULL, '2025-10-21 19:20:04', '2025-10-22 16:33:46'),
(7, 'App\\Models\\User', 10, 'api_token', 'cc0dccc41dc11fe899ab1bab0dd453bcbab5255c71f3064789026797ce7bc9ff', '[\"*\"]', '2025-10-21 19:41:42', NULL, '2025-10-21 19:41:07', '2025-10-21 19:41:42'),
(8, 'App\\Models\\User', 10, 'api_token', '4625a6ccc967cc193534fa2960111227a716847d67991902c56793aa28b38678', '[\"*\"]', NULL, NULL, '2025-10-22 15:30:25', '2025-10-22 15:30:25'),
(9, 'App\\Models\\User', 10, 'api_token', '12adb10976e95b24e5a7ebf8ba26d2c2b59633e691ad540ad92eb00f513babcb', '[\"*\"]', '2025-10-22 16:34:16', NULL, '2025-10-22 15:30:36', '2025-10-22 16:34:16'),
(10, 'App\\Models\\User', 12, 'customer_api_token', '15330f5801a7a7ee660740d8ef2996b240d421d16eccc4c15920f0c907be5bc9', '[\"*\"]', '2025-10-22 17:38:54', NULL, '2025-10-22 16:34:27', '2025-10-22 17:38:54'),
(11, 'App\\Models\\User', 12, 'api_token', '65f306c813ca4029674d71c423583c8699debc0ec20e11a453de6c6f0da5347a', '[\"*\"]', NULL, NULL, '2025-10-22 16:35:13', '2025-10-22 16:35:13'),
(12, 'App\\Models\\User', 10, 'api_token', '2ca79e7e0dc16d779f796b7075e29d77ceeba3f4a52daa37c682feebc6de69d6', '[\"*\"]', '2025-10-22 16:39:50', NULL, '2025-10-22 16:39:49', '2025-10-22 16:39:50'),
(13, 'App\\Models\\User', 12, 'api_token', '9c0e99b0aea9727c16c0ecd75bcf2f909dd497bda69dfd1c5f73a4b08e9ef703', '[\"*\"]', '2025-10-22 17:06:13', NULL, '2025-10-22 16:40:06', '2025-10-22 17:06:13'),
(14, 'App\\Models\\User', 12, 'api_token', '331ca1da4a880a8c8717b6d97a63ac8857d55f702968675bbc744edaddac7499', '[\"*\"]', '2025-10-22 17:38:16', NULL, '2025-10-22 17:06:10', '2025-10-22 17:38:16'),
(15, 'App\\Models\\User', 12, 'api_token', '07ee82ffa610c0d0ee41382ed7f745483c1008fd5b5f4c2dc20c3d5b4c502f75', '[\"*\"]', '2025-10-22 17:51:58', NULL, '2025-10-22 17:39:18', '2025-10-22 17:51:58'),
(16, 'App\\Models\\User', 12, 'api_token', 'fb9167ba340a88e92f00d6f665d7b71950ca8a7a7880771054743045ceb7f565', '[\"*\"]', '2025-10-22 17:47:41', NULL, '2025-10-22 17:46:19', '2025-10-22 17:47:41'),
(17, 'App\\Models\\User', 10, 'api_token', '30e85b8bfb97f67381547e1574a8b050aa7e871b0b9e332cd00ec87bdcb5f9ec', '[\"*\"]', '2025-10-22 18:15:51', NULL, '2025-10-22 17:52:29', '2025-10-22 18:15:51'),
(18, 'App\\Models\\User', 10, 'api_token', '857ad7dba18b8b1f02fb2197ad2f9eb4d50f29831209ced12e4ba03f85ffbac7', '[\"*\"]', '2025-10-22 18:10:41', NULL, '2025-10-22 18:10:40', '2025-10-22 18:10:41'),
(19, 'App\\Models\\User', 12, 'api_token', '09e2fa4a6cae0087b694c16c2efcc41dc37e38adfd4a6f6a075a015bee95a0bb', '[\"*\"]', NULL, NULL, '2025-10-22 18:10:59', '2025-10-22 18:10:59'),
(20, 'App\\Models\\User', 12, 'api_token', 'a910f13fb86aa2cee1c39fdc14b6def479dc39ebb9567bd62145dc478aa53a79', '[\"*\"]', NULL, NULL, '2025-10-22 18:13:46', '2025-10-22 18:13:46'),
(21, 'App\\Models\\User', 10, 'api_token', 'b4fa1470ae9c2073c61ae523e3419c8de457edc8500d7d07aa43f97635691002', '[\"*\"]', '2025-10-22 18:14:11', NULL, '2025-10-22 18:14:03', '2025-10-22 18:14:11'),
(22, 'App\\Models\\User', 12, 'api_token', '800d9d2edc628bc79600d0ea2bca22d71b4ec75230ce1f093d0b4aaa75fc7521', '[\"*\"]', NULL, NULL, '2025-10-22 18:14:18', '2025-10-22 18:14:18'),
(23, 'App\\Models\\User', 12, 'customer_api_token', 'f5fe28016a31cdcb7232ce9298ca93801ba34c1a6ee35510203c85616ac822d3', '[\"*\"]', '2025-10-22 18:14:53', NULL, '2025-10-22 18:14:44', '2025-10-22 18:14:53'),
(24, 'App\\Models\\User', 12, 'api_token', '46e7bc20cc15139befbe10435e951b7844af44e9a20a74bec85ca371168f8607', '[\"*\"]', '2025-10-22 18:17:33', NULL, '2025-10-22 18:15:46', '2025-10-22 18:17:33'),
(25, 'App\\Models\\User', 10, 'api_token', 'b5f1cfb0a1ed21d5777f72a964aa143431d1fd2d56daa35b23e2545ef1b483dc', '[\"*\"]', '2025-10-22 18:17:21', NULL, '2025-10-22 18:17:14', '2025-10-22 18:17:21'),
(26, 'App\\Models\\User', 12, 'api_token', '6feda1cb55d038f019f1d49dd29d4ca514f463a4d95a8312758ed0f1ff475f7b', '[\"*\"]', '2025-10-22 18:26:20', NULL, '2025-10-22 18:17:28', '2025-10-22 18:26:20'),
(27, 'App\\Models\\User', 10, 'api_token', '8b31cef5242bf22d7db837bdbcc5c875d19b6d76700c638b158b4cc36328ceca', '[\"*\"]', '2025-10-22 18:20:30', NULL, '2025-10-22 18:20:28', '2025-10-22 18:20:30'),
(28, 'App\\Models\\User', 12, 'api_token', 'bbd8d2c50c2b30d4eee963130f01c33b4d25397bd491fb9483044577b412c3b6', '[\"*\"]', NULL, NULL, '2025-10-22 18:21:10', '2025-10-22 18:21:10'),
(29, 'App\\Models\\User', 12, 'api_token', 'a22fdc0f5ab0967dfacf47d1089284e857b8f86bc364d313d4d5fc0ea7502068', '[\"*\"]', NULL, NULL, '2025-10-22 18:22:38', '2025-10-22 18:22:38'),
(30, 'App\\Models\\User', 10, 'api_token', '05a975c7ed6b9e3cbebe0f81212a9f64135d64826743487b8384cc685a0d382b', '[\"*\"]', '2025-10-22 18:51:29', NULL, '2025-10-22 18:26:07', '2025-10-22 18:51:29'),
(31, 'App\\Models\\User', 10, 'api_token', '5d7e05d16bc65926779a4a180ac119987d158279052fa3b0b3340ca799ca62a6', '[\"*\"]', '2025-10-24 16:44:36', NULL, '2025-10-24 15:43:05', '2025-10-24 16:44:36'),
(32, 'App\\Models\\User', 10, 'api_token', '71ce6cfeeaf58234e078faf3b5a9b2de92dba891ad3999cb0ccd0c0d58012f70', '[\"*\"]', '2025-10-27 17:09:49', NULL, '2025-10-24 15:47:17', '2025-10-27 17:09:49'),
(33, 'App\\Models\\User', 10, 'api_token', '35271a6389b546adb711dd4aee3f8162a51ce0003c0b74b47b5841ca8ee33779', '[\"*\"]', '2025-10-25 15:21:59', NULL, '2025-10-25 14:48:38', '2025-10-25 15:21:59'),
(34, 'App\\Models\\User', 10, 'api_token', '076ad57afd85b7d3bdc7b74c194118f5a67e8a735b256aa7e025dcd30160cde7', '[\"*\"]', '2025-10-27 15:55:13', NULL, '2025-10-27 15:18:29', '2025-10-27 15:55:13'),
(35, 'App\\Models\\User', 14, 'api_token', 'ea98da91086d13e03756bf4f29a25ab47614b3623e82f38bf164e7f14eebc3dd', '[\"*\"]', NULL, NULL, '2025-10-27 15:42:00', '2025-10-27 15:42:00'),
(36, 'App\\Models\\User', 14, 'api_token', 'e7d5e73295104e8448bf73d9c9c388b38950b864861612272d83a0ff3e6c2bc1', '[\"*\"]', '2025-10-27 15:43:18', NULL, '2025-10-27 15:42:07', '2025-10-27 15:43:18'),
(37, 'App\\Models\\User', 10, 'api_token', 'fc9cfc269e7486012c25d3bfa21e73c05d860132f528d6127c33d5424b1860dd', '[\"*\"]', '2025-10-27 15:45:17', NULL, '2025-10-27 15:45:10', '2025-10-27 15:45:17'),
(38, 'App\\Models\\User', 12, 'api_token', '3d038c1cd5833f197c80a89c13475255237a562039ee8bae6fff230dea23b645', '[\"*\"]', NULL, NULL, '2025-10-27 15:45:33', '2025-10-27 15:45:33'),
(39, 'App\\Models\\User', 13, 'api_token', '793f01d388cfd2e832f21001eddce2af775d2aec429091d7eca9f6cd80240e73', '[\"*\"]', NULL, NULL, '2025-10-27 15:46:15', '2025-10-27 15:46:15'),
(40, 'App\\Models\\User', 10, 'api_token', '10a62caac5a50d475bc6b2df7acc393a9bbd61523cfb879129b8f8d9f1d2f63c', '[\"*\"]', '2025-10-27 15:47:12', NULL, '2025-10-27 15:46:32', '2025-10-27 15:47:12'),
(41, 'App\\Models\\User', 12, 'api_token', '9b382a2a7664d8d940ce1c94e055c8704cf083bd8cade81bc6a3d9244fa75295', '[\"*\"]', '2025-10-27 15:53:13', NULL, '2025-10-27 15:47:21', '2025-10-27 15:53:13'),
(42, 'App\\Models\\User', 12, 'customer_api_token', '7a0ccd95c471c410b2e5eac3cbf5b766290fde1e0ab89ccd66023802d52e82de', '[\"*\"]', '2025-10-27 15:48:15', NULL, '2025-10-27 15:47:56', '2025-10-27 15:48:15'),
(43, 'App\\Models\\User', 10, 'api_token', '6cf5ce45952b3a25ff236923d041b3a926f44e1bfbc0c6761782c2ea7774aced', '[\"*\"]', '2025-10-27 15:52:59', NULL, '2025-10-27 15:52:57', '2025-10-27 15:52:59'),
(44, 'App\\Models\\User', 12, 'api_token', '97b803ca16973aaebf0e0da6fd21c305999de94b6a84a12a49abf75730a478da', '[\"*\"]', '2025-10-27 15:53:51', NULL, '2025-10-27 15:53:07', '2025-10-27 15:53:51'),
(45, 'App\\Models\\User', 12, 'api_token', '3e22cb3e2075769c1be6ba4527303fa3349f831417e17325cce9c748ea811253', '[\"*\"]', '2025-10-27 17:23:33', NULL, '2025-10-27 15:54:20', '2025-10-27 17:23:33'),
(46, 'App\\Models\\User', 14, 'api_token', '6dd0037f48aa45fc1bdb50eb352bba0b0f3945644c1aded3986dd9223d77475d', '[\"*\"]', '2025-10-27 15:55:12', NULL, '2025-10-27 15:55:10', '2025-10-27 15:55:12'),
(47, 'App\\Models\\User', 10, 'api_token', 'a6b0db401a900de0b8a74ab1bf772433d86c220a2aeebd0f96b11f034b1dcb69', '[\"*\"]', '2025-10-27 16:06:16', NULL, '2025-10-27 15:56:14', '2025-10-27 16:06:16'),
(48, 'App\\Models\\User', 10, 'api_token', '8e50b665f6d04c3095557aab01ff3987047987448e42c797e3566b2ea7b0f1a0', '[\"*\"]', NULL, NULL, '2025-10-27 16:13:23', '2025-10-27 16:13:23'),
(49, 'App\\Models\\User', 10, 'api_token', '1159bc747d13ff53ded11e43c43c41b55c55467bc35b0e261fcdf71f1fb7b15a', '[\"*\"]', '2025-10-27 16:14:10', NULL, '2025-10-27 16:13:28', '2025-10-27 16:14:10'),
(50, 'App\\Models\\User', 12, 'api_token', 'ccbffe9fcf559278b1408df6bba0e73ae9f15a6a9578fc25d1abfe8e749d3df3', '[\"*\"]', '2025-10-27 16:15:11', NULL, '2025-10-27 16:14:34', '2025-10-27 16:15:11'),
(51, 'App\\Models\\User', 10, 'api_token', 'b9f6db089f5c0a5cd9945c8ab32a072c7d176ee07b841686e041910601fe30ab', '[\"*\"]', '2025-10-27 17:30:37', NULL, '2025-10-27 16:18:48', '2025-10-27 17:30:37'),
(52, 'App\\Models\\User', 10, 'api_token', '9c4949e2ed74a5370989e513ca0081011ddc07604774754f084292759f8da805', '[\"*\"]', '2025-10-27 17:32:44', NULL, '2025-10-27 17:32:03', '2025-10-27 17:32:44'),
(53, 'App\\Models\\User', 10, 'api_token', 'b6d28b5e0651f30a0e214f61bb227e64df94c6db15c1eb83fd4ae19198bdd6e6', '[\"*\"]', '2025-10-28 14:55:03', NULL, '2025-10-27 17:46:03', '2025-10-28 14:55:03'),
(54, 'App\\Models\\User', 10, 'api_token', '218c7c5334d510f3b9bd4292e097ad797ad7bc498438f77a1dffd4b958fadf04', '[\"*\"]', '2025-10-27 17:56:21', NULL, '2025-10-27 17:46:29', '2025-10-27 17:56:21'),
(55, 'App\\Models\\User', 15, 'api_token', '86e5114833a64a931325083a1d5deef6bba7e6fb0cef1b7fd789b9f5c3c8460a', '[\"*\"]', '2025-10-27 17:57:23', NULL, '2025-10-27 17:57:18', '2025-10-27 17:57:23'),
(56, 'App\\Models\\User', 10, 'api_token', '90b3971ede267aaa11cbc96e106b83954cb3bbb1ae73b86ce6364a6650bfffbe', '[\"*\"]', '2025-10-28 14:40:57', NULL, '2025-10-27 17:57:32', '2025-10-28 14:40:57'),
(57, 'App\\Models\\User', 10, 'api_token', 'bb22234bee6e58eb25cff96c7f07f75df5dddafdd9338670c3c112fb8ba86aa2', '[\"*\"]', '2025-10-27 18:27:54', NULL, '2025-10-27 18:27:38', '2025-10-27 18:27:54'),
(58, 'App\\Models\\User', 10, 'api_token', '10b671568a70e65fd3e0fac8b07f77a0da7af2066051c9e7f14e79946a26c0bb', '[\"*\"]', NULL, NULL, '2025-10-28 14:38:56', '2025-10-28 14:38:56'),
(59, 'App\\Models\\User', 10, 'api_token', '3ba20113e4af66803b1229325ae807fb655c53c86716c34da753b9e9138fc05f', '[\"*\"]', '2025-10-28 14:40:19', NULL, '2025-10-28 14:39:01', '2025-10-28 14:40:19'),
(60, 'App\\Models\\User', 12, 'api_token', 'b729269c135c8b01dbe25f5f9a8d8de80b7f78696390f979fe88f679b03d169b', '[\"*\"]', '2025-10-28 14:40:34', NULL, '2025-10-28 14:40:28', '2025-10-28 14:40:34'),
(61, 'App\\Models\\User', 14, 'api_token', 'ef08638c5a124fa41307fdfa1b66454bd1739a285c5c6e6351fbdb1636a9489b', '[\"*\"]', '2025-10-28 14:53:41', NULL, '2025-10-28 14:40:53', '2025-10-28 14:53:41'),
(62, 'App\\Models\\User', 10, 'api_token', 'f463cee1c5a198fa68294256e3fc937043a79d0e45c85752726a61d80398efdb', '[\"*\"]', '2025-10-28 15:42:07', NULL, '2025-10-28 14:53:54', '2025-10-28 15:42:07'),
(63, 'App\\Models\\User', 14, 'api_token', '9997ce157c86faf146cb708239eeb8b4f463614f3b42dc4cab5b7e2976b1e32a', '[\"*\"]', '2025-10-28 15:19:38', NULL, '2025-10-28 15:06:26', '2025-10-28 15:19:38'),
(64, 'App\\Models\\User', 14, 'api_token', '7eb519861910d6edafa0ab7918a0fbe677695191ecf0fdc52150ef97e798b252', '[\"*\"]', '2025-10-28 15:07:20', NULL, '2025-10-28 15:06:29', '2025-10-28 15:07:20'),
(65, 'App\\Models\\User', 10, 'api_token', '588b36e35ff1d4a173202c84a2ffa596c593bdc16173d09c7fa27f85270e34db', '[\"*\"]', '2025-10-28 15:07:51', NULL, '2025-10-28 15:07:45', '2025-10-28 15:07:51'),
(66, 'App\\Models\\User', 14, 'api_token', '66baf9a9a3fd905505f285f5c2c71b1fa8dcb8bd6aab61aa7acd5128d8591e57', '[\"*\"]', '2025-10-28 16:16:00', NULL, '2025-10-28 15:28:39', '2025-10-28 16:16:00'),
(67, 'App\\Models\\User', 4, 'api_token', '697916647e3006a7321d4753b5be9a5ade24352683698729967351b60b57974b', '[\"*\"]', NULL, NULL, '2025-10-28 15:43:33', '2025-10-28 15:43:33'),
(68, 'App\\Models\\User', 4, 'api_token', '498ed3dfa8a73e99238f92b9781fd3c35bb9172701f2028b4d274944118cb5bc', '[\"*\"]', NULL, NULL, '2025-10-28 15:43:37', '2025-10-28 15:43:37'),
(69, 'App\\Models\\User', 4, 'api_token', '983489c2dea2f3d3ac1f0fccb4ef8d4ef760cb993c28fc178f9c2934cc06fd12', '[\"*\"]', NULL, NULL, '2025-10-28 15:43:53', '2025-10-28 15:43:53'),
(70, 'App\\Models\\User', 4, 'api_token', '36470ec8fa9178c2e496d606050694c53f86a2a5b80942871e41991fde749566', '[\"*\"]', NULL, NULL, '2025-10-28 15:44:09', '2025-10-28 15:44:09'),
(71, 'App\\Models\\User', 4, 'api_token', 'dcfa1b5267bb0033a0fa1525ece826b2d4e52e6aaea2481c7563a3af8470635e', '[\"*\"]', NULL, NULL, '2025-10-28 15:44:15', '2025-10-28 15:44:15'),
(72, 'App\\Models\\User', 4, 'api_token', 'b6c3ab5dd4609cb71e111f31a904492952378c52f89c7798c28d63fcb51f56d1', '[\"*\"]', NULL, NULL, '2025-10-28 15:44:20', '2025-10-28 15:44:20'),
(73, 'App\\Models\\User', 4, 'api_token', '2deb67e792325041c467858411e7e9e88fab10b7313ec23aa1e51d234b104e26', '[\"*\"]', '2025-10-28 15:44:32', NULL, '2025-10-28 15:44:23', '2025-10-28 15:44:32'),
(74, 'App\\Models\\User', 10, 'api_token', '92330147185c4661ec719aa1a82048876f3288a26f02cf99382c114b3d2334d1', '[\"*\"]', '2025-10-28 15:45:53', NULL, '2025-10-28 15:45:09', '2025-10-28 15:45:53'),
(75, 'App\\Models\\User', 10, 'api_token', 'd4a682c67b176328f5d887206329a1108e3acecb8b8a093222391436d2603b05', '[\"*\"]', '2025-10-28 16:08:23', NULL, '2025-10-28 15:48:17', '2025-10-28 16:08:23'),
(76, 'App\\Models\\User', 22, 'api_token', '21a02dfdfe5f3288234406b45773b55aca8d7ec3c3aaed9112d2d1cc0862d8da', '[\"*\"]', '2025-10-28 16:15:11', NULL, '2025-10-28 16:08:18', '2025-10-28 16:15:11'),
(77, 'App\\Models\\User', 22, 'api_token', '5050fdd3fbc8026fa65990887abac4510ada382bbaa5b6bb3bb84e8ccd6de55c', '[\"*\"]', '2025-10-28 16:28:39', NULL, '2025-10-28 16:15:06', '2025-10-28 16:28:39'),
(78, 'App\\Models\\User', 10, 'api_token', '07643fb27aae311e6df49ea29c125ef5558be983d46fd12a05a1f29863a1dbec', '[\"*\"]', '2025-10-28 16:28:07', NULL, '2025-10-28 16:28:02', '2025-10-28 16:28:07'),
(79, 'App\\Models\\User', 22, 'api_token', '67cb07bac384548b94b671dc4335b385a7f311f83dbdb014a8b492d838024422', '[\"*\"]', '2025-10-28 16:48:15', NULL, '2025-10-28 16:28:16', '2025-10-28 16:48:15'),
(80, 'App\\Models\\User', 22, 'api_token', 'b4faddf86c9c33878626e85810a5ffa388da035cab38651c399cdb599ed491ef', '[\"*\"]', '2025-10-28 16:31:01', NULL, '2025-10-28 16:29:36', '2025-10-28 16:31:01'),
(81, 'App\\Models\\User', 22, 'api_token', '7a6c8fd3572d851ece073e6bd4b31ad6ff2123ac8a2b00da181cfa05bbef050f', '[\"*\"]', NULL, NULL, '2025-10-28 16:32:10', '2025-10-28 16:32:10'),
(82, 'App\\Models\\User', 22, 'api_token', 'd7912be9720af6c2d333b15b44e6f82b77a9c8cb5fdadefd6c8383fc6981e7a2', '[\"*\"]', '2025-10-28 16:35:15', NULL, '2025-10-28 16:32:23', '2025-10-28 16:35:15'),
(83, 'App\\Models\\User', 10, 'api_token', '1a0c632d8bbe343e4a91292e6679537529870257740c37e9969adf17206f38fe', '[\"*\"]', '2025-10-28 16:44:27', NULL, '2025-10-28 16:34:50', '2025-10-28 16:44:27'),
(84, 'App\\Models\\User', 16, 'api_token', 'ebb93d7f4823ab6376194844720f9f3775f82392a981a009570adbcdc4aebdf7', '[\"*\"]', NULL, NULL, '2025-10-28 16:40:09', '2025-10-28 16:40:09'),
(85, 'App\\Models\\User', 16, 'api_token', '9099ab3a1615d2bb6909a71321738bceb1cfbc3a08de4245f64e908f36679f16', '[\"*\"]', NULL, NULL, '2025-10-28 16:42:08', '2025-10-28 16:42:08'),
(86, 'App\\Models\\User', 22, 'api_token', '1146d533bb4fdab3b0743dd1b27e8c07015a6efb00beb7cb40ee78debd2c92d4', '[\"*\"]', NULL, NULL, '2025-10-28 16:42:26', '2025-10-28 16:42:26'),
(87, 'App\\Models\\User', 10, 'api_token', 'aee2d6cd05e1ef9a0e95146c637480ab84bb41967243402cc2e4c7068d80bedb', '[\"*\"]', NULL, NULL, '2025-10-28 16:42:49', '2025-10-28 16:42:49'),
(88, 'App\\Models\\User', 22, 'api_token', 'ffc84efa3960df6b5c1c0fdcc9f5522fec22d8c818c8e31039ffa08c17ce4321', '[\"*\"]', NULL, NULL, '2025-10-28 16:42:58', '2025-10-28 16:42:58'),
(89, 'App\\Models\\User', 22, 'api_token', 'f7bc9f053e3cd22963baad00a2c61326b81953298f6b719d9ad30d73779929ff', '[\"*\"]', '2025-10-28 17:51:01', NULL, '2025-10-28 16:43:56', '2025-10-28 17:51:01'),
(90, 'App\\Models\\User', 10, 'api_token', 'c64baacd0e131733019e5925a8a2bbb60e911569ea0d6a83344628fd29146c9c', '[\"*\"]', '2025-10-29 17:09:52', NULL, '2025-10-28 17:51:22', '2025-10-29 17:09:52'),
(91, 'App\\Models\\User', 22, 'api_token', '5373875d4bad98163fae40b91738f8263e092e06999767f16e5a4de956dc019f', '[\"*\"]', NULL, NULL, '2025-10-28 18:25:35', '2025-10-28 18:25:35'),
(92, 'App\\Models\\User', 22, 'api_token', 'f6020272b4ff729ff07d69c3539de67aff9e01c66527193a3a01652110ac5f31', '[\"*\"]', '2025-10-28 18:25:47', NULL, '2025-10-28 18:25:40', '2025-10-28 18:25:47'),
(93, 'App\\Models\\User', 10, 'api_token', '851fe8f7a22f0d31cc1ced8166c2865772a004868e1b8248bdc395ad4aa8b39d', '[\"*\"]', '2025-10-29 17:12:59', NULL, '2025-10-29 16:38:20', '2025-10-29 17:12:59'),
(94, 'App\\Models\\User', 10, 'api_token', 'cee60a245541072925a7eeb9d7e3d9491fccca3c86fb008ee457266cc4b74942', '[\"*\"]', '2025-10-29 17:03:42', NULL, '2025-10-29 17:01:34', '2025-10-29 17:03:42'),
(95, 'App\\Models\\User', 14, 'api_token', 'a347d3ecc66b8d2104276d7fc3a5de8336a3a55f41cd95ce749a0ab935a100b2', '[\"*\"]', '2025-10-29 17:04:57', NULL, '2025-10-29 17:04:02', '2025-10-29 17:04:57'),
(96, 'App\\Models\\User', 12, 'api_token', 'ca7637cc4b0fe93d5d606a1f7f0602c40a4cb5b7f5d957b82ecee3e1b5c9110b', '[\"*\"]', '2025-10-29 17:05:13', NULL, '2025-10-29 17:05:07', '2025-10-29 17:05:13'),
(97, 'App\\Models\\User', 14, 'api_token', 'd45cefd557bece7eb7f0577f77988e431d9080a8d0eef4616271777d725d2e0e', '[\"*\"]', '2025-10-29 17:10:13', NULL, '2025-10-29 17:06:16', '2025-10-29 17:10:13'),
(98, 'App\\Models\\User', 10, 'api_token', '958bea3358408a5c3dba47696f0ef83d43f20f9ed0e747672c39dff18c88e7b8', '[\"*\"]', '2025-10-29 17:11:05', NULL, '2025-10-29 17:10:20', '2025-10-29 17:11:05'),
(99, 'App\\Models\\User', 10, 'api_token', '2bf9988e84b5ae217ffd338b665fa5a8413794924e38731242fdb231bce2245c', '[\"*\"]', '2025-10-29 17:11:36', NULL, '2025-10-29 17:11:30', '2025-10-29 17:11:36'),
(100, 'App\\Models\\User', 24, 'api_token', '911c6281338c4e44496188fc9450a681bed0357000ffa8312c3abab2c7276daa', '[\"*\"]', '2025-10-29 17:12:11', NULL, '2025-10-29 17:11:46', '2025-10-29 17:12:11'),
(101, 'App\\Models\\User', 10, 'api_token', 'a021833ddf4303c781fe2e39599ecfe9c68f1e102756fc133f251f7014f968a0', '[\"*\"]', '2025-10-29 17:12:36', NULL, '2025-10-29 17:12:21', '2025-10-29 17:12:36'),
(102, 'App\\Models\\User', 24, 'api_token', '61b9632b61404f915e54ce1140a79682f9b2ea66f74c699f497b637dfeb11605', '[\"*\"]', '2025-10-29 17:13:24', NULL, '2025-10-29 17:13:09', '2025-10-29 17:13:24'),
(103, 'App\\Models\\User', 10, 'api_token', '90497c7572f5ed40a5685cd63230f8151f05f64d8f9f14f692944abf2c7ba2a7', '[\"*\"]', '2025-10-30 16:16:47', NULL, '2025-10-29 17:13:43', '2025-10-30 16:16:47'),
(104, 'App\\Models\\User', 10, 'api_token', '931b843cd76239fea647f7cc1071f181d56b5677be13e388aff60ff55505b8fb', '[\"*\"]', '2025-10-29 17:50:04', NULL, '2025-10-29 17:50:03', '2025-10-29 17:50:04'),
(105, 'App\\Models\\User', 10, 'api_token', 'b8de9055f2e38d6ddeea2e4531c80d9d4c4c07c530e497760090be600acbb9ab', '[\"*\"]', '2025-10-29 18:14:22', NULL, '2025-10-29 17:52:21', '2025-10-29 18:14:22'),
(106, 'App\\Models\\User', 10, 'api_token', '518c97f2b1d726b4543665f78b3eb9ce6f938b3350f790cb39349a514a72d8c8', '[\"*\"]', '2025-10-29 18:21:11', NULL, '2025-10-29 18:15:27', '2025-10-29 18:21:11'),
(107, 'App\\Models\\User', 14, 'api_token', '5c14165eaeb634f40ec65f6429abc554ba14b17751830d6af22917f926379bd6', '[\"*\"]', '2025-10-29 19:03:46', NULL, '2025-10-29 18:24:07', '2025-10-29 19:03:46'),
(108, 'App\\Models\\User', 14, 'api_token', '99371595cc3dd4e803768af14fc622b80bb67dc96c89efc1a8da7b62beadcb5e', '[\"*\"]', '2025-10-29 19:07:04', NULL, '2025-10-29 19:01:10', '2025-10-29 19:07:04'),
(109, 'App\\Models\\User', 14, 'api_token', 'dfe50bac776925902d1cb60b03ebbcc410d2bb669ad0353fa2fb0ced78751183', '[\"*\"]', '2025-10-29 19:07:20', NULL, '2025-10-29 19:06:35', '2025-10-29 19:07:20'),
(110, 'App\\Models\\User', 10, 'api_token', '909b21c267198572f5ab8173f417fd4d26b1241b9b8d50fde9c565751125415b', '[\"*\"]', '2025-10-29 19:31:14', NULL, '2025-10-29 19:07:26', '2025-10-29 19:31:14'),
(111, 'App\\Models\\User', 10, 'api_token', '6dbbeec842e69c65037c52a3d7e9598fbeedd7fe7219d37bd6d4dc141009a15e', '[\"*\"]', '2025-10-30 18:27:12', NULL, '2025-10-30 07:23:19', '2025-10-30 18:27:12'),
(112, 'App\\Models\\User', 10, 'api_token', '657cd670b9124dc2da3f041ed66194d0162aaabffb0c5acf1a4da2da44d649a9', '[\"*\"]', '2025-10-30 10:49:32', NULL, '2025-10-30 08:30:12', '2025-10-30 10:49:32'),
(113, 'App\\Models\\User', 10, 'api_token', '8f2486aa54b992b74387872406d193a34f489c7bfbcdbfd01c10e02d70d1c4a7', '[\"*\"]', '2025-10-30 16:21:41', NULL, '2025-10-30 13:10:12', '2025-10-30 16:21:41'),
(114, 'App\\Models\\User', 10, 'api_token', '3e82ce118b2681b9c463bffc5db0c744284ede70645ac1a60172da6da7dbf07d', '[\"*\"]', '2025-10-30 13:46:24', NULL, '2025-10-30 13:46:18', '2025-10-30 13:46:24'),
(115, 'App\\Models\\User', 28, 'api_token', '72437e34bb93c06a3a23eb66eccbf902e500b3c2f82253c11f35bbf7bbe9cf0f', '[\"*\"]', NULL, NULL, '2025-10-30 15:45:16', '2025-10-30 15:45:16'),
(116, 'App\\Models\\User', 28, 'api_token', '8d59cfb6a4038d02398acd2572ba4436213bb050484e81256b2a41aa89cedb70', '[\"*\"]', NULL, NULL, '2025-10-30 15:51:24', '2025-10-30 15:51:24'),
(117, 'App\\Models\\User', 4, 'api_token', '81df87f6b562e4c369f55aa77978c11453e826f280d898db204a409a8bae3528', '[\"*\"]', '2025-10-30 16:29:08', NULL, '2025-10-30 15:56:55', '2025-10-30 16:29:08'),
(118, 'App\\Models\\User', 22, 'api_token', '0c6c9ad7165b98c6aedabf1b3593252ba3803f89e59940f6d1911a8ea3ee869b', '[\"*\"]', '2025-10-30 18:03:01', NULL, '2025-10-30 16:15:12', '2025-10-30 18:03:01'),
(119, 'App\\Models\\User', 10, 'api_token', 'f3fa2a2b053f8c646bb00ef69f92a2e693b46bc91fc3d460386183f81f38ed47', '[\"*\"]', '2025-10-30 18:00:02', NULL, '2025-10-30 17:58:35', '2025-10-30 18:00:02'),
(120, 'App\\Models\\User', 12, 'api_token', '8d3f99162d976c870517a27d5ad4969eaa02daf0ab37aa72d2c1a6053608a7be', '[\"*\"]', '2025-10-30 18:01:32', NULL, '2025-10-30 18:00:47', '2025-10-30 18:01:32'),
(121, 'App\\Models\\User', 22, 'api_token', '1a86997f5ccaf4418dc711f310a5b78cb9c4c65a2cf9ca15bf21fe9c27c9ee62', '[\"*\"]', '2025-10-30 18:02:14', NULL, '2025-10-30 18:02:02', '2025-10-30 18:02:14'),
(122, 'App\\Models\\User', 14, 'api_token', '569e46d32402dd256343aaaba30ceb5f1da14cf7a5d34800ec2e2b9ea92e2b41', '[\"*\"]', '2025-10-30 18:03:08', NULL, '2025-10-30 18:02:44', '2025-10-30 18:03:08'),
(123, 'App\\Models\\User', 10, 'api_token', '8b8471961950e1dc1905550e420dda91095b6a03137bdd45cf0b3a03eae6064b', '[\"*\"]', '2025-10-30 18:03:41', NULL, '2025-10-30 18:03:35', '2025-10-30 18:03:41'),
(124, 'App\\Models\\User', 16, 'api_token', 'e47d5f61286a65919d9690abaf56d066ba6ebab1042736d11df5d62e2e130873', '[\"*\"]', NULL, NULL, '2025-10-30 18:03:54', '2025-10-30 18:03:54'),
(125, 'App\\Models\\User', 10, 'api_token', 'c3a665dc1e9ce27610ec73741b265a771a856feb761bcb089ad2d9220865e222', '[\"*\"]', '2025-10-30 18:27:30', NULL, '2025-10-30 18:27:28', '2025-10-30 18:27:30'),
(126, 'App\\Models\\User', 14, 'api_token', '1fc792ecb39968545810139435ce5ad8f6fde4bfa20f6af82f7642641f89eb11', '[\"*\"]', '2025-10-30 18:30:24', NULL, '2025-10-30 18:30:22', '2025-10-30 18:30:24'),
(127, 'App\\Models\\User', 10, 'api_token', '9a60ab62e224cefa1337cd4b763f44ec9068d120b7f06920de47d4c1569dbbd2', '[\"*\"]', '2025-10-30 19:23:07', NULL, '2025-10-30 19:19:39', '2025-10-30 19:23:07'),
(128, 'App\\Models\\User', 10, 'api_token', '5aa4d4adec83c2c1427939d9a5f725d3e152b58c95c70851c9e1bf4a88f7d450', '[\"*\"]', '2025-11-07 07:39:29', NULL, '2025-10-30 19:46:10', '2025-11-07 07:39:29'),
(129, 'App\\Models\\User', 10, 'api_token', '8ecb81485aacc72394c06cfedad1fdbc573b3309ae17f3d9a6b2aa451e237e9c', '[\"*\"]', '2025-10-31 18:05:38', NULL, '2025-10-31 10:05:27', '2025-10-31 18:05:38'),
(130, 'App\\Models\\User', 14, 'api_token', 'ae44c228d1168245f925fd356990cc211d7432ba94c12a94f92e03b03572bd09', '[\"*\"]', NULL, NULL, '2025-10-31 12:22:38', '2025-10-31 12:22:38'),
(131, 'App\\Models\\User', 10, 'api_token', '407d0b67625e7242270b2029cc302779ae7b306411a41ceac8bf9fc99115e068', '[\"*\"]', '2025-10-31 17:26:12', NULL, '2025-10-31 16:51:28', '2025-10-31 17:26:12'),
(132, 'App\\Models\\User', 10, 'api_token', '0c8938b337ca4389d22c5ada7e480c1e03f3fe82fd54d41d55bc7c499d83e8b4', '[\"*\"]', '2025-10-31 17:00:31', NULL, '2025-10-31 16:54:26', '2025-10-31 17:00:31'),
(133, 'App\\Models\\User', 29, 'api_token', '9de26d02d34a3748cd6fcc6b3e67df504e842f0cf75b54f8c459b505e5342f6c', '[\"*\"]', '2025-10-31 17:21:42', NULL, '2025-10-31 17:01:18', '2025-10-31 17:21:42'),
(134, 'App\\Models\\User', 29, 'api_token', 'e73f02a1f146657fa935d4471f72a6f84727c6fc122f16b81f3c5a0b44576d2d', '[\"*\"]', NULL, NULL, '2025-10-31 17:02:35', '2025-10-31 17:02:35'),
(135, 'App\\Models\\User', 29, 'api_token', 'fd154d5d3389ec0e2f4595669150bd30fb2fa3c6ba50489c0e247e9a561ce8e3', '[\"*\"]', NULL, NULL, '2025-10-31 17:03:48', '2025-10-31 17:03:48'),
(136, 'App\\Models\\User', 29, 'api_token', '59985e80e6382cfa055b4e175dafaf1418b0ae37e7ca77da6a5ed2dfe6720ebf', '[\"*\"]', '2025-10-31 17:09:04', NULL, '2025-10-31 17:04:21', '2025-10-31 17:09:04'),
(137, 'App\\Models\\User', 10, 'api_token', '8c4837172ea0bc26363ea0679a41472337bea750ece018381d86e65bc5e7f7b5', '[\"*\"]', '2025-10-31 17:09:21', NULL, '2025-10-31 17:09:19', '2025-10-31 17:09:21'),
(138, 'App\\Models\\User', 22, 'api_token', '608f771e4fc74b9e857cfbf79725a7994113bef65722ec1a572dbcebc53b722b', '[\"*\"]', '2025-10-31 17:09:32', NULL, '2025-10-31 17:09:30', '2025-10-31 17:09:32'),
(139, 'App\\Models\\User', 12, 'api_token', 'fb18aaef209058826c4b9c88b238ceb366f04f7d1ee758061d331e81160b8492', '[\"*\"]', '2025-10-31 17:10:12', NULL, '2025-10-31 17:10:01', '2025-10-31 17:10:12'),
(140, 'App\\Models\\User', 10, 'api_token', 'b5d3e88394e65d00d430e77799c7a52c68a086de01b6bdfc430594611ea6f14a', '[\"*\"]', '2025-10-31 17:11:48', NULL, '2025-10-31 17:11:47', '2025-10-31 17:11:48'),
(141, 'App\\Models\\User', 22, 'api_token', '91a0ceae30388ca1247232a65a95a7762307352f3df0b152fcdd8ddde02bd708', '[\"*\"]', '2025-10-31 17:16:22', NULL, '2025-10-31 17:12:02', '2025-10-31 17:16:22'),
(142, 'App\\Models\\User', 10, 'api_token', '0bb30ff42418d51d3a69adc0e3672fa726e3c356f8e484973916587b760d861f', '[\"*\"]', '2025-10-31 17:16:39', NULL, '2025-10-31 17:16:36', '2025-10-31 17:16:39'),
(143, 'App\\Models\\User', 12, 'api_token', 'c38c9202dcdc0b516311a2da8e7b553bb03157cfcafc58cb08a97febe8811c16', '[\"*\"]', '2025-10-31 17:16:58', NULL, '2025-10-31 17:16:49', '2025-10-31 17:16:58'),
(144, 'App\\Models\\User', 29, 'api_token', '4ed0fda5a5243b797ddda74cd7bf9511cc017c6904873789fc4add2905de8a8f', '[\"*\"]', '2025-10-31 17:20:22', NULL, '2025-10-31 17:17:22', '2025-10-31 17:20:22'),
(145, 'App\\Models\\User', 10, 'api_token', '00fd4e81fee1e3384b0c2fcf335848dbb45366a742faea3a3971c0c77d99c19a', '[\"*\"]', '2025-10-31 17:59:36', NULL, '2025-10-31 17:23:51', '2025-10-31 17:59:36'),
(146, 'App\\Models\\User', 10, 'api_token', '8ba6a1bbe008c1c406221e1c8df85d1abe333941fac1a0ef9f74219086ddf475', '[\"*\"]', '2025-10-31 17:29:51', NULL, '2025-10-31 17:24:53', '2025-10-31 17:29:51'),
(147, 'App\\Models\\User', 10, 'api_token', 'c9ba8c15cbcddb32065ea9fbcf7dc5046d35d54e8b75f17b1b7b133548eaf3a1', '[\"*\"]', '2025-10-31 17:26:58', NULL, '2025-10-31 17:26:51', '2025-10-31 17:26:58'),
(148, 'App\\Models\\User', 29, 'api_token', 'b081d6f6da1bcb7946e453877a83c7d69ed88f2ce0ede8caeca2b003712b7f4f', '[\"*\"]', '2025-10-31 17:31:01', NULL, '2025-10-31 17:30:59', '2025-10-31 17:31:01'),
(149, 'App\\Models\\User', 12, 'api_token', '1e645b29abf4be6e557a57ad22abfc0c9b9d472acd15e3219a90b1eafb5809ba', '[\"*\"]', '2025-11-01 15:44:50', NULL, '2025-10-31 17:52:20', '2025-11-01 15:44:50'),
(150, 'App\\Models\\User', 12, 'api_token', '845d32ebb41b1995ab13e967d2950616edfa0ca1a848640b55034e179090c0d3', '[\"*\"]', '2025-10-31 18:02:04', NULL, '2025-10-31 18:00:46', '2025-10-31 18:02:04'),
(151, 'App\\Models\\User', 10, 'api_token', 'e40a33521622464535b1641b6f334a58bec66c72cba671286d0553cf26aa0adc', '[\"*\"]', '2025-10-31 18:03:48', NULL, '2025-10-31 18:03:42', '2025-10-31 18:03:48'),
(152, 'App\\Models\\User', 12, 'api_token', '2c965d56f8ab70ba5bfaa475b012784a39d9534d34ca70be3c08cd28f7547083', '[\"*\"]', '2025-10-31 18:15:05', NULL, '2025-10-31 18:06:08', '2025-10-31 18:15:05'),
(153, 'App\\Models\\User', 10, 'api_token', 'eb535612f3431d080b1afe3a34437cf3c47d8725efe378ae951d1d135493dd80', '[\"*\"]', '2025-11-01 18:14:31', NULL, '2025-10-31 18:19:03', '2025-11-01 18:14:31'),
(154, 'App\\Models\\User', 10, 'api_token', 'c486abd57a20d7fe51159c67f96b28975126a9d0608aa0de952e66ba366a9046', '[\"*\"]', NULL, NULL, '2025-11-01 05:36:09', '2025-11-01 05:36:09'),
(155, 'App\\Models\\User', 10, 'api_token', '6b788610f8ccf9332b28f79839d390a00a45991b1446fb031e49627870872354', '[\"*\"]', '2025-11-01 06:02:02', NULL, '2025-11-01 05:36:23', '2025-11-01 06:02:02'),
(156, 'App\\Models\\User', 10, 'api_token', 'bb55387fccd446b2650eb262d417adbfd023e90d04401322704105d06f10eb0b', '[\"*\"]', '2025-11-01 16:34:44', NULL, '2025-11-01 15:15:36', '2025-11-01 16:34:44'),
(157, 'App\\Models\\User', 10, 'api_token', '240253800328c5facb42553639837adea0d2259ffd311982e83b97ebd40dc160', '[\"*\"]', NULL, NULL, '2025-11-01 15:39:51', '2025-11-01 15:39:51'),
(158, 'App\\Models\\User', 10, 'api_token', 'a37a8c83ba01989b12736093837c678e6039fb3317b1627cd1a0309797a17587', '[\"*\"]', '2025-11-01 17:40:46', NULL, '2025-11-01 15:40:04', '2025-11-01 17:40:46'),
(159, 'App\\Models\\User', 10, 'api_token', 'a0d7c1ace7a8423ca6957725cdb4e545c910d618012a6e1cfc2af0e96ad5326b', '[\"*\"]', '2025-11-01 16:40:05', NULL, '2025-11-01 16:35:34', '2025-11-01 16:40:05'),
(160, 'App\\Models\\User', 12, 'api_token', 'd53093950b856c3322873cbd59cf3aac3d01a255d7edc69120f5fd3155e4a4b0', '[\"*\"]', NULL, NULL, '2025-11-01 16:41:09', '2025-11-01 16:41:09'),
(161, 'App\\Models\\User', 22, 'api_token', '3ef82f04d49149bfdc044b7ea9841b2dd5cf970f578d1bf4dcf0bee7bbb4f95e', '[\"*\"]', '2025-11-01 16:50:05', NULL, '2025-11-01 16:41:22', '2025-11-01 16:50:05'),
(162, 'App\\Models\\User', 10, 'api_token', 'e02128254f0aa2cdf3dea8ec0657724e9dd9e49d45518ed82096e46ca0afa0a5', '[\"*\"]', '2025-11-01 17:09:23', NULL, '2025-11-01 16:49:59', '2025-11-01 17:09:23'),
(163, 'App\\Models\\User', 22, 'api_token', '09631c59e2c688d156641fbdbe8348ce1e5a319e05af1875e08903d56a2e5be2', '[\"*\"]', '2025-11-01 17:21:22', NULL, '2025-11-01 17:05:46', '2025-11-01 17:21:22'),
(164, 'App\\Models\\User', 10, 'api_token', '4f4fa99bbb1058bb068fda29ccb66d512a5aaff972b9906b525c636fafdeff6f', '[\"*\"]', '2025-11-01 17:37:15', NULL, '2025-11-01 17:21:45', '2025-11-01 17:37:15'),
(165, 'App\\Models\\User', 10, 'api_token', 'b402910e7662dc7ca83338bf3a36646081ef9cdf349d8b00fb91f27fc14eb6dd', '[\"*\"]', '2025-11-01 17:25:10', NULL, '2025-11-01 17:24:20', '2025-11-01 17:25:10'),
(166, 'App\\Models\\User', 14, 'api_token', '9c1637c1ff6051fa494c74f61baf0569c649ddb0ceb3961f7a603a78638c01cf', '[\"*\"]', '2025-11-01 17:25:52', NULL, '2025-11-01 17:25:52', '2025-11-01 17:25:52'),
(170, 'App\\Models\\User', 39, 'api_token', '84d97adc12e5d63482a65d8d0ff7cd1fd87dacda77148510691a915c5c25f69d', '[\"*\"]', '2025-11-01 17:46:23', NULL, '2025-11-01 17:44:57', '2025-11-01 17:46:23'),
(171, 'App\\Models\\User', 22, 'api_token', 'a20748e1a698c98370500960cfd2ec06dd15bfe11e37ddb46de06855d283b14c', '[\"*\"]', '2025-11-01 18:03:46', NULL, '2025-11-01 18:00:16', '2025-11-01 18:03:46'),
(172, 'App\\Models\\User', 39, 'api_token', '959d0ee5632721b9fb84f308b3b772498e00cb94b7cfa9c1c184381055b827df', '[\"*\"]', '2025-11-01 18:05:10', NULL, '2025-11-01 18:00:52', '2025-11-01 18:05:10'),
(173, 'App\\Models\\User', 39, 'api_token', 'e7c06cf4b2311a4cb70ef08631c1c95154bbb7af7903ba6fe053039f82802f30', '[\"*\"]', '2025-11-02 14:45:17', NULL, '2025-11-01 18:02:13', '2025-11-02 14:45:17'),
(174, 'App\\Models\\User', 39, 'api_token', '8ccc27eb08cd50d8023a7131022e5c0db260256cc5aa6c61e05ece1f4b84f302', '[\"*\"]', '2025-11-02 15:09:26', NULL, '2025-11-01 18:05:28', '2025-11-02 15:09:26'),
(175, 'App\\Models\\User', 10, 'api_token', '1b4906afc657e8b026680340a0a4766ddaf0e55aff366db2a230c28dc2164e6c', '[\"*\"]', '2025-11-02 10:23:00', NULL, '2025-11-02 10:22:30', '2025-11-02 10:23:00'),
(176, 'App\\Models\\User', 10, 'api_token', '3d47eae5b9ec67beb8fc45b6a45e9d53df7eee3442d782d1bdd3c2c4ab75a4cb', '[\"*\"]', '2025-11-02 14:44:00', NULL, '2025-11-02 14:43:34', '2025-11-02 14:44:00'),
(177, 'App\\Models\\User', 39, 'api_token', 'ed705ce65de56da5cba4a019211f4039e66dbb431e5a2f3d4d998c9a87ba8d67', '[\"*\"]', '2025-11-02 14:44:33', NULL, '2025-11-02 14:44:31', '2025-11-02 14:44:33'),
(178, 'App\\Models\\User', 39, 'api_token', '2870f81164d3eec3f3de6e227e293746d70c871e1763324afa0cfd6234e7e081', '[\"*\"]', '2025-11-02 14:59:19', NULL, '2025-11-02 14:45:29', '2025-11-02 14:59:19'),
(179, 'App\\Models\\User', 10, 'api_token', '278b23fb2bfbb9b83f7bb2c05b19163fb250e904a4368447eaed3209e5a8de2b', '[\"*\"]', '2025-11-02 14:51:25', NULL, '2025-11-02 14:46:33', '2025-11-02 14:51:25'),
(180, 'App\\Models\\User', 22, 'api_token', 'e3f305e4b600a81197900f4bba4b2a104c914ee442889efa0b87e0f0ce0b0bb0', '[\"*\"]', '2025-11-02 14:52:20', NULL, '2025-11-02 14:52:08', '2025-11-02 14:52:20'),
(181, 'App\\Models\\User', 39, 'api_token', '33d24948125df3f284df10109666837555751a19ae616f7535d94aeadeb30111', '[\"*\"]', '2025-11-02 15:07:11', NULL, '2025-11-02 14:52:47', '2025-11-02 15:07:11'),
(182, 'App\\Models\\User', 10, 'api_token', '4e3b9fe6cb1bb675247e191ccd5a723b2753ae8e4943ee7b15574e1ccbe7e357', '[\"*\"]', '2025-11-02 15:19:26', NULL, '2025-11-02 15:07:18', '2025-11-02 15:19:26'),
(183, 'App\\Models\\User', 10, 'api_token', '7d8a6b3f03f08b2b6e76ef329bca6f3d5c3b9f3504aae1c4227967c126c416b7', '[\"*\"]', '2025-11-02 15:09:13', NULL, '2025-11-02 15:09:10', '2025-11-02 15:09:13'),
(184, 'App\\Models\\User', 39, 'api_token', '4fca17361b30d4f383b5f80770da0e2fa79c9f8dbb191410a0fa9a7078e73052', '[\"*\"]', '2025-11-02 15:30:09', NULL, '2025-11-02 15:19:47', '2025-11-02 15:30:09'),
(185, 'App\\Models\\User', 10, 'api_token', '906447248cf159442b9bab887e127793c2206f5f403d78b8c42aaa24e924f077', '[\"*\"]', '2025-11-02 15:31:48', NULL, '2025-11-02 15:30:03', '2025-11-02 15:31:48'),
(186, 'App\\Models\\User', 39, 'api_token', '72ac0ed09aba6de69c7d45c64fec9b6b06f795a0a8c928ddf3f184ce9f11aa5b', '[\"*\"]', '2025-11-02 15:31:07', NULL, '2025-11-02 15:31:02', '2025-11-02 15:31:07'),
(187, 'App\\Models\\User', 10, 'api_token', '3cbe7a611d16ba87bbd49fb3439931c1962d25a1453c6cd890acdf3314dbf669', '[\"*\"]', '2025-11-02 15:34:47', NULL, '2025-11-02 15:31:19', '2025-11-02 15:34:47'),
(188, 'App\\Models\\User', 39, 'api_token', 'c0bc4f5cf3ba417ca99f2beef5c2d672cdf9b27bef51aac85970b8b90b3a264b', '[\"*\"]', '2025-11-02 15:43:58', NULL, '2025-11-02 15:32:14', '2025-11-02 15:43:58'),
(189, 'App\\Models\\User', 39, 'api_token', '77ddfa139d6fee8d650a192bd156ed297389b1ddc1d8aac734fe37a6f5597228', '[\"*\"]', '2025-11-02 15:42:26', NULL, '2025-11-02 15:36:03', '2025-11-02 15:42:26'),
(190, 'App\\Models\\User', 10, 'api_token', '6b3d632dc614f4eebf0fa79079057bbe4d405100c14ecd3872f3e99faa70f402', '[\"*\"]', '2025-11-02 16:17:59', NULL, '2025-11-02 15:41:28', '2025-11-02 16:17:59'),
(191, 'App\\Models\\User', 10, 'api_token', '19b4fc2200d59e1e3e5c51cc80c00fa583c4bc445c2897e415fe6fcc24f327d3', '[\"*\"]', '2025-11-02 15:52:00', NULL, '2025-11-02 15:45:02', '2025-11-02 15:52:00'),
(192, 'App\\Models\\User', 10, 'api_token', '49a8e3ce9e7533f933c78dd7741a04e5c78b392ea0d5f254c0d6b8b7b1f82a5b', '[\"*\"]', '2025-11-02 18:06:00', NULL, '2025-11-02 15:48:31', '2025-11-02 18:06:00'),
(194, 'App\\Models\\User', 39, 'api_token', '56e99c4701609f21b74fa00ef10886c45022c92bcbd494c9642228bd5fc65466', '[\"*\"]', NULL, NULL, '2025-11-02 16:12:25', '2025-11-02 16:12:25'),
(195, 'App\\Models\\User', 10, 'api_token', 'de7405b0969d4c806743ea61a0f26fd3becfc410b52d56e34c2ef438ec6d1237', '[\"*\"]', '2025-11-04 16:09:48', NULL, '2025-11-02 16:15:01', '2025-11-04 16:09:48'),
(197, 'App\\Models\\User', 10, 'api_token', '7d124ca03d1766e2b471ec73d5c22abf9b8cfd192d2516f8cbca18f51cfed97f', '[\"*\"]', '2025-11-02 18:18:23', NULL, '2025-11-02 16:16:43', '2025-11-02 18:18:23'),
(198, 'App\\Models\\User', 10, 'api_token', '2f24ad3aa3e0b6d2dea30913137fc6b1c4cd95efbf2830f9108bb73dd2ebbe26', '[\"*\"]', '2025-11-02 17:58:24', NULL, '2025-11-02 17:41:59', '2025-11-02 17:58:24'),
(200, 'App\\Models\\User', 10, 'api_token', '378226a02b9295c4597a584b37d1f9dc5c9e66e22326af7e74bc25cfefb2e9b7', '[\"*\"]', '2025-11-02 18:20:36', NULL, '2025-11-02 18:20:13', '2025-11-02 18:20:36'),
(201, 'App\\Models\\User', 10, 'api_token', '37ebfa909674af211eb9fbc83ff60ee90c1440122dd54cbf8b9a946bc2ae5e5e', '[\"*\"]', '2025-11-02 19:15:03', NULL, '2025-11-02 19:15:02', '2025-11-02 19:15:03'),
(202, 'App\\Models\\User', 14, 'api_token', 'd6b77e9b66888222049b3f062d6f3793d671b9426e805a592217da5306ca8639', '[\"*\"]', '2025-11-02 19:17:58', NULL, '2025-11-02 19:17:00', '2025-11-02 19:17:58'),
(203, 'App\\Models\\User', 10, 'api_token', 'd0a14c6c3991f8d63f1387af458d7b5ce15b52b4b755e5bb5a789a0c1d713a9b', '[\"*\"]', '2025-11-03 09:21:14', NULL, '2025-11-03 09:20:49', '2025-11-03 09:21:14'),
(204, 'App\\Models\\User', 10, 'api_token', '0ad0ec607a443f5719937e0acf3a2c35c5d4130d4fb0fefd791c70b57772e4df', '[\"*\"]', '2025-11-03 18:59:18', NULL, '2025-11-03 15:20:53', '2025-11-03 18:59:18'),
(206, 'App\\Models\\User', 10, 'api_token', '93ff81b7dc672f771f3f1f13186df17dbd138d8e2438ec6ae042a2ec011af361', '[\"*\"]', '2025-11-03 18:08:58', NULL, '2025-11-03 16:34:31', '2025-11-03 18:08:58'),
(207, 'App\\Models\\User', 10, 'api_token', '0d2db7e55a9428c8162643d96cac483db9c9e4d96e20fcda4116228838fbdc3f', '[\"*\"]', '2025-11-03 18:30:36', NULL, '2025-11-03 17:29:05', '2025-11-03 18:30:36'),
(215, 'App\\Models\\User', 10, 'api_token', '88804498cb716284137ee398b837fbfeea319d9c1dab5433aacd659dfdfaf61b', '[\"*\"]', '2025-11-03 18:39:02', NULL, '2025-11-03 18:38:59', '2025-11-03 18:39:02'),
(216, 'App\\Models\\User', 10, 'api_token', '3aa272d0516c3f65eab5afbe72d94f07b4caccb0e0055634e50a9cd36f060454', '[\"*\"]', '2025-11-04 18:46:55', NULL, '2025-11-03 18:41:09', '2025-11-04 18:46:55'),
(217, 'App\\Models\\User', 10, 'api_token', '4fc89b35b66a920a54608e7883a7947a994d541aefb8f73ed31b4dae61e85c96', '[\"*\"]', '2025-11-03 19:17:43', NULL, '2025-11-03 19:16:08', '2025-11-03 19:17:43'),
(225, 'App\\Models\\User', 50, 'api_token', '0512dc56ae9e7d10093018da9580f573232cf2deb666d4f5f0cae679f3a01f62', '[\"*\"]', '2025-11-04 16:14:00', NULL, '2025-11-04 16:10:08', '2025-11-04 16:14:00'),
(231, 'App\\Models\\User', 52, 'api_token', 'cc6dd1efea7acca62a6b6d330c0ec222f46708162d6bbf4c6b602fa08e74625b', '[\"*\"]', '2025-11-04 17:18:09', NULL, '2025-11-04 16:56:56', '2025-11-04 17:18:09'),
(232, 'App\\Models\\User', 52, 'api_token', '21a4bdae41d02bd06683823e9fcfcd41634cb1dd05282f69ade7797016b2afb7', '[\"*\"]', NULL, NULL, '2025-11-04 17:18:21', '2025-11-04 17:18:21'),
(233, 'App\\Models\\User', 10, 'api_token', '4ea4f38b9170b579cf7d11edd8988bcbcd58009a0205bc03f6e60f773fffb396', '[\"*\"]', '2025-11-04 18:13:58', NULL, '2025-11-04 17:18:34', '2025-11-04 18:13:58'),
(234, 'App\\Models\\User', 10, 'api_token', '5031de2b5e9ab09b4e3c7feaed9f0f648b9a17ee1eeceda4225140f65f8d2c3b', '[\"*\"]', '2025-11-04 18:14:12', NULL, '2025-11-04 17:20:22', '2025-11-04 18:14:12'),
(237, 'App\\Models\\User', 10, 'api_token', 'c1de11ccc3c3566048ace98b460d8ac2226da7fc2b2b0d2b5c749153412eb4b6', '[\"*\"]', '2025-11-10 14:36:28', NULL, '2025-11-04 18:29:09', '2025-11-10 14:36:28'),
(240, 'App\\Models\\User', 50, 'api_token', '2864fc5fe7637d0322f14ab3ef4bb2de5c292b032a6fb749682a3b984d1716d3', '[\"*\"]', '2025-11-04 18:31:46', NULL, '2025-11-04 18:31:44', '2025-11-04 18:31:46'),
(248, 'App\\Models\\User', 42, 'api_token', '15e5c5ac5f110a282f70dbd75584e5806a15281d39305a11e9d5b1007f02a451', '[\"*\"]', '2025-11-04 18:58:39', NULL, '2025-11-04 18:58:38', '2025-11-04 18:58:39'),
(249, 'App\\Models\\User', 10, 'api_token', 'b71a9df9c597f3535f17dc77932fcee5b2a9d3f8652b30914e16859ae3057c03', '[\"*\"]', '2025-11-04 19:10:21', NULL, '2025-11-04 19:10:13', '2025-11-04 19:10:21'),
(252, 'App\\Models\\User', 42, 'api_token', '1a8b6fd943c243d00e155edc69e982c4316dffb91f482f91bcc288575af9291e', '[\"*\"]', '2025-11-04 19:32:38', NULL, '2025-11-04 19:12:32', '2025-11-04 19:32:38'),
(253, 'App\\Models\\User', 51, 'api_token', '5b593a0ac36836dd9722faf7f17b0ec9b47208b6ad9f2054bdfd7bc4a2c69ed6', '[\"*\"]', NULL, NULL, '2025-11-04 19:39:31', '2025-11-04 19:39:31'),
(254, 'App\\Models\\User', 10, 'api_token', 'd2058fdb02913f3ca11adc7f3f1b8a880d5b285c0f3d7043faeb8eb8225152a2', '[\"*\"]', '2025-11-04 20:08:51', NULL, '2025-11-04 19:40:47', '2025-11-04 20:08:51'),
(255, 'App\\Models\\User', 10, 'api_token', '03cdfc8555534b729c4085b53dcf1f2666e51ce41e1c8f0ff6ff9936512c9e7e', '[\"*\"]', '2025-11-05 04:57:26', NULL, '2025-11-05 04:54:24', '2025-11-05 04:57:26'),
(257, 'App\\Models\\User', 52, 'api_token', '30741ca09e733d39c595d7876ada344b05b1c322643ec9faa2652ccf77593e9b', '[\"*\"]', '2025-11-05 06:13:37', NULL, '2025-11-05 06:12:19', '2025-11-05 06:13:37'),
(258, 'App\\Models\\User', 10, 'api_token', '84381a033bb7a41d11ff4f97a3c0033ae78c733909367cd3f7eb8a5063c73265', '[\"*\"]', '2025-11-05 06:13:27', NULL, '2025-11-05 06:13:20', '2025-11-05 06:13:27'),
(263, 'App\\Models\\User', 10, 'api_token', '7526b0a4baaf3a1c55e4c662d8efb801d0d3364bba8f5ee1410a8f65ef24d127', '[\"*\"]', NULL, NULL, '2025-11-10 14:47:05', '2025-11-10 14:47:05'),
(264, 'App\\Models\\User', 52, 'api_token', '78fe10ca34982eddfde6cdf38154ea81629bb3bdeb9ce5e1aa641ea1c1bfa6f2', '[\"*\"]', '2025-11-10 14:48:19', NULL, '2025-11-10 14:47:36', '2025-11-10 14:48:19'),
(275, 'App\\Models\\User', 10, 'api_token', '57df5c1e3f967952985f0da7969ce321a0b55a422b9038bb389c02b2500b517c', '[\"*\"]', '2025-11-10 15:44:01', NULL, '2025-11-10 15:05:08', '2025-11-10 15:44:01'),
(276, 'App\\Models\\User', 10, 'api_token', 'ecba0129e2b70aa98a9219c2642833d68de578d7323d41f8e377825df3fa4210', '[\"*\"]', '2025-11-11 17:24:58', NULL, '2025-11-11 15:08:06', '2025-11-11 17:24:58'),
(277, 'App\\Models\\User', 10, 'api_token', '3ec7881135a2a2c27d5e2b7af1b9154d2df698dff691b38cb9d133b4f0a79cc0', '[\"*\"]', '2025-11-11 15:56:30', NULL, '2025-11-11 15:10:16', '2025-11-11 15:56:30'),
(278, 'App\\Models\\User', 10, 'api_token', 'bd3f4b5f74428c751c83edfe94185ce2bcf912fa91eb182d0ccb313d6ea7b466', '[\"*\"]', '2025-11-11 17:41:19', NULL, '2025-11-11 17:27:29', '2025-11-11 17:41:19'),
(281, 'App\\Models\\User', 42, 'api_token', 'd913765ff800e677fab01822938c1fb494f82b4960d2820dea216c11aa15d261', '[\"*\"]', '2025-11-12 14:21:12', NULL, '2025-11-12 14:20:09', '2025-11-12 14:21:12'),
(283, 'App\\Models\\User', 10, 'api_token', '0c4f37dc3cc791595768f31b5d98f6528ac0bd520977ba532da573ed0b74dc74', '[\"*\"]', '2025-11-12 14:26:26', NULL, '2025-11-12 14:25:00', '2025-11-12 14:26:26'),
(284, 'App\\Models\\User', 10, 'api_token', '6e4d8dad2b4f7395125957e4f43af35b6c37a76525c96e2fcfadae7d20a19d9f', '[\"*\"]', '2025-11-12 18:40:14', NULL, '2025-11-12 18:35:56', '2025-11-12 18:40:14'),
(285, 'App\\Models\\User', 10, 'api_token', '8022c48641fe0b867e241e8659ed002ad22ccb1706b19c4f8e8fe0edfd260d23', '[\"*\"]', '2025-11-12 18:41:35', NULL, '2025-11-12 18:38:03', '2025-11-12 18:41:35'),
(286, 'App\\Models\\User', 10, 'api_token', '0556cb50a67371553f56392c2666dd9076daec81ff0c891359768fafa5a93056', '[\"*\"]', '2025-11-13 03:54:11', NULL, '2025-11-13 03:51:03', '2025-11-13 03:54:11'),
(287, 'App\\Models\\User', 10, 'api_token', 'b68b32915a372a970c2259998b459ab707aa85148101ab2b2cf3ba602604c8a2', '[\"*\"]', '2025-11-13 04:33:52', NULL, '2025-11-13 03:53:59', '2025-11-13 04:33:52'),
(288, 'App\\Models\\User', 10, 'api_token', '5b214eb5dbacf2eed1a811c204f3c5b9fe23c8fe29e61d1eec8e44ae72a63551', '[\"*\"]', '2025-11-13 04:08:55', NULL, '2025-11-13 03:55:52', '2025-11-13 04:08:55'),
(289, 'App\\Models\\User', 10, 'api_token', '1b7e5616943a1ef3d90611646a50aff096ee92a63b1a689537962a95c112a9ed', '[\"*\"]', '2025-11-13 04:45:56', NULL, '2025-11-13 04:35:04', '2025-11-13 04:45:56'),
(290, 'App\\Models\\User', 10, 'api_token', '4c6df91ba3a715bfd015b61ec5390fec74e04ea0479d55683e7da2464a042545', '[\"*\"]', '2025-11-16 11:09:15', NULL, '2025-11-14 05:48:26', '2025-11-16 11:09:15'),
(291, 'App\\Models\\User', 10, 'api_token', '4575ce210dc38fdfef2d2786283b2cb120f8f9bad27ce5c89fe3974367a52b2f', '[\"*\"]', '2025-11-16 16:12:17', NULL, '2025-11-15 11:31:51', '2025-11-16 16:12:17'),
(293, 'App\\Models\\User', 42, 'api_token', '80c5b592188c10da17a2f7331ce10fb2708a391904ad0c2a542306a84cb8077b', '[\"*\"]', '2025-11-16 11:48:58', NULL, '2025-11-16 11:22:49', '2025-11-16 11:48:58'),
(294, 'App\\Models\\User', 42, 'api_token', '08b7f08f9ca50d719f7f179ceaeb1d8332e28b36e32819c7f9d89113f72eb7dd', '[\"*\"]', '2025-11-16 11:41:42', NULL, '2025-11-16 11:38:45', '2025-11-16 11:41:42'),
(301, 'App\\Models\\User', 42, 'api_token', 'fb30bd9f5f541469d45bd7d39bb85911bfa4f5a184665ae13cb0c053d2f31d2a', '[\"*\"]', NULL, NULL, '2025-11-16 15:54:37', '2025-11-16 15:54:37'),
(302, 'App\\Models\\User', 42, 'api_token', 'a95bdafa36de97693e76b775434a4943fc2d8ffbc34d1d4264f75ddff6045c4a', '[\"*\"]', '2025-11-16 16:12:36', NULL, '2025-11-16 15:57:39', '2025-11-16 16:12:36'),
(307, 'App\\Models\\User', 10, 'api_token', '160dcc0294920f9ebe459e223a1efa0ee02c6895393298d0349ebbaee0de18f0', '[\"*\"]', '2025-11-21 16:50:18', NULL, '2025-11-16 17:26:49', '2025-11-21 16:50:18'),
(308, 'App\\Models\\User', 10, 'api_token', '0e539d7f86913bc825e8268dabc12a3c0deb4cdc104f61c8442b2e04b3dabe05', '[\"*\"]', '2025-11-16 18:13:21', NULL, '2025-11-16 17:28:01', '2025-11-16 18:13:21'),
(309, 'App\\Models\\User', 10, 'api_token', '9ae29b26ca35c2700855f4d3fd1cb59d323505c66589c2242aeed1cb4826e795', '[\"*\"]', '2025-11-18 14:33:22', NULL, '2025-11-18 14:26:53', '2025-11-18 14:33:22'),
(311, 'App\\Models\\User', 10, 'api_token', '00efb611fc084d527ff6f9ab1edc9d70e4ab9b47664ac5e0c9e527569f30cc1a', '[\"*\"]', '2025-11-18 17:06:13', NULL, '2025-11-18 17:05:03', '2025-11-18 17:06:13'),
(315, 'App\\Models\\User', 10, 'api_token', '9d7ec98073d8eb226935537e9739a2b164daa270019270138fbd91e036a09913', '[\"*\"]', '2025-11-18 19:22:30', NULL, '2025-11-18 19:17:13', '2025-11-18 19:22:30'),
(316, 'App\\Models\\User', 10, 'api_token', '3d4ad7acefc10f9f9982c81730786c8f8332d57bf99e75057ba088aa8322b268', '[\"*\"]', '2025-11-19 09:25:14', NULL, '2025-11-19 07:56:01', '2025-11-19 09:25:14'),
(322, 'App\\Models\\User', 10, 'api_token', '1518f99629b8d8e870bb72635c655496bb7928eefc0f8a900f192b66528044fa', '[\"*\"]', '2025-11-20 06:05:45', NULL, '2025-11-19 11:41:44', '2025-11-20 06:05:45'),
(323, 'App\\Models\\User', 10, 'api_token', 'b87864451ca65ee4e973d452c65bffab90e2516b259703ea61dc0d84c95dd534', '[\"*\"]', '2025-11-19 18:26:25', NULL, '2025-11-19 18:22:21', '2025-11-19 18:26:25'),
(324, 'App\\Models\\User', 10, 'api_token', '1c3a9321f0bf3215876cfea2f703671654f3a7041af00efd2f4fc69de363fc5e', '[\"*\"]', '2025-11-20 06:06:46', NULL, '2025-11-20 06:05:10', '2025-11-20 06:06:46'),
(325, 'App\\Models\\User', 10, 'api_token', 'ac783942546ef71a85856bb683324ae956b3d50744125e8c6ec0726d24ee6145', '[\"*\"]', '2025-11-20 10:41:06', NULL, '2025-11-20 10:31:33', '2025-11-20 10:41:06'),
(326, 'App\\Models\\User', 10, 'api_token', 'c213fd720bcf500cc95c60f86e7bf92f1ce4140e8a7c8ffb782f88da726a5c9b', '[\"*\"]', '2025-11-20 18:41:17', NULL, '2025-11-20 18:40:42', '2025-11-20 18:41:17'),
(329, 'App\\Models\\User', 10, 'api_token', '558dcf77b8dbffa485bac69445807b1e8e72c29b36df67a8a5289d77939fd936', '[\"*\"]', '2025-11-21 19:05:27', NULL, '2025-11-21 18:40:12', '2025-11-21 19:05:27'),
(330, 'App\\Models\\User', 10, 'api_token', 'a5d8aa09a3fa2d009b950597e65a953f7a580829b5b0a0baffad868cf9a52062', '[\"*\"]', '2025-11-22 19:20:04', NULL, '2025-11-22 19:20:03', '2025-11-22 19:20:04'),
(331, 'App\\Models\\User', 10, 'api_token', 'e7e04e6b69711cc2b7bda33255a8bf831b7935f3b1a6c1951921b2615b92ad71', '[\"*\"]', '2025-11-23 10:19:53', NULL, '2025-11-23 10:19:52', '2025-11-23 10:19:53'),
(332, 'App\\Models\\User', 10, 'api_token', '460da45037f9d40cfe6f4d771154ab8995937ec909baa889f8b18dde9ed44251', '[\"*\"]', '2025-11-23 18:32:45', NULL, '2025-11-23 18:32:44', '2025-11-23 18:32:45'),
(333, 'App\\Models\\User', 10, 'api_token', 'bc01c15079488eee67e09557fab4b7f4be0da88e7cde548509bc10d1e661758a', '[\"*\"]', '2025-11-24 18:24:58', NULL, '2025-11-24 18:24:57', '2025-11-24 18:24:58'),
(334, 'App\\Models\\User', 10, 'api_token', '522b6834b0180e55948955c1c47060a6517a2b49faa2d718e3f32033c0efc10c', '[\"*\"]', '2025-11-24 18:27:58', NULL, '2025-11-24 18:27:22', '2025-11-24 18:27:58'),
(335, 'App\\Models\\User', 10, 'api_token', 'c04ed3a2e550594588169d23266a805f88f072662d343a2e470f44cf021d92cc', '[\"*\"]', '2025-11-24 18:30:34', NULL, '2025-11-24 18:30:31', '2025-11-24 18:30:34');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(336, 'App\\Models\\User', 10, 'api_token', '38150371cf3614379bba0002f271079cd47110ab1d73bad6e12918f44f85d2ea', '[\"*\"]', '2025-11-24 18:57:17', NULL, '2025-11-24 18:55:40', '2025-11-24 18:57:17'),
(338, 'App\\Models\\User', 10, 'api_token', '81218531a678bda627ed84d8a0084c212e7f56b0389facaacb8d0fdeacd56fa4', '[\"*\"]', '2025-11-25 17:01:28', NULL, '2025-11-25 15:58:41', '2025-11-25 17:01:28'),
(339, 'App\\Models\\User', 10, 'api_token', '8c8324ab0e6e6d02c21f7cbf3826671ae97367bd821b2a386c003601703b22ae', '[\"*\"]', '2025-11-25 16:26:35', NULL, '2025-11-25 16:02:44', '2025-11-25 16:26:35'),
(341, 'App\\Models\\User', 10, 'api_token', '31f995f95d2f82a63b225390b95aa1c807031700dc973eee913e6b661e854cfa', '[\"*\"]', '2025-11-25 16:50:50', NULL, '2025-11-25 16:31:13', '2025-11-25 16:50:50'),
(342, 'App\\Models\\User', 10, 'api_token', 'd0755cd81bb22b503624d168cbf6a7c29bf41827ca539753b4feb7178f4515df', '[\"*\"]', '2025-11-26 04:15:46', NULL, '2025-11-25 16:35:49', '2025-11-26 04:15:46'),
(347, 'App\\Models\\User', 42, 'api_token', '9c9b9b77a0777cbd0c3a370086c8b5cab8130537cd989863b1eef9e8594c87b5', '[\"*\"]', '2025-11-25 17:02:55', NULL, '2025-11-25 17:02:53', '2025-11-25 17:02:55'),
(348, 'App\\Models\\User', 10, 'api_token', '45c07a0d52f1e3261f6de6f53da894fba5e16b3a65b52d301d5fb523104aa4ff', '[\"*\"]', '2025-11-25 17:07:54', NULL, '2025-11-25 17:06:56', '2025-11-25 17:07:54'),
(349, 'App\\Models\\User', 10, 'api_token', 'ea1d3932bb7f92c0938cc0fc9dcac5340facbb7040d1b7aaf57efc15d2de9101', '[\"*\"]', '2025-11-25 18:03:03', NULL, '2025-11-25 17:56:09', '2025-11-25 18:03:03'),
(351, 'App\\Models\\User', 42, 'api_token', 'f7cd263b979fde94a65a1c2ff7b4fa95c0047e2748115a632611940e16d874ea', '[\"*\"]', '2025-11-25 18:47:40', NULL, '2025-11-25 18:46:11', '2025-11-25 18:47:40'),
(352, 'App\\Models\\User', 42, 'api_token', '22dafff0e5aeb5f64dcf3396a66a51dd0528f12289faffd36704ef8a748a9269', '[\"*\"]', '2025-11-26 10:05:51', NULL, '2025-11-26 10:05:50', '2025-11-26 10:05:51'),
(353, 'App\\Models\\User', 10, 'api_token', '38bed21cb0a6ff4c70c08a892ce81a45ecb39c572baac78ea217ab844cef99f9', '[\"*\"]', '2025-11-26 10:06:38', NULL, '2025-11-26 10:06:12', '2025-11-26 10:06:38'),
(355, 'App\\Models\\User', 42, 'api_token', 'b8c062165a82e3fbd40e5c74a510299c6be91d393d7110b44faf6450282a64ba', '[\"*\"]', '2025-12-02 10:48:40', NULL, '2025-11-26 11:11:46', '2025-12-02 10:48:40'),
(356, 'App\\Models\\User', 10, 'api_token', 'acd552128e05fe5f7c04eedce1d9d9abb57d4b9087091a9637c215ccc0ac512e', '[\"*\"]', '2025-11-26 18:32:58', NULL, '2025-11-26 18:26:43', '2025-11-26 18:32:58'),
(357, 'App\\Models\\User', 10, 'api_token', 'ac39f13574bf6e14f94e94e30a3d2b1e60041f1692f0448e2331fcba2abde0af', '[\"*\"]', '2025-11-26 18:40:53', NULL, '2025-11-26 18:33:47', '2025-11-26 18:40:53'),
(358, 'App\\Models\\User', 10, 'api_token', 'b97ad0a482325190673abade9720a6b09679b7b944310f1576abaf57af926cb8', '[\"*\"]', '2025-11-27 19:31:06', NULL, '2025-11-27 09:06:32', '2025-11-27 19:31:06'),
(361, 'App\\Models\\User', 54, 'api_token', '8d978563897c26d7cfd0cd0038e16e2865173b73663b41ede5930410ef5fa5ed', '[\"*\"]', '2025-11-28 15:52:59', NULL, '2025-11-28 15:32:55', '2025-11-28 15:52:59'),
(362, 'App\\Models\\User', 10, 'api_token', '6491e02a83ef4b8fcb71178e4255e953ffa0b8e5dd17c28a8c1887749ed4a0c1', '[\"*\"]', '2025-11-28 18:03:41', NULL, '2025-11-28 16:15:05', '2025-11-28 18:03:41'),
(363, 'App\\Models\\User', 10, 'api_token', '36a2fe76ac695d608032a0184976a74f9ea2a431ba05f3fceb24e7c6a640fb66', '[\"*\"]', '2025-11-28 17:04:15', NULL, '2025-11-28 16:28:17', '2025-11-28 17:04:15'),
(364, 'App\\Models\\User', 10, 'api_token', '52198360f6c3a71f654d16c7a3eff5d9d38738b05a9534a1c64e8be23ddb06a0', '[\"*\"]', '2025-11-28 18:05:53', NULL, '2025-11-28 18:05:52', '2025-11-28 18:05:53'),
(365, 'App\\Models\\User', 10, 'api_token', '23f33d1dca03dc25f8202e0b0f0c2e7543cef48b85af2bf7e1a94d51c5d8a31b', '[\"*\"]', '2025-11-29 08:16:31', NULL, '2025-11-29 08:00:13', '2025-11-29 08:16:31'),
(366, 'App\\Models\\User', 10, 'api_token', 'b5021ba0ccedb2802bb107e0ada3be0dfa0647794ba488f4eca1d8e616e44f06', '[\"*\"]', '2025-11-30 16:48:41', NULL, '2025-11-29 11:28:16', '2025-11-30 16:48:41'),
(367, 'App\\Models\\User', 10, 'api_token', '7f05749b80e3a9d670432c5ee5ff2d5f83d0eec752834bdbdcbbffa9dd629c6f', '[\"*\"]', '2025-11-29 16:21:53', NULL, '2025-11-29 11:56:23', '2025-11-29 16:21:53'),
(368, 'App\\Models\\User', 10, 'api_token', 'dfb4c5937ced1f1049e963d71aa6c1cf3ad0843b149ccae70e8ff0f8c7a6819b', '[\"*\"]', '2025-11-29 17:57:22', NULL, '2025-11-29 12:09:10', '2025-11-29 17:57:22'),
(369, 'App\\Models\\User', 10, 'api_token', '28e24333eee400cad7a4b278fa0035ed649469a270f28d91b81a2e67b03407f4', '[\"*\"]', '2025-11-29 16:52:11', NULL, '2025-11-29 16:51:50', '2025-11-29 16:52:11'),
(372, 'App\\Models\\User', 10, 'api_token', '797d552c2f65de806e826efe61dca8a107952a318eb941e83a7eb590924163d5', '[\"*\"]', '2025-11-29 17:37:32', NULL, '2025-11-29 17:33:38', '2025-11-29 17:37:32'),
(373, 'App\\Models\\User', 10, 'api_token', 'f7315e050ce43894063aa3d0a81d6d1b163cc30ca1385bf29f2fe2fe46b7c578', '[\"*\"]', '2025-11-29 18:06:27', NULL, '2025-11-29 17:40:00', '2025-11-29 18:06:27'),
(374, 'App\\Models\\User', 10, 'api_token', '18d8d250ab5d456ec12f4cccd5e4dcbc7824f9fbcb1aecea7640be23344e8d92', '[\"*\"]', '2025-11-29 18:09:02', NULL, '2025-11-29 18:08:14', '2025-11-29 18:09:02'),
(375, 'App\\Models\\User', 10, 'api_token', 'f7031e722df95b1a6a29e4807c28e310eaae6f54f1b620dd375f962080bcfc66', '[\"*\"]', '2025-11-29 18:36:50', NULL, '2025-11-29 18:31:46', '2025-11-29 18:36:50'),
(376, 'App\\Models\\User', 10, 'api_token', '4650e9b676b61e995c72dd342a516ea2bcc5c90aa79552224f6714939fcf382d', '[\"*\"]', '2025-11-30 04:28:52', NULL, '2025-11-30 04:27:35', '2025-11-30 04:28:52'),
(377, 'App\\Models\\User', 10, 'api_token', '7d7a866d4e12838fc147b75c9cb66373e9fad2de5b4b262f66736821044680b4', '[\"*\"]', NULL, NULL, '2025-11-30 16:48:38', '2025-11-30 16:48:38'),
(378, 'App\\Models\\User', 10, 'api_token', 'c00f7794e5ed78ae78d28904a0fd0987dd6224f2055d331481abd769b2d74f3d', '[\"*\"]', '2025-11-30 16:52:02', NULL, '2025-11-30 16:48:50', '2025-11-30 16:52:02'),
(379, 'App\\Models\\User', 10, 'api_token', '86644f3564af7a0949b33885ea02462f969dad7824fd6c4e2a675b321a917f40', '[\"*\"]', '2025-12-05 14:31:10', NULL, '2025-11-30 18:06:53', '2025-12-05 14:31:10'),
(384, 'App\\Models\\User', 10, 'api_token', 'ee362c2b026fb2f0f591fdeede6cf540a56f51c863703bb437ca292917b60577', '[\"*\"]', '2025-12-01 16:34:42', NULL, '2025-12-01 16:32:44', '2025-12-01 16:34:42'),
(385, 'App\\Models\\User', 10, 'api_token', 'daf5affafd041bda2a4e55be8147c7abd0144cb0b3d2034a2797e8e647e9c4ce', '[\"*\"]', '2025-12-01 19:24:11', NULL, '2025-12-01 17:36:34', '2025-12-01 19:24:11'),
(386, 'App\\Models\\User', 10, 'api_token', '3d7ef3fae6aa50e926f341c0459fe5a5193a6ba94f46ebb784c46eebd284006e', '[\"*\"]', '2025-12-03 15:32:58', NULL, '2025-12-01 17:38:16', '2025-12-03 15:32:58'),
(387, 'App\\Models\\User', 10, 'api_token', '3fff780827e85560f596371e40e2658b37d1e63a768f54e2c9618e5fc30013ad', '[\"*\"]', '2025-12-01 18:52:12', NULL, '2025-12-01 18:52:11', '2025-12-01 18:52:12'),
(388, 'App\\Models\\User', 10, 'api_token', 'f05a9690a7f5485fb0d78a6f90953a9f4c99b7e601f8e50c18773371a703687f', '[\"*\"]', NULL, NULL, '2025-12-01 19:13:39', '2025-12-01 19:13:39'),
(389, 'App\\Models\\User', 10, 'api_token', 'a2c29873fbb55788c70ea7f73c4a778facc071732a6ca46280ea5d93284f59c6', '[\"*\"]', '2025-12-01 19:14:10', NULL, '2025-12-01 19:13:44', '2025-12-01 19:14:10'),
(390, 'App\\Models\\User', 10, 'api_token', 'ecb367ad788af1e738f0c37e2df1bc25379a53310688b3c83db92215c711c519', '[\"*\"]', '2025-12-01 19:51:59', NULL, '2025-12-01 19:16:35', '2025-12-01 19:51:59'),
(391, 'App\\Models\\User', 10, 'api_token', 'a1a1986e0915d4dce50978e2fa386f1585bb6dfd406f6dd2702c643180197e84', '[\"*\"]', '2025-12-01 19:50:13', NULL, '2025-12-01 19:30:34', '2025-12-01 19:50:13'),
(392, 'App\\Models\\User', 42, 'api_token', '17b7b5d31033c74e8711f3da1b01bb4e838475866f8e87dbac899d9a3b047a06', '[\"*\"]', '2025-12-01 19:38:22', NULL, '2025-12-01 19:32:48', '2025-12-01 19:38:22'),
(393, 'App\\Models\\User', 10, 'api_token', '0313094d841f2f709356fcb9ed9fc00811a551168c8f82c5916bb2ab944e3815', '[\"*\"]', '2025-12-01 19:40:04', NULL, '2025-12-01 19:38:31', '2025-12-01 19:40:04'),
(395, 'App\\Models\\User', 42, 'api_token', 'b3ae9d028d9167c1b62f8fc0d98e5f3d68679964fb500bc470e872a856a402f7', '[\"*\"]', '2025-12-02 10:50:02', NULL, '2025-12-02 10:49:36', '2025-12-02 10:50:02'),
(396, 'App\\Models\\User', 10, 'api_token', 'd0e842f32c164918957294a0f57179bc02333e092dbaa7c798f7f536fd708ee7', '[\"*\"]', '2025-12-02 13:58:51', NULL, '2025-12-02 13:56:23', '2025-12-02 13:58:51'),
(397, 'App\\Models\\User', 10, 'api_token', 'a66c3f5d49480f2ff6e01ca1bcf4e99cf0c8305ec3c503f067692a42b95322d3', '[\"*\"]', '2025-12-02 16:59:11', NULL, '2025-12-02 16:08:26', '2025-12-02 16:59:11'),
(398, 'App\\Models\\User', 10, 'api_token', '4946681b1610db7b6637032c492e5848d6145a2005b0490874e833a61ba5afee', '[\"*\"]', '2025-12-02 16:45:29', NULL, '2025-12-02 16:43:11', '2025-12-02 16:45:29'),
(401, 'App\\Models\\User', 10, 'api_token', '4a87eb8a2b1d651380706a64961148c103eea679b977e3ea2c36e8b44ec38466', '[\"*\"]', NULL, NULL, '2025-12-02 17:04:41', '2025-12-02 17:04:41'),
(402, 'App\\Models\\User', 44, 'api_token', '1bbba731a893b617ecfc33e87f5faa04b353864ddbd7867ee96d03c8168cc202', '[\"*\"]', NULL, NULL, '2025-12-02 17:06:50', '2025-12-02 17:06:50'),
(405, 'App\\Models\\User', 44, 'api_token', '12608e781fb2ecc6fc3876cf76f38f85d1dcfe737714469f5ea99188533b0bbe', '[\"*\"]', '2025-12-02 17:16:37', NULL, '2025-12-02 17:07:55', '2025-12-02 17:16:37'),
(406, 'App\\Models\\User', 44, 'api_token', 'c4224bf3876102a500c158cd1ca3ff5a041212ead4d5dd83bf59b3a87be5deff', '[\"*\"]', '2025-12-22 18:15:43', NULL, '2025-12-02 17:09:14', '2025-12-22 18:15:43'),
(407, 'App\\Models\\User', 10, 'api_token', '17d38ba5ecc06f56d41d087ae3e994a7591587da3605199ed6d573f528c8baaa', '[\"*\"]', NULL, NULL, '2025-12-02 17:24:35', '2025-12-02 17:24:35'),
(408, 'App\\Models\\User', 44, 'api_token', '6acb98d22c23cf9b1a10b10ec52c87bcc2510224028c50ee74936163678350a3', '[\"*\"]', '2025-12-02 17:46:43', NULL, '2025-12-02 17:24:58', '2025-12-02 17:46:43'),
(409, 'App\\Models\\User', 10, 'api_token', '41b6a572154c9d364c0b114704bcc5a176f7aa4f633df81fbed90b6669d9a98e', '[\"*\"]', '2025-12-02 17:49:37', NULL, '2025-12-02 17:46:23', '2025-12-02 17:49:37'),
(410, 'App\\Models\\User', 44, 'api_token', 'be8a98a60a5b8543af918fecb701b6743dac01ed4b6b68c3177f18d8439f1da2', '[\"*\"]', '2025-12-03 04:42:57', NULL, '2025-12-02 17:51:44', '2025-12-03 04:42:57'),
(411, 'App\\Models\\User', 10, 'api_token', '9ee359cab9206d2ed1c10cfa6cf207b4d2cb051627531a3fec17692b8558e51f', '[\"*\"]', '2025-12-02 18:33:10', NULL, '2025-12-02 18:25:19', '2025-12-02 18:33:10'),
(412, 'App\\Models\\User', 10, 'api_token', 'f1265b43569ed25bc25c5132dff81c0cc464d4dc14ceb08878ba58dfa67424f6', '[\"*\"]', '2025-12-03 03:40:40', NULL, '2025-12-03 03:40:03', '2025-12-03 03:40:40'),
(413, 'App\\Models\\User', 10, 'api_token', '816a5c0ec4bad3d513aaa73a30b448681f240ec8f81c222f3494fd39f25ab7d9', '[\"*\"]', '2025-12-03 11:52:45', NULL, '2025-12-03 11:51:26', '2025-12-03 11:52:45'),
(415, 'App\\Models\\User', 44, 'api_token', '9470f9a2cdf3e5ee95270f76df1dc2def84810bc72fa8562a7411fc84f2aae50', '[\"*\"]', '2025-12-03 17:59:42', NULL, '2025-12-03 15:29:30', '2025-12-03 17:59:42'),
(416, 'App\\Models\\User', 44, 'api_token', 'b669ebb9c19ba678bd8fe6ec3d7343b3abd3ab038254a6463d64a767cc03c4c9', '[\"*\"]', '2025-12-03 16:03:08', NULL, '2025-12-03 16:02:59', '2025-12-03 16:03:08'),
(423, 'App\\Models\\User', 10, 'api_token', 'f198c2784718f4cd76f332293594499c4f69d63ae5692e3bf291a4daf4957ef1', '[\"*\"]', '2025-12-03 18:05:02', NULL, '2025-12-03 18:04:02', '2025-12-03 18:05:02'),
(424, 'App\\Models\\User', 50, 'api_token', 'e8619705c6eec0678268b73cc816e8e40ead35752e4b1d705926c915bc6afb81', '[\"*\"]', '2025-12-03 18:11:17', NULL, '2025-12-03 18:06:20', '2025-12-03 18:11:17'),
(425, 'App\\Models\\User', 10, 'api_token', '4db7004dbe16a552d712d0307bd77a35378ffc711bed1694492a7f94ffcc7041', '[\"*\"]', '2025-12-03 18:22:19', NULL, '2025-12-03 18:07:23', '2025-12-03 18:22:19'),
(426, 'App\\Models\\User', 10, 'api_token', 'c5405c29b3ee998ca6d69d1840419f0ac078f35ec8883b44e3bdaa9ae8b6bbdb', '[\"*\"]', NULL, NULL, '2025-12-03 18:17:33', '2025-12-03 18:17:33'),
(429, 'App\\Models\\User', 14, 'api_token', 'c59a4ec484286daa9623e0c36655dfec3d0f050ce2a50076a5bfecbb64b9772c', '[\"*\"]', '2025-12-03 18:20:07', NULL, '2025-12-03 18:20:06', '2025-12-03 18:20:07'),
(431, 'App\\Models\\User', 10, 'api_token', '5dfa5e7a27923c75eaa7f5166919a2e40fad574f49cd10d2e6f54a926efe59c5', '[\"*\"]', '2025-12-04 11:50:49', NULL, '2025-12-04 11:50:48', '2025-12-04 11:50:49'),
(432, 'App\\Models\\User', 10, 'api_token', '8e98766e0a5b318e1949b57c37a950132c5328b30e5ff5ffb47f6bb5d42227d9', '[\"*\"]', '2025-12-04 19:11:50', NULL, '2025-12-04 19:11:49', '2025-12-04 19:11:50'),
(433, 'App\\Models\\User', 10, 'api_token', '1a174ce881b0a6522b15b5d398b7392453c57dc7b7e9a3a9c7fae863587ac218', '[\"*\"]', '2025-12-05 11:27:54', NULL, '2025-12-05 11:27:52', '2025-12-05 11:27:54'),
(434, 'App\\Models\\User', 10, 'api_token', 'a67bf36a5e951807984f2dd628170ad4caf80acf0a9f6628721f3ab049c0f02c', '[\"*\"]', '2025-12-05 16:28:25', NULL, '2025-12-05 16:28:24', '2025-12-05 16:28:25'),
(435, 'App\\Models\\User', 10, 'api_token', '93dff963cea7cacc2bfa134905092005cd0026447e9234a53a3e8367e23dd76f', '[\"*\"]', '2025-12-05 18:55:41', NULL, '2025-12-05 18:53:47', '2025-12-05 18:55:41'),
(436, 'App\\Models\\User', 10, 'api_token', 'db88a3ca0c97a0594caa234c72bf886f2ca672f102f5923595446b5bd18cfd2c', '[\"*\"]', '2025-12-05 18:55:51', NULL, '2025-12-05 18:55:50', '2025-12-05 18:55:51'),
(437, 'App\\Models\\User', 10, 'api_token', '8559a2ee838b74205b2fb433774ee1472291c384e86d0b3a9fe140a399c87bac', '[\"*\"]', '2025-12-08 15:49:54', NULL, '2025-12-06 16:28:56', '2025-12-08 15:49:54'),
(438, 'App\\Models\\User', 10, 'api_token', '1c871ee6b38c84a77ae8da2bce10617eaa835005fb2ad85693bb02f05318e295', '[\"*\"]', '2025-12-06 19:17:04', NULL, '2025-12-06 19:16:33', '2025-12-06 19:17:04'),
(439, 'App\\Models\\User', 10, 'api_token', '0bea3b84fa386372074a0b824e0a6beac35128bc53614128bd06b52eaab4ab2e', '[\"*\"]', '2025-12-07 06:34:38', NULL, '2025-12-07 06:34:37', '2025-12-07 06:34:38'),
(440, 'App\\Models\\User', 10, 'api_token', '3411529491394c473e6b3a0e8b68a1b5571831a811b5f679167a25e0c72283df', '[\"*\"]', '2025-12-07 13:54:44', NULL, '2025-12-07 13:54:43', '2025-12-07 13:54:44'),
(441, 'App\\Models\\User', 10, 'api_token', '74e47ed10758fc629c6473365a6e06428645052cacc660df2775c48a4b86ce3c', '[\"*\"]', '2025-12-07 15:14:20', NULL, '2025-12-07 15:14:18', '2025-12-07 15:14:20'),
(442, 'App\\Models\\User', 10, 'api_token', 'ba9205f5f33ada7520f3550ae0915c8c254daed4d5e9122f447872bfa445694e', '[\"*\"]', '2025-12-07 16:50:36', NULL, '2025-12-07 15:17:53', '2025-12-07 16:50:36'),
(443, 'App\\Models\\User', 10, 'api_token', '758267cc0613f7aaa955be44f896818fff47a7797541e9e4da493fadecb59793', '[\"*\"]', '2025-12-07 16:36:14', NULL, '2025-12-07 15:39:56', '2025-12-07 16:36:14'),
(444, 'App\\Models\\User', 10, 'api_token', '0f9bd792d952567007d6af47c276a1dd6980a1a221467a5a340fabd6305379be', '[\"*\"]', '2025-12-07 17:07:41', NULL, '2025-12-07 16:53:16', '2025-12-07 17:07:41'),
(445, 'App\\Models\\User', 10, 'api_token', 'eb59f36ba0467bb9c60bb1b11a64581179aa3d8c353032d1b43fd21e25682418', '[\"*\"]', '2025-12-07 20:35:32', NULL, '2025-12-07 20:35:30', '2025-12-07 20:35:32'),
(446, 'App\\Models\\User', 10, 'api_token', '3115a2b948961ed0f4dee5e235c671d83bdfe7014673fcbd6718b7056cbc5684', '[\"*\"]', '2025-12-08 19:00:59', NULL, '2025-12-08 16:33:30', '2025-12-08 19:00:59'),
(447, 'App\\Models\\User', 10, 'api_token', 'e6341075b734327a4f12f1fa4f13309154ac8cb6fc4ad60e42d08b28a7534095', '[\"*\"]', '2025-12-08 18:05:01', NULL, '2025-12-08 18:01:54', '2025-12-08 18:05:01'),
(448, 'App\\Models\\User', 10, 'api_token', '3df605da151ac787106032cdbec9feb00e76050687eb0c83bf49e371f52ccc02', '[\"*\"]', '2025-12-08 18:22:24', NULL, '2025-12-08 18:11:06', '2025-12-08 18:22:24'),
(449, 'App\\Models\\User', 10, 'api_token', '82b33a2e5ba81314be6b3e170962f58410941f407a25aa76453c53549daa2613', '[\"*\"]', '2025-12-09 17:21:59', NULL, '2025-12-08 18:22:58', '2025-12-09 17:21:59'),
(450, 'App\\Models\\User', 10, 'api_token', '53eeec5bcd66e4a59a1506c17fd484301f260d201554c17ffaf2e964b19a9c6a', '[\"*\"]', '2025-12-08 18:59:45', NULL, '2025-12-08 18:59:44', '2025-12-08 18:59:45'),
(451, 'App\\Models\\User', 10, 'api_token', '6bfc0c8507ae275b08f6cb63693378f16d0ad28e45e96f586e3411eba8d74634', '[\"*\"]', NULL, NULL, '2025-12-08 19:02:36', '2025-12-08 19:02:36'),
(453, 'App\\Models\\User', 10, 'api_token', 'cf85c4a74748259b4126980d9b1a246bbf47377ed4b14b541a2c0eb3a34bd800', '[\"*\"]', '2025-12-09 07:48:25', NULL, '2025-12-09 07:46:52', '2025-12-09 07:48:25'),
(454, 'App\\Models\\User', 10, 'api_token', 'cb369d12439677dab2014ada8f9e0b670905324f0fa656164c1569ebed4240a9', '[\"*\"]', '2025-12-09 09:37:57', NULL, '2025-12-09 09:21:26', '2025-12-09 09:37:57'),
(461, 'App\\Models\\User', 42, 'api_token', '360b62a02e44d9c58ab27a7601be11d3f48c9a6153329ae3ae66ca03bb054c60', '[\"*\"]', '2025-12-09 17:20:34', NULL, '2025-12-09 17:17:00', '2025-12-09 17:20:34'),
(462, 'App\\Models\\User', 52, 'api_token', 'd23d5d698ad8fb0ab200f3da3e83c6434cdc08e5044d2fb00db25077f7addd26', '[\"*\"]', '2025-12-10 15:51:50', NULL, '2025-12-09 18:03:58', '2025-12-10 15:51:50'),
(463, 'App\\Models\\User', 10, 'api_token', 'e6755d6d97bc794e6c6bfe928234cd2514db7f2b4d162d891117ba8fa824abdb', '[\"*\"]', '2025-12-09 18:12:52', NULL, '2025-12-09 18:09:24', '2025-12-09 18:12:52'),
(464, 'App\\Models\\User', 10, 'api_token', '173b02f98e3b3b10c51870ffa8ea2df2c05eece68e416fe70246e24a47867975', '[\"*\"]', '2025-12-09 19:41:46', NULL, '2025-12-09 19:41:43', '2025-12-09 19:41:46'),
(465, 'App\\Models\\User', 10, 'api_token', 'a2ee3a6dc4f20275d2f63e99d56707ddb24bea40a16090a1b7c19a3692586794', '[\"*\"]', '2025-12-09 19:42:28', NULL, '2025-12-09 19:42:08', '2025-12-09 19:42:28'),
(466, 'App\\Models\\User', 10, 'api_token', '6c19c93303703af4ba91174040e86027e5950f31da3feea4537607276f85903b', '[\"*\"]', NULL, NULL, '2025-12-10 15:49:27', '2025-12-10 15:49:27'),
(469, 'App\\Models\\User', 42, 'api_token', '7ca6f8b45080def04fb7245a283630a231127048c0f945d9f81f55846b2613be', '[\"*\"]', NULL, NULL, '2025-12-10 15:56:12', '2025-12-10 15:56:12'),
(485, 'App\\Models\\User', 10, 'api_token', '6d031c042cb45d82a6098c910615685cc0ff414f370a1153abc782d66304d55c', '[\"*\"]', '2025-12-10 17:43:08', NULL, '2025-12-10 17:43:07', '2025-12-10 17:43:08'),
(486, 'App\\Models\\User', 10, 'api_token', 'ff3ab44774527ffdbf563613ae6d01085d5103b7021ddbb8fb0e49cc68016502', '[\"*\"]', '2025-12-10 17:47:14', NULL, '2025-12-10 17:45:01', '2025-12-10 17:47:14'),
(487, 'App\\Models\\User', 52, 'api_token', 'b7e1d62dd3f9759a0db90f3ef886e30b18cb46db758691efcbbff0f3c0bf000d', '[\"*\"]', '2025-12-10 17:50:59', NULL, '2025-12-10 17:49:51', '2025-12-10 17:50:59'),
(489, 'App\\Models\\User', 10, 'api_token', '151f0789b37f90ceb3d98942234d6eb40f3b6f08e1f933b16588807222e6a155', '[\"*\"]', '2025-12-10 18:00:05', NULL, '2025-12-10 17:59:10', '2025-12-10 18:00:05'),
(490, 'App\\Models\\User', 10, 'api_token', '842fc84e17cb9b05dd17ed36515611e82fa0857e4833549b1cd8a4e12a4d37eb', '[\"*\"]', '2025-12-10 18:37:39', NULL, '2025-12-10 18:00:45', '2025-12-10 18:37:39'),
(491, 'App\\Models\\User', 10, 'api_token', '97ad08b83577d9958db78c69069d32c95c107931b0eb0235cc7ae78602430ec3', '[\"*\"]', '2025-12-10 18:03:20', NULL, '2025-12-10 18:01:46', '2025-12-10 18:03:20'),
(492, 'App\\Models\\User', 80, 'api_token', '21b6cf1b7e8836cce6606518e58ddeb4880173c6fdeb05bd7427376b14bfd9fb', '[\"*\"]', '2025-12-10 18:24:07', NULL, '2025-12-10 18:04:22', '2025-12-10 18:24:07'),
(493, 'App\\Models\\User', 10, 'api_token', '9f1be614b782d42674bfea0ffbe46287d44a0fc537ac2496cb943efb957646a7', '[\"*\"]', '2025-12-10 18:21:22', NULL, '2025-12-10 18:19:32', '2025-12-10 18:21:22'),
(495, 'App\\Models\\User', 10, 'api_token', 'a4546ba0a54aa50d7f0c03d9142c32c3d734c2b7f6ff587d2270947cff35cb5e', '[\"*\"]', '2025-12-10 18:36:24', NULL, '2025-12-10 18:32:09', '2025-12-10 18:36:24'),
(496, 'App\\Models\\User', 10, 'api_token', '67dc00c5784680fc76172c88a462691ede890a817e59ed4c887f75e6e40fe851', '[\"*\"]', '2025-12-11 05:19:42', NULL, '2025-12-11 05:18:20', '2025-12-11 05:19:42'),
(497, 'App\\Models\\User', 10, 'api_token', '54e46edd40251966296ed9d4eefdce8a89e63290f720bd6fb409a76838961094', '[\"*\"]', '2025-12-20 12:43:34', NULL, '2025-12-11 08:47:20', '2025-12-20 12:43:34'),
(498, 'App\\Models\\User', 10, 'api_token', '93492c884df83da4ef5cd9654342c33d30e98d2fefe578ac59f59cf2d0723ba1', '[\"*\"]', '2025-12-11 19:54:19', NULL, '2025-12-11 17:46:26', '2025-12-11 19:54:19'),
(499, 'App\\Models\\User', 83, 'api_token', 'd9fdbe3c2d6e9092fbf382b2e4c773bc20420a9b0871ea52fc37372827722787', '[\"*\"]', '2025-12-11 19:56:54', NULL, '2025-12-11 18:00:25', '2025-12-11 19:56:54'),
(500, 'App\\Models\\User', 10, 'api_token', '7dac91c4903fe882a21ba6de7cdc7cdb35f4bd2dd2c2becd779919e819eba4de', '[\"*\"]', '2025-12-11 18:52:48', NULL, '2025-12-11 18:47:42', '2025-12-11 18:52:48'),
(501, 'App\\Models\\User', 83, 'api_token', 'cbd676dc4234266233f50812e494a329a1d5b379ae2256f25254d211b003c065', '[\"*\"]', '2025-12-11 18:59:35', NULL, '2025-12-11 18:48:52', '2025-12-11 18:59:35'),
(504, 'App\\Models\\User', 83, 'api_token', 'e99572a10290f92b27fc678ba1648e757160962e3aac150f74963793e4215fbd', '[\"*\"]', '2025-12-14 11:48:41', NULL, '2025-12-14 11:48:40', '2025-12-14 11:48:41'),
(507, 'App\\Models\\User', 10, 'api_token', '64690b4518e8e4177d7b7a350251405932f97020871d2280c1d24601aa16b622', '[\"*\"]', NULL, NULL, '2025-12-14 15:21:38', '2025-12-14 15:21:38'),
(511, 'App\\Models\\User', 42, 'api_token', '4e802a2a7b3e9646bee4a4266637dff165b4b070ae949f42e57165ef35212dcf', '[\"*\"]', '2025-12-14 15:30:30', NULL, '2025-12-14 15:23:19', '2025-12-14 15:30:30'),
(512, 'App\\Models\\User', 42, 'api_token', '06d8a039719fd644bfcbd7b855591c8334c8e8d03bd06b095b28094f98e056f0', '[\"*\"]', '2025-12-14 15:34:03', NULL, '2025-12-14 15:28:47', '2025-12-14 15:34:03'),
(515, 'App\\Models\\User', 10, 'api_token', '9cb6489c687a6c3595c2750194c632cc1191c8ce74bed9b9a158a17803050fc4', '[\"*\"]', '2025-12-14 15:46:19', NULL, '2025-12-14 15:46:13', '2025-12-14 15:46:19'),
(520, 'App\\Models\\User', 52, 'api_token', '877cc31b8096786f2667c95f7f041ee5a7d5fe507d7ef058c03b13da4e018d2d', '[\"*\"]', '2025-12-14 16:09:36', NULL, '2025-12-14 16:09:28', '2025-12-14 16:09:36'),
(527, 'App\\Models\\User', 52, 'api_token', '5dd7af0fd95fa3664b1f7a162351f30c13957c68e78e319d582114f2b2061919', '[\"*\"]', '2025-12-14 16:33:01', NULL, '2025-12-14 16:32:42', '2025-12-14 16:33:01'),
(528, 'App\\Models\\User', 10, 'api_token', 'f5fd9c272d052f3b4ec224bb5b17d8a9aa8d3ee87d3376dff956bbf5e1372480', '[\"*\"]', '2025-12-14 16:34:43', NULL, '2025-12-14 16:34:39', '2025-12-14 16:34:43'),
(534, 'App\\Models\\User', 81, 'api_token', '36ae6136f2c0d7c53e471ea332e49f4032de88abf916e721a227fb7b56c35e70', '[\"*\"]', NULL, NULL, '2025-12-14 18:34:52', '2025-12-14 18:34:52'),
(539, 'App\\Models\\User', 42, 'api_token', '845d1f7d682bcc0c2694e577500d826ba47db719cca24b52da170f6af26a0f12', '[\"*\"]', '2025-12-14 18:43:07', NULL, '2025-12-14 18:43:06', '2025-12-14 18:43:07'),
(541, 'App\\Models\\User', 10, 'api_token', '00b3e790d16fe2087b00c34cdc2a4f8c0c40415bb43f398996de3ccbce9d2930', '[\"*\"]', '2025-12-14 19:23:10', NULL, '2025-12-14 18:52:42', '2025-12-14 19:23:10'),
(542, 'App\\Models\\User', 42, 'api_token', '043e2e9b68992bd154d82af83851ccfe689d14e3be7d3e32164f2c5323359ba3', '[\"*\"]', '2025-12-14 19:16:39', NULL, '2025-12-14 18:55:14', '2025-12-14 19:16:39'),
(546, 'App\\Models\\User', 10, 'api_token', '413f81b9ee25139f81268e28723159db14f1d4ff2090bdbb70d41b60ee5564ec', '[\"*\"]', '2025-12-15 19:25:41', NULL, '2025-12-15 19:25:40', '2025-12-15 19:25:41'),
(549, 'App\\Models\\User', 42, 'api_token', 'f0876ae21fad4bc28f8388f5508eb7795ee18e9e6f5d57858235ba65fd7b2ed5', '[\"*\"]', '2025-12-16 11:50:04', NULL, '2025-12-16 11:50:03', '2025-12-16 11:50:04'),
(553, 'App\\Models\\User', 10, 'api_token', '206b40e770798b948dd54d974a3a21582cc1c0cfbe3a5610add29e9300723a27', '[\"*\"]', '2025-12-16 20:01:44', NULL, '2025-12-16 20:01:44', '2025-12-16 20:01:44'),
(555, 'App\\Models\\User', 42, 'api_token', 'defd818958857fd18db400755d0bb235e0b06eb051592888b6b479b6400d8b9d', '[\"*\"]', '2025-12-17 11:04:26', NULL, '2025-12-17 11:04:18', '2025-12-17 11:04:26'),
(556, 'App\\Models\\User', 42, 'api_token', '44c0ded282fed6d2ff04f4666eb8a2644684ea566344266989f3f8d2a3379ed7', '[\"*\"]', '2025-12-17 11:06:08', NULL, '2025-12-17 11:06:06', '2025-12-17 11:06:08'),
(557, 'App\\Models\\User', 42, 'api_token', '1ca1c45e106d48b8292dbd2c336d40dbefdd826d4f6676918b2eceb503cd8a58', '[\"*\"]', '2025-12-17 17:07:12', NULL, '2025-12-17 17:07:11', '2025-12-17 17:07:12'),
(558, 'App\\Models\\User', 10, 'api_token', 'ae43e513d5bfe637978408562e0a62ed929d309cae10fcedd135ed8ffa83ca1a', '[\"*\"]', '2025-12-17 18:21:14', NULL, '2025-12-17 17:07:45', '2025-12-17 18:21:14'),
(559, 'App\\Models\\User', 83, 'api_token', 'b5602211ab7aa560e0880b4e3f665509880584eee45efefcde3b16f96dddd038', '[\"*\"]', '2025-12-17 18:13:40', NULL, '2025-12-17 17:49:20', '2025-12-17 18:13:40'),
(563, 'App\\Models\\User', 10, 'api_token', '75aee2ed79d1075fe665e5eeba27a982c00063faca121b0baeb31e52bcdfd339', '[\"*\"]', '2025-12-18 11:41:54', NULL, '2025-12-18 11:41:53', '2025-12-18 11:41:54'),
(565, 'App\\Models\\User', 42, 'api_token', '7f4901bc92e25dc0a0d98a307ed6a66b70de09bd175fab1639b70e48bf245bee', '[\"*\"]', '2025-12-19 05:54:01', NULL, '2025-12-19 05:54:00', '2025-12-19 05:54:01'),
(568, 'App\\Models\\User', 10, 'api_token', '795fb7dd582e6cf6e1f68d0ea1943bd0e6cc012f17b63ef60869ba9961f12be4', '[\"*\"]', '2025-12-19 17:09:34', NULL, '2025-12-19 17:09:15', '2025-12-19 17:09:34'),
(570, 'App\\Models\\User', 42, 'api_token', 'ad6ea9cdb055d878677263ef41db0de4824ea38860c68b9fcd4f48cd7803f153', '[\"*\"]', '2025-12-20 18:20:24', NULL, '2025-12-20 18:20:23', '2025-12-20 18:20:24'),
(571, 'App\\Models\\User', 10, 'api_token', '871c6acacaf7895ef506a1b90fb9b091cfe6ffa452b4625f518e5f17272e85c9', '[\"*\"]', '2025-12-21 05:03:02', NULL, '2025-12-21 05:03:01', '2025-12-21 05:03:02'),
(572, 'App\\Models\\User', 42, 'api_token', '6e29837fb71abcaaa6b12bb9df179fe7aab923ce2ba77a5aa5b7b005ce198ca2', '[\"*\"]', '2025-12-21 05:03:38', NULL, '2025-12-21 05:03:37', '2025-12-21 05:03:38'),
(574, 'App\\Models\\User', 10, 'api_token', '9101257ecfa40cc0212c1022b9c3d1f1129ee676db2d24376175e7737ff22bb5', '[\"*\"]', '2025-12-21 17:26:46', NULL, '2025-12-21 17:26:45', '2025-12-21 17:26:46'),
(575, 'App\\Models\\User', 83, 'api_token', '00d36c123938f9288d7f9655c170e241363c02a16d19f8e4d57aa8a51656b01c', '[\"*\"]', '2025-12-21 17:36:31', NULL, '2025-12-21 17:36:22', '2025-12-21 17:36:31'),
(576, 'App\\Models\\User', 10, 'api_token', 'f090a025b4d3724e4c503fe7663bab8f227b2f76e8035cd6f9b156f29b351a6b', '[\"*\"]', '2025-12-22 15:00:05', NULL, '2025-12-22 14:59:39', '2025-12-22 15:00:05'),
(577, 'App\\Models\\User', 10, 'api_token', '747966377b98ab4a2c8675587ce84a954ec17e387dc13fde58d116e20fb407a3', '[\"*\"]', NULL, NULL, '2025-12-22 15:34:45', '2025-12-22 15:34:45'),
(579, 'App\\Models\\User', 42, 'api_token', 'f6a53d9b61eb4ddd91043aa9dae588c428450ea7b1d575df2d26e57ba0add388', '[\"*\"]', '2025-12-22 15:42:12', NULL, '2025-12-22 15:35:30', '2025-12-22 15:42:12'),
(580, 'App\\Models\\User', 10, 'api_token', 'fc12fcdade9f1b70868f5eb0088756806c3250413dc33783db97b3844fc6aa61', '[\"*\"]', '2025-12-22 16:03:46', NULL, '2025-12-22 15:53:51', '2025-12-22 16:03:46'),
(584, 'App\\Models\\User', 10, 'api_token', '028bac8de83e8330cf4a16fb8dc59dfc165d8b3125ae97c080f46abb51d38586', '[\"*\"]', NULL, NULL, '2025-12-22 16:22:42', '2025-12-22 16:22:42'),
(585, 'App\\Models\\User', 42, 'api_token', 'af071a77dd2ecfc3319274601cffbefa1787ddec894f6373253aa55a311a2e60', '[\"*\"]', '2025-12-22 16:37:09', NULL, '2025-12-22 16:22:58', '2025-12-22 16:37:09'),
(603, 'App\\Models\\User', 52, 'api_token', 'd0632a784e0a2ad189806bc3074ef5f4cc4f37a5cc424bcd7c9fff732aa4b718', '[\"*\"]', '2025-12-22 18:15:47', NULL, '2025-12-22 18:14:20', '2025-12-22 18:15:47'),
(606, 'App\\Models\\User', 10, 'api_token', '8c68dfff824451962cd4f998c6ebb7273290d88a3f1a0043cce7e34d50b9e790', '[\"*\"]', '2025-12-22 18:17:54', NULL, '2025-12-22 18:17:53', '2025-12-22 18:17:54'),
(614, 'App\\Models\\User', 10, 'api_token', '215df0ba18d7593efff73f76dc0c9c055d4b0dd552c8d49ce669ba295d7c0dca', '[\"*\"]', '2025-12-22 18:45:23', NULL, '2025-12-22 18:39:44', '2025-12-22 18:45:23'),
(615, 'App\\Models\\User', 52, 'api_token', '1bff0f40e03b49ac4def975f7fd33c0cae3d4fbfc8c7f675de7f650abbef03c9', '[\"*\"]', '2025-12-22 18:57:51', NULL, '2025-12-22 18:41:05', '2025-12-22 18:57:51'),
(616, 'App\\Models\\User', 42, 'api_token', '0d0a5ebcd37611a44092327e5be8aba23fabad391c2450f4454cdc276720417c', '[\"*\"]', '2025-12-22 19:11:28', NULL, '2025-12-22 18:46:24', '2025-12-22 19:11:28'),
(617, 'App\\Models\\User', 52, 'api_token', 'f01cc878acea5803c5ff03a1b89c6b60865f235509d91f09ae0273ff98f49ba0', '[\"*\"]', '2025-12-22 19:01:47', NULL, '2025-12-22 19:01:43', '2025-12-22 19:01:47'),
(619, 'App\\Models\\User', 42, 'api_token', '5aa4a29f0ebe71f566003d436c60b7567ced895da13b6522c3eaf673415e405e', '[\"*\"]', '2025-12-23 04:08:35', NULL, '2025-12-23 03:55:15', '2025-12-23 04:08:35'),
(620, 'App\\Models\\User', 10, 'api_token', '063aee169d53907f3bf6348ad2071f3204820a2beccf2be6e65e1fc534cbab2f', '[\"*\"]', '2025-12-23 03:59:22', NULL, '2025-12-23 03:59:18', '2025-12-23 03:59:22'),
(621, 'App\\Models\\User', 52, 'api_token', '2c27eafcbf2f37da46108f7eeca4e31d31d682b0719677c836a36a53d758e88f', '[\"*\"]', '2025-12-23 06:04:01', NULL, '2025-12-23 03:59:41', '2025-12-23 06:04:01'),
(622, 'App\\Models\\User', 10, 'api_token', '427127216c39258c584f276e2c71338bbcbb8f9101dde4905b7ea4018b8d4e79', '[\"*\"]', NULL, NULL, '2025-12-23 04:01:07', '2025-12-23 04:01:07'),
(623, 'App\\Models\\User', 10, 'api_token', '37a1275a3203e52c0b919bb846378864348aac39fc129f4fa383a9e6fb4a1dc5', '[\"*\"]', '2025-12-23 04:03:27', NULL, '2025-12-23 04:01:59', '2025-12-23 04:03:27'),
(626, 'App\\Models\\User', 42, 'api_token', 'a672bfc6cb9fd97b5d2ca58aa5060baa72f589332971cf3a8f22557e690c3e02', '[\"*\"]', '2025-12-23 04:18:50', NULL, '2025-12-23 04:18:41', '2025-12-23 04:18:50'),
(628, 'App\\Models\\User', 42, 'api_token', 'de475b5a701be5b84a5f359e16697248f3332a33328b338c2793491b95d8d712', '[\"*\"]', '2025-12-23 05:52:00', NULL, '2025-12-23 04:22:43', '2025-12-23 05:52:00'),
(629, 'App\\Models\\User', 83, 'api_token', 'a16244b5968a910ecc03bb80d04a5b8aa15ff6feae6998142e194b97db9cf9a6', '[\"*\"]', '2025-12-23 04:24:01', NULL, '2025-12-23 04:23:49', '2025-12-23 04:24:01'),
(640, 'App\\Models\\User', 42, 'api_token', '035718126b0bb1a2969bc7bf752e6060270b0fa8f8f07378ac4e71a2d516c410', '[\"*\"]', '2025-12-23 05:51:42', NULL, '2025-12-23 05:51:40', '2025-12-23 05:51:42'),
(641, 'App\\Models\\User', 42, 'api_token', '3aba88bc033e42c2826b91158fb98c920ad148812034c5e5d10d3c123db5e750', '[\"*\"]', '2025-12-23 06:04:45', NULL, '2025-12-23 06:04:28', '2025-12-23 06:04:45');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED DEFAULT NULL,
  `supplier_percentage` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `product_type` enum('consumer','flat','land','share','other') NOT NULL,
  `price` decimal(14,2) NOT NULL DEFAULT 0.00,
  `ccu_percentage` int(11) NOT NULL DEFAULT 0,
  `attributes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attributes`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stock_qty` decimal(14,2) NOT NULL DEFAULT 0.00,
  `min_stock_alert` decimal(14,2) NOT NULL DEFAULT 0.00,
  `is_stock_managed` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `supplier_id`, `supplier_percentage`, `name`, `product_type`, `price`, `ccu_percentage`, `attributes`, `created_at`, `updated_at`, `stock_qty`, `min_stock_alert`, `is_stock_managed`) VALUES
(1, 1, 2, 20, 'Bashundhara Residential Plot', 'land', 5000000.00, 10, '{\"size\":\"5 katha\",\"location\":\"Bashundhara Block D\"}', '2025-10-20 13:59:05', '2025-11-18 14:32:33', 100.00, 10.00, 1),
(3, 10, 2, 12, 'ma-shopnoo bilash', 'land', 1000000.00, 10, NULL, '2025-10-31 17:42:03', '2025-11-18 14:32:23', 1000.00, 10.00, 1),
(4, 2, 1, 20, 'Premium Land Parcel', 'land', 5000000.00, 30, '{\"plot_size\":\"5 katha\"}', '2025-11-11 15:22:18', '2025-11-18 14:32:15', 200.00, 10.00, 1),
(6, 1, 2, 15, 'Dhaka South', 'land', 50000.00, 10, NULL, '2025-11-11 15:44:51', '2025-11-18 14:32:07', 500.00, 0.00, 1),
(10, 1, 1, 10, 'Dhaka_NOrth', 'flat', 500000.00, 20, NULL, '2025-11-11 17:00:02', '2025-12-10 17:44:36', 96.00, 5.00, 1),
(11, 1, 1, 20, 'Premium Land Parcel', 'land', 5000000.00, 30, '{\"plot_size\":\"5 katha\"}', '2025-11-12 18:37:38', '2025-11-12 18:37:38', 2.00, 1.00, 1),
(12, 1, 1, 20, 'Duplex Home', 'flat', 500000.00, 20, NULL, '2025-11-13 04:06:06', '2025-12-10 17:14:51', 98.00, 5.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ranks`
--

CREATE TABLE `ranks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ranks`
--

INSERT INTO `ranks` (`id`, `code`, `name`, `description`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, 'ME', 'Marketing Executive', NULL, 1, '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(2, 'MM', 'Marketing Manager', NULL, 2, '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(3, 'AGM', 'Assistant General Manager', NULL, 3, '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(4, 'DGM', 'Deputy General Manager', NULL, 4, '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(5, 'GM', 'General Manager', NULL, 5, '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(6, 'DM', 'Director Marketing', NULL, 6, '2025-10-20 13:59:03', '2025-12-17 17:20:28'),
(7, 'AMD', 'Assistant Managing Director', NULL, 7, '2025-10-20 13:59:03', '2025-12-17 17:24:46'),
(8, 'DMD', 'Deputy Managing Director', NULL, 8, '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(9, 'DIR', 'Director', NULL, 9, '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(13, 'VC', 'Vice Chairman', NULL, 10, '2025-11-28 16:32:16', '2025-12-17 17:23:41');

-- --------------------------------------------------------

--
-- Table structure for table `rank_memberships`
--

CREATE TABLE `rank_memberships` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `agent_id` bigint(20) UNSIGNED NOT NULL,
  `rank` varchar(255) NOT NULL,
  `achieved_at` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rank_requirements`
--

CREATE TABLE `rank_requirements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rank` varchar(255) NOT NULL,
  `sequence` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `personal_sales_target` decimal(14,2) NOT NULL DEFAULT 0.00,
  `bonus_down_payment` decimal(5,2) NOT NULL DEFAULT 0.00,
  `bonus_installment` decimal(5,2) NOT NULL DEFAULT 0.00,
  `direct_required` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rank_requirements`
--

INSERT INTO `rank_requirements` (`id`, `rank`, `sequence`, `personal_sales_target`, `bonus_down_payment`, `bonus_installment`, `direct_required`, `meta`, `created_at`, `updated_at`) VALUES
(2, 'MM', 2, 100000.00, 15.00, 5.00, 0, '{\"shares_required\":2,\"minimum_share_per_period\":1,\"period_months\":4,\"monthly_incentive\":10000}', '2025-10-20 13:59:03', '2025-11-03 16:17:38'),
(3, 'AGM', 3, 250000.00, 18.00, 6.00, 0, '{\"shares_required\":5,\"minimum_share_per_period\":1,\"period_months\":5,\"monthly_incentive\":20000}', '2025-10-20 13:59:03', '2025-12-22 17:44:47'),
(4, 'DGM', 4, 750000.00, 25.00, 9.00, 0, '{\"shares_required\":15,\"minimum_share_per_period\":1,\"period_months\":4,\"monthly_incentive\":40000}', '2025-10-20 13:59:03', '2025-11-03 17:52:26'),
(5, 'GM', 5, 2000000.00, 30.00, 11.00, 0, '{\"shares_required\":40,\"minimum_share_per_period\":1,\"period_months\":4,\"monthly_incentive\":100000}', '2025-10-20 13:59:03', '2025-11-03 16:19:17'),
(6, 'PD', 6, 3750000.00, 30.00, 11.00, 0, '{\"shares_required\":75,\"minimum_share_per_period\":1,\"period_months\":4,\"direct_mm_required\":12,\"fund_percentage\":2}', '2025-10-20 13:59:03', '2025-11-03 17:53:02'),
(7, 'ED', 7, 6250000.00, 30.00, 11.00, 0, '{\"shares_required\":125,\"minimum_share_per_period\":1,\"period_months\":4,\"direct_mm_required\":25,\"fund_percentage\":2}', '2025-10-20 13:59:03', '2025-11-03 17:53:23'),
(8, 'DMD', 8, 10000000.00, 30.00, 11.00, 0, '{\"shares_required\":200,\"minimum_share_per_period\":1,\"period_months\":4,\"direct_mm_required\":40,\"fund_percentage\":1}', '2025-10-20 13:59:03', '2025-11-03 17:53:41'),
(9, 'DIR', 9, 75000000.00, 30.00, 11.00, 0, '{\"shares_required\":1500,\"minimum_share_per_period\":1,\"period_months\":4,\"direct_pd_required\":20,\"fund_percentage\":20}', '2025-10-20 13:59:03', '2025-11-03 17:54:03'),
(10, 'ME', 1, 50000.00, 0.00, 0.00, 0, '{\"shares_required\":1,\"minimum_share_per_period\":2,\"period_months\":1}', '2025-10-21 15:18:12', '2025-11-03 17:51:38');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(2, 'finance', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(3, 'branch-manager', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(4, 'agent_admin', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(5, 'agent', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(6, 'director', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(7, 'owner', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(8, 'customer', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(9, 'employee', 'web', '2025-10-20 13:59:03', '2025-10-20 13:59:03');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(3, 3),
(4, 1),
(5, 1),
(6, 1),
(6, 3),
(6, 4),
(6, 5),
(7, 1),
(7, 2),
(7, 3),
(8, 1),
(8, 2),
(8, 6),
(9, 1),
(9, 6),
(10, 1),
(10, 2),
(11, 1),
(11, 2),
(11, 3),
(11, 4),
(11, 5),
(11, 6),
(11, 7);

-- --------------------------------------------------------

--
-- Table structure for table `sales_orders`
--

CREATE TABLE `sales_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED DEFAULT NULL,
  `source_me_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` varchar(255) NOT NULL DEFAULT 'system',
  `agent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sales_type` varchar(255) NOT NULL DEFAULT 'order',
  `rank` varchar(255) DEFAULT NULL,
  `introducer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `down_payment` decimal(14,2) DEFAULT 0.00,
  `total` decimal(14,2) NOT NULL,
  `status` enum('draft','active','completed','cancelled') NOT NULL DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales_orders`
--

INSERT INTO `sales_orders` (`id`, `customer_id`, `employee_id`, `source_me_id`, `created_by`, `agent_id`, `sales_type`, `rank`, `introducer_id`, `branch_id`, `down_payment`, `total`, `status`, `created_at`, `updated_at`) VALUES
(1, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 60000.00, 600000.00, 'active', '2025-11-04 17:33:46', '2025-11-04 17:33:46'),
(4, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 20000.00, 200000.00, 'active', '2025-11-04 18:10:10', '2025-11-04 18:10:10'),
(5, 51, 19, 19, 'admin', NULL, 'order', 'ME', NULL, 2, 30000.00, 300000.00, 'active', '2025-11-04 18:13:01', '2025-11-04 18:13:01'),
(6, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 20000.00, 200000.00, 'active', '2025-11-04 18:47:58', '2025-11-04 18:47:58'),
(7, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 50000.00, 500000.00, 'active', '2025-11-05 06:11:39', '2025-11-05 06:11:39'),
(9, 51, 19, 19, 'admin', NULL, 'order', 'ME', NULL, 2, 40000.00, 600000.00, 'active', '2025-11-10 15:28:48', '2025-11-10 15:28:48'),
(10, 48, 16, 16, 'admin', NULL, 'order', 'ME', NULL, 2, 50000.00, 500000.00, 'active', '2025-11-11 15:59:28', '2025-11-11 15:59:28'),
(11, 51, 19, 19, 'admin', NULL, 'order', 'ME', NULL, 2, 50000.00, 500000.00, 'active', '2025-11-11 16:07:51', '2025-11-11 16:07:51'),
(12, 51, 19, 19, 'admin', NULL, 'order', 'ME', NULL, 2, 50000.00, 500000.00, 'active', '2025-11-11 17:00:43', '2025-11-11 17:00:43'),
(13, 51, 19, 19, 'admin', NULL, 'order', 'MM', NULL, 2, 50000.00, 500000.00, 'active', '2025-11-11 17:16:35', '2025-11-11 17:16:35'),
(14, 51, 19, 19, 'admin', NULL, 'order', 'MM', NULL, 2, 50000.00, 500000.00, 'active', '2025-11-12 18:38:51', '2025-11-12 18:38:51'),
(15, 51, 19, 19, 'admin', NULL, 'order', 'MM', NULL, 2, 50000.00, 500000.00, 'active', '2025-11-13 04:32:14', '2025-11-13 04:32:14'),
(16, 54, 12, 12, 'admin', NULL, 'order', 'GM', NULL, 2, 50000.00, 500000.00, 'active', '2025-11-16 16:12:02', '2025-11-16 16:12:02'),
(17, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 100000.00, 500000.00, 'active', '2025-11-19 09:23:37', '2025-11-19 09:23:37'),
(21, 48, 16, 16, 'admin', NULL, 'service', 'MM', NULL, 2, NULL, 50000.00, 'active', '2025-12-01 18:20:06', '2025-12-01 18:20:06'),
(22, 51, 19, 19, 'admin', NULL, 'service', 'MM', NULL, 2, NULL, 50000.00, 'active', '2025-12-01 18:24:20', '2025-12-01 18:24:20'),
(23, 48, 16, 16, 'admin', NULL, 'order', 'MM', NULL, 2, 50000.00, 5000000.00, 'active', '2025-12-01 19:51:22', '2025-12-01 19:51:22'),
(24, 51, 19, 19, 'admin', NULL, 'service', 'MM', NULL, 2, NULL, 17500.00, 'active', '2025-12-02 16:18:22', '2025-12-02 16:18:22'),
(25, 51, 19, 19, 'admin', NULL, 'service', 'MM', NULL, 2, NULL, 17500.00, 'active', '2025-12-03 17:57:27', '2025-12-03 17:57:27'),
(26, 51, 19, 19, 'admin', NULL, 'service', 'MM', NULL, 2, NULL, 17500.00, 'active', '2025-12-03 18:07:34', '2025-12-03 18:07:34'),
(28, 51, 19, 19, 'admin', NULL, 'order', 'MM', NULL, 2, 50000.00, 1000000.00, 'active', '2025-12-09 18:11:36', '2025-12-09 18:11:36'),
(36, 51, 19, 19, 'admin', NULL, 'order', 'MM', NULL, 2, 50000.00, 500000.00, 'active', '2025-12-10 17:14:51', '2025-12-10 17:14:51'),
(37, 48, 16, 16, 'admin', NULL, 'order', 'MM', NULL, 2, 1000000.00, 5000000.00, 'active', '2025-12-10 17:20:54', '2025-12-10 17:20:54'),
(38, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 1000000.00, 5000000.00, 'active', '2025-12-10 17:21:24', '2025-12-10 17:21:24'),
(39, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 50000.00, 500000.00, 'active', '2025-12-10 17:24:18', '2025-12-10 17:24:18'),
(40, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 50000.00, 5000000.00, 'active', '2025-12-10 17:28:07', '2025-12-10 17:28:07'),
(41, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 50000.00, 5000000.00, 'active', '2025-12-10 17:29:12', '2025-12-10 17:29:12'),
(42, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 50000.00, 500000.00, 'active', '2025-12-10 17:44:36', '2025-12-10 17:44:36'),
(43, 77, 26, 26, 'admin', NULL, 'order', 'ED', NULL, 1, 200000.00, 5000000.00, 'active', '2025-12-10 17:47:04', '2025-12-10 17:47:04'),
(44, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 5000.00, 50000.00, 'active', '2025-12-10 17:50:13', '2025-12-10 17:50:13'),
(45, 81, NULL, NULL, 'agent', 7, 'order', NULL, NULL, 1, 1000000.00, 5000000.00, 'active', '2025-12-10 18:10:25', '2025-12-10 18:10:25'),
(48, 84, NULL, NULL, 'agent', 8, 'order', NULL, NULL, 2, 1000000.00, 5000000.00, 'active', '2025-12-11 19:33:42', '2025-12-11 19:33:42'),
(49, 84, NULL, NULL, 'agent', 8, 'order', NULL, NULL, 2, 1000000.00, 5000000.00, 'active', '2025-12-11 19:41:42', '2025-12-11 19:41:42'),
(50, 84, NULL, NULL, 'agent', 8, 'order', NULL, NULL, 2, 1000000.00, 5000000.00, 'active', '2025-12-11 19:42:40', '2025-12-11 19:42:40'),
(51, 84, NULL, NULL, 'agent', 8, 'order', NULL, NULL, 2, 500000.00, 5000000.00, 'active', '2025-12-17 18:06:23', '2025-12-17 18:06:23'),
(52, 89, 12, 12, 'agent', 6, 'order', 'GM', NULL, 2, 50000.00, 5000000.00, 'active', '2025-12-22 18:26:49', '2025-12-22 18:26:49'),
(53, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 50000.00, 5000000.00, 'active', '2025-12-22 18:32:33', '2025-12-22 18:32:33'),
(54, 89, 12, 12, 'agent', 6, 'order', 'GM', NULL, 2, 100000.00, 5000000.00, 'active', '2025-12-22 18:36:31', '2025-12-22 18:36:31'),
(55, 89, 17, 17, 'agent', 6, 'order', 'ME', NULL, 2, 100000.00, 5000000.00, 'active', '2025-12-22 18:44:04', '2025-12-22 18:44:04'),
(56, 96, 12, 12, 'agent', 6, 'order', 'GM', NULL, 2, 100000.00, 5000000.00, 'active', '2025-12-23 04:27:39', '2025-12-23 04:27:39');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(14,2) NOT NULL DEFAULT 0.00,
  `commission_percentage` int(11) NOT NULL,
  `attributes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attributes`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `category_id`, `name`, `price`, `commission_percentage`, `attributes`, `created_at`, `updated_at`) VALUES
(1, 8, 'Premium Hajj Package', 17500.00, 5, '{\"duration\":\"4 nights\"}', '2025-10-20 13:59:05', '2025-12-01 17:58:49'),
(2, 9, 'Tour', 50000.00, 5, '{\"duration\":\"5\",\"location\":\"Dhaka,Hirajeel\",\"includes\":[]}', '2025-10-22 18:43:57', '2025-12-01 17:58:53'),
(3, 8, 'umrah', 200000.00, 5, '{\"duration\":null,\"location\":null,\"includes\":[]}', '2025-12-01 17:42:35', '2025-12-01 17:58:57');

-- --------------------------------------------------------

--
-- Table structure for table `stock_movements`
--

CREATE TABLE `stock_movements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('in','out') NOT NULL,
  `qty` decimal(14,2) NOT NULL,
  `ref_type` varchar(255) DEFAULT NULL,
  `ref_id` bigint(20) UNSIGNED DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_movements`
--

INSERT INTO `stock_movements` (`id`, `product_id`, `type`, `qty`, `ref_type`, `ref_id`, `note`, `created_at`, `updated_at`) VALUES
(1, 2, 'out', 1.00, 'sales_order', 9, NULL, '2025-11-10 15:28:48', '2025-11-10 15:28:48'),
(2, 10, 'out', 1.00, 'sales_order', 12, NULL, '2025-11-11 17:00:43', '2025-11-11 17:00:43'),
(3, 10, 'out', 1.00, 'sales_order', 13, NULL, '2025-11-11 17:16:35', '2025-11-11 17:16:35'),
(4, 12, 'out', 1.00, 'sales_order', 15, NULL, '2025-11-13 04:32:14', '2025-11-13 04:32:14'),
(5, 12, 'out', 1.00, 'sales_order', 36, NULL, '2025-12-10 17:14:51', '2025-12-10 17:14:51'),
(6, 10, 'out', 1.00, 'sales_order', 39, NULL, '2025-12-10 17:24:18', '2025-12-10 17:24:18'),
(7, 10, 'out', 1.00, 'sales_order', 42, NULL, '2025-12-10 17:44:36', '2025-12-10 17:44:36');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `email`, `phone`, `address`, `created_at`, `updated_at`) VALUES
(1, 'ABC Developers Ltd.s', 'finance@abcdevelopers.test', '+8801711000000', 'House 15, Road 7, Dhanmondi, Dhaka', '2025-11-12 18:36:08', '2025-11-12 18:36:25'),
(2, 'Shukran Developers', 'shukran@gmail.com', '01815235474', 'Road-8, North City, Dhaka', '2025-11-13 04:02:51', '2025-11-13 04:03:01');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_payables`
--

CREATE TABLE `supplier_payables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` bigint(20) UNSIGNED NOT NULL,
  `sales_order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` decimal(14,2) NOT NULL,
  `status` enum('unpaid','paid') NOT NULL DEFAULT 'unpaid',
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `supplier_payables`
--

INSERT INTO `supplier_payables` (`id`, `supplier_id`, `payment_id`, `sales_order_id`, `amount`, `status`, `paid_at`, `created_at`, `updated_at`) VALUES
(2, 1, 14, 14, 7500.00, 'unpaid', NULL, '2025-11-12 18:39:25', '2025-11-12 18:39:25'),
(3, 1, 16, 15, 7500.00, 'unpaid', NULL, '2025-11-13 04:33:28', '2025-11-13 04:33:28'),
(4, 2, 19, 17, 5000.00, 'unpaid', NULL, '2025-11-19 09:25:14', '2025-11-19 09:25:14'),
(5, 2, 33, 23, 82500.00, 'unpaid', NULL, '2025-12-02 10:48:40', '2025-12-02 10:48:40'),
(6, 2, 38, 28, 11400.00, 'unpaid', NULL, '2025-12-09 18:12:46', '2025-12-09 18:12:46'),
(8, 1, 44, 41, 82500.00, 'unpaid', NULL, '2025-12-10 17:30:13', '2025-12-10 17:30:13'),
(9, 2, 46, 44, 562.50, 'unpaid', NULL, '2025-12-10 17:50:50', '2025-12-10 17:50:50'),
(10, 2, 48, 45, 40000.00, 'unpaid', NULL, '2025-12-10 18:16:50', '2025-12-10 18:16:50'),
(12, 1, 51, 48, 40000.00, 'unpaid', NULL, '2025-12-11 19:36:20', '2025-12-11 19:36:20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `marital_status` varchar(255) DEFAULT NULL,
  `spouse_name` varchar(255) DEFAULT NULL,
  `profession` varchar(255) DEFAULT NULL,
  `permanent_address` text DEFAULT NULL,
  `present_address` text DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `residence_phone` varchar(255) DEFAULT NULL,
  `whatsapp_number` varchar(255) DEFAULT NULL,
  `national_id` varchar(255) DEFAULT NULL,
  `passport_number` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `religion` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `blood_group` varchar(255) DEFAULT NULL,
  `nominee_name` varchar(255) DEFAULT NULL,
  `nominee_relation` varchar(255) DEFAULT NULL,
  `nominee_phone` varchar(255) DEFAULT NULL,
  `authorized_person_name` varchar(255) DEFAULT NULL,
  `authorized_person_address` text DEFAULT NULL,
  `joint_applicants` text DEFAULT NULL,
  `added_by_role` varchar(255) DEFAULT NULL,
  `added_by_branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `added_by_agent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `source_me_id` bigint(20) UNSIGNED DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'employee',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `father_name`, `mother_name`, `marital_status`, `spouse_name`, `profession`, `permanent_address`, `present_address`, `contact_number`, `residence_phone`, `whatsapp_number`, `national_id`, `passport_number`, `nationality`, `religion`, `date_of_birth`, `blood_group`, `nominee_name`, `nominee_relation`, `nominee_phone`, `authorized_person_name`, `authorized_person_address`, `joint_applicants`, `added_by_role`, `added_by_branch_id`, `added_by_agent_id`, `source_me_id`, `email`, `role`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(10, 'John Doe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin@example.com', 'admin', NULL, '$2y$12$slGM43tVVOmXCZHMzC9Md.vnUOtg3tMJexIr4HL7E/Ci1MWcJ/cpa', NULL, '2025-10-20 14:06:56', '2025-10-20 14:06:56'),
(14, 'Mayin Uddin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'mayin2@example.com', 'agent', NULL, '$2y$12$FA3sEs/CiFITiqX9PkArq.A9exwh3FKVXI.PkTmVuAtsBRTe9QjkC', NULL, '2025-10-27 15:42:00', '2025-10-27 15:42:00'),
(42, 'ZAMAN MIA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'mainu768971@gmail.com', 'employee', NULL, '$2y$12$F6wyd3i0dg0I4rFaDnhuvu.gP57vHfdOKC8sFX.Y5Ea72e1CeiEAi', NULL, '2025-11-03 15:36:33', '2025-11-04 16:07:19'),
(43, 'SAKIL AL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'appdev5807@gmail.com', 'employee', NULL, '$2y$12$mkvyDdlDKfkmVRn0QkUOxO73VarSrzCEWhA0ofeJxcuZAtLC3YJ/C', NULL, '2025-11-03 15:38:47', '2025-11-03 15:38:47'),
(44, 'SABBIR RAHMAN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'mayidiu@gmail.com', 'employee', NULL, '$2y$12$slGM43tVVOmXCZHMzC9Md.vnUOtg3tMJexIr4HL7E/Ci1MWcJ/cpa', NULL, '2025-11-03 15:40:57', '2025-11-03 15:40:57'),
(45, 'MOJAHID', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'fahadbinbashar@gmail.com', 'employee', NULL, '$2y$12$OHxiLiJOFpc3s79gZxLvwuzcPcwWYOkVNPUkBFHl4Rqi/7hVzIWEq', NULL, '2025-11-03 15:42:10', '2025-11-03 15:42:10'),
(46, 'JAKARIA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'abc@gmail.com', 'employee', NULL, '$2y$12$akUTTMj4Z0esAl/JloKOT.T08ENKZfkU1e/5SMK7U8CE0HVJGV9I2', NULL, '2025-11-03 15:44:14', '2025-11-03 15:44:14'),
(47, 'ABDULLAH', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'abdullah1@gmail.com', 'employee', NULL, '$2y$12$QBUdY/OqRRiJTY8YXGgxke/rAZf2/PBky6QK4cbET/JN1zmneJaGG', NULL, '2025-11-03 15:50:44', '2025-11-03 15:50:44'),
(48, 'Asif Bin Mostafa', 'SABBIR', 'SHAKIN', 'Single', 'sdf', 'Student', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '019990701233', NULL, NULL, '234234234324111', '2423432423111', 'Bangladeshi', 'Islam', '1998-05-02', 'o+', 'Sabina', 'Husband', '01999070234', NULL, NULL, NULL, 'admin', 2, NULL, 16, 'cus@gmail.com', 'customer', NULL, '$2y$12$akUTTMj4Z0esAl/JloKOT.T08ENKZfkU1e/5SMK7U8CE0HVJGV9I2', NULL, '2025-11-03 15:54:01', '2025-11-03 15:54:01'),
(49, 'dsfsf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'aea@gmail.com', 'employee', NULL, '$2y$12$p82UtOdvGBuEb9cq6PuM9e95.tYYux/urytXr.xNnDifZ1eZKdLoa', NULL, '2025-11-03 16:39:25', '2025-11-03 16:39:25'),
(50, 'SABBIR MIA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'sabbir@gmail.com', 'employee', NULL, '$2y$12$slGM43tVVOmXCZHMzC9Md.vnUOtg3tMJexIr4HL7E/Ci1MWcJ/cpa', NULL, '2025-11-04 15:52:07', '2025-11-04 15:52:07'),
(51, 'Jahangir Alam', 'Shaid', 'Shakina', 'Single', 'Ssss', 'Student', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '019991232131', NULL, NULL, '234234234324122', '24234324231111', 'Bangladeshi', 'Islam', '1997-05-02', 'o+', 'Sabina', 'Husband', '0199901222', NULL, NULL, NULL, 'admin', 2, NULL, 19, 'jahangir@gmail.com', 'customer', NULL, '$2y$12$TEHT/IdPmeKSiQrg4MWdauRLemXD5iyQWSncMeE45rgERQ2vCoH3u', NULL, '2025-11-04 15:54:03', '2025-11-04 15:54:03'),
(52, 'MD MAYIN UDDIN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'mayinuddin768971@gmail.com', 'agent', NULL, '$2y$12$Cp4jELH8FukFxiIATi1biOVPKG8tvDrab4irYTS2o12OKRDH4Kzfy', NULL, '2025-11-04 16:35:54', '2025-11-04 16:35:54'),
(53, 'Sakib Al Hasan', 'Bajlur rahman', 'Fatema', 'Single', 'sdf', 'Doctor', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '01999324324', NULL, NULL, '2342323334232', '242343242311132', 'Bangladeshi', 'Islam', '1998-05-02', 'o+', 'Sabina', 'Husband', '01999070234', 'fsdf', NULL, NULL, 'agent', 2, 6, NULL, 'sakib@gmail.com', 'customer', NULL, '$2y$12$anbFrwZ.EI8KCJLWZrU8dePUMlYQZkW0yNLPdP0vQ/.7oZsISfNQ2', NULL, '2025-11-04 16:37:20', '2025-11-04 16:37:20'),
(54, 'Saon Mia', 'Abdul mia', 'aysha begum', 'Single', NULL, 'Doctor', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '019990711111', NULL, NULL, '234232333411111', '2423432423111111', 'Bangladeshi', 'Islam', '1997-05-02', 'o+', 'Sabina', 'Husband', '01999070234', 'fsdf', '300/A, North Sahajanpur,Dhaka', NULL, 'admin', 2, NULL, 12, 'saon@gmail.com', 'customer', NULL, '$2y$12$aGWRrBVao9ZCipfXESULQ.ZVNsBaIjhgmoKg5rENUP./nx8pTz.iu', NULL, '2025-11-16 16:11:17', '2025-11-16 16:11:17'),
(55, 'sumi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4lifecomilla1199@gmail.com', 'employee', NULL, '$2y$12$TJ8kW60HkIQk.9VaTpfvGuYVkIBhzdKdaIWSsOcmCcAEqoaHXV.VO', NULL, '2025-11-19 08:08:06', '2025-11-19 08:08:06'),
(56, 'mizan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4lifecomilla@gmail.com', 'employee', NULL, '$2y$12$1/qLIXGGI78BAMF8EdDAz.4my7jLQTXOt/kh0NmOGJFgZ2VnHnP6C', NULL, '2025-11-19 08:15:46', '2025-11-19 08:15:46'),
(57, 'rina', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '01766686301', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', NULL, NULL, NULL, '4lifecomilla2456@gmail.com', 'customer', NULL, '$2y$12$Naq0i.rnBtblOm5NV0ZkieFE9aEVe.mwpzNm0pj96vuo7ZTza7vx.', NULL, '2025-11-19 08:24:00', '2025-11-19 08:24:00'),
(58, 'SAD MIA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'sad@gmail.com', 'employee', NULL, '$2y$12$XEaOzfnQyWaIy8PlOPfYruuV6Ok324ixdw/klVkIFWa8NF2ojAebq', NULL, '2025-11-28 16:30:52', '2025-11-28 16:30:52'),
(59, 'SAPLA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'sapeda@gmail.com', 'employee', NULL, '$2y$12$/sLef.NWeB4ezCD9QbiJleoTaVBy4/N2sOxPQ5QYX7rCRB5S/MSUq', NULL, '2025-11-28 16:33:55', '2025-11-28 16:33:55'),
(60, 'FAJLE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'fajle@gamil.com', 'employee', NULL, '$2y$12$YpBw.cso1sCDpLtATsClJ.3UaEA8ynaMXdihDF.Oi9D0GR5PZkVdG', NULL, '2025-11-28 16:35:55', '2025-11-28 16:35:55'),
(61, 'MOSJA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'mosja@gmail.com', 'employee', NULL, '$2y$12$XLAATCy0wg4ZGvxG7XA2oe4B3yWqXZRoQG87qZiOLsHnqa8s/Jom.', NULL, '2025-11-28 16:37:39', '2025-11-28 16:37:39'),
(62, 'MIZANUR RAHMAN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'mizan@gmail.com', 'employee', NULL, '$2y$12$slGM43tVVOmXCZHMzC9Md.vnUOtg3tMJexIr4HL7E/Ci1MWcJ/cpa', NULL, '2025-11-29 11:59:55', '2025-11-29 11:59:55'),
(63, 'Monir mia', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'monir@gmail.com', 'employee', NULL, '$2y$12$h86zVCFwApPWFxX2xRdIVOmseV8zNo7Fe57BDhIsMOnQOl8gl1Ij6', NULL, '2025-11-29 12:01:58', '2025-11-29 12:01:58'),
(64, 'SIPBKU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'shplu@gmail.com', 'employee', NULL, '$2y$12$0auUcz3hrhAdcTad791IweHY2mNbydX2PCarIf0Ghx29IaaHWGxBu', NULL, '2025-11-29 12:03:32', '2025-11-29 12:03:32'),
(65, 'ESHAN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'eshan@gmail.com', 'employee', NULL, '$2y$12$Ttt3orJBzN1MS8zttdPPVOWuwNaJqxgiZSgZ3na9GmNBNpEIjAaKu', NULL, '2025-11-29 12:05:07', '2025-11-29 12:05:07'),
(66, 'Rehan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rehan@gmail.com', 'employee', NULL, '$2y$12$ldVVCSWzQqnBKfX/UWJWsO2F3AumrjhEPgwcFK2aK52MWpfzak59i', NULL, '2025-11-29 12:11:30', '2025-11-29 12:11:30'),
(67, 'SAW MIA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'saw@gmail.com', 'employee', NULL, '$2y$12$QbVNpVbc4/.UXEYOYDFm1.LhJe.4Xk.7bO/P9MrEb99QfHYoovWU6', NULL, '2025-11-29 12:23:37', '2025-11-29 12:23:37'),
(68, 'KABIR SINGH', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'kabir@gmail.com', 'employee', NULL, '$2y$12$MLZMnzSQ8mBEQRrJ4Q3h1eTarhMWyF.2svj8eEk3/FBeNHo4WHJ0.', NULL, '2025-11-29 12:33:39', '2025-11-29 12:33:39'),
(69, 'SOCRETIS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'scoreties@gmail.com', 'employee', NULL, '$2y$12$8.seFYR.FzJFhEo0ZNpW9O8xjne7WXGBsBIu5e7UTvGRoVYq7Mhqq', NULL, '2025-11-29 12:34:53', '2025-11-29 12:34:53'),
(70, 'MIHILA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'mihila@gmail.com', 'employee', NULL, '$2y$12$b54nbWn0VePsiPBlTrDqEOldKKhK/a5BUknKVZ2LNlEpObcm5GOlK', NULL, '2025-11-29 12:36:02', '2025-11-29 12:36:02'),
(71, 'SJID', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'sjid@gmail.com', 'employee', NULL, '$2y$12$d0YBeVMtDAOqHIGphIAk5eezRZ8oaI6c9a5fmu7EN5RDI/nQOBpV6', NULL, '2025-11-29 12:37:24', '2025-11-29 12:37:24'),
(72, 'FARUQ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'faruq@gmail.com', 'employee', NULL, '$2y$12$cC4md0RIpQUGnlTisIP74eVayJUVaR2Hav8wmCeRQpOb2EVxDIJya', NULL, '2025-11-29 12:39:54', '2025-11-29 12:39:54'),
(73, 'ENUS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'enus@gmail.com', 'employee', NULL, '$2y$12$XHrPJsNMJmQDPa8Cwjl0.uwkVEsn1iFaBKdfP/WfKjda/ZJmHE9z2', NULL, '2025-11-29 12:40:51', '2025-11-29 12:40:51'),
(74, 'HABIB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'habib@gmail.com', 'employee', NULL, '$2y$12$bEkgihf2x3aPfFF2Ih5xHeVUXEOu.j3s3T3LejWDqdvBcA/FHDsia', NULL, '2025-11-29 12:41:59', '2025-11-29 12:41:59'),
(75, 'Eshraj', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'eshraj@gmail.com', 'employee', NULL, '$2y$12$K2aQ1YvQZexCzZUedNXTQ.V4Bwbk71.RrDtj47q9hAWfwU3EfS0rS', NULL, '2025-11-29 12:43:19', '2025-11-29 12:43:19'),
(76, 'SABBIR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'sabbire@gmail.com', 'employee', NULL, '$2y$12$WmPD2aZevYOE4tEePCpOQ.xC21dhcssybLsW/gsJCaSGefy0Ein8e', NULL, '2025-11-29 12:45:36', '2025-11-29 12:45:36'),
(77, 'MOIJ MIA', 'Bajlur rahman', 'Fatema', 'Single', 'sdf', 'Doctor', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, '0199901234', NULL, NULL, '234234222', NULL, 'Bangladeshi', 'Islam', '1995-05-02', 'o+', 'Sabina', NULL, '01999070234', 'fsdf', NULL, NULL, 'admin', 1, NULL, 26, 'moij@gmail.com', 'customer', NULL, '$2y$12$whtYB4FxABCze7ZV3J9NXOWEdxPxkY2OxRdI.hLdzIZiciuNLgy7K', NULL, '2025-11-29 12:49:45', '2025-11-29 12:49:45'),
(78, 'SHihab mia', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'shihab@gmail.com', 'employee', NULL, '$2y$12$QqgXuIAcAgTl7Xbcz6ZkY.qa9OUtwQhn/LiUAjstbJJqvFts3r40y', NULL, '2025-11-29 17:27:49', '2025-11-29 17:27:49'),
(79, 'Shamina', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'shajeda@gmail.com', 'employee', NULL, '$2y$12$fone6vrwocQYRXCPRDXBXunQw9P49f.rQQ5edrMssPH5DkbLxGVhW', NULL, '2025-11-29 17:29:09', '2025-11-29 17:29:09'),
(80, 'Liton', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'liton@gmail.com', 'agent', NULL, '$2y$12$LQwtIG6dSDwovqvMWOX/SO2Jo9uBdEjS9N8WMKJheWr4JVGYpzG1C', NULL, '2025-12-10 18:03:20', '2025-12-10 18:03:20'),
(81, 'mizan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'agent', 1, 7, NULL, 'mizan1@gmail.com', 'customer', NULL, '$2y$12$E6Rw29gBBrgso4QQqWPvYOVVEE7mNvWDYWe5qU4VBiSFiYqMYsmvu', NULL, '2025-12-10 18:08:34', '2025-12-10 18:08:34'),
(82, 'sumi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'sumi@gmail.com', 'employee', NULL, '$2y$12$QV.JdQmUwV7k2Lt3jYdXN.ZLu6Ck8cCxh/a8ZYYkxkxIXmGydEXG6', NULL, '2025-12-10 18:31:11', '2025-12-10 18:31:11'),
(83, 'fusion', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'fusion@gmail.com', 'agent', NULL, '$2y$12$y1IJfR4BcRq7aqT6xD2.beij2vXo84WSdOY.3Fu1ap2ksgAY1wF26', NULL, '2025-12-11 17:56:59', '2025-12-11 17:56:59'),
(84, 'kamrul', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '234345', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'agent', 2, 8, NULL, 'kamrul@gmail.com', 'customer', NULL, '$2y$12$ZvOEAlCIdRRFU.Z4LLq4R..eOmtV.CoXeX.QJ1z8memnYbJfDRKQi', NULL, '2025-12-11 18:05:41', '2025-12-11 18:05:41'),
(85, 'mahabub', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2344', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', NULL, NULL, NULL, 'mahabub@gmail.com', 'customer', NULL, '$2y$12$sClHFEeIuNPRLwF0uqPyruLXAAMiCmi9i3.W.6dwDm4C0WG6fdWfO', NULL, '2025-12-11 19:54:19', '2025-12-11 19:54:19'),
(86, 'mamun', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'mamun@gmail.com', 'employee', NULL, '$2y$12$6cpaJgnC13.ACW0Jy3ilduXKo7qjHNUB9NtjGitHg3SAdIRgcogYG', NULL, '2025-12-17 17:57:03', '2025-12-17 17:57:03'),
(87, 'rana1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '234', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'admin', NULL, NULL, NULL, 'rana1@gmail.com', 'customer', NULL, '$2y$12$6nGjt64Sp8.ie/rVXmtEAeYqmZZimo64E38jo8VVSQhZbi7kZPNqi', NULL, '2025-12-17 18:00:42', '2025-12-17 18:00:42'),
(88, 'ABDULLAH', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'abk@gmail.com', 'employee', NULL, '$2y$12$98ar6zjxSlpi.4E0pT3qvu./POUD3m3l0SIA5uwNU6G8bLfwoNqdO', NULL, '2025-12-22 16:20:56', '2025-12-22 16:20:56'),
(89, 'Saju mia', 'dfsdf', 'sdfdsf', 'Single', 'sdf', 'sdfdsf', '300/A, North Sahajanpur,Dhaka', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '01714526354', NULL, NULL, '234234243243223', '324324324', 'Bangladeshi', 'Islam', '1997-05-02', 'o+', 'sdfsdf', 'sfsdf', 'sdfds', 'fdsfds', 'fdsf', 'sfsd', 'agent', 2, 6, 17, 'saju@gmail.com', 'customer', NULL, '$2y$12$SJPd6mYShDQFgYwpYkrpQelZYSonGovc9aFsD5GGLbrHCt6z6Pi2q', NULL, '2025-12-22 18:23:01', '2025-12-22 18:23:01'),
(90, 'dsfsdf', 'sfdds', 'fdsf', NULL, NULL, 'sdfdsf', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, '01999070234', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'agent', 2, 6, 16, 'm3768971@gmail.com', 'customer', NULL, '$2y$12$VGZq4nyf7sWd/0UZC3SZfuEaHV9AcHyXVCC49PwLDL1krekCFkCVS', NULL, '2025-12-22 18:54:46', '2025-12-22 18:54:46'),
(91, 'abul mia', 'sdfdsf', 'dsf', 'Single', 'sdf', 'dsfdsf', '300/A, North Sahajanpur,Dhaka', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '01714526354', NULL, NULL, '234234123123', '12312321', 'Bangladeshi', 'Islam', '1998-05-02', 'o+', 'dfsf', 'sdfds', '01999070234', NULL, NULL, NULL, 'agent', 2, 6, 12, 'abul@gmail.com', 'customer', NULL, '$2y$12$9AcgifP2WbifXnnxhC75Ouu3ILoVXP2cpWNZgJCLF.tN6owZrt1Se', NULL, '2025-12-22 18:55:45', '2025-12-22 18:55:45'),
(92, 'Abdullah bin', 'Bajlur rahman', 'Fatema', 'Single', 'sdf', 'Doctor', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '0192324324', '23', NULL, '2342342343243234', '24234324231111', 'Bangladeshi', 'Islam', '1988-05-02', 'o+', 'dsfdsf', 'srfsf', NULL, NULL, NULL, NULL, 'agent', 2, 6, 12, 'abcd@gmail.com', 'customer', NULL, '$2y$12$rWEa7Y3ImyU63S0OkskaZOlNXPLO3Lx4pN4CpnNAXqIIrmT.EsLB.', NULL, '2025-12-22 18:57:16', '2025-12-22 18:57:16'),
(93, 'Emon vai', 'Shajahan mia', 'shakina', 'Single', NULL, 'Student', 'Dhaka', 'Dhaka', '01815326541', '01714526354', '01815326541', '21321312321', '213213213', 'Bangladesh', 'Islam', '1998-02-05', 'o+', 'adff', 'df', '01714526354', 'mayin', 'fdsf', 'dsff', 'agent', 2, 6, 12, 'emon@gmail.com', 'customer', NULL, '$2y$12$gEvTWU1G/U8l818MOAC0hehlJ7yOtj.0TwHuERytJLsY8GoItum8m', NULL, '2025-12-23 03:53:06', '2025-12-23 03:53:06'),
(94, 'Sherin', 'Shajahan mia', 'shakina', 'Single', 'abc', 'Student', 'Dhaka', 'Dhaka', '01815322222', '01714522222', NULL, '21321312321111', NULL, 'Bangladesh', 'Islam', '1997-02-05', 'o+', 'adff', 'df', NULL, NULL, NULL, NULL, 'agent', 2, 6, 12, 'sherin@gmail.com', 'customer', NULL, '$2y$12$E1zl8RLwelO3K3747ahCU.g4EkK816Paj7AS77BeohhBrEpdj5baS', NULL, '2025-12-23 04:11:46', '2025-12-23 04:11:46'),
(95, 'Islam vaia', 'Shajahan mia', 'shakina', 'Single', 'abc', 'Student', 'Dhaka', 'Dhaka', '01815321111', '01714526354', '01815326541', '213213123212122', '23142134', 'Bangladesh', 'Islam', '1997-02-05', 'o+', 'dsd', 'rsrsd', NULL, NULL, NULL, NULL, 'admin', 2, NULL, 12, 'islam@gmail.com', 'customer', NULL, '$2y$12$ecKc33G3u3xm2OjOd0vKeudT2jjw9zjVbXG0L84KoR7vk1pO0KbXK', NULL, '2025-12-23 04:14:42', '2025-12-23 04:14:42'),
(96, 'sabuj mia', 'Shajahan mia', 'shakina', 'Single', 'abc', 'Student', 'Dhaka', 'Dhaka', '0181512334', NULL, NULL, '21321312321111', '231421341111', 'Bangladesh', 'Islam', '2000-01-05', 'o+', 'adff', 'df', NULL, NULL, NULL, NULL, 'agent', 2, 6, 12, 'sabuj@gmail.com', 'customer', NULL, '$2y$12$3105d9HZlGzD8wLBZ3JlJ.BO/Rm2XGkBCCGDRrZ17nNTljRAx/NAW', NULL, '2025-12-23 04:26:41', '2025-12-23 04:26:41');

-- --------------------------------------------------------

--
-- Table structure for table `wallet_withdraw_requests`
--

CREATE TABLE `wallet_withdraw_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_type` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `wallet_type` varchar(255) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `method` varchar(255) NOT NULL,
  `method_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`method_details`)),
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `reviewed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `reject_reason` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallet_withdraw_requests`
--

INSERT INTO `wallet_withdraw_requests` (`id`, `user_type`, `user_id`, `wallet_type`, `amount`, `method`, `method_details`, `status`, `reviewed_by`, `reviewed_at`, `reject_reason`, `created_at`, `updated_at`) VALUES
(1, 'employee', 12, 'commission', 500.00, 'bkash', '{\"account\":\"017XXXXXXXX\"}', 'approved', 10, '2025-12-14 16:01:18', NULL, '2025-12-14 15:29:15', '2025-12-14 16:01:18'),
(2, 'employee', 12, 'commission', 500.00, 'bkash', '{\"account\":\"017XXXXXXXX\"}', 'pending', NULL, NULL, NULL, '2025-12-14 15:30:02', '2025-12-14 15:30:02'),
(3, 'employee', 12, 'commission', 500.00, 'bkash', '{\"account\":\"017XXXXXXXX\"}', 'pending', NULL, NULL, NULL, '2025-12-14 15:34:03', '2025-12-14 15:34:03'),
(4, 'employee', 12, 'commission', 500.00, 'bkash', '{\"account\":\"01999070234\"}', 'approved', 10, '2025-12-14 16:19:54', NULL, '2025-12-14 15:40:31', '2025-12-14 16:19:54'),
(5, 'employee', 12, 'commission', 4001.00, 'bkash', '{\"account\":\"01999070234\"}', 'approved', 10, '2025-12-14 19:17:37', NULL, '2025-12-14 15:40:59', '2025-12-14 19:17:37'),
(6, 'agent', 6, 'commission', 500.00, 'bkash', '{\"account\":\"01999070234\"}', 'approved', 10, '2025-12-14 19:18:36', NULL, '2025-12-14 16:12:49', '2025-12-14 19:18:36'),
(7, 'employee', 12, 'commission', 500.00, 'bkash', '{\"account\":\"01766686301\"}', 'approved', 10, '2025-12-14 19:14:59', NULL, '2025-12-14 18:51:55', '2025-12-14 19:14:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject` (`subject_type`,`subject_id`),
  ADD KEY `causer` (`causer_type`,`causer_id`);

--
-- Indexes for table `agents`
--
ALTER TABLE `agents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `agents_agent_code_unique` (`agent_code`),
  ADD KEY `agents_user_id_foreign` (`user_id`),
  ADD KEY `agents_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `agent_wallets`
--
ALTER TABLE `agent_wallets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `agent_wallets_agent_id_unique` (`agent_id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `branches_code_unique` (`code`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commissions`
--
ALTER TABLE `commissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commissions_commission_rule_id_foreign` (`commission_rule_id`),
  ADD KEY `commissions_payment_id_foreign` (`payment_id`),
  ADD KEY `commissions_sales_order_id_foreign` (`sales_order_id`);

--
-- Indexes for table `commission_calculation_items`
--
ALTER TABLE `commission_calculation_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ccu_item_fk` (`commission_calculation_unit_id`);

--
-- Indexes for table `commission_calculation_units`
--
ALTER TABLE `commission_calculation_units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commission_calculation_units_payment_id_unique` (`payment_id`),
  ADD KEY `commission_calculation_units_sales_order_id_foreign` (`sales_order_id`);

--
-- Indexes for table `commission_rules`
--
ALTER TABLE `commission_rules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commission_settings`
--
ALTER TABLE `commission_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `commission_settings_key_unique` (`key`);

--
-- Indexes for table `customer_installments`
--
ALTER TABLE `customer_installments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_installments_sales_order_id_foreign` (`sales_order_id`);

--
-- Indexes for table `director_funds`
--
ALTER TABLE `director_funds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `director_funds_employee_id_type_period_start_unique` (`employee_id`,`type`,`period_start`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documents_documentable_type_documentable_id_index` (`documentable_type`,`documentable_id`),
  ADD KEY `documents_uploaded_by_foreign` (`uploaded_by`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employees_user_id_unique` (`user_id`),
  ADD UNIQUE KEY `employees_employee_code_unique` (`employee_code`),
  ADD KEY `employees_branch_id_foreign` (`branch_id`),
  ADD KEY `employees_agent_id_foreign` (`agent_id`),
  ADD KEY `employees_superior_id_foreign` (`superior_id`);

--
-- Indexes for table `employee_activities`
--
ALTER TABLE `employee_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_activities_created_by_foreign` (`created_by`),
  ADD KEY `employee_activities_customer_id_foreign` (`customer_id`),
  ADD KEY `employee_activities_sales_order_id_foreign` (`sales_order_id`),
  ADD KEY `employee_activities_employee_id_activity_date_index` (`employee_id`,`activity_date`);

--
-- Indexes for table `employee_educations`
--
ALTER TABLE `employee_educations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_educations_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `employee_nominees`
--
ALTER TABLE `employee_nominees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_nominees_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `employee_recruit_requests`
--
ALTER TABLE `employee_recruit_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_recruit_requests_requested_by_employee_id_foreign` (`requested_by_employee_id`),
  ADD KEY `employee_recruit_requests_reviewed_by_user_id_foreign` (`reviewed_by_user_id`),
  ADD KEY `employee_recruit_requests_created_employee_id_foreign` (`created_employee_id`),
  ADD KEY `employee_recruit_requests_status_index` (`status`);

--
-- Indexes for table `employee_wallets`
--
ALTER TABLE `employee_wallets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_wallets_employee_id_unique` (`employee_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `journals`
--
ALTER TABLE `journals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `journals_tx_id_unique` (`tx_id`);

--
-- Indexes for table `land_lots`
--
ALTER TABLE `land_lots`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ledger_accounts`
--
ALTER TABLE `ledger_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ledger_accounts_code_unique` (`code`);

--
-- Indexes for table `ledger_entries`
--
ALTER TABLE `ledger_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ledger_entries_account_id_foreign` (`account_id`),
  ADD KEY `ledger_entries_tx_id_index` (`tx_id`),
  ADD KEY `ledger_entries_journal_id_foreign` (`journal_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `monthly_incentives`
--
ALTER TABLE `monthly_incentives`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `monthly_incentives_employee_id_period_start_unique` (`employee_id`,`period_start`),
  ADD KEY `monthly_incentives_reviewed_by_foreign` (`reviewed_by`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_sales_order_id_foreign` (`sales_order_id`),
  ADD KEY `order_items_itemable_type_itemable_id_index` (`itemable_type`,`itemable_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_sales_order_id_foreign` (`sales_order_id`);

--
-- Indexes for table `payment_allocations`
--
ALTER TABLE `payment_allocations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_allocations_payment_id_foreign` (`payment_id`),
  ADD KEY `payment_allocations_customer_installment_id_foreign` (`customer_installment_id`);

--
-- Indexes for table `payment_intents`
--
ALTER TABLE `payment_intents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_intents_gateway_transaction_id_unique` (`gateway_transaction_id`),
  ADD KEY `payment_intents_sales_order_id_foreign` (`sales_order_id`),
  ADD KEY `payment_intents_customer_id_foreign` (`customer_id`),
  ADD KEY `payment_intents_customer_installment_id_foreign` (`customer_installment_id`);

--
-- Indexes for table `pd_special_bonuses`
--
ALTER TABLE `pd_special_bonuses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pd_special_bonuses_employee_id_month_unique` (`employee_id`,`month`),
  ADD KEY `pd_special_bonuses_month_status_index` (`month`,`status`);

--
-- Indexes for table `pd_special_month_locks`
--
ALTER TABLE `pd_special_month_locks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pd_special_month_locks_month_unique` (`month`),
  ADD KEY `pd_special_month_locks_locked_by_foreign` (`locked_by`);

--
-- Indexes for table `pd_special_selections`
--
ALTER TABLE `pd_special_selections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pd_special_selections_employee_id_month_unique` (`employee_id`,`month`),
  ADD KEY `pd_special_selections_selected_by_foreign` (`selected_by`),
  ADD KEY `pd_special_selections_month_index` (`month`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_supplier_id_foreign` (`supplier_id`);

--
-- Indexes for table `ranks`
--
ALTER TABLE `ranks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ranks_code_unique` (`code`);

--
-- Indexes for table `rank_memberships`
--
ALTER TABLE `rank_memberships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rank_memberships_agent_id_foreign` (`agent_id`);

--
-- Indexes for table `rank_requirements`
--
ALTER TABLE `rank_requirements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `rank_requirements_rank_unique` (`rank`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sales_orders`
--
ALTER TABLE `sales_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_orders_customer_id_foreign` (`customer_id`),
  ADD KEY `sales_orders_agent_id_foreign` (`agent_id`),
  ADD KEY `sales_orders_branch_id_foreign` (`branch_id`),
  ADD KEY `sales_orders_employee_id_foreign` (`employee_id`),
  ADD KEY `sales_orders_introducer_id_foreign` (`introducer_id`),
  ADD KEY `sales_orders_source_me_id_foreign` (`source_me_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `services_category_id_foreign` (`category_id`);

--
-- Indexes for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_movements_product_id_foreign` (`product_id`),
  ADD KEY `stock_movements_ref_type_ref_id_index` (`ref_type`,`ref_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supplier_payables`
--
ALTER TABLE `supplier_payables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `supplier_payables_supplier_id_payment_id_unique` (`supplier_id`,`payment_id`),
  ADD KEY `supplier_payables_payment_id_foreign` (`payment_id`),
  ADD KEY `supplier_payables_sales_order_id_foreign` (`sales_order_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_added_by_branch_id_foreign` (`added_by_branch_id`),
  ADD KEY `users_added_by_agent_id_foreign` (`added_by_agent_id`),
  ADD KEY `users_source_me_id_foreign` (`source_me_id`);

--
-- Indexes for table `wallet_withdraw_requests`
--
ALTER TABLE `wallet_withdraw_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wallet_withdraw_requests_user_type_user_id_index` (`user_type`,`user_id`),
  ADD KEY `wallet_withdraw_requests_status_index` (`status`),
  ADD KEY `wallet_withdraw_requests_method_index` (`method`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1615;

--
-- AUTO_INCREMENT for table `agents`
--
ALTER TABLE `agents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `agent_wallets`
--
ALTER TABLE `agent_wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `commissions`
--
ALTER TABLE `commissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `commission_calculation_items`
--
ALTER TABLE `commission_calculation_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `commission_calculation_units`
--
ALTER TABLE `commission_calculation_units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `commission_rules`
--
ALTER TABLE `commission_rules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `commission_settings`
--
ALTER TABLE `commission_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `customer_installments`
--
ALTER TABLE `customer_installments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=449;

--
-- AUTO_INCREMENT for table `director_funds`
--
ALTER TABLE `director_funds`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `employee_activities`
--
ALTER TABLE `employee_activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_educations`
--
ALTER TABLE `employee_educations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `employee_nominees`
--
ALTER TABLE `employee_nominees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `employee_recruit_requests`
--
ALTER TABLE `employee_recruit_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `employee_wallets`
--
ALTER TABLE `employee_wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `journals`
--
ALTER TABLE `journals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT for table `land_lots`
--
ALTER TABLE `land_lots`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ledger_accounts`
--
ALTER TABLE `ledger_accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `ledger_entries`
--
ALTER TABLE `ledger_entries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=365;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `monthly_incentives`
--
ALTER TABLE `monthly_incentives`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `payment_allocations`
--
ALTER TABLE `payment_allocations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `payment_intents`
--
ALTER TABLE `payment_intents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pd_special_bonuses`
--
ALTER TABLE `pd_special_bonuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pd_special_month_locks`
--
ALTER TABLE `pd_special_month_locks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pd_special_selections`
--
ALTER TABLE `pd_special_selections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=642;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `ranks`
--
ALTER TABLE `ranks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `rank_memberships`
--
ALTER TABLE `rank_memberships`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rank_requirements`
--
ALTER TABLE `rank_requirements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `sales_orders`
--
ALTER TABLE `sales_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `stock_movements`
--
ALTER TABLE `stock_movements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `supplier_payables`
--
ALTER TABLE `supplier_payables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `wallet_withdraw_requests`
--
ALTER TABLE `wallet_withdraw_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `agents`
--
ALTER TABLE `agents`
  ADD CONSTRAINT `agents_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `agents_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `agent_wallets`
--
ALTER TABLE `agent_wallets`
  ADD CONSTRAINT `agent_wallets_agent_id_foreign` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commissions`
--
ALTER TABLE `commissions`
  ADD CONSTRAINT `commissions_commission_rule_id_foreign` FOREIGN KEY (`commission_rule_id`) REFERENCES `commission_rules` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commissions_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `commissions_sales_order_id_foreign` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `commission_calculation_items`
--
ALTER TABLE `commission_calculation_items`
  ADD CONSTRAINT `ccu_item_fk` FOREIGN KEY (`commission_calculation_unit_id`) REFERENCES `commission_calculation_units` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commission_calculation_units`
--
ALTER TABLE `commission_calculation_units`
  ADD CONSTRAINT `commission_calculation_units_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commission_calculation_units_sales_order_id_foreign` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `customer_installments`
--
ALTER TABLE `customer_installments`
  ADD CONSTRAINT `customer_installments_sales_order_id_foreign` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `director_funds`
--
ALTER TABLE `director_funds`
  ADD CONSTRAINT `director_funds_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_agent_id_foreign` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `employees_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `employees_superior_id_foreign` FOREIGN KEY (`superior_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `employees_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `employee_activities`
--
ALTER TABLE `employee_activities`
  ADD CONSTRAINT `employee_activities_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `employee_activities_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `employee_activities_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `employee_activities_sales_order_id_foreign` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `employee_educations`
--
ALTER TABLE `employee_educations`
  ADD CONSTRAINT `employee_educations_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `employee_nominees`
--
ALTER TABLE `employee_nominees`
  ADD CONSTRAINT `employee_nominees_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `employee_recruit_requests`
--
ALTER TABLE `employee_recruit_requests`
  ADD CONSTRAINT `employee_recruit_requests_created_employee_id_foreign` FOREIGN KEY (`created_employee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `employee_recruit_requests_requested_by_employee_id_foreign` FOREIGN KEY (`requested_by_employee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `employee_recruit_requests_reviewed_by_user_id_foreign` FOREIGN KEY (`reviewed_by_user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `employee_wallets`
--
ALTER TABLE `employee_wallets`
  ADD CONSTRAINT `employee_wallets_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ledger_entries`
--
ALTER TABLE `ledger_entries`
  ADD CONSTRAINT `ledger_entries_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `ledger_accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ledger_entries_journal_id_foreign` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `monthly_incentives`
--
ALTER TABLE `monthly_incentives`
  ADD CONSTRAINT `monthly_incentives_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `monthly_incentives_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_sales_order_id_foreign` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_sales_order_id_foreign` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payment_allocations`
--
ALTER TABLE `payment_allocations`
  ADD CONSTRAINT `payment_allocations_customer_installment_id_foreign` FOREIGN KEY (`customer_installment_id`) REFERENCES `customer_installments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payment_allocations_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payment_intents`
--
ALTER TABLE `payment_intents`
  ADD CONSTRAINT `payment_intents_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payment_intents_customer_installment_id_foreign` FOREIGN KEY (`customer_installment_id`) REFERENCES `customer_installments` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `payment_intents_sales_order_id_foreign` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pd_special_bonuses`
--
ALTER TABLE `pd_special_bonuses`
  ADD CONSTRAINT `pd_special_bonuses_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);

--
-- Constraints for table `pd_special_month_locks`
--
ALTER TABLE `pd_special_month_locks`
  ADD CONSTRAINT `pd_special_month_locks_locked_by_foreign` FOREIGN KEY (`locked_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `pd_special_selections`
--
ALTER TABLE `pd_special_selections`
  ADD CONSTRAINT `pd_special_selections_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `pd_special_selections_selected_by_foreign` FOREIGN KEY (`selected_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `products_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `rank_memberships`
--
ALTER TABLE `rank_memberships`
  ADD CONSTRAINT `rank_memberships_agent_id_foreign` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `supplier_payables`
--
ALTER TABLE `supplier_payables`
  ADD CONSTRAINT `supplier_payables_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supplier_payables_sales_order_id_foreign` FOREIGN KEY (`sales_order_id`) REFERENCES `sales_orders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `supplier_payables_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
