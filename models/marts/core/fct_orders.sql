-- an ephemeral model is not built in the warehouse
{{
    config(
        materialized='ephemeral'
    )
}}
WITH orders AS (
    SELECT * FROM {{ ref('stg_orders' ) }}
),

payments AS (
    SELECT * FROM {{ ref('stg_payments') }}
),

order_payments AS (
    SELECT
        order_id,
        SUM(CASE WHEN status = 'success' THEN amount END) AS amount

    FROM payments
    GROUP BY order_id
),

final_cte AS (

    SELECT
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        COALESCE(order_payments.amount, 0) AS amount

    FROM orders
    LEFT JOIN order_payments ON orders.order_id = order_payments.order_id
)

SELECT * FROM final_cte
