-- Banking Financial Data Warehouse
-- PostgreSQL schema validation tests
-- Author: Sahand Mostafaei


-- ============================================================
-- 1. Verify required tables exist
-- ============================================================

SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN (
      'customers',
      'accounts',
      'transactions',
      'loans'
  )
ORDER BY table_name;


-- ============================================================
-- 2. Verify primary keys
-- ============================================================

SELECT
    tc.table_name,
    kcu.column_name
FROM information_schema.table_constraints AS tc

JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema

WHERE tc.constraint_type = 'PRIMARY KEY'
  AND tc.table_schema = 'public'

ORDER BY tc.table_name;


-- ============================================================
-- 3. Verify foreign keys
-- ============================================================

SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column

FROM information_schema.table_constraints AS tc

JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema

JOIN information_schema.constraint_column_usage AS ccu
    ON tc.constraint_name = ccu.constraint_name
    AND tc.table_schema = ccu.table_schema

WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'public'

ORDER BY tc.table_name;


-- ============================================================
-- 4. Verify expected row counts
-- ============================================================

SELECT
    'customers' AS table_name,
    COUNT(*) AS row_count
FROM customers

UNION ALL

SELECT
    'accounts',
    COUNT(*)
FROM accounts

UNION ALL

SELECT
    'transactions',
    COUNT(*)
FROM transactions

UNION ALL

SELECT
    'loans',
    COUNT(*)
FROM loans;
