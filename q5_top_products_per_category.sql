use olist;

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