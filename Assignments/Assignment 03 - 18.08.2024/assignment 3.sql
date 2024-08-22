-- Assignment 3

DECLARE @Databasename VARCHAR(128) = 'HREmployeeDB'; -- declare variable

IF NOT EXISTS(select 1 FROM sys.databases where name = @Databasename)   -- test condition to check if database exists
BEGIN
	DECLARE @SQL NVARCHAR(MAX) = 'CREATE DATABASE ' + QUOTENAME(@Databasename)
	EXEC sp_executesql @SQL;
END


USE HREmployeeDB;



CREATE TABLE EmployeeHRData (
    Attrition VARCHAR(4),
    Business_Travel VARCHAR(20),
    CF_age_band VARCHAR(20),
    CF_attrition_label VARCHAR(20),
    Department VARCHAR(50),
    Education_Field VARCHAR(50),
    emp_no VARCHAR(20),
    Employee_Number INT,
    Gender VARCHAR(10),
    Job_Role VARCHAR(50),
    Marital_Status VARCHAR(20),
    Over_Time VARCHAR(10),
    Over18 VARCHAR(5),
    Training_Times_Last_Year INT,
    Age INT,
    CF_current_Employee VARCHAR(10),
    Daily_Rate INT,
    Distance_From_Home INT,
    Education VARCHAR(20),
    Employee_Count INT,
    Environment_Satisfaction INT,
    Hourly_Rate INT,
    Job_Involvement INT,
    Job_Level INT,
    Job_Satisfaction INT,
    Monthly_Income INT,
    Monthly_Rate INT,
    Num_Companies_Worked INT,
    Percent_Salary_Hike INT,
    Performance_Rating INT,
    Relationship_Satisfaction INT,
    Standard_Hours INT,
    Stock_Option_Level INT,
    Total_Working_Years INT,
    Work_Life_Balance INT,
    Years_At_Company INT,
    Years_In_Current_Role INT,
    Years_Since_Last_Promotion INT,
    Years_With_Curr_Manager INT
);

-- DROP TABLE EmployeeHRData;


BULK INSERT EmployeeHRData 
FROM 'D:/HR Employee.csv'
WITH (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	FIRSTROW = 2
);



SELECT * FROM EmployeeHRData;
-- DROP TABLE EmployeeHRData;


-- a) Return the shape of the table
SELECT 
	(SELECT COUNT(*) FROM EmployeeHRData) AS row_count,
	(SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='EmployeeHRData') AS column_count
-- insight: output table shows count of rows and columns in the main table


-- b) Calculate the cumulative sum of total working years for each department
SELECT Department, Total_Working_Years, 
SUM(Total_Working_Years) OVER(PARTITION BY Department ORDER BY Department ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_years
FROM EmployeeHRData;
-- insight: cumulative sum of total working years, partitioned by department, is calculated


-- c) Which gender have higher strength as workforce in each department
SELECT Department, Gender, gender_freq
FROM (
	SELECT Department, Gender, COUNT(Gender) as gender_freq, DENSE_RANK() OVER(PARTITION BY Department ORDER BY COUNT(Gender) DESC) AS freq_ranking
	FROM EmployeeHRData
	GROUP BY Department, Gender
) AS _
WHERE freq_ranking = 1;
-- insight: found that for departments 'HR', 'R&D' and 'Sales', gender 'Male' has higher strength in workforce 


-- d) Create a new column AGE_BAND and Show Distribution of Employee's Age band group (Below 25, 25-34, 35-44, 45-55. ABOVE 55).
ALTER TABLE EmployeeHRData ADD AGE_BAND VARCHAR(20);

UPDATE EmployeeHRData
	SET AGE_BAND = 
		CASE
			WHEN Age < 25 THEN 'Below 25'
			WHEN Age BETWEEN 25 AND 34 THEN '25-34'
			WHEN Age BETWEEN 35 AND 44 THEN '35-44'
			WHEN Age BETWEEN 45 AND 55 THEN '45-55'
			WHEN Age > 55 THEN 'ABOVE 55'
			ELSE NULL
		END;

SELECT AGE_BAND, COUNT(*) AS age_band_distribution
FROM EmployeeHRData
GROUP BY AGE_BAND;
-- insight: altered table to add a new column and set values according to given band groups. then used aggregate function COUNT to find distribution


