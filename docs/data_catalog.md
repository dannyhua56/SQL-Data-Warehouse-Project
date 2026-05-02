
OVERVIEW

The GOLD layer is the business-level data representation (stage after filtering and standardizing all of the data). This is to help support analytical and reporting use cases. As such, there is a dimension table and multiple fact tabes as a means of business metrics.

1. gold.dim_customers
  Purpose: stores customer details


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


