-- 79 unique customer first names out of a total 100 customers
-- this pivoting model will find customers who have ordered more than once
WITH
-- 1st CTE -> fetches all customer first names from model stg_customers
cust_first_names AS (
    SELECT
        customer_id,
        first_name,
        last_name
    FROM {{ ref("stg_customers") }}
),

-- 2nd CTE -> fetches all customer first names from model stg_customers
pivoted_customers AS (
    SELECT 
        first_name,
        COUNT(customer_id) AS id_count
    FROM cust_first_names
    GROUP BY first_name
    ORDER BY id_count DESC
)

SELECT *
FROM pivoted_customers
