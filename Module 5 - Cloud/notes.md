info:

email - [noelroberttemp@outlook.com](mailto:noelroberttemp@outlook.com)

password - [`n03lr0b3rt`] [`n03l@R0B3RT`]

# Cloud Fundamentals

## Virtualization

We create a virtual representation of server, storage, physical machines, etc. Useful if we have s ingle physical hardware system where we want to digitally separate it to share hardware resources but run separate services.

Each VM has its own allocated resources, network, storage, etc. 

Resources are separated digitally only, not physically. 

- VM is software defined computer which helps enable virtualization. It can only use the resources allocated by host machine.

- Hypervisor is the software component that manages different VM's, which ensures resources are allocated to multiple VM's, and does not interfere with operations of other VM's.
  
  - Type1 hypervisor - Installed directly on computer's hardware instead of OS. Better performance, and usually used by enterprises.
  
  - Type2 hypervisor - Installed on OS, suitable for end-user computing.

## Cloud Computing

Model for delivering computing services including servers, storage, databases, networking, software, analytics and intelligence via internet. Enables  faster innovation, flexible resource utilization, and cost efficiencies by leveraging resources of cloud providers.

### Benefits

- Cost: Moving to cloud helps companies optimize costs.

- Speed: Vast amount of computing resources can be provisioned in minutes, gives business lot of flexibility and takes pressure off capacity planning.

- Global Scale: Ability to scale elastically, ability to easily scale up or down.

- Productivity: Onsite data centers typically require lots of racking and stacking, but cloud computing reduces time required on this.

- Performance: reduced latency, and increased reliability.

- Reliability: Data backup, business continuity is easier and less expensive

- Security: Offers broad set of policies, technologies, and controls that strengthens overall security posture, thereby helping protect data, apps, infrastructures from potential threats.

## Cloud Services

1. IaaS - Offers essential compute, storage and network resources on demand. [*We handle application, data, runtime, middleware and OS. They handle virtualization, servers, storage, and networking*]

2. PaaS - Supplies on-demand environment for developing, testing, delivering and managing software applications. designed to make it easier for developers to quickly create mobile and web apps without worrying about setting up the environment. [*We handle applications and data. They handle runtime, middleware, OS, virtualization, servers, storage, networking*]

3. Serverless

4. SaaS - They handle applications, data, runtime, middleware, OS, virtualization, servers, storage, networking.

## Types of Cloud Computing

1. Public Cloud - Owned and operated by third-party service providers, provide services over the public internet [*GCP, AWS*]

2. Private Cloud - Resources dedicated to a single person/organization. Data located within an organization itself. [*HPE GreenLake, Azure Stack*]

3. Hybrid Cloud

Some cloud providers

- Amazon Web Services

- Azure [*imp: Azure ML Studio*]

13/09/2024

- Created Azure Cosmos DB with name `azure-cosmos-demo-nosql-noelrobert`, location is `Central US`. Resource group is `azure-cosmos`. Provisioned is the capacity we selected.

- Create container in `azurecosmos-demo-noelrobert` to start working. Databaseid - `bank-azuredb`, Manual & 400RU/s, contained ID-`bankcontainer`

- `items` under `bankcontainer`, go to `new item`at top. paste JSON thing [one {}] in area and press `save` button. 'id' field to be used only when there is a unique field in data record itself. use `Upload item` inorder to upload JSON file itself.

# Some queries in Azure Cosmos DB

Q1: show all records in a container

```sql
SELECT * FROM c
```

-> c is an alias for document within container

Q2: filter document based on a filed

```sql
SELECT * FROM c WHERE c.balance > 7000
```

Q3: Limit Top 10

```sql
SELECT TOP 10 * FROM c
```

Q4: Count of records, aggregate operations

```sql
SELECT VALUE COUNT(1) FROM c
```

-> when we write VALUE, only the actual value gets returned

Q5: Count of records, with alias

```sql
SELECT COUNT(1) AS record_count FROM c
```

-> this returns as a key-value pair

Q6: Find count and average balance for each job

```sql
SELECT c.job, COUNT(1) as employee_count, AVG(c.balance) as avg_balance
FROM c
GROUP BY c.job
```

Q7: order data by balance

```sql
SELECT * 
FROM c
ORDER BY c.balance
```

Q8: Distinct keyword

```sql
SELECT DISTINCT c.job
FROM c
```

17/09/2024

# Azure Storage

Storage Challenges - Capacity charges (RU charges in case of CosmosDB), Backup and Disaster Recovery, Limited IT agility, Un-manageable complexity (different types of storage for different data types, coz of different types of data formats).

## Types of Storage offered by Azure

