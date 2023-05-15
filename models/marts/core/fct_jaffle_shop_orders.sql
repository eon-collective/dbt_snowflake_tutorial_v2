WITH
orders_source AS (
    SELECT * FROM {{ ref('stg_orders' ) }}
),

transformed_orders AS (
    SELECT
        order_id,
        status AS order_status,
        order_date,
        customer_id,
        CASE
            WHEN status NOT IN ('returned', 'return_pending') THEN order_date
        END AS valid_order_date
    FROM orders_source
)

SELECT *
FROM transformed_orders
