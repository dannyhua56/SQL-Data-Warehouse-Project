
--Check DATA INTEGRITY FOR BRONZE PHRASE (BRONZE -> SILVER)

--CHECK FOR NULLS OR DUPLICATES IN PRIMARY KEY

SELECT 
cst_id,
COUNT(*) counting_all
FROM bronze.crm_cust_info
group by cst_id
HAVING COUNT(*) > 1 or cst_id IS NULL;


-- CHECK FOR UNWANTED SPACES
--Expectation: No Reslts
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

--DATA Standardization and Consistency

SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info

SELECT DISTINCT cst_marital_status
FROM bronze.crm_cust_info


-- NOW WE CHECK FOR crm_prd_info

-- CHECK FOR NULLS OR DUPLICATES IN PRIMARY KEY


SELECT prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR COUNT(*) IS NULL
--looks good!

--check for any unwanted spaces

SELECT prd_nm
FROM bronze.crm_prd_info
where prd_nm != TRIM(prd_nm)

--CHECK prd_cost FOR nulls and negative nulls
SELECT prd_cost
FROM bronze.crm_prd_info
where prd_cost < 0 OR prd_cost IS NULL

--CHECK Prd_line: change values into the extended phrase, NULL is N/a

SELECT DISTINCT Prd_line
FROM bronze.crm_prd_info

--prd_start_dt and prd_end_dt

SELECT 
*
FROM bronze.crm_prd_info
where prd_start_dt > prd_end_dt




SELECT *
FROM bronze.crm_sales_details

--SLS_order_num is good!
SELECT *
FROM bronze.crm_sales_details
where sls_ord_num != TRIM(sls_ord_num)

SELECT*
FROM bronze.crm_sales_details
where sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info)

SELECT *
FROM bronze.crm_sales_details
where sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info)

SELECT NULLIF(sls_ship_dt, 0)
FROM bronze.crm_sales_details
where sls_ship_dt <= 0 OR LEN(sls_ship_dt) != 8

--CHECK IF ORDERDATE if smaller shipping date
SELECT 
*
FROM bronze.crm_sales_details
where sls_ship_dt < sls_order_dt


--checks sales, qantity and price
SELECT
sls_sales, 
sls_quantity,
sls_price
FROM bronze.crm_sales_details
where sls_sales != sls_quantity * sls_price 
OR sls_sales IS NULL OR sls_quantity IS NULL or sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 or sls_price <= 0
ORDER BY sls_sales, 
sls_quantity,
sls_price

SELECT *
FROM bronze.crm_sales_details

--ERP TIME: erp_cust_az12

SELECT       
CASE WHEN cid like 'NASA%' THEN substring(cid, 4, len(cid)) 
ELSE cid END as cid
FROM bronze.erp_cust_az12

SELECT 
CASE WHEN bdate > current_date THEN NULL
else bdate END as bdate
FROM bronze.erp_cust_az12
ORDER BY bdate desc

SELECT DISTINCT
gen,
CASE WHEN UPPER(TRIM(gen)) = 'F' THEN 'Female'
	WHEN UPPER(TRIM(gen)) = 'M' THEN 'Male'
	WHEN UPPER(TRIM(gen)) = 'Male' Then 'Male'
	WHEN UPPER(TRIM(gen)) = 'Female' Then 'Female'
	Else 'n/a' END AS gennew

FROM bronze.erp_cust_az12


SELECT 
REPLACE(cid, '-','') cid

FROM bronze.erp_loc_a101

-- check for data standardization and consistency


SELECT DISTINCT
cntry,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
ELSE cntry END AS cntry
FROM bronze.erp_loc_a101
