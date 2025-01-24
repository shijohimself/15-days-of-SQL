CREATE DATABASE sql_cx_live;
USE sql_cx_live;
# CROSS JOIN
SELECT * FROM sql_cx_live.users1 t1
CROSS JOIN sql_cx_live.groups t2;

#INNER JOIN
SELECT * FROM sql_cx_live.users1 t1
INNER JOIN sql_cx_live.membership t2
ON t1.user_id = t2.user_id;

# LEFT JOIN
SELECT * FROM sql_cx_live.users1 t1
LEFT JOIN sql_cx_live.membership t2
ON t1.user_id = t2.user_id;

#RIGHT JOIN
SELECT * FROM sql_cx_live.users1 t1
RIGHT JOIN sql_cx_live.membership t2
ON t1.user_id = t2.user_id;

# SET OPERATIONS 
# UNION 
SELECT * FROM sql_cx_live.person1
UNION
SELECT * FROM sql_cx_live.person2;

# UNION ALL
SELECT * FROM sql_cx_live.person1
UNION ALL
SELECT * FROM sql_cx_live.person2;

#INTERSECT
SELECT * FROM sql_cx_live.person1
INTERSECT
SELECT * FROM sql_cx_live.person2;

# EXCEPT
SELECT * FROM sql_cx_live.person1
EXCEPT
SELECT * FROM sql_cx_live.person2;

SELECT * FROM sql_cx_live.person2
EXCEPT
SELECT * FROM sql_cx_live.person1;

# FULL OUTER JOIN IN MYSQL
SELECT * FROM sql_cx_live.users1 t1
LEFT JOIN sql_cx_live.membership t2
ON t1.user_id = t2.user_id
UNION
SELECT * FROM sql_cx_live.users1 t1
RIGHT JOIN sql_cx_live.membership t2
ON t1.user_id = t2.user_id;

# SELF JOIN
SELECT * FROM sql_cx_live.users1 t1
JOIN sql_cx_live.users1 t2
ON t1.emergency_contact = t2.user_id;

CREATE DATABASE flipkart;
use flipkart;
SELECT * FROM flipkart.order_details;

# Filtering rows
SELECT * FROM flipkart.orders t1
JOIN flipkart.users t2
ON t1.user_id = t2.user_id
WHERE t2.city = 'Pune';

# Q.1 Find all profitable orders
SELECT t1.order_id, SUM(t2.profit) AS 'sum' FROM flipkart.orders t1
JOIN flipkart.order_details t2
ON t1.order_id = t2.order_id
GROUP BY order_id
HAVING sum > 0;

# Q.2 Find the customer who has placed the max number of orders.
SELECT t1.name,COUNT(*) AS 'total_orders' FROM flipkart.users t1
JOIN flipkart.orders t2
ON t1.user_id = t2.user_id
GROUP BY t1.name
ORDER BY total_orders DESC
LIMIT 1;

# Which is the most profitable category
SELECT t2.vertical, SUM(profit) AS 'profit' FROM flipkart.order_details t1
JOIN flipkart.category t2
ON t1.category_id = t2.category_id
GROUP BY vertical
ORDER BY profit DESC
LIMIT 1;

# WHICH IS THE MOST PROFITABLE STATE - 3 table joining
SELECT t3.state,SUM(profit) AS 'total_profit' FROM flipkart.order_details t1
JOIN flipkart.orders t2
ON t1.order_id = t2.order_id
JOIN flipkart.users t3
ON t2.user_id = t3.user_id
GROUP BY state
ORDER BY total_profit DESC
LIMIT 1;