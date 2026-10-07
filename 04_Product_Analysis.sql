-- ============================================================
-- AMAZON E-COMMERCE BUSINESS ANALYSIS
-- File Name : 04_Product_Analysis.sql
-- Objective : Product Performance Analysis
-- Database : PostgreSQL
-- ============================================================


-- ============================================================
-- Query 1 : Total Products
-- ============================================================

SELECT COUNT(*) AS total_products
FROM products;



-- ============================================================
-- Query 2 : Total Product Categories
-- ============================================================

SELECT COUNT(DISTINCT product_category_name)
FROM products;



-- ============================================================
-- Query 3 : Products in Each Category
-- ============================================================

SELECT
product_category_name,
COUNT(*)
FROM products
GROUP BY product_category_name
ORDER BY COUNT(*) DESC;



-- ============================================================
-- Query 4 : Top Selling Products
-- ============================================================

SELECT
oi.product_id,
COUNT(*) AS total_sales
FROM order_items oi
GROUP BY oi.product_id
ORDER BY total_sales DESC
LIMIT 10;



-- ============================================================
-- Query 5 : Highest Revenue Products
-- ============================================================

SELECT
product_id,
SUM(price) AS revenue
FROM order_items
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 10;



-- ============================================================
-- Query 6 : Average Product Price
-- ============================================================

SELECT
ROUND(AVG(price),2)
FROM order_items;



-- ============================================================
-- Query 7 : Most Expensive Products
-- ============================================================

SELECT
product_id,
MAX(price) AS max_price
FROM order_items
GROUP BY product_id
ORDER BY max_price DESC
LIMIT 10;



-- ============================================================
-- Query 8 : Cheapest Products
-- ============================================================

SELECT
product_id,
MIN(price) AS min_price
FROM order_items
GROUP BY product_id
ORDER BY min_price
LIMIT 10;



-- ============================================================
-- Query 9 : Average Freight Cost
-- ============================================================

SELECT
ROUND(AVG(freight_value),2)
FROM order_items;



-- ============================================================
-- Query 10 : Top Categories by Revenue
-- ============================================================

SELECT
p.product_category_name,
SUM(oi.price) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id=oi.product_id
GROUP BY p.product_category_name
ORDER BY revenue DESC
LIMIT 10;



-- ============================================================
-- Query 11 : Products with Highest Weight
-- ============================================================

SELECT
product_id,
product_weight_g
FROM products
ORDER BY product_weight_g DESC
LIMIT 10;



-- ============================================================
-- Query 12 : Products with Most Photos
-- ============================================================

SELECT
product_id,
product_photos_qty
FROM products
ORDER BY product_photos_qty DESC
LIMIT 10;



-- ============================================================
-- Query 13 : Average Product Weight
-- ============================================================

SELECT
ROUND(AVG(product_weight_g),2)
FROM products;



-- ============================================================
-- Query 14 : Average Product Dimensions
-- ============================================================

SELECT
ROUND(AVG(product_length_cm),2),
ROUND(AVG(product_height_cm),2),
ROUND(AVG(product_width_cm),2)
FROM products;



-- ============================================================
-- Query 15 : Top Categories by Number of Products
-- ============================================================

SELECT
product_category_name,
COUNT(*)
FROM products
GROUP BY product_category_name
ORDER BY COUNT(*) DESC
LIMIT 10;
