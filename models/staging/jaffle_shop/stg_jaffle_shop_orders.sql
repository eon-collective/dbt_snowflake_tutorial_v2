WITH
orders_source AS (
    SELECT * FROM {{ source("jaffle_shop", "orders") }}
    ),

transformed_orders AS (
    SELECT
        id AS order_id,
        status AS order_status,
        order_date,
        user_id AS customer_id,
        CASE
            WHEN status NOT IN ('returned', 'return_pending') THEN order_date
        END AS valid_order_date
    FROM orders_source

)

SELECT *
FROM transformed_orders
