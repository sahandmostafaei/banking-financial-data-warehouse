-- Banking Financial Data Warehouse
-- Reproducible database setup and data-loading workflow
-- Author: Sahand Mostafaei

-- ============================================================
-- 1. Create database tables
-- ============================================================

-- Run schema.sql first:
-- psql -d banking_dw -f sql/schema.sql


-- ============================================================
-- 2. Load reference and transactional data
-- ============================================================

-- Run the following files in this order:
--
-- psql -d banking_dw -f sql/customers.sql
-- psql -d banking_dw -f sql/accounts.sql
-- psql -d banking_dw -f sql/transactions.sql
-- psql -d banking_dw -f sql/loans.sql


-- ============================================================
-- 3. Run banking analytics
-- ============================================================

-- Execute:
--
-- psql -d banking_dw -f sql/analytics.sql


-- ============================================================
-- Pipeline order
-- ============================================================

-- setup_database.sql
--        ↓
-- banking_dw
--        ↓
-- schema.sql
--        ↓
-- customers.sql
--        ↓
-- accounts.sql
--        ↓
-- transactions.sql
--        ↓
-- loans.sql
--        ↓
-- analytics.sql
