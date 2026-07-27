
-- Create the superstore database
create database Superstore_DB;
go
use Superstore_DB;


-- Create the Orders table

CREATE TABLE Orders (
    [Row ID] INT,
    [Order ID] INT,
    [Order Date] NVARCHAR(50),
    [Order Priority] NVARCHAR(50),
    [Order Quantity] INT,
    [Sales] FLOAT,
    [Discount] FLOAT,
    [Ship Mode] NVARCHAR(50),
    [Profit] FLOAT,
    [Unit Price] FLOAT,
    [Shipping Cost] FLOAT,
    [Customer Name] NVARCHAR(100),
    [Province] NVARCHAR(100),
    [Region] NVARCHAR(50),
    [Customer Segment] NVARCHAR(50),
    [Product Category] NVARCHAR(50),
    [Product Sub-Category] NVARCHAR(50),
    [Product Name] NVARCHAR(255),
    [Product Container] NVARCHAR(50),
    [Product Base Margin] FLOAT,
    [Ship Date] NVARCHAR(50)
);

-- Configure database

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;

--Use BULK INSERT to accurately import the data into the database
-- Import Orders sheet
BULK INSERT Orders
FROM 'C:\Users\Abby\Desktop\3mtt files and app setup vs installation\sql\Superstore_database_creation_using_sql\Orders.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
-- Confirm order sheet upload

SELECT TOP 10 * FROM Orders;

-- Create the customername table

CREATE TABLE CustomerName (
    [Customer Name] NVARCHAR(100),
    [Order ID] INT
);


-- Import the customername sheet
BULK INSERT CustomerName
FROM 'C:\Users\Abby\Desktop\3mtt files and app setup vs installation\sql\Superstore_database_creation_using_sql\CustomerName.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
-- Confirm customername upload
SELECT TOP 10 * FROM CustomerName;


-- Create the return table

CREATE TABLE Returns (
    [Order ID] INT,
    [Status] NVARCHAR(20)
);

-- Import returns sheet 
BULK INSERT Returns
FROM 'C:\Users\Abby\Desktop\3mtt files and app setup vs installation\sql\Superstore_database_creation_using_sql\Returns.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
-- confirm returns table upload
SELECT TOP 10 * FROM Returns;

-- Create the table
CREATE TABLE Users (
    [Region] NVARCHAR(50),
    [Manager] NVARCHAR(100)
);
-- Import users sheet
BULK INSERT Users
FROM 'C:\Users\Abby\Desktop\3mtt files and app setup vs installation\sql\Superstore_database_creation_using_sql\Users.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

SELECT TOP 10 * FROM Users;
-- confirm users table

--Verified and validated imported data using SELECT queries

--Write any (4) syntax you use in querying the database

-- Query 1 - View Total Sales by Region

SELECT Region, SUM(Sales) AS [Total Sales]
FROM Orders
GROUP BY Region;


-- Query 2 - Find All Returned Orders

SELECT o.[Order ID], o.[Customer Name], r.Status
FROM Orders o
JOIN Returns r ON o.[Order ID] = r.[Order ID];

-- Query 3 - Count Orders per Segment

SELECT [Customer Segment], COUNT(*) AS [Order Count]
FROM Orders
GROUP BY [Customer Segment];

-- Query 4 - View Top 5 Most Profitable Products

SELECT [Product Name], SUM(Profit) AS [Total Profit]
FROM Orders
GROUP BY [Product Name]
ORDER BY [Total Profit] DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

--Process Summary:
--Cleaned and converted Excel sheets to CSV format
--Created matching tables in SQL Server using T-SQL CREATE TABLE
--Used BULK INSERT to accurately import the data into the database
--Verified and validated imported data using SELECT queries

--Challenges & Solutions:
--Faced a formatting issue while using OPENROWSET. Resolved it by switching to BULK INSERT
--Column mismatches were resolved by carefully defining data types and table structure

--SQL Syntax Used:
--CREATE TABLE
--BULK INSERT
--SELECT, JOIN, GROUP BY, ORDER BY




