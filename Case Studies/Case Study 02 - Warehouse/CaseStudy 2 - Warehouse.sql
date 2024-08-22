-- Case Study 2: Supply Chain management

USE warehousedb;

SELECT * FROM fmcg;


-- a) Find the Shape of the FMCG Table. 
-- Question: How would you determine the total number of rows and columns in the FMCG dataset?
SELECT COUNT(*) AS rows_count FROM fmcg; -- rows
SELECT COUNT(*) AS column_count FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='fmcg';


-- b) Evaluate the Impact of Warehouse Age on Performance. 
-- Question: How does the age of a warehouse impact its operational performance, specifically in terms of storage issues reported in the previous years?
SELECT (YEAR(GETDATE())-wh_est_year) AS wh_age, AVG(storage_issue_reported_l3m) avg_issues_reported
FROM fmcg
WHERE wh_est_year IS NOT NULL
GROUP BY (YEAR(GETDATE())-wh_est_year)
ORDER BY (YEAR(GETDATE())-wh_est_year);
-- insight: there is positive correlation between age of warehouse and average issues reported per year


-- c) Analyze the Relationship Between Flood-Proof Status and Transport Issues.
-- Question: Is there a significant relationship between flood-proof status and the number of transport issues reported last year?
SELECT flood_proof, SUM(transport_issue_l1y) AS total_reported_transport_issues
FROM fmcg
GROUP BY flood_proof;
-- insight: flood-proof warehouses have reported much less transport issues when compared to non flood-proof warehouses


-- d) Evaluate the Impact of Government Certification on Warehouse Performance.
-- Question: How does having a government certification impact the performance of warehouses, particularly in terms of breakdowns and storage issues?
SELECT approved_wh_govt_certificate, SUM(storage_issue_reported_l3m) AS total_storage_issue_reported, SUM(wh_breakdown_l3m) AS total_breakdown_reported
FROM fmcg
WHERE approved_wh_govt_certificate != 'NA'
GROUP BY approved_wh_govt_certificate
ORDER BY approved_wh_govt_certificate;
-- insight: comparing values of government certification to total number of breakdowns and storage issues, we find no relation between the values


-- e) Determine the Optimal Distance from Hub for Warehouses:
-- Question: What is the optimal distance from the hub for warehouses to minimize transport issues, based on the data provided?
SELECT transport_issue_l1y, AVG(dist_from_hub)
FROM fmcg
GROUP BY transport_issue_l1y
ORDER BY transport_issue_l1y;
-- insight: optimum distance from hub must be <= 162


-- f) Identify the Zones with the Most Operational Challenges.
-- Question: Which zones face the most operational challenges, considering factors like transport issues, storage problems, and breakdowns?
SELECT zone, SUM(transport_issue_l1y) AS total_transport_issues, SUM(storage_issue_reported_l3m) AS total_storage_issue_reported, SUM(wh_breakdown_l3m) AS total_breakdown_reported,
(SUM(transport_issue_l1y)+SUM(storage_issue_reported_l3m)+SUM(wh_breakdown_l3m)) AS total_operational_issues
FROM fmcg
GROUP BY zone
ORDER BY total_operational_issues;
-- insights: North has plenty of breakdown issues and East has least total issues


-- g) Identify High-Risk Warehouses Based on Breakdown Incidents and Age.
-- Question: Which warehouses are at high risk of breakdowns, especially considering their age and the number of breakdown incidents reported in the last 3 months?
SELECT Ware_house_ID, (YEAR(GETDATE())-wh_est_year) AS wh_age, SUM(wh_breakdown_l3m) AS total_breakdown_reported
FROM fmcg
WHERE (YEAR(GETDATE())-wh_est_year) IS NOT NULL
GROUP BY wh_est_year, Ware_house_ID
ORDER BY total_breakdown_reported DESC, wh_age ASC;

