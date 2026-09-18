-- Banking Analytics
-- Pre-aggregate account and loan information separately
-- before joining to the customer dimension.

WITH account_summary AS (
    SELECT
        customer_id,
        COUNT(*) AS account_count,
        SUM(balance) AS total_account_balance
    FROM accounts
    GROUP BY customer_id
),

loan_summary AS (
    SELECT
        customer_id,
        COUNT(*) AS loan_count,
        SUM(loan_amount) AS total_loan_amount
    FROM loans
    GROUP BY customer_id
)

SELECT
    c.customer_id,
    c.name,
    c.city,
    c.country,

    COALESCE(a.account_count, 0)
        AS account_count,

    COALESCE(a.total_account_balance, 0)
        AS total_account_balance,

    COALESCE(l.loan_count, 0)
        AS loan_count,

    COALESCE(l.total_loan_amount, 0)
        AS total_loan_amount

FROM customers c

LEFT JOIN account_summary a
    ON c.customer_id = a.customer_id

LEFT JOIN loan_summary l
    ON c.customer_id = l.customer_id

ORDER BY c.customer_id;
