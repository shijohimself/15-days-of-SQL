-- 3) Find all orders for Planes, Ships and Trains which are neither Shipped nor In Process nor Resolved.
SELECT * FROM Sales_order t1
JOIN products t2 ON t1.product = t2.product_code
WHERE t2.product_line IN ('Planes','Ships','Trains')
AND t1.status NOT IN ('Shipped','Resolved','In Process');
-- 4) Find customers whose phone number has either parenthesis "()" or a plus sign "+".
SELECT * FROM customers
WHERE phone NOT LIKE '%(%' AND phone NOT LIKE '%)%' AND phone NOT LIKE '%+%';

-- 5) Find customers whose phone number does not have any space.
SELECT * FROM customers
WHERE phone NOT LIKE '% %';

-- 6) Fetch all the orders between Feb 2003 and May 2003 where the quantity ordered was an even number.
SELECT * FROM Sales_order
WHERE month_id BETWEEN 2 AND 5
AND quantity_ordered % 2 = 0;

-- 7) Find orders which sold the product for price higher than its original price.
SELECT * FROM products;
SELECT * FROM Sales_order;
SELECT *,ROUND((price_each - price)::numeric , 2 ) profit FROM products t1
JOIN Sales_order t2 ON t1.product_code = t2.product
WHERE price_each > price;

-- 8) Find the average sales order price
SELECT AVG(price_each)
FROM Sales_order;

-- 9) Count total no of orders.
SELECT COUNT(*)
FROM Sales_order;

-- 10) Find the total quantity sold.
SELECT SUM(quantity_ordered)
FROM Sales_order;

-- 11) Fetch the first order date and the last order date.
SELECT MIN(order_date) first_order_date, MAX(order_date) last_order_date
FROM Sales_order;