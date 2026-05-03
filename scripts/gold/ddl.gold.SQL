/*
===================================================================================
DDL Script: Create Gold Views
===================================================================================
Script Purpose:
    This script defines the Gold layer views within the data warehouse.
The Gold layer represents the final dimensional model, structured as a star schema 
with fact and dimension tables.
Each view applies the required transformations and integrates data from the Silver 
layer to deliver a clean, standardized, and analysis-ready dataset.

===================================================================================
*/

IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO
CREATE VIEW gold.dim_customers AS

SELECT
	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key customer_number,
	ci.cst_firstname first_name,
	ci.cst_lastname last_name,
	la.cntry country,
	ci.cst_marital_status marital_status,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
	ELSE COALESCE(ca.gen, 'n/a')
	END AS gender,
	ca.bdate birth_date,
	ci.cst_create_date create_date
FROM silver.crm_cust_info AS ci
left join silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
left join silver.erp_loc_a101 la
on ci.cst_key = la.cid;
GO

--get rid of historical information

IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS

SELECT
	ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt, pn.prd_id) AS product_key,
    pn.prd_id product_id,
	pn.prd_key prduct_number,
	pn.prd_nm product_name,
    pn.cat_id category_id,
	pc.cat AS category,
	pc.subcat subcategory,
	pc.maintenance maintenance,
    pn.prd_cost cost,
    pn.prd_line product_line,
    pn.prd_start_dt AS start_date
	FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL 
GO

IF OBJECT_ID('gold.facts_sales', 'V') IS NOT NULL
    DROP VIEW gold.facts_sales;
GO

--this is a fact table, joins two dimensions
CREATE VIEW gold.facts_sales AS
SELECT
    sd.sls_ord_num order_number,
    pr.product_key,
    cu.customer_key,
    sd.sls_order_dt order_date,
    sd.sls_ship_dt shipping_date,
    sd.sls_due_dt due_date,
    sd.sls_sales sales_amount,
    sd.sls_quantity quantity,
    sd.sls_price AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
    ON sd.sls_prd_key = pr.prduct_number
LEFT JOIN gold.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id
GO
