use olist;

#7 How many customers are repeat buyers vs one-time buyers?
with cust_orders as (
select
	customer_id,
    count(order_id) as num_orders
from orders
group by customer_id
)
select
	 case
		when num_orders = 1 then "One-Time Buyer"
        else "Repeat Buyers" end as buyer_type,
	count(*) as customer_count
from cust_orders
group by buyer_type;