DECLARE @Databasename VARCHAR(128) = 'taxidb'; -- declare variable

IF NOT EXISTS(select 1 FROM sys.databases where name = @Databasename)   -- test condition to check if database exists
BEGIN
	DECLARE @SQL NVARCHAR(MAX) = 'CREATE DATABASE ' + QUOTENAME(@Databasename)
	EXEC sp_executesql @SQL;
END

USE taxidb;


CREATE TABLE taxitrips (
    VendorID INT,
    lpep_pickup_datetime DATETIME,
    lpep_dropoff_datetime DATETIME,
    store_and_fwd_flag VARCHAR(5),
    RatecodeID INT,
    PULocationID INT,
    DOLocationID INT,
    passenger_count INT,
    trip_distance FLOAT,
    fare_amount FLOAT,
    extra FLOAT,
    mta_tax FLOAT,
    tip_amount FLOAT,
    tolls_amount FLOAT,
    ehail_fee FLOAT,
    improvement_surcharge FLOAT,
    total_amount FLOAT,
    payment_type INT,
    trip_type INT,
    congestion_surcharge FLOAT
);


-- !!! warning beofre using this
-- DROP TABLE taxitrips


BULK INSERT taxitrips FROM 'D:/2021_Green_Taxi_Trip_Data.csv'
WITH
(
	FIELDTERMINATOR = ',',		-- filed terminator possibilities: '|', ';', '\t', ' '
	ROWTERMINATOR = '0x0a',		--'\r\n', '\n', '\0x', '\0x0a'[line feed]
	FIRSTROW = 2
);


SELECT * FROM taxitrips;



-- 01) Shape of the Table (Number of Rows and Columns)
SELECT COUNT(*) AS row_count FROM taxitrips;
SELECT COUNT(*) AS column_count FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='taxitrips';


-- 02) Show Summary of Green Taxi Rides – Total Rides, Total Customers, Total Sales
SELECT COUNT(*) AS total_rides, SUM(passenger_count) AS total_customers, ROUND(SUM(total_amount), 3) AS total_sales
FROM taxitrips;


-- 03) Total Rides with Surcharge and its percentage.
--SELECT congestion_surcharge, improvement_surcharge, total_amount, ROUND((congestion_surcharge+improvement_surcharge)*100.0/total_amount, 2) AS surcharge_perc
--FROM taxitrips
--WHERE total_amount > 0 AND improvement_surcharge IS NOT NULL AND congestion_surcharge IS NOT NULL;
SELECT rides_with_surcharge, total_rides, ROUND(rides_with_surcharge*100.0/total_rides, 2) AS percentage_of_rides_with_surcharge
FROM (
	SELECT COUNT(*) AS total_rides, 
	COUNT(
		CASE 
			WHEN improvement_surcharge IS NOT NULL 
				 AND congestion_surcharge IS NOT NULL 
				 AND improvement_surcharge+congestion_surcharge>0 
				 THEN 1 
		END) AS rides_with_surcharge
	FROM taxitrips
) AS _;


-- 04) Cumulative Sum of Total Fare Amount for Each Pickup Location
SELECT PULocationID, total_amount,
SUM(total_amount) OVER (PARTITION BY PULocationID ORDER BY PULocationID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_amount
FROM taxitrips
WHERE total_amount>0
ORDER BY PULocationID, total_amount;


-- 05) Which Payment Type is Most Common in Each Drop-off Location
SELECT DOLocationID, most_common_payment_type, payment_type_count
FROM (
	SELECT DOLocationID, payment_type AS most_common_payment_type, 
	COUNT(payment_type) AS payment_type_count, 
	DENSE_RANK() OVER(PARTITION BY DOLocationID ORDER BY COUNT(payment_type) DESC) AS rank
	FROM taxitrips
	WHERE payment_type IS NOT NULL
	GROUP BY DOLocationID, payment_type
) AS most_common_payment_by_location
WHERE rank = 1;


-- 06) Create a New Column for Trip Distance Band and Show Distribution
SELECT trip_distance_band, COUNT(*) AS frequency_distribution_of_bands
FROM (
	SELECT *,
	CASE
		WHEN quartile=1 THEN 'Near'
		WHEN quartile=2 THEN 'Medium'
		WHEN quartile=3 THEN 'Far'
	END AS trip_distance_band
	FROM (
		SELECT PULocationID, DOLocationID, trip_distance, NTILE(3) OVER(ORDER BY trip_distance) AS quartile
		FROM taxitrips
	) AS _
) AS _
GROUP BY trip_distance_band;


