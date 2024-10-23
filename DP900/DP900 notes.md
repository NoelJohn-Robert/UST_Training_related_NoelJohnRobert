# DP900 Notes

### Data Formats
1. Structured Data
   - Has a fixed schema
2. Semi-Structured Data
   - No fixed schema, thus flexible. One example is JSON
3. Unstructured Data
   - Images, audio and video are all unstructured.

### Common File Formats
1. Delimited text files
   - Data stroed as in CSV or TSV formats
   - Good choice for structured data to be accessed by many type of applications
2. JavaScript Object Notation
    - Heirarchial document schema, with multiple attributes [can be object of collection of objects]
    - Good for both structured and unstructured data
    - objects enclosed in `{}` and collections enclosed in `[]`
3. Extensible markup language
    - More verbose than JSON
    - Uses tags enclosed in angle brackets `<../>` to define elements and attributes.
4. Binary Large Object (BLOB)
    - unstructured data, stored as raw binary.
    - must be interpreted by applications and rendered.
    - used for images, audio, video, application-specific documents.
5. Optimized file formats
    - specialized formats that support compression, indexing and efficient storage and processing.
    - Avro, ORC[Optimized Row Columnar format], Parquet are examples.

### Databases
1. Relational Databases
    - Data stored in tabular format
    - Primary key is used to uniquely identify each record in the table
    - Tables managed and queried using Structured Quey Language.
2. Non-relational Databases
   1. Key-Value databases
       - each record consists of a unique keyn and associated value 
   2. Document databases
       - type of key-value database, where value is a JSON document
   3. Column family databases
       - store tabular data comprising of rows and columns, but columns can be divided into groups called as column-families.
       - column family holds set of columns that are logically related together.
   4. Graph databases
       - stores entities as nodes with links defiing relationship between them.

### Tranasactional Data Processing
It records transactions encapsulating specific events the organization wants to track. A transactions is a small, discrete unit of work.\
Work performed by transactional systems is often referred to as Online Transactional Processing (OLTP). \
OLTP enforce transactions that support ACID semantics.

### Analytical Data Processing
Typically uses read-only systems that store a vast volume of historical data or business metrics. Analysis can be based on snapshot of data at some point of time or based on a series of snapshots.


### Jobs in world of data
1. Database Administrators
2. Data Engineers
3. Data Analysts


### Popular cloud services
1. Azure SQL
2. Azure CosmosDB
    - NoSQL database system. Enables storing and managing data as JSON dcouments, key-value pairs, column families, and graphs.
3. Azure Storage
    - Enables to store data in blob containers, file shares and tables (key-value storage for applications that need to read and write data quickly).
    - Usually used to host data lakes
4. Azure Data Factory
    - used to transfer and transform data using pipelines.
5. Microsoft Fabric
    - SaaS analytics platform based on an open and governed lakehouse.
6. Azure DataBricks
    - Native notebook support provides ability to query and visualize data in an easy to use web-based interface.
7. Azure Stream Analytics
    - Real-time stream processing engine that captures a stream of data from input, applies a query to extract and manipulate the input, nad write result to output for further analysis.
8. Azure Data Explorer
    - Big Data analytics platofrm that offers high-performance querying of log and telemetry data.
9. Microsoft Purview
    - Solution for enterprise-wide data governance and discoverability.
    - Create a amp of data and track data lineage across multiple data sources and systems.


### Normalization
It is a schema design process that minimizes data duplication and enforces data integrity.

### SQL Statements
- Data Defninition Language - create, alter, drop, rename
- Data Control Language - grant, deny, revoke
- Data Manipulation Language - select, insert, update, delete


### Views
It is a virtual table, created based on the result of a SELECT query.

### Stored Procedures
They are SQL statements that can be run on command. They encapsulate programmatic logic in a adataabse for actions that applications need to perform when working with data.

### Index
A particular column is considered for index; index contains copy of data in the column in a sorted order - with pointers to the corresponding rows in the table.\
This is useful for tables containing a large number of records.\
Performing any operation on the table may need the index to be updated, thus creating overhead in those operations.


### Azure SQL Services
1. SQL Server on Azure VMs:
   - IaaS, Allows to use full version of SQLServer in cloud without having to manage any on-premise hardware
   - Suitable when we require access to OS features.
   - Supporst fast migration to cloud with minimal changes (lift-and-shift ready).
2. Azure SQL Managed Instance:
    - Paas offering
    - Runs like a fully-controllable instance of SQLServer in cloud.
    - Automates backup, software patching, database monitoring, and other general tasks - but user still has full control over security and resource allocation for databases.
    - Depends on other Azure services like Azure Storage(for backup), Azure Events Hub(for telemetry), Microdoft ENtra ID(for authentication), Azure Key Vault(for Transparent Data Encryption).
    - Used as an alternative to SQL Server on VM, but to avoid management overhead of running VM.
    - Near 100% compatibility with SQL Server Enterprise Edition running on-premises. 
3. Azure SQL Database:
    - Paas offering
    - Available as Single Database or Elastic Pool(multiple databases can share the same resources, helping to reduce costs - mainly used when there is varying loads on the DB).
    - Best option for low cost with minimial administration.
    - Not fully compatible with on-premises SQLServer installations.
4. Azure SQL Edge:


### Azure Services for open-source databases:
MySQL, MariaDB, PostgreSQL are some popular relational databases.
- MariaDB supports temporal data, ie table can hold different variants of the same data.
- PostgreSQL is a hybrid relational-object database. Uses its own language `pgsql`.


