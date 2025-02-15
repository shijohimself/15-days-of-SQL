select * from Sales_order;
select * from Customers;
select * from Products;

SELECT country , MAX(city) , MIN(city) FROM customers
WHERE country = 'Spain'
GROUP BY country;

-- Rules for group by
-- 1.) column list in group by and select should match
-- 2.) any additional col in select clause must be within the agg func
-- 3.) select clause can only has agg funct
-- 4.) group by col should either be present in select clause as standalone col or within the agg functions

SELECT country , count(1) FROM customers
WHERE country = 'Spain'
GROUP BY country;

SELECT country , city , count(1) FROM customers
WHERE country = 'Spain'
GROUP BY country,city;

SELECT product_line,COUNT(1) vehicle_count FROM products
GROUP BY product_line
HAVING COUNT(1) > 20;

SELECT product_line,COUNT(1) vehicle_count FROM products
WHERE product_line <> 'Trains'
GROUP BY product_line
HAVING COUNT(1) < 20;

-- Find the average sales order price based on deal_size
SELECT deal_size,ROUND(AVG(sales)::decimal,2) avg_order_price FROM Sales_order
GROUP BY deal_size

-- Find total no of orders per each day , sort data based on highest orders
SELECT order_date , COUNT(*) total_order FROM Sales_order
GROUP BY order_date
ORDER BY 2 DESC;

-- Display the total sales figure for each quarter . Represent each quarter with their respective period
SELECT qtr_id,
	CASE WHEN qtr_id = 1 THEN 'Jan-March'
	     WHEN qtr_id = 2 THEN 'April-June'
	     WHEN qtr_id = 3 THEN 'July-September'
	     WHEN qtr_id = 4 THEN 'October-December'
	     ELSE 'Invalid'
	END AS time_period,
	SUM(sales) FROM Sales_order
GROUP BY qtr_id

-- Identify how many cars,motorcycles, trains and ships are available. Treat all types pf cars as just cars
-- solution with subquery
SELECT product_line, COUNT(1) total_count FROM(SELECT
	CASE WHEN product_line IN ('Vintage Cars','Classic Cars') THEN 'Cars'
 	     ELSE product_line
	END AS product_line
    FROM products
    WHERE product_line IN ('Trains','Ships','Motorcycles','Vintage Cars','Classic Cars')
	) x
GROUP BY product_line;

-- Second Method
SELECT
	CASE WHEN product_line LIKE '%Cars%' THEN 'Cars'
	     ELSE product_line
	END AS product_line,
COUNT(1) total_products
FROM products
WHERE product_line IN ('Motorcycles','Ships','Trains','Vintage Cars','Classic Cars')
GROUP BY CASE WHEN product_line LIKE '%Cars%' THEN 'Cars'
	     ELSE product_line
	END;

-- Third method using union
SELECT product_line,count(*) FROM products
WHERE product_line IN ('Motorcycles','Trains','Ships')
GROUP BY product_line
UNION
SELECT 'Cars' product_line,count(*) FROM products
WHERE product_line IN ('Classic Cars','Vintage Cars');

-- Identify the vehicles in the inventory which are short in number.
-- shortage of vehicles is considered when there are less than 10 vehicles

SELECT product_line,COUNT(*) FROM products
GROUP BY product_line
HAVING COUNT(*) < 10;

-- Group concat
SELECT country,
string_agg(DISTINCT city,',' ORDER BY city DESC) states
FROM customers
GROUP BY country;