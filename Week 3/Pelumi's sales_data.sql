-- Created  a database for week 3 project's.
CREATE DATABASE Week3_AnalystLab_Project;

-- Imported the dataset using the table data import wizard.

-- DATA CLEANING AND FAMILIRIZATION.

-- Retrieve all rows from the sales_data_sample table to inspect the full dataset.
SELECT * FROM sales_data_sample;

-- Verified import by counting the total number of records in the sales_data_sample table.
SELECT COUNT(*) FROM sales_data_sample;

-- Display the first 10 rows of the dataset.
SELECT * FROM sales_data_sample LIMIT 10;

-- Rename the incorrectly encoded column to ORDERNUMBER and set its data type to INT.
ALTER TABLE sales_data_sample
CHANGE COLUMN `ï»¿ORDERNUMBER` ORDERNUMBER INT;

-- Show the structure of the sales_data_sample table including column names and data types.
DESCRIBE sales_data_sample;

-- Handling missing data.

-- Checking numerical columns for missing values.
SELECT
SUM(CASE WHEN ORDERNUMBER IS NULL THEN 1 ELSE 0 END) AS ORDERNUMBER_missing,
SUM(CASE WHEN QUANTITYORDERED IS NULL THEN 1 ELSE 0 END) AS QUANTITYORDERED_missing,
SUM(CASE WHEN PRICEEACH IS NULL THEN 1 ELSE 0 END) AS PRICEEACH_missing,
SUM(CASE WHEN ORDERLINENUMBER IS NULL THEN 1 ELSE 0 END) AS ORDERLINENUMBER_missing,
SUM(CASE WHEN SALES IS NULL THEN 1 ELSE 0 END) AS SALES_missing,
SUM(CASE WHEN ORDERDATE IS NULL THEN 1 ELSE 0 END) AS ORDERDATE_missing,
SUM(CASE WHEN QTR_ID IS NULL THEN 1 ELSE 0 END) AS QTR_ID_missing,
SUM(CASE WHEN MONTH_ID IS NULL THEN 1 ELSE 0 END) AS MONTH_ID_missing,
SUM(CASE WHEN YEAR_ID IS NULL THEN 1 ELSE 0 END) AS YEAR_ID_missing,
SUM(CASE WHEN MSRP IS NULL THEN 1 ELSE 0 END) AS MSRP_missing
FROM sales_data_sample;

-- Checking text columns for null values, blank values, and whitespaces.
SELECT
SUM(CASE WHEN STATUS IS NULL OR TRIM(STATUS) = '' THEN 1 ELSE 0 END) AS STATUS_missing,
SUM(CASE WHEN PRODUCTLINE IS NULL OR TRIM(PRODUCTLINE) = '' THEN 1 ELSE 0 END) AS PRODUCTLINE_missing,
SUM(CASE WHEN PRODUCTCODE IS NULL OR TRIM(PRODUCTCODE) = '' THEN 1 ELSE 0 END) AS PRODUCTCODE_missing,
SUM(CASE WHEN CUSTOMERNAME IS NULL OR TRIM(CUSTOMERNAME) = '' THEN 1 ELSE 0 END) AS CUSTOMERNAME_missing,
SUM(CASE WHEN PHONE IS NULL OR TRIM(PHONE) = '' THEN 1 ELSE 0 END) AS PHONE_missing,
SUM(CASE WHEN ADDRESSLINE1 IS NULL OR TRIM(ADDRESSLINE1) = '' THEN 1 ELSE 0 END) AS ADDRESSLINE1_missing,
SUM(CASE WHEN ADDRESSLINE2 IS NULL OR TRIM(ADDRESSLINE2) = '' THEN 1 ELSE 0 END) AS ADDRESSLINE2_missing,
SUM(CASE WHEN CITY IS NULL OR TRIM(CITY) = '' THEN 1 ELSE 0 END) AS CITY_missing,
SUM(CASE WHEN STATE IS NULL OR TRIM(STATE) = '' THEN 1 ELSE 0 END) AS STATE_missing,
SUM(CASE WHEN POSTALCODE IS NULL OR TRIM(POSTALCODE) = '' THEN 1 ELSE 0 END) AS POSTALCODE_missing,
SUM(CASE WHEN COUNTRY IS NULL OR TRIM(COUNTRY) = '' THEN 1 ELSE 0 END) AS COUNTRY_missing,
SUM(CASE WHEN TERRITORY IS NULL OR TRIM(TERRITORY) = '' THEN 1 ELSE 0 END) AS TERRITORY_missing,
SUM(CASE WHEN CONTACTLASTNAME IS NULL OR TRIM(CONTACTLASTNAME) = '' THEN 1 ELSE 0 END) AS CONTACTLASTNAME_missing,
SUM(CASE WHEN CONTACTFIRSTNAME IS NULL OR TRIM(CONTACTFIRSTNAME) = '' THEN 1 ELSE 0 END) AS CONTACTFIRSTNAME_missing,
SUM(CASE WHEN DEALSIZE IS NULL OR TRIM(DEALSIZE) = '' THEN 1 ELSE 0 END) AS DEALSIZE_missing
FROM sales_data_sample;

