SELECT
    id AS payment_id,
    orderid AS order_id,
    paymentmethod AS payment_method,
    status,

    -- amount is stored in cents so convert it to dollars
    {{ cents_to_dollars('amount', 4) }} AS amount,
    created AS created_at

FROM {{ source("stripe", "payment") }}

{{ limit_data_in_dev('created_at') }}
