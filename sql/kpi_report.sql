-- Banking Financial Data Warehouse
-- Management KPI report
-- Author: Sahand Mostafaei


-- ============================================================
-- 1. Customer KPIs
-- ============================================================

SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE customer_segment = 'Premium'
    ) AS premium_customers,
    COUNT(*) FILTER (
        WHERE customer_segment = 'Mass Market'
    ) AS mass_market_customers
FROM customers;


-- ============================================================
-- 2. Deposit KPIs
-- ============================================================

SELECT
    COUNT(*) AS total_accounts,
    SUM(balance) AS total_deposit_balance,
    AVG(balance) AS average_account_balance,
    MAX(balance) AS largest_account_balance
FROM accounts
WHERE status = 'Active';


-- ============================================================
-- 3. Transaction KPIs
-- ============================================================

SELECT
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_transaction_value,
    AVG(amount) AS average_transaction_value,
    MAX(amount) AS largest_transaction
FROM transactions;


-- ============================================================
-- 4. Loan Portfolio KPIs
-- ============================================================

SELECT
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_exposure,
    AVG(loan_amount) AS average_loan_amount,
    AVG(interest_rate) AS average_interest_rate
FROM loans;


-- ============================================================
-- 5. Credit Risk KPIs
-- ============================================================

SELECT
    COUNT(*) AS total_loans,

    COUNT(*) FILTER (
        WHERE loan_status = 'Defaulted'
    ) AS defaulted_loans,

    SUM(loan_amount) FILTER (
        WHERE loan_status = 'Defaulted'
    ) AS defaulted_exposure,

    ROUND(
        100.0 *
        COUNT(*) FILTER (
            WHERE loan_status = 'Defaulted'
        )
        / NULLIF(COUNT(*), 0),
        2
    ) AS default_rate_percentage

FROM loans;


-- ============================================================
-- 6. Portfolio Exposure by Loan Status
-- ============================================================

SELECT
    loan_status,
    COUNT(*) AS loan_count,
    SUM(loan_amount) AS total_exposure,
    ROUND(
        100.0 * SUM(loan_amount)
        / SUM(SUM(loan_amount)) OVER (),
        2
    ) AS exposure_percentage
FROM loans
GROUP BY loan_status
ORDER BY total_exposure DESC;


-- ============================================================
-- 7. Customer Financial Exposure
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    c.customer_segment,

    COALESCE(
        SUM(DISTINCT a.balance),
        0
    ) AS deposit_balance,

    COALESCE(
        SUM(DISTINCT l.loan_amount),
        0
    ) AS loan_exposure

FROM customers c

LEFT JOIN accounts a
    ON c.customer_id = a.customer_id

LEFT JOIN loans l
    ON c.customer_id = l.customer_id

GROUP BY
    c.customer_id,
    c.customer_name,
    c.customer_segment

ORDER BY loan_exposure DESC;
