
**OVERVIEW**

The GOLD layer is the business-level data representation (stage after filtering and standardizing all of the data). This is to help support analytical and reporting use cases. As such, there is a dimension table and multiple fact tabes as a means of business metrics.

## 1.) gold.dim_customers
  **Purpose:** stores customer details


| Column Name     | Data Type     | Description |
|-----------------|---------------|-------------|
| customer_key    | INT           | Surrogate key uniquely identifying each customer record in the dimension table. |
| customer_id     | INT           | Unique numerical identifier assigned to each customer. |
| customer_number | NVARCHAR(50)  | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| first_name      | NVARCHAR(50)  | The customer's first name, as recorded in the system. |
| last_name       | NVARCHAR(50)  | The customer's last name or family name. |
| country    | NVARCHAR(50)          | What country the customer resides in|
| marital_status     |  NVARCHAR(50)        | Describes the customer's marital Status e.g. 'Married' or 'Single'  |
| gender | NVARCHAR(50)  | dsecribes the customer's gender e.g. 'Male', 'Female', 'n/a' |
| birthdate      |DATE  | When the customer was born in the format of YYYY-MM-DD |
| create_date      | DATE  | the date and time when the customer record was created within the system |

## 2.) gold.dim_products
**Purpose:** Stores product details enriched with category and classification attributes for analytical use.


| Column Name     | Data Type     | Description |
|-----------------|--------------|-------------|
| product_id      | INT          | Unique identifier for each product record. |
| product_number  | NVARCHAR(50) | Business-facing product identifier used for tracking and reference. |
| product_name    | NVARCHAR(50)| Name of the product. |
| category_id     | INT          | Identifier linking the product to its category. |
| category        | NVARCHAR(50) | High-level product category classification. |
| subcategory     | NVARCHAR(50) | More detailed classification within a category. |
| maintenance     | NVARCHAR(50) | Indicates maintenance classification or requirement for the product. |
| cost            | INT          | Cost associated with the product. |
| product_line    | NVARCHAR(50) | Product line grouping (e.g., Mountain, Road, Touring). |
| start_date      | DATE         | Date when the product became active or available. |

## 3.) gold.facts_sales
- **Purpose:** Stores transactional sales data linking customers and products, used for revenue, volume, and operational analysis.

| Column Name    | Data Type      | Description |
|----------------|---------------|-------------|
| order_number   | NVARCHAR(50)  | Unique identifier for each sales order. |
| product_key    | INT           | Foreign key linking to the product dimension. |
| customer_key   | INT           | Foreign key linking to the customer dimension. |
| order_date     | DATE          | Date when the order was placed. |
| shipping_date  | DATE          | Date when the order was shipped. |
| due_date       | DATE          | Expected delivery or due date for the order. |
| sales_amount   | INT           | Total revenue generated from the sale. |
| quantity       | INT           | Number of units sold. |
| price          | INT           | Price per unit of the product. |