Highly scalable cloud storage with built-in security, scalability, and reliability. Azure Storage offers a massively scalable object store for data objects, a file system for azure cloud, a messaging store for reliable messaging as well as a NoSQL store.

Features offered by Azure storage - Azure storage is durable, secure, scalable, high availability, fault tolerant, managed, accessible

Types of storage offered are: Blobs, Tables, Queues, Disks, Files

### Blob Storage

    A massively scalable object store for text as well as binary data. Idle for serving different types of images or documents directly to a browser. It stores files for distributed access. Offers backup and restore, disaster recovery and archiving.

    In one storage, multiple containers can be built. One blob storage is divided into multiple containers, and each container can further contain one or more files of type XLSX, CSV, ...

#### Blob Storage Access Tier

Azure Storage provides different options for accessing block of Blob data based on usage pattern. The 3 different types of patters are:

- HOT - Optimized for frequent access of objects

- COOL - Optimized for storing large amount of data that is infrequently accessed and is stored for only 30 days

- Archive - Optimized for data that can tolerate several hours of retrieval latency and it will remain in that archive for 180 days

### Queue Storage

There is a messaging store for reliable messaging between application components. Mainly for storing logs or any activity.

In every Queue, multiple messages will be created. 

Main characteristics are: 

- Messaging queue for asynchronous communication between application components [responsible for creating these].

- Stores and retrieves messages in FIFO order.

Properties:

- Storage for small pieces of data

- Source will generate small messages at regular intervals. It is highly scalable and can handle millions of messages per second.

- Can trigger functions and serviced for automation processing

Uses:

- can be used for processing log messages, user interaction with application, and other background tasks.

### Table Storage

Azure Storage table is NoSQL key-value storage with fast access and schema-less design. There is also partition key.

Usage: Scalable and designed for applications requiring large amounts of structured non-relational data [eg: Applications logs as key-value pairs or metadata].

### File Storage

Managed file share accessible vis SMB (Server Message Block) and NFS (Network File System) products. SMB protocol is a network file-sharing protocol that allows applications on cloud to read and write to files and request services from other programs. They can be also mounted to drives of computer.

Useful if you are running out of storage in system.

## Data Redundancy

Azure storage that replicates multiple copies of your data. Replication options for a storage includes:

a. Local-Redundant Storage  --> A simple, low-cost data replication strategy. Data is replicated within a single storage scale unit.

b. Zone-Redundant Storage  --> Use this for high availability and durability. data replicated synchronously across three available zones

c. Geo-Redundant Storage  --> Cross regional replication to protect against region-wise unavailability of data

d. Read-Access Geo-Redundant Storage --> Cross regional replication with read access to replica

![](D:\UST_Training_related_NoelJohnRobert-main\Module%205%20-%20Cloud\storage.PNG)

![](D:\UST_Training_related_NoelJohnRobert-main\Module%205%20-%20Cloud\storage2.PNG)

## Hands-on

search for StorageAccount -> Create

![](D:\UST_Training_related_NoelJohnRobert-main\Module%205%20-%20Cloud\azure_storage_1.PNG)

only need to make changes in Basics section, others are default itself

Table storage is also possible, create in Data Storage > Tables. Insert using Storage Browser > Tables > your_table

Azure CL to mount a new table:

Open PowerShell [right to copilot] and type:

```powershell
install-Module AzTable

# initializing variables
$group = "azurestorage-demo"
$storageName = "azurestoragedemonoel"
$storageAccountKey = "Tg79FWrKbJrTfT+R1qTTiWw3EnEhD5FDDw6Wpg/Ik8H0BzXjtMinG1wzmFcjupvlbpPH25YIPiqX+AStoonWoA=="

# create storage account context
$account = Get-AzStorageAccount -Name $storageName -ResourceGroupName $group
$context = New-AzStorageContext -StorageAccountName $storageName -StorageAccountKey $storageAccountKey

# define table name
$tableName = "demoaztable"

# create new table
New-AzStorageTable -Name $tableName -Context $context

$cloudTable = (Get-AzStorageTable -Name $tableName -Context $context).CloudTable
$partitionKey1 = "partition1"
$partitionKey2 = "partition2"

# insert into table [-rowKey must be different]
Add-AzTableRow -table $cloudTable -partitionKey $partitionKey1 -rowKey ("CA") -property @{"username"="Uday"; "userid"=1}
Add-AzTableRow -table $cloudTable -partitionKey $partitionKey2 -rowKey ("LA") -property @{"username"="Elias"; "userid"=4}
Add-AzTableRow -table $cloudTable -partitionKey $partitionKey2 -rowKey ("SA") -property @{"username"="Issac"; "userid"=2}
Add-AzTableRow -table $cloudTable -partitionKey $partitionKey1 -rowKey ("WA") -property @{"username"="Anu"; "userid"=3}

# show everything in table
Get-AzTableRow -table $cloudTable | ft
```

