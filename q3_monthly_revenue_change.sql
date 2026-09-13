use olist;

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