SELECT Ware_house_ID, (YEAR(GETDATE())-wh_est_year) AS wh_age, wh_breakdown_l3m,
CASE
	WHEN wh_breakdown_l3m >= 5 then 'High_Risk'
	WHEN wh_breakdown_l3m >= 3 then 'Medium_Risk'
	ELSE 'Low_Risk'
END AS Risk_Level
FROM fmcg 
WHERE (YEAR(GETDATE())-wh_est_year) > 15
ORDER BY wh_breakdown_l3m DESC;



-- h) Examine the Effectiveness of Warehouse Distribution Strategy.
-- Question: How effective is the current distribution strategy in each zone, based on the number of distributors connected to warehouses and their respective product weights?
SELECT zone, SUM(distributor_num) AS total_connected_distributors, SUM(product_wg_ton) total_wt_produced, SUM(product_wg_ton)/SUM(distributor_num) AS ratio
FROM fmcg
GROUP BY zone
ORDER BY ratio DESC;
-- insight: current distribution plan is best in East zone and worst in West and South zone


-- i) Correlation Between Worker Numbers and Warehouse Issues.
-- Question: Is there a correlation between the number of workers in a warehouse and the number of storage or breakdown issues reported?
SELECT workers_num, (AVG(storage_issue_reported_l3m)+AVG(wh_breakdown_l3m)) AS total_issues_reported
-- , AVG(storage_issue_reported_l3m), AVG(wh_breakdown_l3m)
FROM fmcg
WHERE workers_num IS NOT NULL
GROUP BY workers_num
ORDER BY workers_num;
-- there is no correlation betweennoof workers and issues reported


-- j) Assess the Zone-wise Distribution of Flood Impacted Warehouses.
-- Question: Which zones are most affected by flood impacts, and how does this affect their overall operational stability?
SELECT zone, SUM(flood_impacted) * 100 / COUNT(*) as percent_affected
FROM fmcg
GROUP BY zone
ORDER BY percent_affected DESC;
-- Similar to above
SELECT zone, COUNT(*) as total_warehouses,
SUM(CASE WHEN flood_impacted=1 THEN 1 ELSE 0 END) AS flood_impacted_warehouses,
SUM(CASE WHEN flood_impacted=1 THEN 1 ELSE 0 END) * 100 / COUNT(*) AS percent_affected
FROM fmcg
GROUP BY zone
ORDER BY percent_affected DESC;
-- insight: from the data obtained, we see North was affected the worst while East was affected the least


-- k) Calculate the Cumulative Sum of Total Working Years for Each Zone.
-- Question: How can you calculate the cumulative sum of total working years for each zone?
SELECT zone, SUM(YEAR(GETDATE())-wh_est_year) AS total_age
FROM fmcg
WHERE wh_est_year IS NOT NULL
GROUP BY zone;
-- below is the proper cumulative sum, above is mine, not exactly correct
SELECT zone, 
SUM(YEAR(GETDATE())-wh_est_year) OVER (ORDER BY zone ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative_age
FROM fmcg
WHERE wh_est_year IS NOT NULL;



-- extra) Calculate cumulative sum of total workers for each warehouse govt rating
SELECT approved_wh_govt_certificate, workers_num, 
SUM(workers_num) OVER (ORDER BY approved_wh_govt_certificate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative_count
FROM fmcg
WHERE approved_wh_govt_certificate != 'NA';

-- trying what happens it we use PARTITION BY
SELECT approved_wh_govt_certificate, workers_num, 
SUM(workers_num) OVER (PARTITION BY approved_wh_govt_certificate ORDER BY approved_wh_govt_certificate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative_count
FROM fmcg
WHERE approved_wh_govt_certificate != 'NA';

-- l) Rank Warehouses Based on Distance from the Hub.
-- Question: How would you rank warehouses based on their distance from the hub?
SELECT Ware_house_ID, dist_from_hub,
DENSE_RANK() OVER(ORDER BY dist_from_hub ASC) AS RANK
FROM fmcg;


-- m) Calculate the Running average of Product Weight in Tons for Each Zone:
-- Question: How can you calculate the runnings[/cumulative/moving] average of product weight in tons for each zone?
SELECT zone, product_wg_ton, 
AVG(product_wg_ton) OVER (ORDER BY zone ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_avg_product_wt
FROM fmcg;


-- n) Rank Warehouses Based on Total Number of Breakdown Incidents.
-- Question: How can you rank warehouses based on the total number of breakdown incidents in the last 3 months?
SELECT Ware_house_ID, wh_breakdown_l3m,
DENSE_RANK() OVER(ORDER BY wh_breakdown_l3m ASC) AS RANK
FROM fmcg;


