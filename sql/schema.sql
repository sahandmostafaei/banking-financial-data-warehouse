-- Banking Financial Data Warehouse
-- PostgreSQL database schema
-- Author: Sahand Mostafaei


-- ============================================================
-- Customers
-- ============================================================

CREATE TABLE IF NOT EXISTS customers (

    customer_id INTEGER PRIMARY KEY,

    customer_name VARCHAR(100) NOT NULL,

    date_of_birth DATE,

    city VARCHAR(100),

    customer_segment VARCHAR(50),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- Accounts
-- ============================================================

CREATE TABLE IF NOT EXISTS accounts (

    account_id INTEGER PRIMARY KEY,

    customer_id INTEGER NOT NULL,

    account_type VARCHAR(50) NOT NULL,

    currency VARCHAR(10) NOT NULL,

    balance NUMERIC(15,2) DEFAULT 0,

    status VARCHAR(20) NOT NULL,

    opened_date DATE NOT NULL,

    CONSTRAINT fk_accounts_customer

        FOREIGN KEY (customer_id)

        REFERENCES customers(customer_id)
);


-- ============================================================
-- Transactions
-- ============================================================

CREATE TABLE IF NOT EXISTS transactions (

    transaction_id INTEGER PRIMARY KEY,

    account_id INTEGER NOT NULL,

    transaction_date DATE NOT NULL,

    transaction_type VARCHAR(30) NOT NULL,

    amount NUMERIC(15,2) NOT NULL,

    description VARCHAR(255),

    CONSTRAINT fk_transactions_account

        FOREIGN KEY (account_id)

        REFERENCES accounts(account_id)
);


-- ============================================================
-- Loans
-- ============================================================

CREATE TABLE IF NOT EXISTS loans (

    loan_id INTEGER PRIMARY KEY,

    customer_id INTEGER NOT NULL,

    loan_type VARCHAR(50) NOT NULL,

    loan_amount NUMERIC(15,2) NOT NULL,

    interest_rate NUMERIC(5,2) NOT NULL,

    loan_status VARCHAR(30) NOT NULL,

    issue_date DATE NOT NULL,

    CONSTRAINT fk_loans_customer

        FOREIGN KEY (customer_id)

        REFERENCES customers(customer_id)
);


-- ============================================================
-- Indexes
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_accounts_customer_id

    ON accounts(customer_id);


CREATE INDEX IF NOT EXISTS idx_transactions_account_id

    ON transactions(account_id);


CREATE INDEX IF NOT EXISTS idx_transactions_date

    ON transactions(transaction_date);


CREATE INDEX IF NOT EXISTS idx_loans_customer_id

    ON loans(customer_id);


CREATE INDEX IF NOT EXISTS idx_loans_status

    ON loans(loan_status);
