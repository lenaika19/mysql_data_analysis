use olist;

#6 Segment customers into spend tiers (Low / Medium / High).
        # use tbl orders for number of orders per customer
        # user tbl order_payments for payment spending
        # connect orders and order_payments using order id
with tier as (
select
	o.customer_id as customer_name,
    round(sum(op.payment_value),2) as total_spend,
    case
		when sum(op.payment_value) < 3000 then "Low"
        when sum(op.payment_value) between 3000 and 6000 then "Medium" 
        else "High" end as spend_tier
from orders o
join orders_payments op on o.order_id = op.order_id
group by customer_name
)
select
	customer_name,
    total_spend,
    spend_tier
from tier
order by total_spend desc;