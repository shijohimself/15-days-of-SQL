-- 6) Find the countries which have purchased more than 10 motorcycles.
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM Sales_order;

SELECT t3.country,COUNT(*) total_motorcyles FROM Sales_order t1
JOIN products t2 ON t1.product = t2.product_code
JOIN customers t3 ON t1.customer = t3.customer_id
WHERE product_line = 'Motorcycles'
GROUP BY t3.country
HAVING COUNT(*) > 10;

-- 7) Find the orders where the sales amount is incorrect.
SELECT * FROM Sales_order t1
JOIN products t2 ON t1.product = t2.product_code
WHERE price_each <> price
	
-- 8) Fetch the total sales done for each day.
SELECT order_date,ROUND(SUM(sales)::numeric) total_sales FROM Sales_order 
GROUP BY order_date
ORDER BY total_sales DESC;

-- 9) Fetch the top 3 months which have been doing the lowest sales.
SELECT month_id,
	 CASE WHEN month_id = 1 THEN 'Jan'
	      WHEN month_id = 2 THEN 'Feb'
	      WHEN month_id = 3 THEN 'March'
	      WHEN month_id = 4 THEN 'April'
	      WHEN month_id = 5 THEN 'May'
	      WHEN month_id = 6 THEN 'June'
	      WHEN month_id = 7 THEN 'July'
	      WHEN month_id = 8 THEN 'August'
	      WHEN month_id = 9 THEN 'September'
	      WHEN month_id = 10 THEN 'October'
	      WHEN month_id = 11 THEN 'November'
	      WHEN month_id = 12 THEN 'December'
	END AS months
	, ROUND(SUM(sales)::numeric) total_sales FROM Sales_order 
GROUP BY month_id
ORDER BY total_sales ASC;