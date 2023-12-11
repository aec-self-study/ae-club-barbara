 {{ config(
    materialized='view'
 ) }}
 
 select
  date_trunc(first_order_at, month) as datemonth,
  count(*)
 
from {{ ref('customers') }}
 
group by 1