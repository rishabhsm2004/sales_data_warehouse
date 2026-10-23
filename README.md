# Sales Data Warehouse
A SQL Server data warehouse that combines CRM and ERP data to support customer, product, and sales analysis. Data moves through Bronze, Silver, and Gold layers, with SQL scripts for loading, transformation, and quality checks.

## Project structure

- `01_datasets/` — CRM and ERP source CSV files.
- `02_docs/` — requirements, data catalog, naming conventions, and architecture documentation.
- `03_scripts/` — database setup, layer table definitions, load procedures, and Gold views.
- `04_test/` — Silver and Gold data quality checks.

## Data layers

- **Bronze:** Loads raw CSV data into source-aligned tables.
- **Silver:** Cleans and standardizes data, including deduplication, date parsing, and normalization.
- **Gold:** Provides analytical views:
  - `gold.dim_customers`
  - `gold.dim_products`
  - `gold.fact_sales`

The project uses the latest dataset snapshot and does not maintain historical changes.

## Requirements

- Microsoft SQL Server with permission to create databases, schemas, tables, views, and stored procedures.
- SQL Server Management Studio (SSMS) or another SQL client.
- SQL Server’s Database Engine service account must be able to read the source CSV files for `BULK INSERT`.

## Setup and load

Run these scripts in order:

1. `03_scripts/init_database.sql`
2. `03_scripts/bronze/ddl_bronze.sql`
3. `03_scripts/bronze/proc_load_bronze.sql`
4. `03_scripts/silver/ddl_silver.sql`
5. `03_scripts/silver/prod_load_silver.sql`
6. `03_scripts/gold/ddl_gold.sql`

Update the CSV file paths in `03_scripts/bronze/proc_load_bronze.sql` before loading. The current paths point to an older directory; the files in this project are under `01_datasets/source_crm/` and `01_datasets/source_erp/`. Use paths accessible to the SQL Server service account.

Load the Bronze and Silver layers:

```sql
USE DataWarehouse;
GO

EXEC bronze.load_bronze;
GO

EXEC silver.load_silver;
GO
```

Example Gold queries:

```sql
SELECT TOP (100) * FROM gold.fact_sales;
SELECT TOP (100) * FROM gold.dim_customers;
SELECT TOP (100) * FROM gold.dim_products;
```

## Reload behavior

The Bronze and Silver procedures truncate their target tables before reloading the current snapshot. Gold objects are views and reflect the current Silver data.

## Data quality checks

After loading, run `04_test/quality_checks_silver.sql` and `04_test/quality_checks_gold.sql` in the `DataWarehouse` database. Review any returned rows for potential data quality or relationship issues.

## Documentation

See `02_docs/requirements.md`, `02_docs/data_catalog.md`, and `02_docs/naming_conventions.md` for project requirements, Gold-layer fields, and naming rules. The `02_docs/` folder also contains architecture and data model diagrams.
