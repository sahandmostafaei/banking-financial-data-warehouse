-- Banking KPI Report
-- Account and loan metrics are pre-aggregated separately
-- to prevent one-to-many joins from double-counting values.

WITH account_kpis AS (
    SELECT
        customer_id,
        COUNT(*) AS account_count,
        SUM(balance) AS total_balance,
        AVG(balance) AS average_balance
    FROM accounts
    GROUP BY customer_id
),

loan_kpis AS (
    SELECT
        customer_id,
        COUNT(*) AS loan_count,
        SUM(loan_amount) AS total_loan_amount,
        AVG(loan_amount) AS average_loan_amount
    FROM loans
    GROUP BY customer_id
)

SELECT
    c.customer_id,
    c.name,

    COALESCE(a.account_count, 0)
        AS account_count,

    COALESCE(a.total_balance, 0)
        AS total_balance,

    COALESCE(a.average_balance, 0)
        AS average_balance,

    COALESCE(l.loan_count, 0)
        AS loan_count,

    COALESCE(l.total_loan_amount, 0)
        AS total_loan_amount,

    COALESCE(l.average_loan_amount, 0)
        AS average_loan_amount

FROM customers c

LEFT JOIN account_kpis a
    ON c.customer_id = a.customer_id

LEFT JOIN loan_kpis l
    ON c.customer_id = l.customer_id

ORDER BY c.customer_id;
