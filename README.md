# Banking Financial Data Warehouse

![Python](https://img.shields.io/badge/Python-3.x-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-SQL-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Domain](https://img.shields.io/badge/Domain-Banking%20%26%20Financial%20Analytics-purple)

A banking-focused financial data warehouse designed to integrate transaction, customer, account, and credit-risk data for financial reporting, analytical querying, risk analysis, and management reporting.

The project combines **PostgreSQL, SQL, Python, data engineering, financial analytics, and dashboard reporting** into a structured banking analytics workflow.

---

## Overview

Financial institutions generate large volumes of transactional and customer-level data.

A well-designed data warehouse provides a centralized analytical layer for transforming operational banking data into structured information that can be used for:

- Financial reporting
- Transaction analysis
- Customer analytics
- Credit-risk analysis
- Account analysis
- Banking KPIs
- Management reporting
- Business intelligence
- Analytical dashboards

This project implements a simplified banking financial data warehouse to demonstrate how financial data can be organized, transformed, queried, and analyzed using SQL and Python.

The project is designed as a portfolio demonstration of **financial data engineering and banking analytics skills**.

---

## Project Objectives

The main objectives are to:

1. Design a structured banking data model.
2. Store banking data in a relational PostgreSQL environment.
3. Build analytical SQL queries for banking use cases.
4. Transform transactional data into financial and customer-level metrics.
5. Support credit-risk and customer analytics.
6. Generate financial reporting metrics.
7. Connect Python-based analysis to the financial data layer.
8. Provide dashboard-ready analytical outputs.
9. Demonstrate reproducible data-engineering practices.

---

## Banking Use Cases

The warehouse is designed to support several common banking analytical use cases.

### Financial Reporting

The system can support analysis of:

- Transaction volumes
- Transaction values
- Account balances
- Deposits
- Withdrawals
- Financial activity
- Customer balances
- Banking performance indicators

### Transaction Analysis

Transaction data can be analyzed by:

- Customer
- Account
- Transaction type
- Transaction date
- Transaction amount
- Account category
- Geographic or demographic dimensions where available

### Customer Analytics

Customer-level analysis can be used to identify:

- Customer activity
- Account usage
- Transaction behaviour
- Customer balances
- Product usage
- Customer segmentation indicators

### Credit Risk

The data warehouse can support analytical views of:

- Credit exposure
- Credit scores
- Loan-related information
- Risk categories
- Customer financial characteristics
- Delinquency-related indicators where available

### Management Reporting

Aggregated warehouse data can be used to produce:

- Banking KPIs
- Customer summaries
- Transaction summaries
- Risk summaries
- Financial performance indicators

---

## Architecture

The project follows a simplified banking data-engineering architecture.

Banking Source Data
        |
        v
Data Ingestion
        |
        v
PostgreSQL Database
        |
        v
Relational Data Model
        |
        v
SQL Transformations
        |
        +----------------------+
        |                      |
        v                      v
Financial Analytics      Risk Analytics
        |                      |
        +----------+-----------+
                   |
                   v
             Python Analytics
                   |
                   v
               Dashboard
                   |
                   v
          Management Reporting

The architecture separates:

- Data storage
- Data transformation
- Financial analysis
- Risk analysis
- Python-based analytics
- Dashboard reporting
- Management reporting

---

## Technology Stack

### Database

- PostgreSQL
- SQL
- Relational data modelling

### Programming

- Python
- pandas
- NumPy

### Analytics

- SQL aggregations
- Financial KPI calculations
- Transaction analysis
- Customer analytics
- Credit-risk analysis

### Reporting

- Dashboard components
- Financial reporting outputs
- Analytical visualizations

### Development

- pytest
- `.env` configuration
- Git
- GitHub

---

## Data Model

The warehouse is organized around banking entities such as:

- Customers
- Accounts
- Transactions
- Loans
- Credit-risk information
- Financial dimensions

The relational structure is designed to reduce unnecessary duplication while allowing analytical queries to combine information across banking entities.

A simplified conceptual relationship is:

Customer
    |
    +---- Account
            |
            +---- Transaction
            |
            +---- Loan

This structure allows customer-level information to be connected to account activity, transactions, and credit-related information.

---

## Data Engineering Workflow

The project follows a simplified ETL/ELT-style workflow.

Raw Banking Data
        |
        v
Data Validation
        |
        v
Data Transformation
        |
        v
PostgreSQL Storage
        |
        v
Analytical SQL
        |
        v
Aggregated Financial Metrics
        |
        v
Python Analysis
        |
        v
Dashboard / Reporting

The workflow demonstrates how raw financial data can be converted into structured analytical information.

---

## SQL Analytics

SQL is used as the primary analytical language within the warehouse.

Typical analytical operations include:

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- JOIN
- Aggregate functions
- Common table expressions
- Analytical views
- Financial aggregations

Example analytical questions include:

- What is total transaction volume?
- What is total transaction value?
- Which customers have the highest transaction activity?
- Which accounts have the largest balances?
- What is transaction activity by month?
- How is customer activity distributed?
- Which customers have elevated credit-risk characteristics?
- What are the major banking KPIs?

The project demonstrates how SQL can be used to convert transactional banking data into management-level information.

---

## Financial Analytics

The warehouse provides a foundation for calculating financial and operational indicators.

Potential metrics include:

### Transaction KPIs

- Total transaction count
- Total transaction value
- Average transaction value
- Transaction volume by period
- Transaction volume by type

### Customer KPIs

- Number of customers
- Active customers
- Average customer balance
- Customer transaction frequency
- Customer product usage

### Account KPIs

- Number of accounts
- Total account balances
- Average account balance
- Account activity
- Account distribution

### Risk KPIs

- Credit-risk segmentation
- Credit-score distributions
- Customer exposure
- Risk-category counts
- Loan-related indicators

These metrics can be aggregated by time, customer, account, or other available dimensions.

---

## Python Analytics

Python provides an analytical layer above the relational data warehouse.

Python can be used for:

- Data extraction
- Data transformation
- Statistical analysis
- Financial calculations
- Data validation
- Visualization
- Reporting

The project demonstrates the combination of:

**SQL for structured data retrieval**

and

**Python for analytical processing and visualization.**

This combination is highly relevant to financial data analytics.

---

## Dashboard

The repository contains a dashboard component designed to present analytical information derived from the warehouse.

The dashboard can be used to communicate:

- Financial KPIs
- Transaction activity
- Customer metrics
- Risk indicators
- Banking performance information

The separation between the database layer and dashboard layer demonstrates a basic business-intelligence architecture.

---

## Data Quality

Financial analytics depend heavily on data quality.

The project therefore considers common data-quality requirements such as:

- Missing values
- Duplicate records
- Invalid transaction amounts
- Invalid dates
- Referential integrity
- Inconsistent categories
- Invalid customer/account relationships

Data validation should occur before analytical results are used for reporting.

---

## Environment Configuration

The project includes an `.env.example` file for database configuration.

Sensitive credentials should not be committed to GitHub.

Typical configuration values may include:

DATABASE_HOST=
DATABASE_PORT=
DATABASE_NAME=
DATABASE_USER=
DATABASE_PASSWORD=

The actual `.env` file should remain local and must not contain production credentials in the repository.

---

## Testing

The repository includes a pytest configuration and testing structure for validating analytical and data-processing functionality.

Testing can be used to verify:

- Data transformations
- Analytical calculations
- Query-related outputs
- Data-processing functions
- Financial KPI calculations

The objective is to provide basic regression protection for the analytical pipeline.

---

## Reproducibility

The project is structured so that the analytical workflow can be reproduced using:

- Defined database configuration
- Structured datasets
- SQL transformations
- Python analytical scripts
- Documented project structure
- Automated tests

The use of configuration files and modular analytical components helps separate environment-specific settings from the core analytical logic.

---

## Repository Structure

    banking-financial-data-warehouse/
    |
    +-- dashboard/
    |   +-- dashboard components
    |
    +-- data/
    |   +-- banking datasets
    |
    +-- figures/
    |   +-- generated analytical figures
    |
    +-- python/
    |   +-- Python analytics and data-processing modules
    |
    +-- .env.example
    +-- .gitignore
    +-- CHANGELOG.md
    +-- LICENSE
    +-- PROJECT.md
    +-- README.md
    +-- RESULTS.md
    +-- ROADMAP.md
    +-- pytest.ini
    +-- requirements.txt

---

## Project Components

### `data/`

Contains the datasets used by the analytical workflow.

The datasets represent structured banking information used for financial, transaction, customer, and risk analysis.

### `python/`

Contains Python-based analytical and data-processing functionality.

This layer complements the SQL database by providing additional analytical and reporting capabilities.

### `dashboard/`

Contains dashboard-related components for presenting financial and banking analytics.

### `figures/`

Stores generated analytical figures and visual outputs.

### `.env.example`

Provides a template for database and environment configuration without exposing sensitive credentials.

### `pytest.ini`

Provides configuration for the project's Python testing framework.

### `PROJECT.md`

Contains additional project documentation and implementation information.

### `RESULTS.md`

Provides a location for analytical results and project findings.

### `ROADMAP.md`

Documents potential future development.

---

## Analytical Workflow

A typical analytical workflow is:

1. Load banking data.
2. Validate and clean data.
3. Store data in PostgreSQL.
4. Query and transform data using SQL.
5. Generate financial and banking KPIs.
6. Extract analytical datasets into Python.
7. Perform additional analysis.
8. Generate visualizations.
9. Present results through dashboards and reports.

---

## Example Business Questions

The warehouse can be used to answer questions such as:

### Customers

- How many active customers are there?
- Which customers have the highest activity?
- What is the average customer balance?
- Which customers use multiple banking products?

### Transactions

- What is the total transaction value?
- How does transaction activity change over time?
- Which transaction types dominate activity?
- Which customers generate the highest transaction volumes?

### Accounts

- What is the total account balance?
- Which account categories have the highest balances?
- How does account activity vary across customers?

### Credit Risk

- How are customers distributed across risk categories?
- Which customers exhibit higher credit-risk characteristics?
- How does credit score relate to financial activity?
- What is the distribution of credit exposure?

### Financial Reporting

- What are the major banking KPIs?
- How does financial activity change over time?
- Which customer or account segments contribute most to activity?

---

## Data Engineering Skills Demonstrated

This project demonstrates:

- Relational database design
- PostgreSQL
- SQL
- Data modelling
- ETL/ELT concepts
- Data validation
- Data transformation
- Analytical querying
- Database configuration
- Python integration
- Financial data processing
- Dashboard-oriented data preparation

---

## Financial Skills Demonstrated

The project demonstrates practical understanding of:

- Banking transactions
- Customer analytics
- Account analytics
- Financial reporting
- Credit-risk data
- Banking KPIs
- Financial data structures
- Management reporting

---

## Programming Skills Demonstrated

The project demonstrates:

- Python programming
- SQL programming
- pandas
- NumPy
- Data transformation
- Modular project organization
- Automated testing
- Environment configuration
- Data-processing workflows
- Analytical pipeline design

---

## Why This Project Matters

This project complements the other quantitative and financial projects in the portfolio by focusing specifically on the **financial data infrastructure layer**.

Whereas financial modelling projects focus on valuation and investment decisions, a financial data warehouse focuses on the infrastructure required to organize and retrieve the information used by analysts.

The project therefore demonstrates an additional capability:

Financial Data
      |
      v
Data Engineering
      |
      v
Structured Database
      |
      v
SQL Analytics
      |
      v
Financial KPIs
      |
      v
Decision Support

This is particularly relevant to modern banking environments where financial analysts, risk teams, data teams, and technology teams increasingly work with integrated financial datasets.

---

## Relationship to Quantitative Finance

The warehouse provides the data foundation for more advanced quantitative applications.

For example:

Banking Data Warehouse
        |
        v
Financial Data
        |
        v
Risk Metrics
        |
        v
Statistical Analysis
        |
        v
Predictive Models
        |
        v
Financial Decision Support

The project therefore provides a bridge between:

- Financial data engineering
- Banking analytics
- Risk management
- Quantitative analysis
- Business intelligence

---

## Limitations

This project is intentionally designed as a portfolio and educational implementation rather than a production banking data warehouse.

Important limitations include:

- Simplified banking datasets
- Limited data volume
- Simplified database architecture
- No production-scale distributed processing
- No real-time transaction streaming
- Limited data-governance functionality
- Limited role-based database security
- No production banking core-system integration
- Simplified risk analytics
- No proprietary banking data

These limitations are intentional and allow the project to focus on demonstrating the underlying concepts clearly.

---

## Future Development

Potential improvements include:

- Expanded dimensional modelling
- Star-schema implementation
- Slowly changing dimensions
- Advanced ETL pipelines
- Airflow orchestration
- dbt transformations
- Data-quality monitoring
- Data lineage
- Advanced credit-risk analytics
- Customer segmentation
- Fraud detection
- Portfolio-level analytics
- Time-series financial analysis
- Advanced dashboarding
- Cloud data warehouse integration
- Automated database testing
- Performance optimization
- Role-based access control

---

## Educational Purpose

The project is intended to demonstrate the application of software engineering and data-engineering techniques to financial and banking problems.

It is particularly relevant to:

- Banking
- Financial analytics
- Risk management
- Data engineering
- Quantitative finance
- Business intelligence
- Financial technology

---

## Portfolio Context

This project forms part of a broader finance and quantitative-programming portfolio.

The portfolio covers several complementary areas:

| Project | Primary Skill |
|---|---|
| Bank Credit Risk Analytics | Credit Risk & Financial Analytics |
| Portfolio Optimization | Quantitative Finance & Asset Allocation |
| Bank Customer Churn Prediction | Machine Learning & Banking Analytics |
| Banking Financial Data Warehouse | SQL, PostgreSQL & Financial Data Engineering |
| Investment Banking Deal Analytics | Valuation, Financial Modelling & M&A |

Together, these projects demonstrate the application of programming and quantitative methods across multiple areas of finance.

---

## Author

**Sahand Mostafaei**

Bachelor of Science in Electrical Engineering

Interests include:

- Banking
- Investment Banking
- Financial Modelling
- Quantitative Finance
- Financial Risk Management
- Data Analytics
- Financial Data Engineering

---

## License

This project is released under the MIT License.

See `LICENSE` for details.

---

## Disclaimer

This project is an educational and portfolio demonstration.

The datasets and analytical outputs are intended for illustrative purposes. The project is not a production banking system and should not be used for real financial, credit, investment, or regulatory decision-making without appropriate validation, controls, data governance, and professional review.
