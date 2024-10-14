Comprehensive Data Pipeline with Azure Data Factory, Databricks and Dashboard on 
Zomato delivery operations analytics dataset and create solution for seamless food delivery operations.

# About Capstone:
python, dashboard, adf, spark, pyspark, sparksql
(11 different types, dataset and flow will be similar for atleast 2 people - so ensure to make them different)

1. Input data sources (multiple).
-- if it is not splitted, (except cosmos) split into min 3 parts [like, URL, Datalake/blob, azureDB, mongoDB, postgres]

2. DataPipeline (dataflow can be created here)

3. Create and define landing zone (NoSQL database - cosmosDB)

4. Transformations and Aggregations using PySpark notebook
-- store cleaned data to table [delta table, SQL, cosmos - whatever is cheaper], 

5. Materialized views (SQL) - createOrReplace....
-- create SQL table (optional as we have materialized view)
-- SQL for dashboard
-- use optimization techniques here

6. Visualization (PowerBI or Databricks) - 2nd notebook




Dataflow can be added in step 2 especially for those with a single dataset.






Data Details:
[link1](https://www.kaggle.com/datasets/anas123siddiqui/zomato-database?select=orders.csv)
[link2](https://www.kaggle.com/datasets/saurabhbadole/zomato-delivery-operations-analytics-dataset)
[link3](https://www.kaggle.com/datasets/narsingraogoud/zomato-restaurants-dataset-for-metropolitan-areas)

<!-- 1. food.csv
-- index:
-- f_id: food identifier
-- item: food name
-- veg_or_non_veg: veg or non veg

2. menu.csv
-- index:
-- menu_id: 
-- r_id: restautant identifier
-- f_id: food identifier
-- cuisine
-- price

3. orders.csv
-- index
-- order_date:
-- sales_qty:
-- sales_amount:
-- currency:
-- user_id: user who placed order
-- r_id: restaurant which placed order

4. restaurant.csv
-- index:
-- id: identifier of restaurant
-- name
-- city
-- rating: average rating of restaurant
-- rating_count (might drop this)
-- cost: average cost per person at restaurant
-- cusisine:
-- lic_no: license number of restaurant
-- link: website line
-- address
-- menu (can drop this probably)

5. users.csv
-- user_id: unique id of user
-- name:
-- email
-- password
-- Age
-- Gender
-- Marital Status
-- Occupation
-- Monthly Income
-- Educational Qualifications
-- Family size -->

1. zomato_dataset_metropolitan
2. zomato_delivery_operational_analytics




NEW THINGS
Azure Things:
- resource group: capstone-project-ne-rg-noel
- region: (Europe) North Europe
- storage account: capstonestoragezomato
- blob container: datasets
- data factory: capstone-datafactory-ne-noel
- azure SQL DB name: capstone_db
- azure SQL server name: capstone-server-noel, azure-admin, Az@=1234
- azure cosmos account name: capstone-cosmosdb-noel
- azure cosmos database name: capstone_cosmos_database
- azure cosmos containers: zomato_delivery_operational_analytics_container(/Road_traffic_density), zomato_dataset_metropolitan_container (/Cuisine)


Step 0: Load data into sources -
- split zomato_delivery_operational_analytics based on Road_traffic_density into Jam, High, Medium and Low
- store low, medium into blob storage; High, Jam into SQL table
- zomato_dataset_metropolitan is in github

create staging sql table:
CREATE TABLE DeliveryOrders_Staging (
    ID VARCHAR(20),
    Delivery_person_ID VARCHAR(20),
    Delivery_person_Age INT,
    Delivery_person_Ratings DECIMAL(2, 1),
    Restaurant_latitude DECIMAL(10, 6),
    Restaurant_longitude DECIMAL(10, 6),
    Delivery_location_latitude DECIMAL(10, 6),
    Delivery_location_longitude DECIMAL(10, 6),
    Order_Date VARCHAR(20),
    Time_Orderd VARCHAR(20),
    Time_Order_picked VARCHAR(20),
    Weather_conditions VARCHAR(50),
    Road_traffic_density VARCHAR(50),
    Vehicle_condition INT,
    Type_of_order VARCHAR(50),
    Type_of_vehicle VARCHAR(50),
    multiple_deliveries INT,
    Festival VARCHAR(3),
    City VARCHAR(50),
    Time_taken_min INT
);


actual sql table: [create actual table before this]
INSERT INTO DeliveryOrders (ID, Delivery_person_ID, Delivery_person_Age, Delivery_person_Ratings, Restaurant_latitude, Restaurant_longitude, Delivery_location_latitude, Delivery_location_longitude, Order_Date, Time_Orderd, Time_Order_picked, Weather_conditions, Road_traffic_density, Vehicle_condition, Type_of_order, Type_of_vehicle, multiple_deliveries, Festival, City, Time_taken_min)
SELECT 
    ID, 
    Delivery_person_ID, 
    Delivery_person_Age, 
    Delivery_person_Ratings, 
    Restaurant_latitude, 
    Restaurant_longitude, 
    Delivery_location_latitude, 
    Delivery_location_longitude,
    TRY_CAST(Order_Date AS DATE) AS Order_Date,
    TRY_CAST(Time_Orderd AS TIME) AS Time_Orderd,
    TRY_CAST(Time_Order_picked AS TIME) AS Time_Order_picked,
    Weather_conditions,
    Road_traffic_density,
    Vehicle_condition,
    Type_of_order,
    Type_of_vehicle,
    multiple_deliveries,
    Festival,
    City,
    Time_taken_min
FROM 
    DeliveryOrders_Staging
WHERE 
    TRY_CAST(Order_Date AS DATE) IS NOT NULL 
    AND TRY_CAST(Time_Orderd AS TIME) IS NOT NULL
    AND TRY_CAST(Time_Order_picked AS TIME) IS NOT NULL;



jamDensity and highDensity data will be inserted into staging table, after which it will be copied into actual tables
now, sources are:
capstonestoragezomato -> data-source -> lowDensity, 2 files
capstonestoragezomato -> data-source -> mediumDensity, 2 files
capstone_db -> high and jam density data (cleaned or uncleaned?)
github -> zomato_dataset_metropolitan

dont do staging thing, just insert everything as string itself




Step 1: we need to create multiple dataflow tasks, each of which copies data into cosmos db
create 2 containers inside cosmos db














Comprehensive Data Pipeline with Azure Data Factory, Databricks and Dashboard on Zomato Restaurants Dataset and Zomato delivery operations analytics and solution for seamless Delivery in Metropolitan Areas.
possible visualizations in metropolitan_df:
-- Restaurants ordered by lowest price
-- restaurants with most choices [ie most cuisines, or should it be dishes?]
-- cities ordered by number of restaurants
-- cities ordered by lowest average prices
-- count of unique food items
- count of unique restaurants
- Items ordered by ratings (need to check this)
- Check if restaurants can be ordered by BEST_SELLER field


possible visualizations in delivery_operational_analytics:
- time_order_picked - time_ordered gives time difference, ie average delay in pickup per restaurant/city
- type_of_order - to find count
- time_taken (min) - to find average delivery time per city
- Delivery person who has most orders
- using time data [YEAR_ID, MONTH_ID, Day_of_Week, Week_of_Year, QTR_ID] to find various stats



weather influence
revenue generated through zomato by each restaurant []
if possible, use window functions


metropolitan data - 
|Delivery_Rating|           Item_Name|Dining_Rating|    Cuisine|         Place_Name|Votes|Prices|Dining_Votes|Delivery_Votes|       unique_row_id|      City|     Restaurant_Name|Best_Seller|

delivery operational analytics data - 
|    ID|  Time_Order_picked|        Time_Orderd|Restaurant_latitude|Restaurant_longitude|Delivery_location_longitude|Delivery_person_Ratings|Vehicle_condition|Delivery_person_Age|Delivery_location_latitude|Road_traffic_density|       unique_row_id|Type_of_order|         City|Time_taken (min)|Delivery_person_ID| Type_of_vehicle|Order_Date|multiple_deliveries|Weather_conditions|Festival|Year_ID|Month_ID|Day_of_Week|Week_of_Year|QTR_ID|


todo - 
- distance vs time taken [need to avoid outliers in distance]
- top ranked restaurant in each city
- use dining votes from metropolitan data
- [sunburst not possible] top rated restaurants and top rated food in them
- [not req] time taken vs festival yes/no




Flow :
- problem statement
- talk about dataset
- goals and technologies used
- data in sources
- ADF pipeline

- Transformation layer [in databricks] [do only what they say]

"dapi_82f8_3829_346b_a367_bddc_d1b6_3c6f_9b3e_-2" - what is this [plz remove underscores]??



pipeline:
- IngestionLayer -> LandingZone -> Processing[PySpark] -> Analysis[SparkSQL] -> Visualization[Databricks] 