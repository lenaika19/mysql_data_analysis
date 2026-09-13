# Olist SQL Analysis

## Overview

This project contains SQL queries used to analyze the **Olist e-commerce dataset**. The analysis focuses on customer spending, revenue trends, product category performance, customer segmentation, and purchasing behavior.

The queries demonstrate the use of SQL for business-oriented data analysis, including table joins, aggregations, Common Table Expressions (CTEs), `CASE` statements, and window functions.

## Business Questions

The analysis answers the following business questions:

1. **Who are the top 10 customers by total amount spent?**  
   Identifies the highest-spending customers based on their total payment value.

2. **What is the monthly revenue trend across the dataset?**  
   Calculates total revenue by month to show how revenue changes over time.

3. **What is the month-over-month change in revenue?**  
   Compares each month's revenue with the previous month to identify increases or decreases in revenue.

4. **Which product categories generate the most revenue?**  
   Ranks product categories according to their total revenue contribution.

5. **What are the top 3 products within each category by revenue?**  
   Uses a window function to rank products within each product category and identify the top three.

6. **How can customers be segmented into spending tiers?**  
   Classifies customers into:
   - **Low:** Less than 3,000
   - **Medium:** 3,000–6,000
   - **High:** More than 6,000

7. **How many customers are repeat buyers versus one-time buyers?**  
   Counts customers based on the number of orders they have placed.

8. **What percentage of total revenue comes from the top category?**  
   Identifies the highest-revenue category and calculates its percentage contribution to overall revenue.

## Key Findings

The SQL analysis is designed to provide insights into the following areas:

- **Customer value:** Identify the customers who contribute the most revenue.
- **Revenue performance:** Track monthly revenue and changes from one month to the next.
- **Product performance:** Determine which product categories and individual products generate the most revenue.
- **Customer segmentation:** Distinguish high-value customers from medium- and low-spending customers.
- **Customer retention:** Compare one-time buyers with repeat buyers to understand purchasing behavior.
- **Revenue concentration:** Determine how dependent overall revenue is on the highest-performing product category.

> **Note:** Specific numerical findings should be added after executing the queries against the Olist database. The SQL file contains the analysis logic but does not include the resulting output tables.

## Recommendations

Based on the analysis objectives, the following business actions can be considered:

- **Focus on high-value customers:** Develop targeted promotions, loyalty incentives, and personalized offers for high-spending customers.
- **Improve customer retention:** Encourage one-time buyers to make repeat purchases through follow-up campaigns, discounts, and personalized recommendations.
- **Prioritize high-performing categories:** Maintain inventory and marketing support for categories that consistently generate strong revenue.
- **Monitor revenue trends:** Investigate significant month-over-month increases or decreases to identify seasonal patterns and potential business issues.
- **Promote top-performing products:** Use high-revenue products in marketing campaigns and cross-selling strategies.
- **Reduce revenue concentration risk:** If a single category contributes a large share of revenue, explore opportunities to strengthen other categories and diversify revenue sources.

## Tools & Skills

- **Database:** MySQL
- **Language:** SQL
- **Dataset:** Olist Brazilian E-Commerce Dataset
- **SQL Skills Demonstrated:**
  - `SELECT`, `WHERE`, `GROUP BY`, and `ORDER BY`
  - `JOIN` operations
  - Aggregate functions such as `SUM()` and `COUNT()`
  - `ROUND()` and `DATE_FORMAT()`
  - `CASE` statements
  - Common Table Expressions (CTEs)
  - Window functions
  - `LAG()` for month-over-month analysis
  - `ROW_NUMBER()` for product ranking
  - Customer segmentation
  - Revenue contribution analysis

## Files

| File | Description |
|---|---|
| `queries_compilation.sql` | SQL queries used to answer the eight business questions |
| `README.md` | Project overview, business questions, findings, recommendations, and technical skills |

## Database Tables Used

The queries reference the following Olist tables:

- `customers` – Customer information
- `orders` – Order information and purchase timestamps
- `orders_payments` – Payment and transaction values
- `orders_items` – Products included in orders
- `products` – Product information and categories
- `product_category` – Product category names and English translations

## Analysis Notes

The queries use relationships between customers, orders, payments, order items, products, and product categories to create business-level insights.

When interpreting revenue results, payment and order-item relationships should be reviewed carefully because an order may contain multiple products. Depending on the intended definition of product/category revenue, payment values may need to be allocated to individual order items to avoid duplicated payment amounts.

