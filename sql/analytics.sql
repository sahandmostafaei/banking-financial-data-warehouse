-- Banking Financial Data Warehouse
-- Banking analytics queries
-- Author: Sahand Mostafaei


-- ============================================================
-- 1. Customer Account Summary
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(a.account_id) AS number_of_accounts,
    COALESCE(SUM(a.balance), 0) AS total_balance
FROM customers c
LEFT JOIN accounts a
    ON c.customer_id = a.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_balance DESC;


-- ============================================================
-- 2. Total Deposits by Account Type
-- ============================================================

SELECT
    account_type,
    COUNT(account_id) AS number_of_accounts,
    SUM(balance) AS total_balance,
    AVG(balance) AS average_balance
FROM accounts
GROUP BY account_type
ORDER BY total_balance DESC;


-- ============================================================
-- 3. Transaction Activity by Account
-- ============================================================

SELECT
    a.account_id,
    a.customer_id,
    COUNT(t.transaction_id) AS transaction_count,
    SUM(t.amount) AS total_transaction_value,
    AVG(t.amount) AS average_transaction_value
FROM accounts a
LEFT JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    a.account_id,
    a.customer_id
ORDER BY total_transaction_value DESC;


-- ============================================================
-- 4. Monthly Transaction Analysis
-- ============================================================

SELECT
    DATE_TRUNC('month', transaction_date) AS transaction_month,
    COUNT(transaction_id) AS transaction_count,
    SUM(amount) AS total_transaction_value,
    AVG(amount) AS average_transaction_value
FROM transactions
GROUP BY DATE_TRUNC('month', transaction_date)
ORDER BY transaction_month;


-- ============================================================
-- 5. Loan Portfolio Summary
-- ============================================================

SELECT
    loan_type,
    COUNT(loan_id) AS number_of_loans,
    SUM(loan_amount) AS total_exposure,
    AVG(loan_amount) AS average_loan_amount,
    AVG(interest_rate) AS average_interest_rate
FROM loans
GROUP BY loan_type
ORDER BY total_exposure DESC;


-- ============================================================
-- 6. Loan Status Analysis
-- ============================================================

SELECT
    loan_status,
    COUNT(loan_id) AS number_of_loans,
    SUM(loan_amount) AS total_exposure,
    ROUND(
        100.0 * COUNT(loan_id)
        / SUM(COUNT(loan_id)) OVER (),
        2
    ) AS percentage_of_loans
FROM loans
GROUP BY loan_status
ORDER BY number_of_loans DESC;


-- ============================================================
-- 7. Default Exposure
-- ============================================================

SELECT
    COUNT(loan_id) AS defaulted_loans,
    SUM(loan_amount) AS defaulted_exposure,
    AVG(loan_amount) AS average_defaulted_loan
FROM loans
WHERE loan_status = 'Defaulted';


-- ============================================================
-- 8. Customer Loan Exposure
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(l.loan_id) AS number_of_loans,
    COALESCE(SUM(l.loan_amount), 0) AS total_loan_exposure
FROM customers c
LEFT JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_loan_exposure DESC;


-- ============================================================
-- 9. Customers with Both Deposits and Loans
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(a.balance), 0) AS total_deposits,
    COALESCE(SUM(l.loan_amount), 0) AS total_loan_exposure
FROM customers c
LEFT JOIN accounts a
    ON c.customer_id = a.customer_id
LEFT JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_loan_exposure DESC;


-- ============================================================
-- 10. High-Exposure Customers
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(l.loan_amount), 0) AS total_loan_exposure
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING SUM(l.loan_amount) >= 100000
ORDER BY total_loan_exposure DESC;


-- ============================================================
-- 11. Customer Transaction Ranking
-- ============================================================

WITH customer_transactions AS (

    SELECT
        c.customer_id,
        c.customer_name,
        COUNT(t.transaction_id) AS transaction_count,
        SUM(t.amount) AS total_transaction_value
    FROM customers c
    JOIN accounts a
        ON c.customer_id = a.customer_id
    JOIN transactions t
        ON a.account_id = t.account_id
    GROUP BY
        c.customer_id,
        c.customer_name
)

SELECT
    customer_id,
    customer_name,
    transaction_count,
    total_transaction_value,
    RANK() OVER (
        ORDER BY total_transaction_value DESC
    ) AS transaction_rank
FROM customer_transactions
ORDER BY transaction_rank;


-- ============================================================
-- 12. Loan Risk Classification
-- ============================================================

SELECT
    loan_id,
    customer_id,
    loan_type,
    loan_amount,
    interest_rate,
    loan_status,
    CASE
        WHEN loan_status = 'Defaulted'
            THEN 'High Risk'
        WHEN interest_rate >= 8
            THEN 'Elevated Risk'
        WHEN interest_rate >= 6
            THEN 'Moderate Risk'
        ELSE 'Lower Risk'
    END AS risk_category
FROM loans
ORDER BY loan_amount DESC;