18-09-2024

# Azure Synapse

sql pawwords {sql pwd: `sql@1234`, sqladminuser??}

some thingsKs

```
Subscription
Azure Pass - Sponsorship
Resource group
(new) azure-synapse-rg-noel
Region
Central US
Workspace name
(new) azuresynapse-noel
Data Lake Storage Gen2 account
(new) https://datalakefilesytem.dfs.core.windows.net
Data Lake Storage Gen2 file system
(new) employeefs
Managed resource group
auzre-synapse-mg-noel
Role assignments
The Storage Blob Data Contributor role will be assigned on the specified Data Lake Storage Gen2 account to both the workspace managed identity and the current user.
```

After successful deployment, open synapse studio in `ResourceGroup>azuresynapse-noel`

```
Integrate > Copy Data Tool

SOurce is HTTP,
Base URL should be raw url[eg: https://raw.githubusercontent.com/MicrosoftLearning/DP-900T00A-Azure-Data-Fundamentals/refs/heads/master/Azure-Synapse/products.csv], and do test connection
Disable Server Certificate Validation


Destination is Azure DAta Lake Storeage 2
connection is default one
configuration at destinations should match that at source
```

Create new spark pool with size small, nodes 3-3, executors 1-2

then in synapse studio `Develop > New Notebook`

then its same as pyspark

## Azure Data Pipeline (ETL)

Create SQL pool

Create Spark pool

Then load the file into `Data (Linked) > primary folder > GreenTaxiData`

`Develop > New Notebook`

ETL Pipeline using Azure Synapse

- Our data source was  Azure Data Lake Gen2, containing `GreenTaxiTrips.csv`

- PySpark to read data using `spark.read.load()`

- Data transformation using PySpark [included renaming columns, typecasting required columns]

- Load data to DataWarehouse [Azure SQL DWH], repartitioned into 4 parts and saved as parquet format

- Copy Data Pipeline from stored location of Parquet file to Table

- StoredProcedure on GreenTaxiTable updates PaymentType to 2

- Apply changes to data in table

# Azure Data Factory

Server-less data integration tool

Synapse has an internal pool available, but Data Factory does not have internal pools. 



25-09-2024

Azure HDInsight

- Hortonworks distribution as a first-party service on Azure. Hortonworks had Ambari. [Apache Airflow is used to schedule jobs]. not necessary if we already have HDInsight

Databricks 

- can run batch processing, ML, auto-scaling

AzureML Services 

- Azure first-party services for Machine Learning

# Azure Databricks

- Collaboration of Microsoft with founders of Apache Spark

- Native integration with other Spark services

- One-click setup

- Enterprise-grade Azure security

## Azure Databricks Workspace

ADF is a server-less data integration solution, for ingestion, data transformation and load solution. Here, ADF acts like ingestion tool.

Azure Event hubs - Used for data ingestion from source to destination, but as streaming source 

![](D:\UST_Training_related_NoelJohnRobert-main\Module%205%20-%20Cloud\azure-databricks-modern-analytics-architecture.svg)

- **Ingestion Layer** is used to ingest data from multiple sources [blob, azure SQLDB, cosmos, DBFS, deltalake, datalake, Azure Tables]

- **Processing Layer** - For data processing, transformation and insight analysis.

- **Data Lake Gen2** - houses all types of data such as structured, unstructured, and semi-structured. It also batch and streaming data.

- **Delta Lake** - Forms the curated layer of the data lake. It stored refined data in an open-source format:
  
  - Bronze - Holds raw data
  
  - Silver - Contains cleaned, filtered data
  
  - Gold - Stores aggregated data that's useful for business analytics

- **Azure DataBricks** - is a data analytics platform. Its fully managed Spark clusters process large streams of data from multiple sources. Azure Databricks cleans and transforms structureless data sets. It combines the processed data with structured data from operational databases or data warehouses. Azure Databricks also trains and deploys scalable machine learning and deep learning models.

- **Azure Synapse Analytics** - Provides SQL Pool, Spark Pool, which provides SQL server as well as Spark clusters. Synapse can be integrated with other azure services - like Notebooks, Databricks, HDInsight, PowerBI, Azure ML Tools, Power Query. This can be also used for creating pipelines.

- **PowerBI** - collection of software services and apps. These services create and share reports that connect and visualize unrelated sources of data.  Together with Azure Databricks, Power BI can provide root cause  determination and raw data analysis.

## Databrick FileSystem (DBFS):

dbutils.fs.ls("/")  --> different folders

dbutild.library.install()  -->