-- e) Compare all marital status of employee and find the most frequent marital status
SELECT Marital_Status, COUNT(Marital_Status) AS Marital_Status_frequency
FROM EmployeeHRData
GROUP BY Marital_Status
ORDER BY COUNT(Marital_Status) DESC;
-- insight: from the given dataset, most frequent marital status is 'Married' with a frequency of 673


-- f) Show the Job Role with Highest Attrition Rate (Percentage)
SELECT Job_Role, attrition_count_in_dept, total_count_in_dept, ROUND(attrition_count_in_dept*100.0/total_count_in_dept, 2) AS attrition_percentage_in_department
FROM (
	SELECT Job_Role, COUNT(*) AS total_count_in_dept, 
	SUM(
		CASE
			WHEN Attrition = 'Yes' THEN 1
			ELSE 0
		END
	) as attrition_count_in_dept
	FROM EmployeeHRData
	GROUP BY Job_Role
) AS _
ORDER BY attrition_percentage_in_department DESC;
-- insight: job role with highest rate of attrition is 'Sales Representative'


-- g) Show distribution of Employee's Promotion, Find the maximum chances of employee getting promoted.
SELECT Years_Since_Last_Promotion, COUNT(*) AS frequency
FROM EmployeeHRData
GROUP BY Years_Since_Last_Promotion
ORDER BY COUNT(*) DESC;
-- above query shows distribution of promotions based on years since last promotion. 
-- from its result we see that only a few employees have not been promoted for a long time

SELECT Years_Since_Last_Promotion, Total_Working_Years,  COUNT(*) AS frequency
FROM EmployeeHRData
WHERE Years_At_Company>0 
GROUP BY Total_Working_Years, Years_Since_Last_Promotion
ORDER BY COUNT(*) DESC, Years_Since_Last_Promotion, Total_Working_Years;
-- from the above SQL query, it can be found that those who have worked for longer have been promoted more


-- h) Show the cumulative sum of total working years for each department.
SELECT Department, Total_Working_Years, 
SUM(Total_Working_Years) OVER(PARTITION BY Department ORDER BY Department ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_years
FROM EmployeeHRData;
-- insight: cumulative sum of total working years, partitioned by department, is calculated


-- i) Find the rank of employees within each department based on their monthly income
SELECT Employee_Number, emp_no, Department, Monthly_Income, DENSE_RANK() OVER(PARTITION BY Department ORDER BY Monthly_Income DESC) as ranked
FROM EmployeeHRData;
-- insight: employees ranked within their departments based on monthly income
-- STAFF-1338, STAFF-259, STAFF-1282 have been ranked 1 in departments HR, R&D, Sales respectively


-- j) Calculate the running total of 'Total Working Years' for each employee within each department and age band.
SELECT emp_no, Employee_Number, Department, CF_age_band, Total_Working_Years,
SUM(Total_Working_Years) OVER(PARTITION BY Department, CF_age_band ORDER BY Department, CF_age_band ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total 
FROM EmployeeHRData
-- running total based on total_working_years for employees within each department and age_band found


-- k) For each employee who left, calculate the number of years they worked before leaving 
--    and compare it with the average years worked by employees in the same department.
SELECT *,
CASE
	WHEN Years_At_Company<Avg_Years_At_Department THEN 'LESSER'
	WHEN Years_At_Company>Avg_Years_At_Department THEN 'GREATER'
	ELSE 'Equal'
END AS comparison
FROM (
	SELECT Employee_Number, emp_no, Years_At_Company, mainTable.Department, avgYearsTable.avgAtDept AS Avg_Years_At_Department
	FROM EmployeeHRData AS mainTable
	JOIN (
		SELECT Department, AVG(Years_At_Company) AS avgAtDept
		FROM EmployeeHRData
		GROUP BY Department
	) AS avgYearsTable
	ON avgYearsTable.Department = mainTable.Department
	WHERE Attrition = 'Yes'
) AS _
ORDER BY Employee_Number;
-- insight: SQL query compares an ex-employee's years at company with average of years at company
-- LESSER if they have worked for a period less than average, and vice-versa