-- o) Determine the Relation Between Transport Issues and Flood Impact.
-- Question: Is there any significant relationship
SELECT flood_impacted, SUM(transport_issue_l1y) AS total_transport_issues
FROM fmcg
GROUP BY flood_impacted;
-- insight: flood impacted warehouses have more transport issues and vice-versa


-- p) Calculate the Running Total of Product Weight in Tons for Each Zone.
-- Question: How can you calculate the running total of product weight in tons for each zone?
SELECT zone, product_wg_ton, 
SUM(product_wg_ton) OVER (ORDER BY zone ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_product_wt
FROM fmcg;


-- q) Rank Warehouses by Product Weight within Each Zone:
-- Question: How do you rank warehouses based on the product weight they handle within each zone, allowing ties?
SELECT Ware_house_ID, zone, product_wg_ton,
DENSE_RANK() OVER(PARTITION BY zone ORDER BY product_wg_ton ASC) AS product_rank
FROM fmcg;


-- r) Determine the Most Efficient Warehouses Using DENSE_RANK.
-- Question: How can you use DENSE_RANK to find the most efficient warehouses in terms of breakdown incidents within each zone?
SELECT * FROM (
	SELECT Ware_house_ID, zone, transport_issue_l1y, storage_issue_reported_l3m, wh_breakdown_l3m, 
	(transport_issue_l1y + storage_issue_reported_l3m + wh_breakdown_l3m) AS total_issues_reported, dist_from_hub,
	DENSE_RANK() OVER(PARTITION BY zone ORDER BY (transport_issue_l1y + storage_issue_reported_l3m + wh_breakdown_l3m), dist_from_hub) AS rank
	FROM fmcg
) AS _;


-- s) Calculate the Difference in Storage Issues Using LAG.
-- Question: How can you use LAG to calculate the difference in storage issues reported between consecutive warehouses within each zone?
SELECT * , (storage_issue_reported_l3m-prev_storage_issue_reported_l3m) AS diff
FROM (
	SELECT Ware_house_ID, zone, storage_issue_reported_l3m, 
	LAG(storage_issue_reported_l3m, 1) OVER(PARTITION BY zone ORDER BY Ware_house_ID) AS prev_storage_issue_reported_l3m 
	FROM fmcg
) AS _
WHERE prev_storage_issue_reported_l3m IS NOT NULL;


-- t) Compare Current and Next Warehouse's Distance Using LEAD:
-- Question: How can you compare the distance from the hub of the current warehouse to the next one using LEAD?
SELECT Ware_house_ID, dist_from_hub,
LEAD(dist_from_hub, 1) OVER(ORDER BY Ware_house_ID, dist_from_hub) AS next_dist_from_hub
FROM fmcg;


-- u) Calculate Cumulative Total of Product Weight by Zone
-- Question: How can you calculate the cumulative total of product weight handled by warehouses within each zone?
SELECT zone, product_wg_ton, 
SUM(product_wg_ton) OVER (PARTITION BY zone ORDER BY zone ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_total_product_wt
FROM fmcg;


-- v) Categorize Warehouses by Product Weight.
-- Question: How can you categorize warehouses as 'Low', 'Medium', or 'High'; based on the amount of product weight they handle?
-- below code uses NTILE to find 3 divisions
SELECT Ware_house_ID,product_wg_ton,
NTILE(3) OVER(ORDER BY product_wg_ton ASC) AS quartiles
FROM fmcg;
-- below code categorizes data
SELECT Ware_house_ID, product_wg_ton,
CASE
	WHEN product_wg_ton>0 AND product_wg_ton<=16097 THEN 'Low'
	WHEN product_wg_ton>0 AND product_wg_ton<=28059 THEN 'Medium'
	ELSE 'High'
