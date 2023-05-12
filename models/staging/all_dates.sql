{{
    config(
        materialized='table'
    )
}}
-- macro in dbt_utils package that
-- returns the sql code required to build a date spine. 
-- The spine will include the start_date
-- (if it is aligned to the datepart)
-- but will not include the end_date.
{{
    dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2018-01-01' as date)",
        end_date="cast('2019-01-01' as date)",
    )
}}
