dbt_snowflake_tutorial_v2
 ┣ analyses
 ┃ ┣ interactive_ad_hoc_testing.sql
 ┃ ┣ orders_by_day.sql
 ┃ ┗ total_revenues.sql
 ┣ etc
 ┃ ┗ images
 ┃ ┃ ┣ jaffle_shop_lineage.png
 ┃ ┃ ┗ stripe_payment_lineage.png
 ┃ ┗ project_tree_structure.md
 ┣ logs
 ┃ ┗ dbt.log
 ┣ macros
 ┃ ┣ cents_to_dollars.sql
 ┃ ┣ clean_stale_models.sql
 ┃ ┣ grant_select.sql
 ┃ ┣ limit_data_dev.sql
 ┃ ┗ union_tables_by_prefix.sql
 ┣ models
 ┃ ┣ marts
 ┃ ┃ ┗ core
 ┃ ┃ ┃ ┣ dim_customers.sql
 ┃ ┃ ┃ ┣ fct_orders.sql
 ┃ ┃ ┃ ┣ int_orders_pivoted.sql
 ┃ ┃ ┃ ┣ int_order_status_pivoted.sql
 ┃ ┃ ┃ ┗ str_pivoted_customers.sql
 ┃ ┣ staging
 ┃ ┃ ┣ jaffle_shop
 ┃ ┃ ┃ ┣ jaffle_shop.md
 ┃ ┃ ┃ ┣ sources.yml
 ┃ ┃ ┃ ┣ src_jaffle_shop.yml
 ┃ ┃ ┃ ┣ stg_customers.sql
 ┃ ┃ ┃ ┣ stg_jaffle_shop.yml
 ┃ ┃ ┃ ┣ stg_jaffle_shop_orders.sql
 ┃ ┃ ┃ ┗ stg_orders.sql
 ┃ ┃ ┣ stripe
 ┃ ┃ ┃ ┣ sources.yml
 ┃ ┃ ┃ ┣ src_stripe.yml
 ┃ ┃ ┃ ┣ stg_payments.sql
 ┃ ┃ ┃ ┣ stg_stripe.yml
 ┃ ┃ ┃ ┗ stripe.md
 ┃ ┃ ┗ all_dates.sql
 ┃ ┗ .sqlfluff
 ┣ tests
 ┃ ┗ assert_positive_total_for_payments.sql