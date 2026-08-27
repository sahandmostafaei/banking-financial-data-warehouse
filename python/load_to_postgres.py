"""
Banking Financial Data Warehouse
PostgreSQL data loading module

Author: Sahand Mostafaei
"""

import os
from pathlib import Path

import psycopg2
from psycopg2.extras import execute_values

from data_ingestion import read_csv_file


PROJECT_ROOT = Path(__file__).resolve().parent.parent
SQL_DIR = PROJECT_ROOT / "sql"


def get_connection():
    """Create a PostgreSQL database connection."""

    return psycopg2.connect(
        host=os.getenv("POSTGRES_HOST", "localhost"),
        port=os.getenv("POSTGRES_PORT", "5432"),
        database=os.getenv("POSTGRES_DB", "banking_dw"),
        user=os.getenv("POSTGRES_USER", "postgres"),
        password=os.getenv("POSTGRES_PASSWORD"),
    )


def load_customers(cursor):
    """Load customer records into PostgreSQL."""

    records = read_csv_file("customers.csv")

    query = """
        INSERT INTO customers (
            customer_id,
            customer_name,
            date_of_birth,
            city,
            customer_segment
        )
        VALUES %s
        ON CONFLICT (customer_id) DO NOTHING;
    """

    values = [
        (
            int(row["customer_id"]),
            row["customer_name"],
            row["date_of_birth"],
            row["city"],
            row["customer_segment"],
        )
        for row in records
    ]

    execute_values(cursor, query, values)


def load_accounts(cursor):
    """Load account records into PostgreSQL."""

    records = read_csv_file("accounts.csv")

    query = """
        INSERT INTO accounts (
            account_id,
            customer_id,
            account_type,
            currency,
            balance,
            status,
            opened_date
        )
        VALUES %s
        ON CONFLICT (account_id) DO NOTHING;
    """

    values = [
        (
            int(row["account_id"]),
            int(row["customer_id"]),
            row["account_type"],
            row["currency"],
            float(row["balance"]),
            row["status"],
            row["opened_date"],
        )
        for row in records
    ]

    execute_values(cursor, query, values)


def load_transactions(cursor):
    """Load transaction records into PostgreSQL."""

    records = read_csv_file("transactions.csv")

    query = """
        INSERT INTO transactions (
            transaction_id,
            account_id,
            transaction_date,
            transaction_type,
            amount,
            description
        )
        VALUES %s
        ON CONFLICT (transaction_id) DO NOTHING;
    """

    values = [
        (
            int(row["transaction_id"]),
            int(row["account_id"]),
            row["transaction_date"],
            row["transaction_type"],
            float(row["amount"]),
            row["description"],
        )
        for row in records
    ]

    execute_values(cursor, query, values)


def load_loans(cursor):
    """Load loan records into PostgreSQL."""

    records = read_csv_file("loans.csv")

    query = """
        INSERT INTO loans (
            loan_id,
            customer_id,
            loan_type,
            loan_amount,
            interest_rate,
            loan_status,
            issue_date
        )
        VALUES %s
        ON CONFLICT (loan_id) DO NOTHING;
    """

    values = [
        (
            int(row["loan_id"]),
            int(row["customer_id"]),
            row["loan_type"],
            float(row["loan_amount"]),
            float(row["interest_rate"]),
            row["loan_status"],
            row["issue_date"],
        )
        for row in records
    ]

    execute_values(cursor, query, values)


def main():
    """Load all banking datasets into PostgreSQL."""

    connection = None

    try:
        connection = get_connection()

        cursor = connection.cursor()

        load_customers(cursor)
        load_accounts(cursor)
        load_transactions(cursor)
        load_loans(cursor)

        connection.commit()

        print("Banking datasets loaded successfully.")

    except Exception as error:

        if connection:
            connection.rollback()

        print(f"Database loading failed: {error}")
        raise

    finally:

        if connection:
            connection.close()


if __name__ == "__main__":
    main()