### Non-relational Databases
Not all applications need rigid structure of a relational database. For them, these non-relational databases are appropriate.
1. Azure blob storage:
    - Helps store massive amounts of data as binary large objects in the cloud.
    - Blobs stored in containers
    - Folders can be created inside a ocntainer, but this is just a virtual operation.
    - 3 types of blobs: Block blobs, Page blobs, Append blobs.
    - 3 access tiers: Hot tier, Cold tier, Archive tier.
2. Azure Data Lake Gen2:
3. Azure Files:
    - File share enables storing files on one container, and then granting access to it for users and applications on other computers.
    - Supports two common network file sharing protocols: NFS and SMB(server message block)
4. Azure Tables:
    - Helps store semi-structured data
    - All rows have a unique key (composed of partition key and a row key)
    - When data is modified, a `TimeStamp` columnn is updated
    - Number of fields in each row can be different.
    - Split into partitions, based on the partiton key. Partiton is a mechanism to group related rows based on a common property or partition key. This helps improve scalability and performance.

### Cosmos DB
- highly scalable database management system
- different APIs are available for this, enabling its use across different scenarios. Some of them are:
  - Azure Cosmos DB for NoSQL -> for working with document data model; manages data in JSON document format; uses SQL syntax to work with data
  - Azure Cosmos DB for MongoDB -> data stored in BSON format; enables use of MongoDB client libraries and code to work with data in Azure Cosmos DB.
  - Azure Cosmos DB for PostgreSQL -> PostgreSQL automatically shards data to help build highly scalable apps.
  - Azure Cosmos DB for Table -> used to work with data in key-value tables, similar to azure table storage; uses partitionkey and rowkey
  - Azure Cosmos DB for Apache Cassandra -> Apache Cassandra is an open-source database that uses column-family storage structure; column-families are tables (like in relational databases), but its not mandatroy for each row to have same columns.
  - Azure Cosmos DB for Apache Gremlin -> used with data in a graph structure; entities defined as vertices that form nodes in connected graph; edges connect the nodes to show relationship between them.
- Sutiable for different situations like: IoT and telematics, Retail and marketing, Gaming, Web and mobile applications.


### Data Analytics
Data Warehousing Architecture:
- Data ingestion and processing -> Analytical data store -> Analytical data model -> Visualization

Analytical Data Stores:
- Data Warehouses
  - Relational database where data stored in a schema optimized for data analytics rather than transactions.
  - numerical data stored into dfact tables, while dimension table represents entities by wehich data can be aggregated. This structure is called as star schema, though its often extended into a snowflake schema by adding additional tables related to dimension tables to represent dimension hierarchies.
  - Good choice when there is transactional data that can be organized into structured schema of tables, and you want to use SQL to query them.
- Data Lakes
  - data usually stored on a distributed file system for high performance data access.
  - Spark or Hadoop are often used to process queries on the stored file.
  - Often uses schema-on-read approach to define tabular schemas on semi-structured data files
  - Great for supporting a mix of structured, semi-structured, and even unstructured data to be analyzed without a need for schema enforcement.

- Data Lakehouse:
  - A hybrid approach combining the above 2 methods
  - Raw data stored as files in data lake, Microsoft Fabric SQL analytics expose them as tables which can be queried using SQL.
  - Enables through tenchnologies like DeltaLake which adds relational storage capabilities to Spark.

Azure services for Analytical stores:
- Microsoft Fabric:
  - Unified, end-to-end solution for large scale data analytics
  - Combines data integrity and reliability of a scalable, high-performance SQL Server based relational data warehouse with the flexibility of a data lake and open-source Apache Spark.
- Azure DataBricks:
  - Azure implementation of Databricks platform, built on Apache Spark
  - Offers native SQL capabilities
  - provides interactive UI through which system can be managed and data explored in interactive notebooks


### Real-Time Analytics
Data processing is the conversion of raw data into meaningful information through some processes. \
Two main ways to process data - batch processing and stream processing
1. Batch Processing:
    - Newly arrived data is collected and stored, and whole group is processed together as a batch. 
    - An example is monthly billing.
    - Advantage is large volume can be processed, and at off-peak hours
    - Disadvantage is time delay between data ingestion and gettign results
2. Stream Processing:
    - Data collected over time is aggregated.
    - Ideal for time-critical operations, like triggering alarms when getting some data from a sensor.


Delta Lake - 
Open-Source storage layer that adds support for transactional consistency, schema enforcement, and other common data warehousing features to data lake storage. \
It can be used as a streaming source for queries against real-time data, or as a sink to which stream of data is written. \

In Microsoft Fabric, Real-Time hub is a central place to manage streaming data.


### Visualization
Microsoft PowerBI is a suite of tools and services within Microsoft Farbic that data analysts use to build interactive data visualizations. \
Power BI Desktop is a Windows application in which tyou can import data from a wide range of sources, combine and organize them in an analytics data model, and create reports. \
After creating reports, they can be published them to Poower BI Service, which is a cloud service where reports can be published and interacted with by business users. Some basic data modelling and report editing can be done directly in the browser. \
There is also a Power BI phone app to access reports and dashboard.
\
\
In data modelling, the model usually forms a multi-dimensional structure called a cube - in which any point where dimensions(entities by which you want ot aggregate) intersect represnets an aggregated measure for those dimensions.
\
\
_Dimension table_ represents entities by which you want to aggregate numeric measures. Numeirc measures that will be aggregated by various dimensions are stored in the _Fact table_.

\
\
Differnet methods of Data Visualization:
1. Tables and Text
    - useful when we need to show some individual values, like total sales
2. Bar and Column charts
    - useful for visually comparing numeric values for discrete categories
3. Line charts
    - similar to bar and column charts, but used mainly to compare trends often over some period of time
4. Pie charts
    - visualize categorized values as proportional of total
5. Scatter plots
    - useful in comparing two numeric measures
6. Maps
    - visualize values for different geographic areas/locations



