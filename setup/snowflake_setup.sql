create warehouse transforming;
create database raw;
create database analytics;
create schema raw.jaffle_shop;
create schema raw.stripe;


-- Grant your user access to the database
GRANT USAGE ON DATABASE raw TO ROLE PUBLIC;

-- Allow creating schemas/tables
GRANT CREATE SCHEMA ON DATABASE raw TO ROLE PUBLIC;
GRANT USAGE ON SCHEMA raw.jaffle_shop TO ROLE PUBLIC;
GRANT CREATE TABLE ON SCHEMA raw.jaffle_shop TO ROLE PUBLIC;
SHOW GRANTS TO USER NIHARIKA;
SHOW DATABASES;
-- Set the warehouse
CREATE WAREHOUSE IF NOT EXISTS TRANSFORMING---creating the actual tables for the datasets 

create or replace table raw.jaffle_shop.customers
(
id integer,
first_name varchar,
last_name varchar
);
select * from  raw.jaffle_shop.customers;
--------Copying the data from the s3 to the customers table --
copy into raw.jaffle_shop.customers(id, first_name, last_name)
from 's3://dbt-tutorial-public/jaffle_shop_customers.csv'
file_format=(
  type='CSV'
  field_delimiter =','
  skip_header=1
);
select * from  raw.jaffle_shop.customers;


---Creating the orders table----
create table raw.jaffle_shop.orders
(
id integer,
user_id integer,
order_date date,
status varchar,
_etl_loaded_at timestamp default current_timestamp
);

copy into raw.jaffle_shop.orders(id, user_id, order_date,status)
from 's3://dbt-tutorial-public/jaffle_shop_orders.csv'
file_format=(
  type='CSV'
  field_delimiter =','
  skip_header=1
);

select * from   raw.jaffle_shop.orders;


---Creating the stripe payments table----
create table raw.stripe.payments
(
id integer,
order_id integer,
paymentmethod varchar,
status varchar,
amount integer,
created date,
_batched_at timestamp default current_timestamp
);

copy into raw.stripe.payments(id, order_id, paymentmethod,status,amount,created)
from 's3://dbt-tutorial-public/stripe_payments.csv'
file_format=(
  type='CSV'
  field_delimiter =','
  skip_header=1
);

 select * from  raw.stripe.payments;