-- Missing data was found in in ADDRESSLINE2_missing, STATE_missing, and POSTALCODE_missing.
-- Checking the type of missing values in STATE.
SELECT 
SUM(CASE WHEN STATE IS NULL THEN 1 ELSE 0 END) AS null_values,
SUM(CASE WHEN STATE = '' THEN 1 ELSE 0 END) AS blank_values,
SUM(CASE WHEN TRIM(STATE) = ''AND STATE IS NOT NULL AND STATE <> ''THEN 1 ELSE 0 END) AS whitespace_values
FROM sales_data_sample;

-- Checking the type of missing values in ADDRESSLINE2.
SELECT
SUM(CASE WHEN ADDRESSLINE2 IS NULL THEN 1 ELSE 0 END) AS null_values,
SUM(CASE WHEN ADDRESSLINE2 = '' THEN 1 ELSE 0 END) AS blank_values,
SUM(CASE WHEN TRIM(ADDRESSLINE2) = '' AND ADDRESSLINE2 IS NOT NULL AND ADDRESSLINE2 <> '' THEN 1 ELSE 0 END) AS whitespace_values
FROM sales_data_sample;

-- Checking the type of missing values in POSTALCODE.
SELECT
SUM(CASE WHEN POSTALCODE IS NULL THEN 1 ELSE 0 END) AS null_values,
SUM(CASE WHEN POSTALCODE = '' THEN 1 ELSE 0 END) AS blank_values,
SUM(CASE WHEN TRIM(POSTALCODE) = '' AND POSTALCODE IS NOT NULL AND POSTALCODE <> '' THEN 1 ELSE 0 END) AS whitespace_values
FROM sales_data_sample;

-- Replace missing or blank STATE values with 'Unknown'.
UPDATE sales_data_sample
SET STATE = 'Unknown'
WHERE (STATE IS NULL OR TRIM(STATE) = '')
AND ORDERNUMBER IS NOT NULL;

-- Replace missing or blank ADDRESSLINE2 values with 'Unknown'.
UPDATE sales_data_sample
SET ADDRESSLINE2 = 'Unknown'
WHERE ADDRESSLINE2 IS NULL OR TRIM(ADDRESSLINE2) = '';

-- Replace missing or blank POSTALCODE values with 'Unknown'.
UPDATE sales_data_sample
SET POSTALCODE = 'Unknown'
WHERE POSTALCODE IS NULL OR TRIM(POSTALCODE) = '';

-- Handling Duplicate Data.

-- Check for completely identical duplicate rows in the dataset.
SELECT *,
COUNT(*) AS duplicate_count
FROM sales_data_sample
GROUP BY
ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER,
SALES, ORDERDATE, STATUS, QTR_ID, MONTH_ID, YEAR_ID,
PRODUCTLINE, MSRP, PRODUCTCODE, CUSTOMERNAME, PHONE,
ADDRESSLINE1, ADDRESSLINE2, CITY, STATE, POSTALCODE,
COUNTRY, TERRITORY, CONTACTLASTNAME, CONTACTFIRSTNAME,
DEALSIZE
HAVING COUNT(*) > 1;

-- Check duplicate order line entries.
SELECT ORDERNUMBER, PRODUCTCODE, ORDERLINENUMBER,
       COUNT(*) AS duplicate_count
FROM sales_data_sample
GROUP BY ORDERNUMBER, PRODUCTCODE, ORDERLINENUMBER
HAVING COUNT(*) > 1;

-- Unique Category Exploration.

-- View all unique product lines in the dataset.
SELECT DISTINCT PRODUCTLINE
FROM sales_data_sample
ORDER BY PRODUCTLINE;

-- View all unique countries where customers are located.
SELECT DISTINCT COUNTRY
FROM sales_data_sample
ORDER BY COUNTRY;

-- View all unique sales territories.
SELECT DISTINCT TERRITORY
FROM sales_data_sample
ORDER BY TERRITORY;

-- View all unique deal size categories.
SELECT DISTINCT DEALSIZE
FROM sales_data_sample;

-- View all unique order statuses.
SELECT DISTINCT STATUS
FROM sales_data_sample;

