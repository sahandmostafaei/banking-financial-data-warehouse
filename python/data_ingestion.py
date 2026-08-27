"""
Banking Financial Data Warehouse
Data ingestion and validation module

Author: Sahand Mostafaei
"""

from pathlib import Path
import csv
from typing import List, Dict


DATA_DIR = Path(__file__).resolve().parent.parent / "data"


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
    required_columns: List[str]
) -> bool:
    """
    Validate that required columns exist in the dataset.
    """

    if not records:
        return False

    available_columns = set(records[0].keys())

    missing_columns = set(required_columns) - available_columns

    if missing_columns:
        raise ValueError(
            f"Missing required columns: {sorted(missing_columns)}"
        )

    return True


def summarize_dataset(
    records: List[Dict[str, str]]
) -> None:
    """
    Print basic dataset information.
    """

    print(f"Number of records: {len(records)}")

    if records:
        print(
            "Columns:",
            ", ".join(records[0].keys())
        )


def main() -> None:
    """
    Run a basic data ingestion and validation example.
    """

    print("=" * 60)
    print("BANKING DATA INGESTION")
    print("=" * 60)

    print("\nData directory:")
    print(DATA_DIR)

    print(
        "\nThis module provides reusable functions "
        "for loading and validating banking datasets."
    )


if __name__ == "__main__":
    main()
