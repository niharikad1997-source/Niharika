with customers as (
    select * from {{ ref('stg_jaffle_Shop_customers') }}
),

orders as (
    select * from {{ ref('stg_jaffle_shop_orders') }}
)

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    orders.id as order_id,
    orders.status
from customers
left join orders on customers.customer_id = orders.user_id