-- Handling Zero and Negative values.

-- Identify records with invalid sales values.
SELECT *
FROM sales_data_sample
WHERE SALES <= 0;

-- Count number of rows with zero or negative sales.
SELECT COUNT(*) AS invalid_sales_count
FROM sales_data_sample
WHERE SALES <= 0;

-- Inspect negative sales rows in detail.
SELECT ORDERNUMBER, PRODUCTCODE, QUANTITYORDERED, PRICEEACH, SALES
FROM sales_data_sample
WHERE SALES <= 0;

-- Outlier Detection.

-- View top 10 highest sales transactions.
SELECT
ORDERNUMBER,
CUSTOMERNAME,
PRODUCTLINE,
SALES
FROM sales_data_sample
ORDER BY SALES DESC
LIMIT 10;

-- View lowest sales transactions.
SELECT
    ORDERNUMBER,
    CUSTOMERNAME,
    PRODUCTLINE,
    SALES
FROM sales_data_sample
ORDER BY SALES ASC
LIMIT 10;

-- Detect high-value outliers.
SELECT *
FROM sales_data_sample
WHERE SALES > 10000;

-- Detect unusually low (but non-zero) sales.
SELECT *
FROM sales_data_sample
WHERE SALES > 0 AND SALES < 100;

-- SQL ANALYSIS.

-- Total revenue generated from all sales.
SELECT 
ROUND(SUM(SALES), 2) AS total_revenue
FROM sales_data_sample;

-- Yearly revenue performance.
SELECT YEAR_ID, ROUND(SUM(SALES), 2) AS yearly_revenue
FROM sales_data_sample
GROUP BY YEAR_ID
ORDER BY yearly_revenue DESC;

-- Monthly revenue trends.
SELECT 
MONTH_ID,
ROUND(SUM(SALES), 2) AS monthly_revenue
FROM sales_data_sample
GROUP BY MONTH_ID
ORDER BY MONTH_ID;

-- Best-performing product categories.
SELECT 
PRODUCTLINE,
ROUND(SUM(SALES), 2) AS revenue
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY revenue DESC;

-- Geographic revenue distribution.
SELECT 
COUNTRY,
ROUND(SUM(SALES), 2) AS revenue
FROM sales_data_sample
GROUP BY COUNTRY
ORDER BY revenue DESC;

-- Check distribution of order statuses.
SELECT 
STATUS,
COUNT(*) AS total_orders
FROM sales_data_sample
GROUP BY STATUS
ORDER BY total_orders DESC;

-- Revenue contribution by deal size.
SELECT 
DEALSIZE,
ROUND(SUM(SALES), 2) AS revenue
FROM sales_data_sample
GROUP BY DEALSIZE
ORDER BY revenue DESC;

-- Segment customers based on purchase value.
SELECT 
    CUSTOMERNAME,
    SUM(SALES) AS total_spent,
    CASE 
        WHEN SUM(SALES) > 100000 THEN 'VIP Customer'
        WHEN SUM(SALES) BETWEEN 50000 AND 100000 THEN 'Regular Customer'
        ELSE 'Low Value Customer'
    END AS customer_segment
FROM sales_data_sample
GROUP BY CUSTOMERNAME;

-- WINDOWS FUNCTION.

-- Rank customers based on total spending.
SELECT 
    CUSTOMERNAME,
    SUM(SALES) AS total_spent,
    RANK() OVER (ORDER BY SUM(SALES) DESC) AS customer_rank
FROM sales_data_sample
GROUP BY CUSTOMERNAME;

-- Rank product lines by revenue
SELECT 
    PRODUCTLINE,
    SUM(SALES) AS revenue,
    DENSE_RANK() OVER (ORDER BY SUM(SALES) DESC) AS product_rank
FROM sales_data_sample
GROUP BY PRODUCTLINE;

-- Monthly revenue comparison
SELECT 
    YEAR_ID,
    MONTH_ID,
    SUM(SALES) AS monthly_revenue,
    LAG(SUM(SALES)) OVER (
        ORDER BY YEAR_ID, MONTH_ID
    ) AS previous_month_revenue
FROM sales_data_sample
GROUP BY YEAR_ID, MONTH_ID;

-- Cumulative revenue over time
SELECT 
    YEAR_ID,
    MONTH_ID,
    SUM(SALES) AS monthly_revenue,
    SUM(SUM(SALES)) OVER (
        ORDER BY YEAR_ID, MONTH_ID
    ) AS running_total
FROM sales_data_sample
GROUP BY YEAR_ID, MONTH_ID;

SELECT * FROM sales_data_sample;
