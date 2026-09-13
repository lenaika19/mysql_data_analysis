use olist;

#1 Who are the top 10 customers by total amount spent?
select
	c.customer_id,
    sum(op.payment_value) as total_spent
from customers as c
join orders o on c.customer_id = o.customer_id
join orders_payments as op on o.order_id = op.order_id
group by c.customer_id
order by total_spent desc
limit 10;

------------------------------------------------------------------------------------------------------------------------------------
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

------------------------------------------------------------------------------------------------------------------------------------
#3 What is the month-over-month change in revenue?
with monthly as (
	select
		date_format(order_purchase_timestamp, '%Y-%m') as order_month,
		round(sum(payment_value),2) as monthly_revenue
        from orders_payments as op
join orders o on op.order_id = o.order_id
group by date_format(order_purchase_timestamp, '%Y-%m')
)
SELECT
    order_month,
    round(monthly_revenue,2),
    round(LAG(monthly_revenue) OVER (ORDER BY order_month),2) AS prev_month,
    round(monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY order_month),2) AS rev_change
FROM monthly
ORDER BY order_month;

------------------------------------------------------------------------------------------------------------------------------------
#4 Which product categories generate the most revenue?
	# use tbl orders_payments as op for revenue and order_id
	# use tbl orders_items as oi for order_id and product_id
	# use tbl products as p for product_id and product_category_name
	# join op and oi on order_id
	# join oi and p on product_id
	# join tbl products and tbl product_category
select
	pc.product_category_name_english as prod_categories,
	round(sum(op.payment_value),2) as prod_rev
from product_category pc
join products p on pc.product_category_name = p.product_category_name
join orders_items oi on p.product_id = oi.product_id
join orders_payments op on oi.order_id = op.order_id
group by prod_categories
order by prod_rev desc;


------------------------------------------------------------------------------------------------------------------------------------
#5 Rank the top 3 products within each category by revenue.
with ranked as (
	select 
		oi.product_id as productname,
		pc.product_category_name_english as prod_categories,
		round(sum(op.payment_value),2) as prod_rev,
		row_number() over (
			partition by pc.product_category_name_english
            order by sum(op.payment_value) desc) as rn 
    from product_category pc
	join products p on pc.product_category_name = p.product_category_name
	join orders_items oi on p.product_id = oi.product_id
	join orders_payments op on oi.order_id = op.order_id
    group by productname, prod_categories
)
select 
	productname,
	prod_categories,
    prod_rev
from ranked
where rn <= 3;


------------------------------------------------------------------------------------------------------------------------------------
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

------------------------------------------------------------------------------------------------------------------------------------
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


------------------------------------------------------------------------------------------------------------------------------------
#8 What percent of total revenue comes from the top category?
		# use tbl products for product_id and product_category_name
        # use tbl product_category for product_category_name_english
        # user tbl order_payments for revenue
        # use tbl order_items for order_id and product_id
select 
	pc.product_category_name_english as prod_category,
    round(sum(op.payment_value),2) as revenue,
    sum(round(sum(op.payment_value),2)) over () as total_of_all,
    round((sum(op.payment_value) / sum(sum(op.payment_value)) over ()) * 100, 2) as perntage_contribution
from product_category pc
join products p on pc.product_category_name = p.product_category_name
join orders_items oi on p.product_id = oi.product_id
join orders_payments op on oi.order_id = op.order_id
group by pc.product_category_name_english
order by revenue desc
limit 1;