END AS prod_wt_category
FROM fmcg;
-- merging both code, using subqueries is below [directly using the quartile values]:
SELECT Ware_house_ID, product_wg_ton,
CASE
	WHEN quartile=3 THEN 'High'
	WHEN quartile=2 THEN 'Medium'
	ELSE 'Low'
END AS prod_wt_category
FROM (
	SELECT Ware_house_ID,product_wg_ton,
	NTILE(3) OVER(ORDER BY product_wg_ton ASC) AS quartile
	FROM fmcg
) as tile
ORDER BY Ware_house_ID;


-- w) Determine Risk Levels Based on Storage Issues.
-- Question: How can you determine the risk level of each warehouse based on the number of storage issues reported in the last 3 months?
SELECT Ware_house_ID, storage_issue_reported_l3m
FROM fmcg


-- x) Create a Stored Procedure to Fetch High-Risk Warehouses:
-- Question: How would you create a stored procedure that returns all warehouses classified as 'High Risk' based on the number of breakdowns and storage issues?
GO
CREATE PROCEDURE HighRiskWarehouse
AS
BEGIN
	SELECT Ware_house_ID, transport_issue_l1y, storage_issue_reported_l3m, wh_breakdown_l3m
	FROM fmcg
	WHERE transport_issue_l1y>0 AND (storage_issue_reported_l3m>10 OR wh_breakdown_l3m>5);
END;
GO
EXEC HighRiskWarehouse


-- y) Create a Stored Procedure to Calculate Warehouse Efficiency:
-- Question: How would you create a stored procedure to calculate and return the efficiency of each warehouse based on its product weight and number of distributors?
GO
CREATE PROCEDURE WareHouseEfficiency
AS
BEGIN
	SELECT *, 
	CASE
		WHEN quartile=3 THEN 'High'
		WHEN quartile=2 THEN 'Medium'
		ELSE 'Low'
	END AS efficiency_category
	FROM
	(SELECT Ware_house_ID, product_wg_ton, distributor_num, (product_wg_ton/distributor_num) AS efficiency_val,
	NTILE(3) OVER(ORDER BY product_wg_ton/distributor_num) AS quartile
	FROM fmcg
	) AS Efficiency_table 
	ORDER BY quartile DESC
END;
GO
EXEC WareHouseEfficiency
-- DROP PROCEDURE WareHouseEfficiency


-- z) Create a View for Warehouse Overview:
-- Question: How can you create a view that shows an overview of warehouses, including their location, product weight, and flood-proof status?
GO
CREATE VIEW fmcgOverview
AS
	SELECT Ware_house_ID, Location_type, product_wg_ton, flood_proof
	FROM fmcg ;
GO
SELECT * FROM fmcgOverview;
-- insight: above shows how ton create a view[a temporary table]. view is declared using table|tables or a SQL query. doesnt store any records in it

-- aa) Create a View for High-Capacity Warehouses. 
-- Question: How would you create a view to display only those warehouses with a product weight greater than 100 tons?
GO
CREATE VIEW fmcg_product_wg_ton_over_100
AS
	SELECT Ware_house_ID, product_wg_ton
	FROM fmcg
	WHERE product_wg_ton > 100
GO
SELECT * FROM fmcg_product_wg_ton_over_100
-- DROP VIEW fmcg_product_wg_ton_over_100
-- insight: above code shows how to create a VIEW to display only warehouses with a product_wt over 100ton