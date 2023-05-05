WITH p AS (
    SELECT
        orderid AS order_id,
        MAX(created) AS payment_finalized_date,
        SUM(amount) / 100.0 AS total_amount_paid
    FROM raw.stripe.payment
    WHERE status != "fail"
    GROUP BY 1
),
paid_orders AS (
    SELECT
        orders.id AS order_id,
        orders.user_id AS customer_id,
        orders.order_date AS order_placed_at,
        orders.status AS order_status,
        p.total_amount_paid,
        p.payment_finalized_date,
        c.first_name AS customer_first_name,
        c.last_name AS customer_last_name
    FROM raw.jaffle_shop.orders AS orders
    LEFT JOIN p
        ON orders.id = p.order_id
    LEFT JOIN raw.jaffle_shop.customers AS c ON orders.user_id = c.id
),

customer_orders AS (
    SELECT
        c.id AS customer_id,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS most_recent_order_date,
        COUNT(orders.id) AS number_of_orders
    FROM raw.jaffle_shop.customers AS c
    LEFT JOIN raw.jaffle_shop.orders
        ON orders.user_id = c.id
    GROUP BY 1
)

SELECT
    p.*,
    ROW_NUMBER() OVER (ORDER BY p.order_id) AS transaction_seq,
    ROW_NUMBER()
        OVER (PARTITION BY customer_id ORDER BY p.order_id)
        AS customer_sales_seq,
    CASE
        WHEN c.first_order_date = p.order_placed_at
            THEN "new"
        ELSE "return"
    END AS nvsr,
    x.clv_bad AS customer_lifetime_value,
    c.first_order_date AS fdos
FROM paid_orders AS p
LEFT JOIN customer_orders AS c ON p.customer_id = c.customer_id
LEFT OUTER JOIN
(
    SELECT
        p.order_id,
        SUM(t2.total_amount_paid) AS clv_bad
    FROM paid_orders AS p
    LEFT JOIN
        paid_orders AS t2
        ON p.customer_id = t2.customer_id AND p.order_id >= t2.order_id
    GROUP BY 1
    ORDER BY p.order_id
) AS x
ON x.order_id = p.order_id
ORDER BY order_id