-- l) Rank the departments by the average monthly income of employees who have left.
SELECT Department, AVG(Monthly_Income) AS dept_avg_monthly_income, DENSE_RANK() OVER(ORDER BY AVG(Monthly_Income) DESC) AS ranks
FROM EmployeeHRData
WHERE Attrition = 'Yes'
GROUP BY Department;
-- insight: ranking department by average of monthly income of ex-employees, 'Sales' department is rank 1 followed by 'R&D' at 2 and 'HR' at 3


-- m) Find the if there is any relation between Attrition Rate and Marital Status of Employee.
SELECT 
	attritionTable.Attrition,
	attritionTable.Marital_Status,
	attritionTable.frequency,
	ROUND((attritionTable.frequency*100.0/totalEmployeeTable.total_freq_per_Marital_Status), 2) AS Attrition_Rate
FROM (
	SELECT Attrition, Marital_Status, COUNT(*) AS frequency
	FROM EmployeeHRData
	GROUP BY Attrition, Marital_Status
--	ORDER BY Marital_Status
) AS attritionTable
JOIN (
	SELECT Marital_Status, COUNT(*) AS total_freq_per_Marital_Status
	FROM EmployeeHRData
	GROUP BY Marital_Status
) AS totalEmployeeTable
ON attritionTable.Marital_Status = totalEmployeeTable.Marital_Status
ORDER BY attritionTable.Marital_Status
-- insight: Employees who fall under the categories of 'Married' and 'Divorced' have a lower attrition rate(10-12.5%), than compared to 'Single's(~25%)


-- n) Show the Department with Highest Attrition Rate (Percentage)
SELECT TOP 1 dept_attrition_table.Department, per_dept_attrition, per_dept_employees, ROUND(per_dept_attrition*100.0/per_dept_employees, 2) AS dept_attrition_percentage
FROM (
	SELECT Department, COUNT(*) AS per_dept_attrition
	FROM EmployeeHRData
	WHERE Attrition = 'Yes'
	GROUP BY Department
) AS dept_attrition_table
JOIN (
	SELECT Department, COUNT(*) AS per_dept_employees
	FROM EmployeeHRData
	GROUP BY Department
) AS dept_employees_table
ON dept_attrition_table.Department = dept_employees_table.Department
ORDER BY dept_attrition_percentage DESC;
-- insight: Department with highest attrition percentage is 'Sales'(~21%)


-- o) Calculate the moving average of monthly income over the past 3 employees for each job role.
SELECT emp_no, Employee_Number, Job_Role, Monthly_Income,
AVG(Monthly_Income) OVER(PARTITION BY Job_Role ORDER BY Employee_Number ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_past3_employees
FROM EmployeeHRData;
-- insight: calculated moving average of monthly income over past 3 employees, for each job role


-- p) Identify employees with outliers in monthly income within each job role. 
--    [ Condition : Monthly_Income < Q1 - (Q3 - Q1) * 1.5 OR Monthly_Income > Q3 + (Q3 - Q1) ]
SELECT emp_no, Job_Role, Monthly_Income
FROM (
	SELECT *, 
	PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY Monthly_Income) OVER(PARTITION BY Job_Role) AS q1,
	PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY Monthly_Income) OVER(PARTITION BY Job_Role) AS q3
	FROM EmployeeHRData
) AS _
WHERE Monthly_Income<q1-1.5*(q3-q1) OR Monthly_Income>q3+1.5*(q3-q1)
ORDER BY Job_Role;
-- insight: The SQL quey shows details of staff in each job role, whose monthly income is outlier within the given data


-- q) Gender distribution within each job role, show each job role with its gender domination.  
--    [Male_Domination or Female_Domination]
SELECT *,
CASE
	WHEN Gender='Male' THEN 'Male_Domination'
	WHEN Gender='Female' THEN 'Female_Domination'
END AS dominating_gender_in_job_role
FROM (
	SELECT Job_Role, Gender, COUNT(*) AS frequency, DENSE_RANK() OVER(PARTITION BY Job_Role ORDER BY Gender DESC) AS ranking
	FROM EmployeeHRData
	GROUP BY Job_Role, Gender
) AS _
WHERE ranking = 1;
-- insight: all 9 job roles, are found to be dominated by men


-- r) Percent rank of employees based on training times last year
SELECT emp_no, Training_Times_Last_Year, 
PERCENT_RANK() OVER(ORDER BY Training_Times_Last_Year) AS percent_rank
FROM EmployeeHRData;
-- insight: PERCENT_RANK() function was used to find percent rank of employees based on the number of times they had training last year.
-- results are shown in the below table