-- 07) Find the Most Frequent Pickup Location (Mode) with rides fare greater than average of ride fare.tax
SELECT TOP 1 PULocationID, COUNT(*) AS frequency
FROM (
	SELECT PULocationID
	FROM taxitrips 
	WHERE fare_amount > (SELECT AVG(fare_amount) FROM taxitrips)
) AS _
GROUP BY PULocationID
ORDER BY frequency DESC;
-- insight: most frequent pickup location with ride fare greater than average ride fare is PULocationID:75


-- 08) Show the Rate Code with the Highest Percentage of Usage
SELECT RatecodeID, COUNT(RatecodeID) AS count_RatecodeID, COUNT(RatecodeID)*100/(SELECT COUNT(*) FROM taxitrips WHERE RatecodeID IS NOT NULL) AS percentage
FROM taxitrips
GROUP BY RatecodeID
HAVING RatecodeID IS NOT NULL
ORDER BY COUNT(RatecodeID) DESC;


-- 09) Show Distribution of Tips, Find the Maximum Chances of Getting a Tip
SELECT PULocationID, DOLocationID, passenger_count, ROUND(AVG(tip_amount), 2) AS avg_tip_amount, COUNT(*) AS tips_frequency
FROM taxitrips
WHERE tip_amount>0 AND trip_distance>0
GROUP BY PULocationID, DOLocationID, passenger_count
ORDER BY tips_frequency DESC, avg_tip_amount DESC;
-- insught: there is maximum chances of getting a tip for trips from Location:74 to Location:75


-- 10) Calculate the Rank of Trips Based on Fare Amount within Each Pickup Location
SELECT PULocationID, DOLocationID, fare_amount, DENSE_RANK() OVER(PARTITION BY PULocationID ORDER BY fare_amount) AS rank
FROM taxitrips
ORDER BY PULocationID;


-- 11) Find Top 20 Most Frequent Rides Routes. 
SELECT TOP 20 *
FROM (
	SELECT PULocationID, DOLocationID, COUNT(*) AS trips_in_route
	FROM taxitrips
	GROUP BY PULocationID, DOLocationID
) AS _
ORDER BY trips_in_route DESC;


-- 12) Calculate the Average Fare of Completed Trips vs. Cancelled Trips
SELECT trip_type, ROUND(AVG(fare_amount), 2) AS  avg_fare_amount
FROM taxitrips
WHERE trip_type IS NOT NULL
GROUP BY trip_type


-- 13) Rank the Pickup Locations by Average Trip Distance and Average Total Amount.
SELECT *, DENSE_RANK() OVER(ORDER BY avg_trip_distance DESC, avg_total_amount DESC) AS rank
FROM (
	SELECT PULocationID, ROUND(AVG(trip_distance), 2) AS avg_trip_distance, ROUND(AVG(total_amount), 2) AS avg_total_amount
	FROM taxitrips
	GROUP BY PULocationID
) AS _;


-- 14) Find the Relationship Between Trip Distance & Fare Amount
SELECT trip_distance, ROUND(AVG(fare_amount), 2) AS avg_fare_amount
FROM taxitrips
WHERE fare_amount>0 AND trip_distance>0
GROUP BY trip_distance
ORDER BY trip_distance;
-- insight: general trend is that both trip distance and fare amount are directly proportional, ie as trip distance increases the fare amount also increases


-- 15) Identify Trips with Outlier Fare Amounts within Each Pickup Location
SELECT PULocationID, fare_amount
FROM (
	SELECT *,
	PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY fare_amount) OVER(PARTITION BY PULocationID) AS q1,
	PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY fare_amount) OVER(PARTITION BY PULocationID) AS q3
	FROM taxitrips
) AS _
WHERE fare_amount<q1-1.5*(q3-q1) OR fare_amount>q3+1.5*(q3-q1)
ORDER BY PULocationID;


