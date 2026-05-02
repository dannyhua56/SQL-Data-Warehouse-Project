
/*
===============================================================================
Quality Checks
===============================================================================

Script Purpose:
    This script performs various quality checks for data consistency, accuracy,
    and standardization across the 'silver' schema. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.

===============================================================================
*/


-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results


--CHECK FOR NULLS OR DUPLICATES IN PRIMARY KEY

SELECT 
cst_id,
COUNT(*) counting_all
FROM silver.crm_cust_info
group by cst_id
HAVING COUNT(*) > 1 or cst_id IS NULL;


-- CHECK FOR UNWANTED SPACES
--Expectation: No Reslts
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

--DATA Standardization and Consistency

SELECT DISTINCT cst_gndr
FROM sliver_cust_info

SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info

select * 
from silver.crm_cust_info

--SILVER CRM CHECK
SELECT Count(*)
FROM silver.crm_prd_info

SELECT
cat_id
FROM silver.crm_prd_info
where cat_id like '%-%'

SELECT prd_cost
FROM silver.crm_prd_info
where prd_cost < 0 OR prd_cost IS NULL

SELECT 
prd_start_dt,
prd_end_dt
FROM silver.crm_prd_info
where prd_start_dt > prd_end_dt


SELECT 
count(sls_quantity)
FROM silver.crm_sales_details
group by 
having count(sls_quantity) > 1



SELECT 
*
FROM silver.crm_sales_details
where sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt


SELECT DISTINCT gen
FROM silver.erp_cust_az12
