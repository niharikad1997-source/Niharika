-- ✅ Correct columns for orders
select
    id,
    user_id,
    status,
    order_date,
     _etl_loaded_at
from raw.jaffle_shop.orders