-- 16) Categorize Trips Based on Distance Travelled
SELECT trip_distance_band, COUNT(*) AS frequency_distribution_of_bands
FROM (
	SELECT *,
	CASE
		WHEN quartile=1 THEN 'Near'
		WHEN quartile=2 THEN 'Medium'
		WHEN quartile=3 THEN 'Far'
	END AS trip_distance_band
	FROM (
		SELECT PULocationID, DOLocationID, trip_distance, NTILE(3) OVER(ORDER BY trip_distance) AS quartile
		FROM taxitrips
	) AS _
) AS _
GROUP BY trip_distance_band;


-- 17) Top 5 Busiest Pickup Locations, Drop Locations with Fare less than median total fare
-- less optimized
SELECT TOP 5 PULocationID, DOLocationID, COUNT(*) AS frequency
FROM taxitrips
WHERE fare_amount <= (
	SELECT MAX(median)
	FROM (
		SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY fare_amount) OVER() AS median
	) AS _
)
GROUP BY PULocationID, DOLocationID
ORDER BY COUNT(*) DESC;

-- mode optimized
WITH MedianSubquery AS (
	SELECT TOP 1 PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY fare_amount) OVER() AS median
	FROM taxitrips
	ORDER BY median DESC
)
SELECT TOP 5 PULocationID, DOLocationID, COUNT(*) AS frequency
FROM taxitrips
WHERE fare_amount <= (SELECT median FROM MedianSubquery)
GROUP BY PULocationID, DOLocationID
ORDER BY COUNT(*) DESC;


-- 18) Distribution of Payment Types
SELECT payment_type, COUNT(payment_type) AS frequency
FROM taxitrips
WHERE payment_type IS NOT NULL
GROUP BY payment_type
ORDER BY payment_type;


-- 19) Trips with Congestion Surcharge Applied and Its Percentage Count.
SELECT lpep_pickup_datetime, lpep_dropoff_datetime, PULocationID, DOLocationID, passenger_count, trip_distance, 
congestion_surcharge, total_amount, ROUND(congestion_surcharge*100/total_amount, 2) AS percentage
FROM taxitrips
WHERE congestion_surcharge > 0 AND total_amount > 0;


-- 20) Top 10 Longest Trip by Distance and Its summary about total amount.
SELECT TOP 10 PULocationID, DOLocationID, trip_distance, fare_amount
FROM taxitrips
ORDER BY trip_distance DESC;


-- 21) Trips with a Tip Greater than 20% of the Fare
SELECT lpep_pickup_datetime, lpep_dropoff_datetime, PULocationID, DOLocationID, trip_distance, fare_amount, tip_amount
FROM taxitrips
WHERE tip_amount >= (0.2 * fare_amount) AND fare_amount>0;


-- 22) Average Trip Duration by Rate Code
SELECT RatecodeID, AVG(duration) AS avg_duration_in_minutes
FROM (
	SELECT RatecodeID, DATEDIFF(MINUTE, lpep_pickup_datetime, lpep_dropoff_datetime) AS duration
	FROM taxitrips
	WHERE DATEDIFF(MINUTE, lpep_pickup_datetime, lpep_dropoff_datetime)>=0
) AS _
WHERE RatecodeID IS NOT NULL
GROUP BY RatecodeID
ORDER BY RatecodeID;


-- 23) Total Trips per Hour of the Day
SELECT DATEPART(hour, lpep_pickup_datetime) AS hours_of_day, COUNT(*) AS hourly_frequency
FROM taxitrips
GROUP BY DATEPART(hour, lpep_pickup_datetime)
ORDER BY hours_of_day;


-- 24) Show the Distribution about Busiest Time in a Day.
SELECT year, month, day, hour_of_day, frequency
FROM (
	SELECT year, month, day, hour_of_day, COUNT(*) AS frequency, DENSE_RANK() OVER(PARTITION BY year, month, day ORDER BY COUNT(*) DESC) AS freq_rank
	FROM (
		SELECT DATEPART(hour, lpep_pickup_datetime) AS hour_of_day, DATEPART(day, lpep_pickup_datetime) AS day, DATEPART(month, lpep_pickup_datetime) AS month, DATEPART(year, lpep_pickup_datetime) AS year
		FROM taxitrips
	) AS _
	WHERE year = 2021
	GROUP BY year, month, day, hour_of_day
) AS _
WHERE freq_rank = 1
ORDER BY year, month, day, hour_of_day;