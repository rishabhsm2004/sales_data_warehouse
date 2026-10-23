/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates the 'DataWarehouse' database if it does not already exist. It sets up three schemas
    within the database: 'bronze', 'silver', and 'gold'.
	
    This setup script preserves an existing database and its data.
*/

USE master;
GO

-- Create the database only when it is absent. Do not drop existing data here.
IF DB_ID(N'DataWarehouse') IS NULL
    CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
IF SCHEMA_ID(N'bronze') IS NULL EXEC(N'CREATE SCHEMA bronze');
GO

IF SCHEMA_ID(N'silver') IS NULL EXEC(N'CREATE SCHEMA silver');
GO

IF SCHEMA_ID(N'gold') IS NULL EXEC(N'CREATE SCHEMA gold');
GO
