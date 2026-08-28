"""
Tests for the banking data ingestion module.

Author: Sahand Mostafaei
"""

import sys
from pathlib import Path

import pytest


PROJECT_ROOT = Path(__file__).resolve().parent.parent
PYTHON_DIR = PROJECT_ROOT / "python"

sys.path.insert(0, str(PYTHON_DIR))

from data_ingestion import (  # noqa: E402
    read_csv_file,
    validate_required_columns,
    validate_no_empty_required_values,
)


def test_customers_csv_can_be_loaded():
    """Customers dataset should load successfully."""

    records = read_csv_file("customers.csv")

    assert len(records) == 10
    assert records[0]["customer_id"] == "1"


def test_accounts_csv_can_be_loaded():
    """Accounts dataset should load successfully."""

    records = read_csv_file("accounts.csv")

    assert len(records) == 12
    assert records[0]["account_id"] == "1001"


def test_transactions_csv_can_be_loaded():
    """Transactions dataset should load successfully."""

    records = read_csv_file("transactions.csv")

    assert len(records) == 20
    assert records[0]["transaction_id"] == "5001"


def test_loans_csv_can_be_loaded():
    """Loans dataset should load successfully."""

    records = read_csv_file("loans.csv")

    assert len(records) == 15
    assert records[0]["loan_id"] == "3001"


def test_required_columns_are_valid():
    """Required columns should be accepted."""

    records = read_csv_file("customers.csv")

    required_columns = [
        "customer_id",
        "customer_name",
        "date_of_birth",
        "city",
        "customer_segment",
    ]

    assert validate_required_columns(
        records,
        required_columns,
    )


def test_required_values_are_not_empty():
    """Required customer values should not be empty."""

    records = read_csv_file("customers.csv")

    required_columns = [
        "customer_id",
        "customer_name",
        "date_of_birth",
        "city",
        "customer_segment",
    ]

    assert validate_no_empty_required_values(
        records,
        required_columns,
    )


def test_missing_required_column_is_rejected():
    """A missing required column should raise an error."""

    records = [
        {
            "customer_id": "1",
            "customer_name": "Customer 001",
        }
    ]

    required_columns = [
        "customer_id",
        "customer_name",
        "city",
    ]

    with pytest.raises(ValueError):

        validate_required_columns(
            records,
            required_columns,
        )


def test_empty_required_value_is_rejected():
    """An empty required value should raise an error."""

    records = [
        {
            "customer_id": "1",
            "customer_name": "",
            "city": "Zurich",
        }
    ]

    required_columns = [
        "customer_id",
        "customer_name",
        "city",
    ]

    with pytest.raises(ValueError):

        validate_no_empty_required_values(
            records,
            required_columns,
        )
