-- ============================================================
-- AMAZON E-COMMERCE BUSINESS ANALYSIS
-- File Name : 03_Customer_Analysis.sql
-- Objective : Customer Behavior Analysis
-- Database : PostgreSQL
-- ============================================================


-- ============================================================
-- Query 1 : Total Customers
-- ============================================================

SELECT COUNT(*) AS total_customers
FROM customers;


-- ============================================================
-- Query 2 : Customers by State
-- ============================================================

SELECT customer_state,
COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;



-- ============================================================
-- Query 3 : Top 10 Cities with Highest Customers
-- ============================================================

SELECT customer_city,
COUNT(*) AS total_customers
FROM customers
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;



-- ============================================================
-- Query 4 : Customers Who Placed Most Orders
-- ============================================================

SELECT
o.customer_id,
COUNT(o.order_id) AS total_orders
FROM orders o
GROUP BY o.customer_id
ORDER BY total_orders DESC
LIMIT 10;



-- ============================================================
-- Query 5 : Average Orders per Customer
-- ============================================================

SELECT
ROUND(
COUNT(order_id)::NUMERIC /
COUNT(DISTINCT customer_id),2
) AS avg_orders_per_customer
FROM orders;



-- ============================================================
-- Query 6 : Customers by Order Status
-- ============================================================

SELECT
order_status,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;



-- ============================================================
-- Query 7 : First Order Date
-- ============================================================

SELECT
MIN(order_purchase_timestamp) AS first_order
FROM orders;



-- ============================================================
-- Query 8 : Latest Order Date
-- ============================================================

SELECT
MAX(order_purchase_timestamp) AS latest_order
FROM orders;



-- ============================================================
-- Query 9 : Customers with Delivered Orders
-- ============================================================

SELECT
COUNT(DISTINCT customer_id) AS delivered_customers
FROM orders
WHERE order_status='delivered';



-- ============================================================
-- Query 10 : Top 10 Repeat Customers
-- ============================================================

SELECT
customer_id,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id)>1
ORDER BY total_orders DESC
LIMIT 10;



-- ============================================================
-- Query 11 : Customers by Zip Code
-- ============================================================

SELECT
customer_zip_code_prefix,
COUNT(*) AS customers
FROM customers
GROUP BY customer_zip_code_prefix
ORDER BY customers DESC
LIMIT 10;



-- ============================================================
-- Query 12 : Customer Distribution by State
-- ============================================================

SELECT
customer_state,
ROUND(
COUNT(*)*100.0/
(SELECT COUNT(*) FROM customers),2
) AS percentage
FROM customers
GROUP BY customer_state
ORDER BY percentage DESC;



-- ============================================================
-- Query 13 : Average Delivery Time
-- ============================================================

SELECT
ROUND(
AVG(
EXTRACT(EPOCH FROM (order_delivered_customer_date - order_purchase_timestamp))
/86400
),2
) AS avg_delivery_days
FROM orders
WHERE order_status='delivered';



-- ============================================================
-- Query 14 : Customers with Pending Orders
-- ============================================================

SELECT
COUNT(DISTINCT customer_id)
FROM orders
WHERE order_status<>'delivered';



-- ============================================================
-- Query 15 : Monthly Customer Growth
-- ============================================================

SELECT
DATE_TRUNC('month',order_purchase_timestamp) AS month,
COUNT(DISTINCT customer_id)
FROM orders
GROUP BY month
ORDER BY month;

