-- loading data from file


-- create database
DECLARE @Databasename VARCHAR(128) = 'warehousedb'; -- declare variable

IF NOT EXISTS(select 1 FROM sys.databases where name = @Databasename)   -- test condition to check if database exists
BEGIN
	DECLARE @SQL NVARCHAR(MAX) = 'CREATE DATABASE ' + QUOTENAME(@Databasename)
	EXEC sp_executesql @SQL;
END

USE warehousedb;


-- creating table schema
CREATE TABLE [dbo].fmcg (
    Ware_house_ID VARCHAR(20),
    WH_Manager_ID VARCHAR(20),
    Location_type VARCHAR(10),
    WH_capacity_size VARCHAR(10),
    zone VARCHAR(10),
    WH_regional_zone VARCHAR(10),
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
    approved_wh_govt_certificate VARCHAR(5),
    wh_breakdown_l3m INT,
    govt_check_l3m INT,
    product_wg_ton INT
);


-- insert data from CSV, method 2
BULK INSERT fmcg FROM 'D:/fmcg_data.csv'
WITH
(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2		-- to skip first heading line
);


-- drop table [dbo].fmcg;


SELECT * FROM fmcg;


-- 1. show number of records
SELECT COUNT(*) AS num_of_records FROM fmcg;


-- 2. query to find top 5 warehouse with maximum capacity of storage [from product_wg_ton]
SELECT TOP(5) * FROM fmcg ORDER BY product_wg_ton DESC;


-- 3. query to find top 5 warehouse with minimum capacity of storage [from product_wg_ton]
SELECT TOP(5) * FROM fmcg ORDER BY product_wg_ton;


-- 4. total count of warehouse regional zone category
SELECT WH_regional_zone, COUNT(WH_regional_zone) AS count_WH_regional_zone FROM fmcg GROUP BY WH_regional_zone ORDER BY WH_regional_zone;


-- 5. find average, minimum, maximum, median distance from hub for value of warehouse with minimum capacity 10000, and location type urban
-- finding just median, WITH is used to create a duplicate table
WITH MedianCTE AS (
	SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY dist_from_hub) OVER() 
	AS MedianPrice
	FROM fmcg
)
SELECT MAX(MedianPrice) FROM MedianCTE;

-- finding other things
SELECT AVG(dist_from_hub) AS average, MIN(dist_from_hub) AS minimum, MAX(dist_from_hub) AS maximum
FROM fmcg 
WHERE Location_type='Urban' and product_wg_ton>=10000;

-- final
WITH MedianCTE AS (
	SELECT dist_from_hub, 
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY dist_from_hub) OVER() AS MedianPrice
	FROM fmcg
	WHERE Location_type='Urban' and product_wg_ton>=10000
)
SELECT AVG(dist_from_hub) AS average, MIN(dist_from_hub) AS minimum, MAX(dist_from_hub) AS maximum, MAX(MedianPrice) AS median FROM MedianCTE;





-- 6. window function
-- in sql server, window functions performs calculations across set of
-- table rows, unlike aggregate functions which returns a single value for group of rows,
-- window function returns a value for each row in result set

-- ranking based on no of competitors
SELECT Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton, Competitor_in_mkt,
RANK() OVER(PARTITION BY Competitor_in_mkt ORDER BY product_wg_ton DESC) AS RANK
FROM fmcg;

-- ranking by number of retail shops in each zone
SELECT Ware_house_ID, Location_type, zone, product_wg_ton, retail_shop_num,
RANK() OVER(PARTITION BY Location_type,zone ORDER BY product_wg_ton DESC,retail_shop_num DESC) AS rank
FROM fmcg;

-- show only top 5 ranks from previous
WITH temptable AS (
	SELECT Ware_house_ID, Location_type, zone, product_wg_ton, retail_shop_num,
	RANK() OVER(PARTITION BY Location_type,zone ORDER BY product_wg_ton DESC,retail_shop_num DESC) AS rank
	FROM fmcg
)
SELECT rank, Ware_house_ID, Location_type, zone, product_wg_ton, retail_shop_num
FROM temptable WHERE rank<=5;

-- to see response, an example of problem with rank
SELECT Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton, competitor_in_mkt, workers_num,
RANK() OVER(PARTITION BY zone ORDER BY workers_num DESC) AS rank
FROM fmcg; -- issue in this, duplicate ranks and skipping some -- use dense_rank to overcome this

-- previous one, with dense_rank
SELECT Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton, competitor_in_mkt, workers_num,
DENSE_RANK() OVER(PARTITION BY zone ORDER BY workers_num DESC) AS rank
FROM fmcg;

-- show rank <= 5 only from previous table
-- using subquery, we can also use CTE
SELECT *
FROM (
	SELECT Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton, competitor_in_mkt, workers_num,
	DENSE_RANK() OVER(PARTITION BY zone ORDER BY workers_num DESC) AS rank
	FROM fmcg
) as regional_table WHERE rank <= 5;


-- LAG and LEAD
-- by how much is current value lagging/leading when compared to previous value
-- here, we crated a new column to show previous 1 value
SELECT Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton, competitor_in_mkt, workers_num,
LAG(product_wg_ton, 1) OVER(PARTITION BY zone ORDER BY workers_num DESC) AS prev_product_wg_ton
FROM fmcg;
-- if we change from 1 to 2, previous to previos value will be shown
SELECT Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton, competitor_in_mkt, workers_num,
LAG(product_wg_ton, 2) OVER(PARTITION BY zone ORDER BY workers_num DESC) AS prev_product_wg_ton
FROM fmcg;

-- lead indicates the next value [last entry will be NULL in LEAD's case]
SELECT Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton, competitor_in_mkt, workers_num,
LEAD(product_wg_ton, 1) OVER(PARTITION BY zone ORDER BY workers_num DESC) AS next_product_wg_ton
FROM fmcg;

-- LEAD and LAG actual usage is to find difference


-- finding in which quartile some data falls
SELECT Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton, competitor_in_mkt, workers_num,
NTILE(4) OVER(ORDER BY product_wg_ton ASC) AS five_percentiles
FROM fmcg;


-- percent ranks
SELECT Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton, competitor_in_mkt, workers_num,
PERCENT_RANK() OVER(ORDER BY workers_num ASC) AS percentiles
FROM fmcg
WHERE workers_num IS NOT NULL;	-- WHERE clause was added due to large number of NULL values for 'workers_num' field

-- q: show all records where workers_num comes in range 0th-40th percentile
SELECT * FROM (
	SELECT Ware_house_ID, Location_type, zone, wh_owner_type, product_wg_ton, competitor_in_mkt, workers_num,
	PERCENT_RANK() OVER(ORDER BY workers_num ASC) AS percentiles
	FROM fmcg
	WHERE workers_num IS NOT NULL
) AS percentile_table WHERE percentiles <= 0.40;


-- q: find the difference between current value of product_wt_ton and compare it with previous 2 values [ie lag = 2]
-- rank it according to difference
SELECT *, DENSE_RANK() OVER(ORDER BY diff DESC) AS rank
FROM (
	SELECT *, (prev_prev_product_wg_ton-product_wg_ton) AS diff
	FROM (
		SELECT Ware_house_ID, product_wg_ton, competitor_in_mkt, workers_num,
		LAG(product_wg_ton, 2) OVER(PARTITION BY zone ORDER BY workers_num DESC) AS prev_prev_product_wg_ton
		FROM fmcg
	) AS lag2_table
	WHERE prev_prev_product_wg_ton IS NOT NULL
) AS diff_ranked_table;