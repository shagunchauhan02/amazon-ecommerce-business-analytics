-- ============================================================
-- AMAZON E-COMMERCE BUSINESS ANALYSIS
-- File Name : 05_Advanced_SQL.sql
-- Objective : Advanced SQL Analysis
-- Database : PostgreSQL
-- ============================================================


-- ============================================================
-- Query 1 : Top 10 Customers by Revenue
-- ============================================================

SELECT
    o.customer_id,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_revenue DESC
LIMIT 10;



-- ============================================================
-- Query 2 : Rank Customers by Revenue
-- ============================================================

SELECT
    customer_id,
    total_revenue,
    RANK() OVER(ORDER BY total_revenue DESC) AS customer_rank
FROM
(
SELECT
    o.customer_id,
    SUM(oi.price) AS total_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.customer_id
)t;



-- ============================================================
-- Query 3 : Dense Rank Products by Revenue
-- ============================================================

SELECT
    product_id,
    revenue,
    DENSE_RANK() OVER(ORDER BY revenue DESC) AS product_rank
FROM
(
SELECT
    product_id,
    SUM(price) AS revenue
FROM order_items
GROUP BY product_id
)t;



-- ============================================================
-- Query 4 : Row Number by Revenue
-- ============================================================

SELECT
    product_id,
    revenue,
    ROW_NUMBER() OVER(ORDER BY revenue DESC) AS row_num
FROM
(
SELECT
    product_id,
    SUM(price) AS revenue
FROM order_items
GROUP BY product_id
)t;



-- ============================================================
-- Query 5 : Running Revenue Total
-- ============================================================

SELECT
    DATE(order_purchase_timestamp) AS order_date,
    SUM(oi.price) AS daily_revenue,
    SUM(SUM(oi.price)) OVER(
        ORDER BY DATE(order_purchase_timestamp)
    ) AS running_total
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY DATE(order_purchase_timestamp)
ORDER BY order_date;



-- ============================================================
-- Query 6 : Monthly Revenue Growth using LAG()
-- ============================================================

WITH monthly_sales AS
(
SELECT
    DATE_TRUNC('month',order_purchase_timestamp) AS month,
    SUM(price) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY month
)

SELECT
    month,
    revenue,
    LAG(revenue) OVER(ORDER BY month) AS previous_month,
    revenue-LAG(revenue) OVER(ORDER BY month) AS growth
FROM monthly_sales;



-- ============================================================
-- Query 7 : Monthly Revenue Difference using LEAD()
-- ============================================================

WITH monthly_sales AS
(
SELECT
DATE_TRUNC('month',order_purchase_timestamp) AS month,
SUM(price) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY month
)

SELECT
month,
revenue,
LEAD(revenue) OVER(ORDER BY month) AS next_month
FROM monthly_sales;



-- ============================================================
-- Query 8 : Top 5 Products in Each Category
-- ============================================================

SELECT *
FROM
(
SELECT
p.product_category_name,
oi.product_id,
SUM(oi.price) AS revenue,
ROW_NUMBER() OVER(
PARTITION BY p.product_category_name
ORDER BY SUM(oi.price) DESC
) AS rn
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY
p.product_category_name,
oi.product_id
)t
WHERE rn<=5;



-- ============================================================
-- Query 9 : Revenue Quartiles using NTILE()
-- ============================================================

SELECT
product_id,
SUM(price) AS revenue,
NTILE(4) OVER(
ORDER BY SUM(price) DESC
) AS revenue_quartile
FROM order_items
GROUP BY product_id;



-- ============================================================
-- Query 10 : CASE WHEN Revenue Category
-- ============================================================

SELECT
product_id,
SUM(price) AS revenue,

CASE

WHEN SUM(price)>=5000
THEN 'High Revenue'

WHEN SUM(price)>=2000
THEN 'Medium Revenue'

ELSE 'Low Revenue'

END AS revenue_category

FROM order_items
GROUP BY product_id;



-- ============================================================
-- Query 11 : CTE - Top Customers
-- ============================================================

WITH customer_sales AS
(
SELECT
o.customer_id,
SUM(oi.price) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY o.customer_id
)

SELECT *
FROM customer_sales
WHERE revenue>5000
ORDER BY revenue DESC;



-- ============================================================
-- Query 12 : Customers Above Average Spending
-- ============================================================

WITH customer_sales AS
(
SELECT
o.customer_id,
SUM(oi.price) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY o.customer_id
)

SELECT *
FROM customer_sales
WHERE revenue >
(
SELECT AVG(revenue)
FROM customer_sales
);



-- ============================================================
-- Query 13 : Product Revenue Percentage
-- ============================================================

SELECT
product_id,
SUM(price) AS revenue,

ROUND(
SUM(price)*100/
SUM(SUM(price)) OVER(),
2
) AS revenue_percent

FROM order_items
GROUP BY product_id
ORDER BY revenue DESC;



-- ============================================================
-- Query 14 : Top Revenue State
-- ============================================================

SELECT
customer_state,
SUM(price) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY customer_state
ORDER BY revenue DESC
LIMIT 1;



-- ============================================================
-- Query 15 : Revenue by Payment Type
-- ============================================================

SELECT
payment_type,
ROUND(SUM(payment_value),2) AS revenue
FROM order_payments
GROUP BY payment_type
ORDER BY revenue DESC;


