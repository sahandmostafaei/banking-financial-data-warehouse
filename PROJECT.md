# Project Methodology

## 1. Overview

The Banking Financial Data Warehouse is a synthetic banking analytics project designed to demonstrate the integration of SQL, PostgreSQL, Python, data-quality validation, and reproducible analytical workflows.

The project models four core banking entities:

- Customers
- Accounts
- Transactions
- Loans

The system supports customer-level, account-level, transaction-level, and credit-risk analysis.

---

## 2. Architecture

The project follows a simple analytical data pipeline:

```text
Synthetic CSV Data
       |
       v
Python Ingestion
       |
       v
Data Quality Validation
       |
       v
PostgreSQL Relational Database
       |
       v
SQL Analytics
       |
       v
Financial KPIs and Risk Metrics
