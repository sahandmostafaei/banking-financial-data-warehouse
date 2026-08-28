"""
Banking Financial Data Warehouse
Pipeline orchestration module

Author: Sahand Mostafaei
"""

import os
import subprocess
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parent.parent
SQL_DIR = PROJECT_ROOT / "sql"


def run_sql_file(sql_file: str) -> None:
    """
    Execute a SQL file against the configured PostgreSQL database.
    """

    database = os.getenv("POSTGRES_DB", "banking_dw")
    sql_path = SQL_DIR / sql_file

    if not sql_path.exists():
        raise FileNotFoundError(
            f"SQL file not found: {sql_path}"
        )

    command = [
        "psql",
        "-d",
        database,
        "-f",
        str(sql_path),
    ]

    print(f"\nRunning {sql_file}...")

    subprocess.run(
        command,
        check=True,
    )


def main() -> None:
    """
    Run the reproducible banking analytics pipeline.
    """

    print("=" * 60)
    print("BANKING FINANCIAL DATA WAREHOUSE")
    print("PIPELINE RUNNER")
    print("=" * 60)

    sql_files = [
        "schema.sql",
        "customers.sql",
        "accounts.sql",
        "transactions.sql",
        "loans.sql",
    ]

    for sql_file in sql_files:
        run_sql_file(sql_file)

    print("\nDatabase loading completed.")

    print("\nRunning analytics...")

    run_sql_file("analytics.sql")

    print("\nPipeline completed successfully.")


if __name__ == "__main__":
    main()
