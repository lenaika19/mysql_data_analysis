use olist;

#2 What is the monthly revenue trend across the dataset?
	# group by month using date_format then sum.
	# join orders_payments as op for the amount, orders as o for the month join by order_id
select 
	date_format(order_purchase_timestamp, '%Y-%m') as order_month,
	round(sum(payment_value),2) as monthly_revenue
from orders_payments as op
join orders o on op.order_id = o.order_id
group by date_format(order_purchase_timestamp, '%Y-%m')
order by order_month;
