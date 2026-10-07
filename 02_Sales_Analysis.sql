-- ============================================================
-- AMAZON E-COMMERCE BUSINESS ANALYSIS
-- File Name : 02_Sales_Analysis.sql
-- Objective : Sales Performance Analysis
-- Database : PostgreSQL
-- ============================================================


-- ============================================================
-- Query 1 : Monthly Orders Trend
-- ============================================================

SELECT
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;


-- ============================================================
-- Query 2 : Monthly Revenue
-- ============================================================

SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;


-- ============================================================
-- Query 3 : Yearly Revenue
-- ============================================================

SELECT
    DATE_TRUNC('year', o.order_purchase_timestamp) AS year,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY year
ORDER BY year;


-- ============================================================
-- Query 4 : Average Order Value (AOV)
-- ============================================================

SELECT
ROUND(AVG(order_total),2) AS average_order_value
FROM
(
SELECT
order_id,
SUM(price) AS order_total
FROM order_items
GROUP BY order_id
) t;


-- ============================================================
-- Query 5 : Top 10 Highest Revenue Orders
-- ============================================================

SELECT
order_id,
ROUND(SUM(price),2) AS revenue
FROM order_items
GROUP BY order_id
ORDER BY revenue DESC
LIMIT 10;


-- ============================================================
-- Query 6 : Lowest Revenue Orders
-- ============================================================

SELECT
order_id,
ROUND(SUM(price),2) AS revenue
FROM order_items
GROUP BY order_id
ORDER BY revenue ASC
LIMIT 10;


-- ============================================================
-- Query 7 : Revenue by State
-- ============================================================

SELECT
c.customer_state,
ROUND(SUM(oi.price),2) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC;


-- ============================================================
-- Query 8 : Revenue by Product Category
-- ============================================================

SELECT
p.product_category_name,
ROUND(SUM(oi.price),2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue DESC;


-- ============================================================
-- Query 9 : Total Freight Cost
-- ============================================================

SELECT
ROUND(SUM(freight_value),2) AS total_freight_cost
FROM order_items;



-- ============================================================
-- Query 10 : Average Freight Cost
-- ============================================================

SELECT
ROUND(AVG(freight_value),2) AS average_freight_cost
FROM order_items;



-- ============================================================
-- Query 11 : Revenue by Month and State
-- ============================================================

SELECT
DATE_TRUNC('month',o.order_purchase_timestamp) AS month,
c.customer_state,
ROUND(SUM(oi.price),2) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY month,c.customer_state
ORDER BY month,revenue DESC;



-- ============================================================
-- Query 12 : Orders Per Month
-- ============================================================

SELECT
DATE_TRUNC('month',order_purchase_timestamp) AS month,
COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;



-- ============================================================
-- Query 13 : Orders Per Year
-- ============================================================

SELECT
DATE_TRUNC('year',order_purchase_timestamp) AS year,
COUNT(*) AS total_orders
FROM orders
GROUP BY year
ORDER BY year;



-- ============================================================
-- Query 14 : Average Products Per Order
-- ============================================================

SELECT
ROUND(AVG(product_count),2) AS avg_products_per_order
FROM
(
SELECT
order_id,
COUNT(product_id) AS product_count
FROM order_items
GROUP BY order_id
)t;



-- ============================================================
-- Query 15 : Top 10 Revenue Days
-- ============================================================

SELECT
DATE(order_purchase_timestamp) AS order_date,
ROUND(SUM(price),2) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY order_date
ORDER BY revenue DESC
LIMIT 10;


-- ============================================================
-- Query 16 : Bottom 10 Revenue Days
-- ============================================================

SELECT
DATE(order_purchase_timestamp) AS order_date,
ROUND(SUM(price),2) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
GROUP BY order_date
ORDER BY revenue ASC
LIMIT 10;



-- ============================================================
-- Query 17 : Daily Sales Trend
-- ============================================================

SELECT
DATE(order_purchase_timestamp) AS order_date,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;



-- ============================================================
-- Query 18 : Weekly Sales Trend
-- ============================================================

SELECT
DATE_TRUNC('week',order_purchase_timestamp) AS week,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY week
ORDER BY week;



-- ============================================================
-- Query 19 : Highest Single Product Price Sold
-- ============================================================

SELECT
product_id,
MAX(price) AS highest_price
FROM order_items
GROUP BY product_id
ORDER BY highest_price DESC
LIMIT 10;



-- ============================================================
-- Query 20 : Revenue Including Freight
-- ============================================================

SELECT
ROUND(SUM(price + freight_value),2) AS total_revenue_with_shipping
FROM order_items;


