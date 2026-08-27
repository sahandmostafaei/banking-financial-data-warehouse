-- Banking Financial Data Warehouse
-- Loan sample data

INSERT INTO loans (
    loan_id,
    customer_id,
    loan_type,
    loan_amount,
    interest_rate,
    loan_status,
    issue_date
)
VALUES
    (3001, 1,  'Mortgage',       250000.00, 4.25, 'Active',    '2022-03-15'),
    (3002, 2,  'Personal Loan',   15000.00, 7.50, 'Active',    '2023-01-20'),
    (3003, 3,  'Auto Loan',       32000.00, 5.75, 'Active',    '2023-04-10'),
    (3004, 4,  'Mortgage',       310000.00, 4.10, 'Active',    '2021-11-05'),
    (3005, 5,  'Personal Loan',   10000.00, 8.25, 'Paid Off',  '2020-06-18'),
    (3006, 6,  'Business Loan',  125000.00, 6.50, 'Active',    '2022-09-12'),
    (3007, 7,  'Auto Loan',       28000.00, 6.25, 'Active',    '2024-02-01'),
    (3008, 8,  'Mortgage',       225000.00, 4.50, 'Active',    '2023-07-22'),
    (3009, 9,  'Personal Loan',   18000.00, 9.00, 'Defaulted', '2021-05-14'),
    (3010, 10, 'Business Loan',   85000.00, 7.25, 'Active',    '2022-12-08'),
    (3011, 1,  'Auto Loan',       35000.00, 5.90, 'Active',    '2024-03-17'),
    (3012, 2,  'Personal Loan',   12000.00, 8.75, 'Paid Off',  '2020-10-25'),
    (3013, 1,  'Personal Loan',   20000.00, 7.80, 'Active',    '2024-01-10'),
    (3014, 3,  'Mortgage',       275000.00, 4.35, 'Active',    '2022-08-30'),
    (3015, 6,  'Auto Loan',       30000.00, 6.10, 'Active',    '2023-09-05');
