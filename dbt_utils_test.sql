-- formats current date and time
{{ dbt_utils.pretty_time(format='%Y-%m-%d %H:%M:%S') }}

-- LIST ALL COLUMNS FROM THE MODEL
SELECT
{{ dbt_utils.star(ref('stg_customers')) }}
FROM {{ ref('stg_customers') }}
