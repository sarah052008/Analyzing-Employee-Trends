--/ table creation
create table  EmployeeDetails (
 emp_no INT PRIMARY KEY,
 gender NVARCHAR(10),
 marital_status NVARCHAR(10),
 age_band NVARCHAR(20),
 age INT,
 department NVARCHAR(50),
 education NVARCHAR(50),
 education_field NVARCHAR(50),
 job_role NVARCHAR(50),
 business_travel NVARCHAR(20),
 employee_count INT,
 attrition NVARCHAR(5),
 attrition_label NVARCHAR(20),
 job_satisfaction INT,
 active_employee BIT
 );
 BULK INSERT EmployeeDetails
 FROM'C:\employee data\employee_trends.csv'
 WITH (
 FIELDTERMINATOR = ',',
 ROWTERMINATOR ='\n',
 FIRSTROW = 2,
 KEEPNULLS,
 CODEPAGE='65001'
 );
-- 1. Count the number of employees in each department
select * From EmployeeDetails;
select  department from EmployeeDetails;

SELECT department, COUNT(emp_no) AS employee_count
FROM EmployeeDetails
GROUP BY department;

select department, count(age) AS ageaverage;
from EmployeeDetails
where ageaverage = AVG(age)
GROUP BY department;

-- 2. Calculate the average age for each department

SELECT department, AVG(age) AS age_average
FROM EmployeeDetails
GROUP BY department;

-- 3. Identify the most common job roles in each department

SELECT department,job_role, COUNT(job_role) AS must_communjob
FROM EmployeeDetails
GROUP BY department, job_role
ORDER BY department ,must_communjob DESC;

-- 4. Calculate the average job satisfaction for each education level

select education, AVG(job_satisfaction) AS Jsatisfaction
from EmployeeDetails
group by education

-- 5. Determine the average age for employees with different levels of jobsatisfaction
select job_satisfaction, AVG(Age) AS avgage
FROM EmployeeDetails
GROUP BY job_satisfaction;

-- 6. Calculate the attrition rate for each age band

SELECT  age_band, COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*) AS attrition_rate 
FROM EmployeeDetails E
GROUP BY age_band;

SELECT age_band, 
       CAST(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5, 2)) AS attrition_rate
FROM EmployeeDetails
GROUP BY age_band;

-- 7. Identify the department with the highest and lowest average job satisfaction
SELECT department, AVG(job_satisfaction) AS avjobsat
FROM EmployeeDetails
GROUP BY department;


/-- 8. The age band with the highest attrition rate among employees with a
 specific education level
SELECT top 1 age_band,education,
       CAST(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5, 2)) AS attrition_rate
FROM EmployeeDetails
GROUP BY age_band, education
ORDER BY attrition_rate DESC;

/-- 9. The education level with the highest average job satisfaction among employees who travel frequently

select top 3 education, business_travel, AVG(job_satisfaction) AS avjobsat
FROM EmployeeDetails
where business_travel = 'Travel_frequently'
GROUP by business_travel, education
ORDER BY avjobsat DESC;

SELECT marital_status from EmployeeDetails

-- 10/ Identify the age band with the highest average job satisfaction among married employees

SELECT age_band, AVG(job_satisfaction) AS avjobsat
FROM EmployeeDetails
WHERE marital_status= 'Married'
group by age_band 
ORDER BY avjobsat DESC;