-- s) Divide employees into 5 groups based on training times last year [Use NTILE ()]
SELECT emp_no, Job_Role, Training_Times_Last_Year, 
NTILE(5) OVER(ORDER BY Training_Times_Last_Year) AS group_by_training_times_ly
FROM EmployeeHRData;
-- used NTILE function to group employees into 5 groups based on training times of previous year


-- t) Categorize employees based on training times last year as - Frequent Trainee, Moderate Trainee, Infrequent Trainee.
SELECT *,
CASE
	WHEN category=1 THEN 'Infrequent Trainee'
	WHEN category=2 THEN 'Moderate Trainee'
	WHEN category=3 THEN 'Frequent Trainee'
END AS categorized_by_training_ly
FROM (
	SELECT emp_no, Employee_Number, Job_Role, Training_Times_Last_Year, 
	NTILE(3) OVER(ORDER BY Training_Times_Last_Year) AS category
	FROM EmployeeHRData
) AS _
ORDER BY Employee_Number;
-- insight: above SQL query categorized employees based on training times of previous year


-- u) Categorize employees as 'High', 'Medium', or 'Low' performers based on their performance rating, using a CASE WHEN statement.
SELECT emp_no, Performance_Rating,
CASE
	WHEN performance_percentile=1 THEN 'Low'
	WHEN performance_percentile=2 THEN 'Medium'
	WHEN performance_percentile=3 THEN 'High'
END AS performance_band
FROM (
	SELECT emp_no, Employee_Number, Performance_Rating, NTILE(3) OVER(ORDER BY Performance_Rating) AS performance_percentile
	FROM EmployeeHRData
) AS _
ORDER BY Employee_Number;
-- insight: above sql query was used to categorize employees using performance ratings


-- v) Use a CASE WHEN statement to categorize employees into 'Poor', 'Fair', 'Good', or 'Excellent'  work-life balance 
--    based on their work-life balance score.
SELECT emp_no, Employee_Number, Work_Life_Balance,
CASE
	WHEN Work_Life_Balance=1 THEN 'Poor'
	WHEN Work_Life_Balance=2 THEN 'Fair'
	WHEN Work_Life_Balance=3 THEN 'Good'
	WHEN Work_Life_Balance=4 THEN 'Excellent'
END AS wlb_category
FROM EmployeeHRData;
-- insight: above SQL query was used to categorize each employee based on work-life balance score


-- w) Group employees into 3 groups based on their stock option level using the [NTILE] function.
SELECT emp_no, Stock_Option_Level, NTILE(3) OVER(ORDER BY Stock_Option_Level) AS group_num
FROM EmployeeHRData;
-- insight: above SQL query was used to group employees into 3 distinct groups based on their Stock_Option_Level value


-- x) Find key reasons for Attrition in Company
SELECT (Environment_Satisfaction+Job_Satisfaction+Relationship_Satisfaction) AS satisfaction_factor, Education, COUNT(*) AS attrition_frequency
FROM EmployeeHRData
WHERE Attrition='YES'
GROUP BY Education, (Environment_Satisfaction+Job_Satisfaction+Relationship_Satisfaction)
ORDER BY COUNT(*) DESC, satisfaction_factor, Education;
-- insight: Employees with a lower level of education or low 'satisfaction_factor' have a higher chance of leaving, 
-- but those with a higher level of education are much less likely to leave
-- also, with a high value of 'satisfaction_factor' , they are less likely to leave inspite of education level

SELECT CF_age_band, Gender, Marital_Status, COUNT(*) AS frequency
FROM EmployeeHRData
WHERE Attrition='YES' 
GROUP BY CF_age_band, Gender, Marital_Status
ORDER BY CF_age_band;
-- from the above SQL query, we conclude that those who are in age range of 25 to 34 leave the most
-- inspite of age group, single males have higher chance of attrition

SELECT Percent_Salary_Hike, COUNT(*) AS frequency
FROM EmployeeHRData
WHERE Attrition='YES' 
GROUP BY Percent_Salary_Hike
ORDER BY frequency DESC;
-- using the above query, it can be clearly seen that employees with a lesser salary hike are have a higher cance of attrition 