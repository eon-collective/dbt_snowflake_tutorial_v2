-- 79 unique customer first names out of a total 100 customers
-- this pivoting model will find customers who have ordered more than once
WITH
-- 1st CTE -> fetches all customer first names from model stg_customers
cust_first_names AS (
    SELECT
        first_name,
        last_name
    FROM {{ ref("stg_customers") }}
),

-- 2nd CTE -> fetches all customer first names from model stg_customers
pivoted_customers AS (
    SELECT first_name FROM cust_first_names GROUP BY 1
)

SELECT *
FROM pivoted_customers
