"""
Banking Financial Data Warehouse
Data ingestion and validation module

Author: Sahand Mostafaei
"""

from pathlib import Path
import csv
from typing import Dict, List


PROJECT_ROOT = Path(__file__).resolve().parent.parent
DATA_DIR = PROJECT_ROOT / "data"


DATASETS = {
    "customers": {
        "filename": "customers.csv",
        "required_columns": [
            "customer_id",
            "customer_name",
            "date_of_birth",
            "city",
            "customer_segment",
        ],
    },
    "accounts": {
        "filename": "accounts.csv",
        "required_columns": [
            "account_id",
            "customer_id",
            "account_type",
            "currency",
            "balance",
            "status",
            "opened_date",
        ],
    },
    "transactions": {
        "filename": "transactions.csv",
        "required_columns": [
            "transaction_id",
            "account_id",
            "transaction_date",
            "transaction_type",
            "amount",
            "description",
        ],
    },
    "loans": {
        "filename": "loans.csv",
        "required_columns": [
            "loan_id",
            "customer_id",
            "loan_type",
            "loan_amount",
            "interest_rate",
            "loan_status",
            "issue_date",
        ],
    },
}


def read_csv_file(filename: str) -> List[Dict[str, str]]:
    """
    Read a CSV file from the project's data directory.

    Parameters
    ----------
    filename : str
        Name of the CSV file.

    Returns
    -------
    list[dict]
        Records contained in the CSV file.

    Raises
    ------
    FileNotFoundError
        If the requested CSV file does not exist.
    """

    file_path = DATA_DIR / filename

    if not file_path.exists():
        raise FileNotFoundError(
            f"Data file not found: {file_path}"
        )

    with file_path.open(
        mode="r",
        encoding="utf-8",
        newline=""
    ) as file:

        reader = csv.DictReader(file)

        return list(reader)


def validate_required_columns(
    records: List[Dict[str, str]],
    required_columns: List[str],
) -> bool:
    """
    Validate that all required columns exist.
    """

    if not records:
        raise ValueError("Dataset contains no records.")

    available_columns = set(records[0].keys())

    missing_columns = set(required_columns) - available_columns

    if missing_columns:
        raise ValueError(
            "Missing required columns: "
            f"{sorted(missing_columns)}"
        )

    return True


def validate_no_empty_required_values(
    records: List[Dict[str, str]],
    required_columns: List[str],
) -> bool:
    """
    Validate that required fields do not contain empty values.
    """

    for row_number, record in enumerate(records, start=2):

        for column in required_columns:

            value = record.get(column)

            if value is None or not value.strip():

                raise ValueError(
                    f"Empty value found in column "
                    f"'{column}' at CSV row {row_number}."
                )

    return True


def summarize_dataset(
    dataset_name: str,
    records: List[Dict[str, str]],
) -> None:
    """
    Print a basic summary of a dataset.
    """

    print(f"\nDataset: {dataset_name}")
    print(f"Records: {len(records)}")

    if records:
        print(
            "Columns:",
            ", ".join(records[0].keys())
        )


def validate_dataset(
    dataset_name: str,
    configuration: Dict[str, object],
) -> List[Dict[str, str]]:
    """
    Load and validate one banking dataset.
    """

    filename = configuration["filename"]
    required_columns = configuration["required_columns"]

    records = read_csv_file(filename)

    validate_required_columns(
        records,
        required_columns,
    )

    validate_no_empty_required_values(
        records,
        required_columns,
    )

    summarize_dataset(
        dataset_name,
        records,
    )

    return records


def main() -> None:
    """
    Validate all available banking datasets.
    """

    print("=" * 60)
    print("BANKING FINANCIAL DATA WAREHOUSE")
    print("DATA INGESTION AND VALIDATION")
    print("=" * 60)

    print(f"\nData directory: {DATA_DIR}")

    total_records = 0

    for dataset_name, configuration in DATASETS.items():

        try:

            records = validate_dataset(
                dataset_name,
                configuration,
            )

            total_records += len(records)

        except (FileNotFoundError, ValueError) as error:

            print(
                f"\nValidation failed for "
                f"{dataset_name}: {error}"
            )

    print("\n" + "=" * 60)
    print(
        f"Total records processed: {total_records}"
    )
    print("=" * 60)


if __name__ == "__main__":
    main()
