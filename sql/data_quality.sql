-- Banking Financial Data Warehouse
-- SQL data-quality checks
-- Author: Sahand Mostafaei


-- ============================================================
-- 1. Check for duplicate customer IDs
-- ============================================================

SELECT
    customer_id,
    COUNT(*) AS record_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- ============================================================
-- 2. Check for duplicate account IDs
-- ============================================================

SELECT
    account_id,
    COUNT(*) AS record_count
FROM accounts
GROUP BY account_id
HAVING COUNT(*) > 1;


-- ============================================================
-- 3. Check for duplicate transaction IDs
-- ============================================================

SELECT
    transaction_id,
    COUNT(*) AS record_count
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;


-- ============================================================
-- 4. Check for duplicate loan IDs
-- ============================================================

SELECT
    loan_id,
    COUNT(*) AS record_count
FROM loans
GROUP BY loan_id
HAVING COUNT(*) > 1;


-- ============================================================
-- 5. Check accounts without a valid customer
-- ============================================================

SELECT
    a.account_id,
    a.customer_id
FROM accounts a
LEFT JOIN customers c
    ON a.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- ============================================================
-- 6. Check transactions without a valid account
-- ============================================================

SELECT
    t.transaction_id,
    t.account_id
FROM transactions t
LEFT JOIN accounts a
    ON t.account_id = a.account_id
WHERE a.account_id IS NULL;


-- ============================================================
-- 7. Check loans without a valid customer
-- ============================================================

SELECT
    l.loan_id,
    l.customer_id
FROM loans l
LEFT JOIN customers c
    ON l.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- ============================================================
-- 8. Check negative account balances
-- ============================================================

SELECT
    account_id,
    customer_id,
    balance
FROM accounts
WHERE balance < 0;


-- ============================================================
-- 9. Check invalid loan amounts
-- ============================================================

SELECT
    loan_id,
    customer_id,
    loan_amount
FROM loans
WHERE loan_amount <= 0;


-- ============================================================
-- 10. Check invalid interest rates
-- ============================================================

SELECT
    loan_id,
    interest_rate
FROM loans
WHERE interest_rate < 0
   OR interest_rate > 100;


-- ============================================================
-- 11. Overall row-count validation
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
