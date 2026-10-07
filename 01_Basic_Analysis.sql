-- ============================================================
-- AMAZON E-COMMERCE BUSINESS ANALYSIS
-- File Name : 01_Basic_Analysis.sql
-- Objective : Basic Performance Analysis
-- Database : PostgreSQL
-- ============================================================



-- ============================================
-- Query 1: Total Customers
-- ============================================

SELECT COUNT(*) AS total_customers
FROM customers;



-- ============================================
-- Query 2: Total Orders
-- ============================================

SELECT COUNT(*) AS total_orders
FROM orders;



-- ============================================
-- Query 3: Total Products
-- ============================================

SELECT COUNT(*) AS total_products
FROM products;



-- ============================================
-- Query 4: Orders by Status
-- ============================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;



-- ============================================
-- Query 5: Customers by State
-- ============================================

SELECT
    customer_state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;


-- ============================================
-- Query 6: Orders by State (JOIN)
-- ============================================

SELECT
    c.customer_state,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;



-- ============================================
-- Query 7: Average Product Price
-- ============================================

SELECT
    ROUND(AVG(price),2) AS average_product_price
FROM order_items;



-- ============================================
-- Query 8: Total Revenue
-- ============================================

SELECT
    ROUND(SUM(price),2) AS total_revenue
FROM order_items;



-- ============================================
-- Query 9: Top 10 Most Expensive Products Sold
-- ============================================

SELECT
    product_id,
    MAX(price) AS highest_price
FROM order_items
GROUP BY product_id
ORDER BY highest_price DESC
LIMIT 10;



-- ============================================
-- Query 10: Top 10 Highest Freight Charges
-- ============================================

SELECT
    order_id,
    freight_value
FROM order_items
ORDER BY freight_value DESC
LIMIT 10;

