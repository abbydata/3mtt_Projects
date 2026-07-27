# Superstore Database Project

## Overview
This project demonstrates how to build a SQL Server database from raw Superstore sales data. The data was first cleaned and converted from Excel sheets into CSV files, then imported into SQL Server using T-SQL `CREATE TABLE` statements and `BULK INSERT` operations.

The database created for this project is named `Superstore_DB` and contains structured tables for orders, customer information, returns, and user/region mapping.

## Project Objective
The goal of this project was to:
- transform Excel-based data into a relational SQL database
- create matching database tables in SQL Server
- load the data efficiently using bulk import
- validate the imported data with SQL queries

## Dataset Used for Bulk Insert
The following CSV files were used to populate the database:

- `Orders.csv` – contains the main sales/order transaction data such as order ID, order date, sales, profit, customer name, region, and product details.
- `CustomerName.csv` – contains customer names mapped to their corresponding order IDs.
- `Returns.csv` – contains order return status information.
- `Users.csv` – contains region and manager information.

These files were converted from Excel sheets and imported into SQL Server using `BULK INSERT`.

## Database Structure
The project creates the following tables:

- `Orders` – stores transaction-level sales data
- `CustomerName` – stores customer names linked to orders
- `Returns` – stores returned order status data
- `Users` – stores regional manager information

## SQL Process Summary
The database was created using the following workflow:
1. Cleaned and converted Excel sheets into CSV format.
2. Created matching tables using T-SQL `CREATE TABLE`.
3. Imported the datasets using `BULK INSERT`.
4. Verified the imported data using `SELECT` queries.

## SQL Syntax Used
The main SQL commands used in this project include:
- `CREATE TABLE`
- `BULK INSERT`
- `SELECT`
- `JOIN`
- `GROUP BY`
- `ORDER BY`

## Example Queries
Below are sample SQL queries used to explore and validate the database:

### 1. Total Sales by Region
```sql
SELECT Region, SUM(Sales) AS [Total Sales]
FROM Orders
GROUP BY Region;
```

### 2. Returned Orders
```sql
SELECT o.[Order ID], o.[Customer Name], r.Status
FROM Orders o
JOIN Returns r ON o.[Order ID] = r.[Order ID];
```

### 3. Orders per Customer Segment
```sql
SELECT [Customer Segment], COUNT(*) AS [Order Count]
FROM Orders
GROUP BY [Customer Segment];
```

### 4. Top 5 Most Profitable Products
```sql
SELECT [Product Name], SUM(Profit) AS [Total Profit]
FROM Orders
GROUP BY [Product Name]
ORDER BY [Total Profit] DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;
```

## Challenges and Solutions
During the project, some issues were encountered:
- A formatting issue occurred while trying to use `OPENROWSET`, which was resolved by switching to `BULK INSERT`.
- Some column mismatches were fixed by carefully defining the table structure and data types before importing the data.

## Notes
To run the SQL script successfully on your machine, update the file paths in the `BULK INSERT` statements to match the location of the CSV files on your system.

## Summary
This project provides a practical example of how to turn raw spreadsheet data into a functional SQL database and query it using common T-SQL operations.
