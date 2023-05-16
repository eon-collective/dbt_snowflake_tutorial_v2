-- check for duplicate customer ids in model stg_Customers
SELECT customer_id
FROM {{ ref("stg_customers") }}
GROUP BY customer_id
HAVING COUNT(*) > 1
