use olist;

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