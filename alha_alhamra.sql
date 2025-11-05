-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 05, 2025 at 05:04 AM
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
(275, 'audit', 'updated', 'updated', 'App\\Models\\Payment', 5, 'App\\Models\\User', 10, '{\"attributes\":{\"commission_processed_at\":\"2025-11-04T18:49:15.000000Z\"},\"old\":{\"commission_processed_at\":null}}', NULL, '2025-11-04 18:49:15', '2025-11-04 18:49:15');

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
(6, 52, 2, 'AGT-0001', '01999070234', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-04 16:35:54', '2025-11-04 16:35:54');

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

INSERT INTO `commissions` (`id`, `commission_rule_id`, `payment_id`, `sales_order_id`, `recipient_type`, `recipient_id`, `amount`, `status`, `paid_at`, `meta`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 1, 'App\\Models\\Agent', 6, 3000.00, 'paid', '2025-11-04 18:29:25', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"calculation_unit_id\":1,\"calculation_item_id\":1,\"order_created_by\":\"agent\"}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(2, NULL, 2, 3, 'App\\Models\\Employee', 16, 7100.00, 'paid', '2025-11-04 18:29:25', '{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":10,\"calculation_unit_id\":2,\"calculation_item_id\":2,\"order_created_by\":\"admin\",\"source_me_id\":16}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(3, NULL, 2, 3, 'App\\Models\\Employee', 15, 3550.00, 'paid', '2025-11-04 18:29:25', '{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":2,\"calculation_item_id\":3,\"order_created_by\":\"admin\",\"source_me_id\":16}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(4, NULL, 2, 3, 'App\\Models\\Employee', 14, 3550.00, 'paid', '2025-11-04 18:29:25', '{\"category\":\"development_bonus\",\"rank\":\"AGM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":2,\"calculation_item_id\":4,\"order_created_by\":\"admin\",\"source_me_id\":16}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(5, NULL, 2, 3, 'App\\Models\\Employee', 13, 3550.00, 'paid', '2025-11-04 18:29:25', '{\"category\":\"development_bonus\",\"rank\":\"DGM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":2,\"calculation_item_id\":5,\"order_created_by\":\"admin\",\"source_me_id\":16}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(6, NULL, 2, 3, 'App\\Models\\Employee', 12, 3550.00, 'paid', '2025-11-04 18:29:25', '{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":5,\"calculation_unit_id\":2,\"calculation_item_id\":6,\"order_created_by\":\"admin\",\"source_me_id\":16}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(7, NULL, 3, 4, 'App\\Models\\Agent', 6, 1000.00, 'paid', '2025-11-04 18:29:25', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":3,\"calculation_item_id\":7,\"order_created_by\":\"agent\"}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(8, NULL, 4, 5, 'App\\Models\\Employee', 19, 3000.00, 'paid', '2025-11-04 18:29:25', '{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":10,\"recipient_name\":\"SABBIR MIA\",\"calculation_unit_id\":4,\"calculation_item_id\":8,\"order_created_by\":\"admin\",\"source_me_id\":19}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(9, NULL, 4, 5, 'App\\Models\\Employee', 12, 6000.00, 'paid', '2025-11-04 18:29:25', '{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":20,\"recipient_name\":\"ZAMAN MIA\",\"calculation_unit_id\":4,\"calculation_item_id\":9,\"order_created_by\":\"admin\",\"source_me_id\":19}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(10, NULL, 5, 6, 'App\\Models\\Agent', 6, 1000.00, 'paid', '2025-11-04 18:49:15', '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\",\"calculation_unit_id\":5,\"calculation_item_id\":10,\"order_created_by\":\"agent\"}', '2025-11-04 18:49:15', '2025-11-04 18:49:15');

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
(1, 1, 'App\\Models\\Agent', 6, 3000.00, NULL, '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\"}', '2025-11-04 17:33:59', '2025-11-04 17:33:59'),
(2, 2, 'App\\Models\\Employee', 16, 7100.00, 10.000, '{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":10}', '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(3, 2, 'App\\Models\\Employee', 15, 3550.00, 5.000, '{\"category\":\"development_bonus\",\"rank\":\"MM\",\"payment_type\":\"down_payment\",\"percentage\":5}', '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(4, 2, 'App\\Models\\Employee', 14, 3550.00, 5.000, '{\"category\":\"development_bonus\",\"rank\":\"AGM\",\"payment_type\":\"down_payment\",\"percentage\":5}', '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(5, 2, 'App\\Models\\Employee', 13, 3550.00, 5.000, '{\"category\":\"development_bonus\",\"rank\":\"DGM\",\"payment_type\":\"down_payment\",\"percentage\":5}', '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(6, 2, 'App\\Models\\Employee', 12, 3550.00, 5.000, '{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":5}', '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(7, 3, 'App\\Models\\Agent', 6, 1000.00, 5.000, '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\"}', '2025-11-04 18:10:29', '2025-11-04 18:10:29'),
(8, 4, 'App\\Models\\Employee', 19, 3000.00, 10.000, '{\"category\":\"development_bonus\",\"rank\":\"ME\",\"payment_type\":\"down_payment\",\"percentage\":10,\"recipient_name\":\"SABBIR MIA\"}', '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(9, 4, 'App\\Models\\Employee', 12, 6000.00, 20.000, '{\"category\":\"development_bonus\",\"rank\":\"GM\",\"payment_type\":\"down_payment\",\"percentage\":20,\"recipient_name\":\"ZAMAN MIA\"}', '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(10, 5, 'App\\Models\\Agent', 6, 1000.00, 5.000, '{\"category\":\"agent_commission\",\"payment_type\":\"down_payment\",\"percentage\":5,\"recipient_name\":\"MD MAYIN UDDIN\"}', '2025-11-04 18:48:21', '2025-11-04 18:48:21');

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
(1, 1, 1, 'paid', '2025-11-04 17:33:59', '2025-11-04 18:29:25', '{\"commissionable_amount\":60000,\"payment_type\":\"down_payment\",\"order_created_by\":\"agent\"}', '2025-11-04 17:33:59', '2025-11-04 18:29:25'),
(2, 2, 3, 'paid', '2025-11-04 17:37:45', '2025-11-04 18:29:25', '{\"commissionable_amount\":71000,\"payment_type\":\"down_payment\",\"order_created_by\":\"admin\"}', '2025-11-04 17:37:45', '2025-11-04 18:29:25'),
(3, 3, 4, 'paid', '2025-11-04 18:10:29', '2025-11-04 18:29:25', '{\"commissionable_amount\":20000,\"payment_type\":\"down_payment\",\"order_created_by\":\"agent\"}', '2025-11-04 18:10:29', '2025-11-04 18:29:25'),
(4, 4, 5, 'paid', '2025-11-04 18:13:15', '2025-11-04 18:29:25', '{\"commissionable_amount\":30000,\"payment_type\":\"down_payment\",\"order_created_by\":\"admin\"}', '2025-11-04 18:13:15', '2025-11-04 18:29:25'),
(5, 5, 6, 'paid', '2025-11-04 18:48:21', '2025-11-04 18:49:15', '{\"commissionable_amount\":20000,\"payment_type\":\"down_payment\",\"order_created_by\":\"agent\"}', '2025-11-04 18:48:21', '2025-11-04 18:49:15');

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
(6, 'Owner 01 Down Payment Share', 'any', 'on_payment', 'App\\Models\\User', 6, 2.50, NULL, 1, '{\"applies_to\":\"down_payment\",\"owner_position\":\"owner_01\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:06'),
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
(2, 'agent_rates', '{\"down_payment\":5,\"installment\":1}', '2025-10-20 13:59:03', '2025-11-04 17:33:10'),
(3, 'branch_rates', '{\"down_payment\":5,\"installment\":1}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(4, 'development_bonus', '{\"ME\":{\"down_payment\":10,\"installment\":4},\"MM\":{\"down_payment\":15,\"installment\":5},\"AGM\":{\"down_payment\":20,\"installment\":6},\"DGM\":{\"down_payment\":25,\"installment\":9},\"GM\":{\"down_payment\":30,\"installment\":11}}', '2025-10-20 13:59:03', '2025-11-03 15:29:01'),
(5, 'monthly_incentives', '{\"MM\":10000,\"AGM\":20000,\"DGM\":40000,\"GM\":100000,\"PD\":200000,\"ED\":200000,\"DMD\":200000,\"DIR\":200000}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(6, 'director_fund', '{\"PD\":{\"percentage\":2,\"frequency\":\"quarterly\"},\"ED\":{\"percentage\":2,\"frequency\":\"half_yearly\"},\"DMD\":{\"percentage\":1,\"frequency\":\"yearly\"},\"DIR\":{\"percentage\":20,\"per_person_share\":1}}', '2025-10-20 13:59:03', '2025-11-04 17:32:02'),
(7, 'service_sales', '{\"percentage\":15}', '2025-10-20 13:59:03', '2025-10-20 13:59:03');

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
(2, 3, '2025-11-09', 629000.00, 0.00, 'partial', '2025-11-04 17:37:30', '2025-11-04 17:37:45'),
(3, 4, '2025-11-09', 180000.00, 0.00, 'partial', '2025-11-04 18:10:15', '2025-11-04 18:10:29'),
(4, 5, '2025-11-09', 270000.00, 0.00, 'partial', '2025-11-04 18:13:05', '2025-11-04 18:13:15'),
(5, 6, '2025-11-09', 180000.00, 0.00, 'partial', '2025-11-04 18:48:02', '2025-11-04 18:48:21');

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
(12, 'AL-0001', 'ZAMAN MIA', 'ZAMAN MIA', 'JAEHR', 'JAHURA', '01999070431', '12321312321', '1997-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, NULL, NULL, NULL, 42, 2, NULL, NULL, 'GM', '2025-11-03 15:36:33', '2025-11-03 15:36:33'),
(13, 'AL-00004', 'SAKIL AL', 'SAKIL AL', 'SHAJAHAN', 'SHAJEDA', '01999072133123', '123123123', '1997-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, NULL, NULL, NULL, 43, 2, NULL, 12, 'DGM', '2025-11-03 15:38:47', '2025-11-03 15:38:47'),
(14, 'AL-0005', 'SABBIR RAHMAN', 'SABBIR RAHMAN', 'SHAKIA', 'SHAJEDA', '019990123123', '213123123123', '1997-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, NULL, NULL, NULL, 44, 2, NULL, 13, 'AGM', '2025-11-03 15:40:57', '2025-11-03 15:40:57'),
(15, 'AL-0006', 'MOJAHID', 'MOJAHID', 'Mohkka', 'Mosada', '019990723333', '23324324', '1998-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, NULL, NULL, NULL, 45, 2, NULL, 14, 'MM', '2025-11-03 15:42:10', '2025-11-03 15:42:10'),
(16, 'AL-0007', 'JAKARIA', 'JAKARIA', 'Jafor mia', 'Sajeda', '01999071213', '21321321321', '1997-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, NULL, NULL, NULL, 46, 2, NULL, 15, 'ME', '2025-11-03 15:44:14', '2025-11-03 18:31:22'),
(17, 'AL-00008', 'ABDULLAH', 'ABDULLAH', 'SAKIN', 'SHAKINA BIBI', '01999071222', '12345678122', '1998-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, NULL, NULL, NULL, 47, 2, NULL, 16, 'ME', '2025-11-03 15:50:44', '2025-11-03 15:50:44'),
(19, 'AL-00010', 'SABBIR MIA', 'SABBIR MIA', 'SAJED', 'SHAJEDA BEGUM', '0199222121', '13123123123', '1998-05-02', 'Single', 'Islam', 'Male', 'Bangladeshi', NULL, NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', NULL, 50, 2, NULL, 12, 'ME', '2025-11-04 15:52:07', '2025-11-04 15:52:07');

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
(7, 19, 'Bachelor/Honours', NULL, 'CSE', '3.56', '2025', '2025-11-04 15:52:07', '2025-11-04 15:52:07');

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
(8, 19, 'MD MAYIN UDDIN', 'Brother', '01999070234', NULL, 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '2025-11-04 15:52:07', '2025-11-04 15:52:07');

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
(1, 19, 3000.00, '2025-11-04 18:28:53', '2025-11-04 18:29:25'),
(2, 16, 7100.00, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(3, 15, 3550.00, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(4, 14, 3550.00, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(5, 13, 3550.00, '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(6, 12, 9550.00, '2025-11-04 18:29:25', '2025-11-04 18:29:25');

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
(1, '101', 'Cash', 'asset', '{\"key\":\"cash\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(2, '102', 'Bank', 'asset', '{\"key\":\"bank\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(3, '110', 'Accounts Receivable', 'asset', '{\"key\":\"accounts_receivable\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(4, '510', 'Commission Expense', 'expense', '{\"key\":\"commission_expense\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(5, '210', 'Commission Payable', 'liability', '{\"key\":\"commission_payable\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(6, '220', 'Incentive Fund Payable', 'liability', '{\"key\":\"incentive_fund\"}', '2025-10-20 13:59:03', '2025-10-20 13:59:03');

-- --------------------------------------------------------

--
-- Table structure for table `ledger_entries`
--

CREATE TABLE `ledger_entries` (
  `id` bigint(20) UNSIGNED NOT NULL,
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

INSERT INTO `ledger_entries` (`id`, `tx_id`, `account_id`, `debit`, `credit`, `occurred_at`, `meta`, `created_at`, `updated_at`) VALUES
(1, 'PMT-1', 1, 60000.00, 0.00, '2025-11-04 00:00:00', '{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"cash\"}', '2025-11-04 17:33:59', '2025-11-04 17:33:59'),
(2, 'PMT-1', 3, 0.00, 60000.00, '2025-11-04 00:00:00', '{\"payment_id\":1,\"sales_order_id\":1,\"method\":\"cash\"}', '2025-11-04 17:33:59', '2025-11-04 17:33:59'),
(3, 'PMT-2', 1, 71000.00, 0.00, '2025-11-04 00:00:00', '{\"payment_id\":2,\"sales_order_id\":3,\"method\":\"cash\"}', '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(4, 'PMT-2', 3, 0.00, 71000.00, '2025-11-04 00:00:00', '{\"payment_id\":2,\"sales_order_id\":3,\"method\":\"cash\"}', '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(5, 'PMT-3', 1, 20000.00, 0.00, '2025-11-04 00:00:00', '{\"payment_id\":3,\"sales_order_id\":4,\"method\":\"cash\"}', '2025-11-04 18:10:28', '2025-11-04 18:10:28'),
(6, 'PMT-3', 3, 0.00, 20000.00, '2025-11-04 00:00:00', '{\"payment_id\":3,\"sales_order_id\":4,\"method\":\"cash\"}', '2025-11-04 18:10:29', '2025-11-04 18:10:29'),
(7, 'PMT-4', 1, 30000.00, 0.00, '2025-11-04 00:00:00', '{\"payment_id\":4,\"sales_order_id\":5,\"method\":\"cash\"}', '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(8, 'PMT-4', 3, 0.00, 30000.00, '2025-11-04 00:00:00', '{\"payment_id\":4,\"sales_order_id\":5,\"method\":\"cash\"}', '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(9, 'CMS-1', 4, 3000.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(10, 'CMS-1', 5, 0.00, 3000.00, '2025-11-04 18:29:25', '{\"commission_id\":1,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(11, 'CMS-2', 4, 7100.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(12, 'CMS-2', 5, 0.00, 7100.00, '2025-11-04 18:29:25', '{\"commission_id\":2,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":16}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(13, 'CMS-3', 4, 3550.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":15}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(14, 'CMS-3', 5, 0.00, 3550.00, '2025-11-04 18:29:25', '{\"commission_id\":3,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":15}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(15, 'CMS-4', 4, 3550.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(16, 'CMS-4', 5, 0.00, 3550.00, '2025-11-04 18:29:25', '{\"commission_id\":4,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":14}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(17, 'CMS-5', 4, 3550.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":5,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(18, 'CMS-5', 5, 0.00, 3550.00, '2025-11-04 18:29:25', '{\"commission_id\":5,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":13}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(19, 'CMS-6', 4, 3550.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":6,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(20, 'CMS-6', 5, 0.00, 3550.00, '2025-11-04 18:29:25', '{\"commission_id\":6,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(21, 'CMS-7', 4, 1000.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(22, 'CMS-7', 5, 0.00, 1000.00, '2025-11-04 18:29:25', '{\"commission_id\":7,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(23, 'CMS-8', 4, 3000.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(24, 'CMS-8', 5, 0.00, 3000.00, '2025-11-04 18:29:25', '{\"commission_id\":8,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":19}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(25, 'CMS-9', 4, 6000.00, 0.00, '2025-11-04 18:29:25', '{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(26, 'CMS-9', 5, 0.00, 6000.00, '2025-11-04 18:29:25', '{\"commission_id\":9,\"recipient_type\":\"App\\\\Models\\\\Employee\",\"recipient_id\":12}', '2025-11-04 18:29:25', '2025-11-04 18:29:25'),
(27, 'PMT-5', 1, 20000.00, 0.00, '2025-11-04 00:00:00', '{\"payment_id\":5,\"sales_order_id\":6,\"method\":\"cash\"}', '2025-11-04 18:48:21', '2025-11-04 18:48:21'),
(28, 'PMT-5', 3, 0.00, 20000.00, '2025-11-04 00:00:00', '{\"payment_id\":5,\"sales_order_id\":6,\"method\":\"cash\"}', '2025-11-04 18:48:21', '2025-11-04 18:48:21'),
(29, 'CMS-10', 4, 1000.00, 0.00, '2025-11-04 18:49:15', '{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-04 18:49:15', '2025-11-04 18:49:15'),
(30, 'CMS-10', 5, 0.00, 1000.00, '2025-11-04 18:49:15', '{\"commission_id\":10,\"recipient_type\":\"App\\\\Models\\\\Agent\",\"recipient_id\":6}', '2025-11-04 18:49:15', '2025-11-04 18:49:15');

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
(45, '2025_11_01_000000_create_employee_activities_table', 5);

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
(9, 'App\\Models\\User', 50);

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
(3, 3, 'App\\Models\\Product', 1, 1, 700000.00, 700000.00, '2025-11-04 17:37:24', '2025-11-04 17:37:24'),
(4, 4, 'App\\Models\\Product', 1, 1, 200000.00, 200000.00, '2025-11-04 18:10:10', '2025-11-04 18:10:10'),
(5, 5, 'App\\Models\\Product', 1, 1, 300000.00, 300000.00, '2025-11-04 18:13:01', '2025-11-04 18:13:01'),
(6, 6, 'App\\Models\\Product', 1, 1, 200000.00, 200000.00, '2025-11-04 18:47:58', '2025-11-04 18:47:58');

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
  `type` enum('down_payment','installment','full_payment') NOT NULL DEFAULT 'installment',
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
(2, 3, '2025-11-04', 71000.00, NULL, '2025-11-04 18:29:25', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"12321312\"}', '2025-11-04 17:37:45', '2025-11-04 18:29:25'),
(3, 4, '2025-11-04', 20000.00, NULL, '2025-11-04 18:29:25', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"111111\"}', '2025-11-04 18:10:28', '2025-11-04 18:29:25'),
(4, 5, '2025-11-04', 30000.00, NULL, '2025-11-04 18:29:25', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"2121\"}', '2025-11-04 18:13:15', '2025-11-04 18:29:25'),
(5, 6, '2025-11-04', 20000.00, NULL, '2025-11-04 18:49:15', 'down_payment', 'down_payment', 'cash', '{\"reference\":\"11212\"}', '2025-11-04 18:48:21', '2025-11-04 18:49:15');

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
(2, 2, 2, 0.00, '2025-11-04 17:37:45', '2025-11-04 17:37:45'),
(3, 3, 3, 0.00, '2025-11-04 18:10:29', '2025-11-04 18:10:29'),
(4, 4, 4, 0.00, '2025-11-04 18:13:15', '2025-11-04 18:13:15'),
(5, 5, 5, 0.00, '2025-11-04 18:48:21', '2025-11-04 18:48:21');

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
(128, 'App\\Models\\User', 10, 'api_token', '5aa4d4adec83c2c1427939d9a5f725d3e152b58c95c70851c9e1bf4a88f7d450', '[\"*\"]', '2025-10-31 20:28:57', NULL, '2025-10-30 19:46:10', '2025-10-31 20:28:57'),
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
(237, 'App\\Models\\User', 10, 'api_token', 'c1de11ccc3c3566048ace98b460d8ac2226da7fc2b2b0d2b5c749153412eb4b6', '[\"*\"]', '2025-11-04 18:31:34', NULL, '2025-11-04 18:29:09', '2025-11-04 18:31:34'),
(240, 'App\\Models\\User', 50, 'api_token', '2864fc5fe7637d0322f14ab3ef4bb2de5c292b032a6fb749682a3b984d1716d3', '[\"*\"]', '2025-11-04 18:31:46', NULL, '2025-11-04 18:31:44', '2025-11-04 18:31:46'),
(248, 'App\\Models\\User', 42, 'api_token', '15e5c5ac5f110a282f70dbd75584e5806a15281d39305a11e9d5b1007f02a451', '[\"*\"]', '2025-11-04 18:58:39', NULL, '2025-11-04 18:58:38', '2025-11-04 18:58:39'),
(249, 'App\\Models\\User', 10, 'api_token', 'b71a9df9c597f3535f17dc77932fcee5b2a9d3f8652b30914e16859ae3057c03', '[\"*\"]', '2025-11-04 19:10:21', NULL, '2025-11-04 19:10:13', '2025-11-04 19:10:21'),
(252, 'App\\Models\\User', 42, 'api_token', '1a8b6fd943c243d00e155edc69e982c4316dffb91f482f91bcc288575af9291e', '[\"*\"]', '2025-11-04 19:32:38', NULL, '2025-11-04 19:12:32', '2025-11-04 19:32:38'),
(253, 'App\\Models\\User', 51, 'api_token', '5b593a0ac36836dd9722faf7f17b0ec9b47208b6ad9f2054bdfd7bc4a2c69ed6', '[\"*\"]', NULL, NULL, '2025-11-04 19:39:31', '2025-11-04 19:39:31'),
(254, 'App\\Models\\User', 10, 'api_token', 'd2058fdb02913f3ca11adc7f3f1b8a880d5b285c0f3d7043faeb8eb8225152a2', '[\"*\"]', '2025-11-04 20:08:51', NULL, '2025-11-04 19:40:47', '2025-11-04 20:08:51'),
(255, 'App\\Models\\User', 10, 'api_token', '03cdfc8555534b729c4085b53dcf1f2666e51ce41e1c8f0ff6ff9936512c9e7e', '[\"*\"]', '2025-11-05 04:57:26', NULL, '2025-11-05 04:54:24', '2025-11-05 04:57:26');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `product_type` enum('small','big','land','share','other') NOT NULL,
  `price` decimal(14,2) NOT NULL DEFAULT 0.00,
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

INSERT INTO `products` (`id`, `category_id`, `name`, `product_type`, `price`, `attributes`, `created_at`, `updated_at`, `stock_qty`, `min_stock_alert`, `is_stock_managed`) VALUES
(1, 1, 'Bashundhara Residential Plot', 'land', 5000000.00, '{\"size\":\"5 katha\",\"location\":\"Bashundhara Block D\"}', '2025-10-20 13:59:05', '2025-10-20 13:59:05', 10.00, 1.00, 1),
(2, 2, 'Premium Apartment Unit', 'big', 8000000.00, '{\"bedrooms\":4,\"bathrooms\":3}', '2025-10-20 13:59:05', '2025-11-04 16:44:02', -17.00, 1.00, 1),
(3, 10, 'ma-shopnoo bilash', 'land', 1000000.00, NULL, '2025-10-31 17:42:03', '2025-10-31 17:42:03', 5.00, 2.00, 0);

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
(6, 'PD', 'Project Director', NULL, 6, '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(7, 'ED', 'Executive Director', NULL, 7, '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(8, 'DMD', 'Deputy Managing Director', NULL, 8, '2025-10-20 13:59:03', '2025-10-20 13:59:03'),
(9, 'DIR', 'Director', NULL, 9, '2025-10-20 13:59:03', '2025-10-20 13:59:03');

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
(3, 'AGM', 3, 250000.00, 18.00, 6.00, 0, '{\"shares_required\":5,\"minimum_share_per_period\":1,\"period_months\":4,\"monthly_incentive\":20000}', '2025-10-20 13:59:03', '2025-11-03 17:51:52'),
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
  `down_payment` decimal(14,2) NOT NULL DEFAULT 0.00,
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
(3, 48, 16, 16, 'admin', NULL, 'order', 'ME', NULL, 2, 71000.00, 700000.00, 'active', '2025-11-04 17:37:24', '2025-11-04 17:37:24'),
(4, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 20000.00, 200000.00, 'active', '2025-11-04 18:10:10', '2025-11-04 18:10:10'),
(5, 51, 19, 19, 'admin', NULL, 'order', 'ME', NULL, 2, 30000.00, 300000.00, 'active', '2025-11-04 18:13:01', '2025-11-04 18:13:01'),
(6, 53, NULL, NULL, 'agent', 6, 'order', NULL, NULL, 2, 20000.00, 200000.00, 'active', '2025-11-04 18:47:58', '2025-11-04 18:47:58');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(14,2) NOT NULL DEFAULT 0.00,
  `attributes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attributes`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `category_id`, `name`, `price`, `attributes`, `created_at`, `updated_at`) VALUES
(1, 8, 'Premium Hajj Package', 800000.00, '{\"duration\":\"30 days\",\"includes\":[\"visa\",\"hotel\",\"transport\"]}', '2025-10-20 13:59:05', '2025-10-20 13:59:05'),
(2, 9, 'Tour', 50000.00, '{\"duration\":\"5\",\"location\":\"Dhaka,Hirajeel\",\"includes\":[]}', '2025-10-22 18:43:57', '2025-10-22 18:43:57');

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
(44, 'SABBIR RAHMAN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'mayidiu@gmail.com', 'employee', NULL, '$2y$12$wCHd0c/zOFD.YsiE.ATev.mEMB34vlRsOl7ZyCYIJrN8qrEvv6Z0a', NULL, '2025-11-03 15:40:57', '2025-11-03 15:40:57'),
(45, 'MOJAHID', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'fahadbinbashar@gmail.com', 'employee', NULL, '$2y$12$OHxiLiJOFpc3s79gZxLvwuzcPcwWYOkVNPUkBFHl4Rqi/7hVzIWEq', NULL, '2025-11-03 15:42:10', '2025-11-03 15:42:10'),
(46, 'JAKARIA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'abc@gmail.com', 'employee', NULL, '$2y$12$akUTTMj4Z0esAl/JloKOT.T08ENKZfkU1e/5SMK7U8CE0HVJGV9I2', NULL, '2025-11-03 15:44:14', '2025-11-03 15:44:14'),
(47, 'ABDULLAH', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'abdullah1@gmail.com', 'employee', NULL, '$2y$12$QBUdY/OqRRiJTY8YXGgxke/rAZf2/PBky6QK4cbET/JN1zmneJaGG', NULL, '2025-11-03 15:50:44', '2025-11-03 15:50:44'),
(48, 'Asif Bin Mostafa', 'SABBIR', 'SHAKIN', 'Single', 'sdf', 'Student', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '019990701233', NULL, NULL, '234234234324111', '2423432423111', 'Bangladeshi', 'Islam', '1998-05-02', 'o+', 'Sabina', 'Husband', '01999070234', NULL, NULL, NULL, 'admin', 2, NULL, 16, 'cus@gmail.com', 'customer', NULL, '$2y$12$akUTTMj4Z0esAl/JloKOT.T08ENKZfkU1e/5SMK7U8CE0HVJGV9I2', NULL, '2025-11-03 15:54:01', '2025-11-03 15:54:01'),
(49, 'dsfsf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'aea@gmail.com', 'employee', NULL, '$2y$12$p82UtOdvGBuEb9cq6PuM9e95.tYYux/urytXr.xNnDifZ1eZKdLoa', NULL, '2025-11-03 16:39:25', '2025-11-03 16:39:25'),
(50, 'SABBIR MIA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'sabbir@gmail.com', 'employee', NULL, '$2y$12$slGM43tVVOmXCZHMzC9Md.vnUOtg3tMJexIr4HL7E/Ci1MWcJ/cpa', NULL, '2025-11-04 15:52:07', '2025-11-04 15:52:07'),
(51, 'Jahangir Alam', 'Shaid', 'Shakina', 'Single', 'Ssss', 'Student', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '019991232131', NULL, NULL, '234234234324122', '24234324231111', 'Bangladeshi', 'Islam', '1997-05-02', 'o+', 'Sabina', 'Husband', '0199901222', NULL, NULL, NULL, 'admin', 2, NULL, 19, 'jahangir@gmail.com', 'customer', NULL, '$2y$12$TEHT/IdPmeKSiQrg4MWdauRLemXD5iyQWSncMeE45rgERQ2vCoH3u', NULL, '2025-11-04 15:54:03', '2025-11-04 15:54:03'),
(52, 'MD MAYIN UDDIN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'mayinuddin768971@gmail.com', 'agent', NULL, '$2y$12$Cp4jELH8FukFxiIATi1biOVPKG8tvDrab4irYTS2o12OKRDH4Kzfy', NULL, '2025-11-04 16:35:54', '2025-11-04 16:35:54'),
(53, 'Sakib Al Hasan', 'Bajlur rahman', 'Fatema', 'Single', 'sdf', 'Doctor', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', 'CHAIRMAN BARI, KISMAT,SADAR SOUTH,CUMILLA-3503', '01999324324', NULL, NULL, '2342323334232', '242343242311132', 'Bangladeshi', 'Islam', '1998-05-02', 'o+', 'Sabina', 'Husband', '01999070234', 'fsdf', NULL, NULL, 'agent', 2, 6, NULL, 'sakib@gmail.com', 'customer', NULL, '$2y$12$anbFrwZ.EI8KCJLWZrU8dePUMlYQZkW0yNLPdP0vQ/.7oZsISfNQ2', NULL, '2025-11-04 16:37:20', '2025-11-04 16:37:20');

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
  ADD KEY `ledger_entries_tx_id_index` (`tx_id`);

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
  ADD KEY `products_category_id_foreign` (`category_id`);

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
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_added_by_branch_id_foreign` (`added_by_branch_id`),
  ADD KEY `users_added_by_agent_id_foreign` (`added_by_agent_id`),
  ADD KEY `users_source_me_id_foreign` (`source_me_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=276;

--
-- AUTO_INCREMENT for table `agents`
--
ALTER TABLE `agents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `commission_calculation_items`
--
ALTER TABLE `commission_calculation_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `commission_calculation_units`
--
ALTER TABLE `commission_calculation_units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `commission_rules`
--
ALTER TABLE `commission_rules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `commission_settings`
--
ALTER TABLE `commission_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customer_installments`
--
ALTER TABLE `customer_installments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `employee_activities`
--
ALTER TABLE `employee_activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_educations`
--
ALTER TABLE `employee_educations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `employee_nominees`
--
ALTER TABLE `employee_nominees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `employee_wallets`
--
ALTER TABLE `employee_wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `land_lots`
--
ALTER TABLE `land_lots`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ledger_accounts`
--
ALTER TABLE `ledger_accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ledger_entries`
--
ALTER TABLE `ledger_entries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payment_allocations`
--
ALTER TABLE `payment_allocations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payment_intents`
--
ALTER TABLE `payment_intents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=256;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ranks`
--
ALTER TABLE `ranks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `stock_movements`
--
ALTER TABLE `stock_movements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

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
-- Constraints for table `employee_wallets`
--
ALTER TABLE `employee_wallets`
  ADD CONSTRAINT `employee_wallets_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ledger_entries`
--
ALTER TABLE `ledger_entries`
  ADD CONSTRAINT `ledger_entries_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `ledger_accounts` (`id`) ON DELETE CASCADE;

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
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
