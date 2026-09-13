use olist;

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