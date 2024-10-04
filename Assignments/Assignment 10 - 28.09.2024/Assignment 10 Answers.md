# **Assignment 10 - Azure Data Factory**

##### Q1. Design an ADF pipeline to copy data from an on-premise Azure SQL database to Azure Cosmos DB, ensuring data consistency and performance optimization. Pick correct options of partitioning for better performance.

a. Main component of the pipeline is the copy data tool. Selected source is an SQL table named CarsSQLTable containing various details of different models of cars from multiple manufacturers.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q1_1.png" alt="" width="462">

b. Sink for the Copy Data tool is a Container in Azure CosmosDB.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q1_2.png" alt="" width="463">

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q1_3.png" alt="" width="464">

Multiple partitioning options are availlable while choosing source - here, Noone is choosen due to the smaller size of availabe data which will not provide significant performance benefits. For bigger datasets, using partitions will help provide performance benefits by parallelizing data extraction

##### Q2. Create Pipeline using Azure Data Flow in Azure Data Factory to apply Filter and Sort transformations on datasets.

a. Main component of the pipeline is a dataflow task.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q2_1.png" alt="" width="471">

b. Dataflow first involves taking the data from a FlatFile source named Customers.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q2_2.png" alt="" width="474">

c. Filter involves taking only rows from the data where State equals 'TX'

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q2_3.png" alt="" width="504">

d. Sort involves sorting the output from Filter step based on descending order of LastName and FirstName columns

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q2_4.png" alt="" width="505">

e. Final destination is a CSV file.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q2_5.png" alt="" width="499">

##### Q3. Design an ADF pipeline to implement aggregate operations, such as sum, average, max, min and count, within an Azure Data Flow.

a. Main component of PIpeline is a dataflow task.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q3_1.png" alt="" width="467">

b. Data source here is a CSV file named Cars. Change datatype of each column to the appropriate type from the projection section. 

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q3_2.png" alt="" width="470">

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q3_3.png" alt="" width="462">

c. Aggregating data by 'Make' producing columns 'avg_MSRP, avg_MPG_City, avg_MPG_Highway, stddev_Weight'

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q3_4.png" alt="" width="468">

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q3_5.png" alt="" width="471">

d. Final output is stored to a CSV file

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q3_6.png" alt="" width="518">

##### 4. Create best approach to bulk copy data from multiple homogenous sources into Azure SQL Database using ADF pipelines. Show usage of Lookup, For Each Loop and Expressions in Azure Data Factory.

a. Lookup component uses a query to get list of all tables in the specified database. The source dataset has only a linked service and no table connection as it is used just to have a connection the the database.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q4_1.png" alt="" width="448">

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q4_2.png" alt="" width="443">

b. ForEach loop gives the name of the tables to the 'Export Table' activity inside it using the expression `@activity('List tables').output.value`

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q4_3.png" alt="" width="479">

c. In the Export Table activity, source dataset has two properties - TableName and SchemaName. These were used to access each table in database.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q4_4.png" alt="" width="482">

d. Sink dataset is a blob storage, where we store as records of each table in CSV files. Dataset has a property named TableName with value set to `@concat(item().table_schema, '_', item().table_name, '.csv')`

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q4_5.png" alt="" width="486">

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q4_6.png" alt="" width="487">

##### 5. Implement incremental load Pipeline in Azure Data Factory for handling datasets, ensuring efficient insert/upsert/updates to the target storage without re-inserting the entire dataset?

a. Main pipeline

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q5_1.png" alt="" width="508">

b. The lookup activity named 'getOldWatermark' is used to retreive latest lookup value stored in the watermark table- which signifies when incremental loading last took place.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q5_2.png" alt="" width="504">

c. The lookup activity 'getNewWatermark' uses a query to retreive the time when Source Dataset was last modified.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q5_3.png" alt="" width="504">

d. Copy Data tool uses an SQL query inorder to retreive al rows where watermark  value is greater than old watermark, but less than or equals newer watermark

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q5_4.png" alt="" width="504">

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q5_5.png" alt="" width="506">

e. THe sink dataset is the destination table to which we are incrementally loading data. Upsert option is used to continuously input new data without getting overridden. Primary key for the table is employee_id.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q5_6.png" alt="" width="523">

f. A stored procedure is used to write new watermark value and table name to the watermark table. 'LastModifiedtime' from getNewWatermark activity and 'TableName' are passed are parameters to the stored procedure.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q5_7.png" alt="" width="530">

##### 6. What are the key steps to connect Azure Databricks to Cosmos DB for real-time analytics and data transformation using spark and Databricks.

a. Transfer data from source to CosmonDB storage. Source here is a CSV file in blob storage, that needs to be moved to Cosmos using the Copy Data Tool.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q6_1.png" alt="" width="529">

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q6_2.png" alt="" width="531">

b. Create a linked service for connecting to databricks notebook. Go to Settings section to connect to a notebook.

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q6_3.png" alt="" width="527">

<img title="" src="file:///C:/Users/noel0/Downloads/New%20folder%20(2)/q6_4.png" alt="" width="530">

c. In the databricks notebook, first install driver to connect the cluster to CosmosDB. Define endpoint URL, primary key, database name and container name. Read from cosmos  as given below.

![](C:\Users\noel0\Downloads\New%20folder%20(2)\q6_5.png)
