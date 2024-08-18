-- T-SQL or Transact SQL which is an extension of Structured Query Language
-- T-SQL developed by Microsoft for use of SQL server, Azure SQL-DB
-- Key features of T-SQL: [check notes]

-- 1. show databases
SELECT name FROM sys.databases;

-- 2. show list of schemas
SELECT name as SchemaName from sys.Schemas;

-- 3. create new database
create database sales;

-- 4. create database with condition to check if it exists
DECLARE @Databasename VARCHAR(128) = 'sales'; -- declare variable
IF NOT EXISTS(select 1 FROM sys.databases where name = @Databasename)   -- test condition to check if database exists
BEGIN
	DECLARE @SQL NVARCHAR(MAX) = 'CREATE DATABASE ' + QUOTENAME(@Databasename)
	EXEC sp_executesql @SQL;
END


-- 5. use database
USE sales;


-- 6. create table using schema name (dbo), which is default
create table [dbo].products(productid varchar(20) NOT NULL, productname varchar(50), price float, quantity int, 
storename varchar(50), city varchar(50));

-- ---- drop a table
-- DROP TABLE [dbo].products;


-- 7. insert data into table 'sales'
INSERT INTO [dbo].products (productid, productname, price, quantity, storename, city)
VALUES
('P001', 'Wireless Mouse', 25.99, 150, 'Techie Store', 'New York'),
('P002', 'Bluetooth Headphones', 89.50, 75, 'Gadgets Galore', 'San Francisco'),
('P003', 'USB-C Charger', 15.75, 200, 'Electro World', 'Los Angeles'),
('P004', 'Gaming Keyboard', 120.00, 50, 'Game Zone', 'Chicago'),
('P005', '4K Monitor', 299.99, 30, 'Visual Tech', 'Seattle'),
('P006', 'Laptop Stand', 35.00, 100, 'Techie Store', 'New York'),
('P007', 'Portable SSD', 150.00, 60, 'Data Hub', 'Austin'),
('P008', 'Smartwatch', 250.00, 45, 'Wearable Tech', 'Miami'),
('P009', 'Ergonomic Chair', 199.99, 20, 'Comfort Zone', 'Denver'),
('P010', 'HD Webcam', 79.99, 80, 'Vision Supplies', 'Boston');


-- 8. show all records in 'product' table
SELECT * FROM products;


-- 9. show schema/description of table
SELECT 
	TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM
	INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME = 'products'


-- 10. 
SELECT COUNT(*) FROM products WHERE quantity>30;


-- 11. alter table
ALTER TABLE products ADD total_bill float;

-- 12. drop column from table
ALTER TABLE products ADD transaction_date float;
ALTER TABLE products DROP COLUMN transaction_date;

-- 13. update existing column's datatype
ALTER TABLE products ALTER COLUMN total_bill DECIMAL(18,2);

-- 14. update value of column: total_bill = price*quantity
UPDATE  products SET total_bill = price*quantity; -- WHERE clause can be used along with this




-- select first 2 records
SELECT TOP (2) [productid]
      ,[productname]
      ,[price]
      ,[quantity]
      ,[storename]
      ,[city]
      ,[total_bill]
  FROM [sales].[dbo].[products]
