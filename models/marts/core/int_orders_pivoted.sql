-- setting value of list variable payment_methods. Easily accessible since it is at
-- the top of the page.
{% set payment_methods = ["gift_card", "credit_card", "coupon", "bank_transfer"] %}

WITH  -- 1st CTE -> gets all records from model stg_payments
stripe_payments AS (SELECT * FROM {{ ref("stg_payments") }}),

pivoted_payments AS (
    -- 2nd CTE -> fetches records from 1st CTE and produces a summary of the
    -- amount of money paid
    -- through a particular payment method
    SELECT
        order_id,
        {% for payment in payment_methods %}
            SUM(
                CASE
                    WHEN payment_method = '{{ payment }}' THEN amount ELSE 0
                END
            ) AS {{ payment }}_amount
            {% if not loop.last %}, {% endif %}
        {% endfor %}

    FROM stripe_payments
    WHERE status = "success"
    GROUP BY 1
)

SELECT *
FROM pivoted_payments
