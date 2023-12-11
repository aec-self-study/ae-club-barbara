{{ config(
    materialized='table'
 ) }}
 
WITH temp_orders_customers AS (
  SELECT
  o.customer_id AS customer_id,
  name AS customer_name,
  email AS customer_email,
  created_at AS order_created_at,
  o.id AS order_id
FROM analytics-engineers-club.coffee_shop.customers as c
LEFT JOIN analytics-engineers-club.coffee_shop.orders as o
ON c.id= o.customer_id
)
SELECT
  customer_id,
  customer_name AS name,
  customer_email AS email,
  MIN(order_created_at) AS first_order_at,
  COUNT(DISTINCT order_id) AS number_of_orders
FROM temp_orders_customers
GROUP BY 1,2,3
ORDER BY first_order_at
LIMIT 5