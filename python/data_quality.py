"""
Banking Financial Data Warehouse
Data quality validation module

Author: Sahand Mostafaei
"""

from pathlib import Path
import csv
from typing import Dict, List


PROJECT_ROOT = Path(__file__).resolve().parent.parent
DATA_DIR = PROJECT_ROOT / "data"


DATASETS = {
    "customers": "customers.csv",
    "accounts": "accounts.csv",
    "transactions": "transactions.csv",
    "loans": "loans.csv",
}


def read_csv(filename: str) -> List[Dict[str, str]]:
    """Read a CSV file from the data directory."""

    file_path = DATA_DIR / filename

    if not file_path.exists():
        raise FileNotFoundError(
            f"File not found: {file_path}"
        )

    with file_path.open(
        mode="r",
        encoding="utf-8",
        newline=""
    ) as file:

        return list(csv.DictReader(file))


def check_empty_values(
    dataset_name: str,
    records: List[Dict[str, str]]
) -> int:
    """Count rows containing empty values."""

    errors = 0

    for row_number, record in enumerate(records, start=2):

        for column, value in record.items():

            if value is None or not value.strip():

                print(
                    f"[ERROR] {dataset_name}: "
                    f"empty value in '{column}' "
                    f"at row {row_number}"
                )

                errors += 1

    return errors


def check_duplicate_ids(
    dataset_name: str,
    records: List[Dict[str, str]],
    id_column: str
) -> int:
    """Check for duplicate primary identifiers."""

    seen = set()
    errors = 0

    for record in records:

        record_id = record[id_column]

        if record_id in seen:

            print(
                f"[ERROR] {dataset_name}: "
                f"duplicate {id_column}: {record_id}"
            )

            errors += 1

        seen.add(record_id)

    return errors


def check_non_negative(
    dataset_name: str,
    records: List[Dict[str, str]],
    column: str
) -> int:
    """Check that numeric financial values are non-negative."""

    errors = 0

    for row_number, record in enumerate(records, start=2):

        value = float(record[column])

        if value < 0:

            print(
                f"[ERROR] {dataset_name}: "
                f"negative {column} "
                f"at row {row_number}"
            )

            errors += 1

    return errors


def validate_dataset(
    dataset_name: str,
    filename: str
) -> int:
    """Run data-quality checks for one dataset."""

    records = read_csv(filename)

    errors = 0

    errors += check_empty_values(
        dataset_name,
        records
    )

    id_columns = {
        "customers": "customer_id",
        "accounts": "account_id",
        "transactions": "transaction_id",
        "loans": "loan_id",
    }

    errors += check_duplicate_ids(
        dataset_name,
        records,
        id_columns[dataset_name]
    )

    if dataset_name == "accounts":

        errors += check_non_negative(
            dataset_name,
            records,
            "balance"
        )

    elif dataset_name == "transactions":

        errors += check_non_negative(
            dataset_name,
            records,
            "amount"
        )

    elif dataset_name == "loans":

        errors += check_non_negative(
            dataset_name,
            records,
            "loan_amount"
        )

        errors += check_non_negative(
            dataset_name,
            records,
            "interest_rate"
        )

    return errors


def main() -> None:
    """Run all data-quality checks."""

    print("=" * 60)
    print("BANKING DATA QUALITY VALIDATION")
    print("=" * 60)

    total_errors = 0

    for dataset_name, filename in DATASETS.items():

        print(
            f"\nChecking {dataset_name}..."
        )

        errors = validate_dataset(
            dataset_name,
            filename
        )

        if errors == 0:

            print(
                f"[PASS] {dataset_name}"
            )

        total_errors += errors

    print("\n" + "=" * 60)

    if total_errors == 0:

        print(
            "DATA QUALITY CHECK PASSED"
        )

    else:

        print(
            f"DATA QUALITY CHECK FAILED: "
            f"{total_errors} issue(s)"
        )

    print("=" * 60)

    if total_errors > 0:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
