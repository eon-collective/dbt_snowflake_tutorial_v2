{% set order_status = [
    "placed",
    "shipped",
    "completed",
    "return_pending",
    "returned",
] %}

WITH  -- 1st CTE -> fetches all records from model stg_orders
order_status AS (
    SELECT * FROM {{ ref("stg_orders") }}
),

pivoted_orders AS (
    -- 2nd CTE -> fetches records from 1st CTE, query result set and produces a
    -- summary of the
    -- status of each customer order
    SELECT
        order_id,
        {% for list_status in order_status %}
            SUM(
                CASE WHEN status = '{{ list_status }}' THEN 1 ELSE 0 END
            ) AS {{ list_status }}_order
            {% if not loop.last %}, {% endif %}
        {% endfor %}

    FROM order_status
    GROUP BY 1
)

SELECT *
FROM pivoted_orders
