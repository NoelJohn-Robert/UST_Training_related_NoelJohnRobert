DECLARE @Databasename NVARCHAR(128) = 'warehousedb';

-- Test condition to check if database exists
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = @Databasename)
BEGIN
	DECLARE @sql NVARCHAR(MAX)='CREATE DATABASE '+QUOTENAME(@Databasename);
    EXEC sp_executesql @sql;
END

USE warehousedb;

DROP TABLE [dbo].fmcg;

CREATE TABLE [dbo].fmcg (
    Ware_house_ID VARCHAR(20),
    WH_Manager_ID VARCHAR(20),
    Location_type VARCHAR(20),
    WH_capacity_size VARCHAR(20),
    zone VARCHAR(20),
    WH_regional_zone VARCHAR(20),
    num_refill_req_l3m INT,
    transport_issue_l1y INT,
    Competitor_in_mkt INT,
    retail_shop_num INT,
    wh_owner_type VARCHAR(20),
    distributor_num INT,
    flood_impacted INT,
    flood_proof INT,
    electric_supply INT,
    dist_from_hub INT,
    workers_num INT,
    wh_est_year INT,
    storage_issue_reported_l3m INT,
    temp_reg_mach INT,
    approved_wh_govt_certificate VARCHAR(20),
    wh_breakdown_l3m INT,
    govt_check_l3m INT,
    product_wg_ton INT
);

BULK INSERT fmcg FROM 'D:/FMCG_data.csv'
WITH
(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2          -- skip the header from records
);

select * from fmcg;

-- 1. Show number of records
select count(*) as Num_of_Records from fmcg;

-- 2. Write a Query to Find WareHouse with Maximum Capacity of Storage (Top 5)
select Top(5) Ware_house_ID, product_wg_ton from fmcg order by product_wg_ton DESC;

-- 3. Write a Query to Find WareHouse with Minimum Capacity of Storage (Bottom 5)
select Top(5) Ware_house_ID, product_wg_ton from fmcg order by product_wg_ton;

-- 4. Find the Total Number of WH Regional Zone Count of Each Category.
select WH_regional_zone, count(*) as Total_count from fmcg 
group by WH_regional_zone
order by WH_regional_zone;

-- 5. Find average, minimum, maximum, median distance from HUB for warehouse with 
-- minimum capacity 10000, and location type is urban.
WITH MedianCTE AS (
    SELECT dist_from_hub, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY dist_from_hub) OVER()
	AS MedianPrice
    FROM fmcg WHERE product_wg_ton > 10000 and Location_type = 'Urban'
)
SELECT MIN(dist_from_hub),
	AVG(dist_from_hub),
	MAX(dist_from_hub),
	MAX(MedianPrice)
FROM MedianCTE;

-- 6. Window Function - In sql server window function performs calculations accross set 
-- of table rows. Unlike aggregate function which returns a single value for group of rows.
-- window functions return a value for each row in result set.
select * from fmcg;

select Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton,
Competitor_in_mkt,
RANK() OVER(PARTITION BY Competitor_in_mkt ORDER BY product_wg_ton DESC)
AS WH_RANK FROM fmcg;

-- Same values for same category returns same rank.
select Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton,
Competitor_in_mkt, workers_num,
RANK() OVER(PARTITION BY WH_regional_zone ORDER BY workers_num DESC)
AS WH_RANK FROM fmcg;

select Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton,
Competitor_in_mkt, workers_num,
DENSE_RANK() OVER(PARTITION BY WH_regional_zone ORDER BY workers_num DESC)
AS WH_RANK FROM fmcg;

-- Show Top 5 Rank from each category.
-- Using CTE with 
with regional_table as 
(select Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton,Competitor_in_mkt, 
workers_num, DENSE_RANK() OVER(PARTITION BY WH_regional_zone ORDER BY workers_num DESC)
AS WH_RANK FROM fmcg)
select * from regional_table where WH_RANK <= 5;

-- Do By using Subquery
select * from  
(select Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton,Competitor_in_mkt, 
workers_num, DENSE_RANK() OVER(PARTITION BY WH_regional_zone ORDER BY workers_num DESC)
AS WH_RANK FROM fmcg) as regional_table where WH_RANK <= 5;

-- Show First 5 Rows
select Top(5) * from 
(select Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton,Competitor_in_mkt, 
workers_num, DENSE_RANK() OVER(PARTITION BY WH_regional_zone ORDER BY workers_num DESC)
AS WH_RANK FROM fmcg) as regional_table;

-- Lag & Lead
select Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton,
Competitor_in_mkt, workers_num,
LAG(product_wg_ton, 2) OVER(PARTITION BY zone ORDER BY workers_num DESC)
AS Previous_product_wg_ton FROM fmcg;

select Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton,
Competitor_in_mkt, workers_num,
LEAD(product_wg_ton, 1) OVER(PARTITION BY zone ORDER BY workers_num DESC)
AS Next_product_wg_ton FROM fmcg;

-- Distribute Each Row into Percetiles.
select Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton,
Competitor_in_mkt, workers_num,
NTILE(5) OVER(ORDER BY product_wg_ton ASC) AS Percetiles FROM fmcg;

select Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton,
Competitor_in_mkt,workers_num,
PERCENT_RANK() OVER(ORDER BY workers_num ASC) AS Percetiles FROM fmcg 
where workers_num >=0;

-- Show all records where number of workers comes in range of First 40th Percetile Range.
select * from (select Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton,
Competitor_in_mkt,workers_num,
PERCENT_RANK() OVER(ORDER BY workers_num ASC) AS Percetiles FROM fmcg 
where workers_num >=0) AS _ where Percetiles <= .4;

-- Find the Difference between current value of product wt ton and compare it with previous 
-- 2 values Lag(2). and Rank overall records as per Differences.
SELECT *,Previous_product_wg_ton-product_wg_ton AS DIFF,RANK() 
OVER(ORDER BY Previous_product_wg_ton-product_wg_ton DESC) FROM 
(select Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton,
Competitor_in_mkt, workers_num,
LAG(product_wg_ton, 2) OVER(PARTITION BY zone ORDER BY workers_num DESC)
AS Previous_product_wg_ton FROM fmcg) AS _;



