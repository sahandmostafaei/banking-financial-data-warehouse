"""
Banking Financial Data Warehouse
PostgreSQL database verification module

Author: Sahand Mostafaei
"""

import os

import psycopg2


EXPECTED_TABLES = {
    "customers": 10,
    "accounts": 12,
    "transactions": 20,
    "loans": 15,
}


def get_connection():
    """Create a PostgreSQL database connection."""

    return psycopg2.connect(
        host=os.getenv("POSTGRES_HOST", "localhost"),
        port=os.getenv("POSTGRES_PORT", "5432"),
        database=os.getenv("POSTGRES_DB", "banking_dw"),
        user=os.getenv("POSTGRES_USER", "postgres"),
        password=os.getenv("POSTGRES_PASSWORD"),
    )


def verify_table(
    cursor,
    table_name: str,
    expected_count: int,
) -> bool:
    """Verify that a table exists and has the expected row count."""

    cursor.execute(
        """
        SELECT COUNT(*)
        FROM information_schema.tables
        WHERE table_schema = 'public'
        AND table_name = %s;
        """,
        (table_name,),
    )

    table_exists = cursor.fetchone()[0] == 1

    if not table_exists:

        print(
            f"[FAIL] Table '{table_name}' does not exist."
        )

        return False

    cursor.execute(
        f"SELECT COUNT(*) FROM {table_name};"
    )

    actual_count = cursor.fetchone()[0]

    if actual_count != expected_count:

        print(
            f"[FAIL] {table_name}: "
            f"expected {expected_count} rows, "
            f"found {actual_count}."
        )

        return False

    print(
        f"[PASS] {table_name}: "
        f"{actual_count} rows"
    )

    return True


def main():
    """Verify the banking data warehouse."""

    print("=" * 60)
    print("BANKING DATABASE VERIFICATION")
    print("=" * 60)

    connection = None

    try:

        connection = get_connection()
        cursor = connection.cursor()

        results = []

        for table_name, expected_count in EXPECTED_TABLES.items():

            result = verify_table(
                cursor,
                table_name,
                expected_count,
            )

            results.append(result)

        print("\n" + "=" * 60)

        if all(results):

            print(
                "DATABASE VERIFICATION PASSED"
            )

        else:

            print(
                "DATABASE VERIFICATION FAILED"
            )

            raise SystemExit(1)

        print("=" * 60)

        cursor.close()

    except Exception as error:

        print(
            f"\nDatabase verification failed: {error}"
        )

        raise

    finally:

        if connection:
            connection.close()


if __name__ == "__main__":
    main()
