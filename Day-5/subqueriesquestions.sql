select * from paintings;
select * from artists;
select * from collectors;
select * from sales;

-- Q. Fetch paintings that are priced higher than the avg painting price
SELECT * FROM paintings
WHERE listed_price > (SELECT AVG(listed_price) FROM paintings);

-- Q. Fetch all collectors who purchased paintings
SELECT collector_id FROM sales;

SELECT * FROM collectors
WHERE id IN (SELECT collector_id FROM sales);

-- solution using join
SELECT DISTINCT t1.* FROM collectors t1 
JOIN sales t2 on t1.id = t2.collector_id;

-- Q. Fetch the total amount of sales for each artist who has sold at least one painting
-- Display artist name and total sales amount
SELECT *
FROM (SELECT artist_id, SUM(sales_price) total_amount FROM sales
GROUP BY artist_id) t1
JOIN artists t2 ON t1.artist_id = t2.id;

-- Q. Fetch the total amount of sales for each artist who has sold either 1 or 2 paintings only
SELECT t1.artist_id,t2.first_name,t2.last_name,total_amount,total_paintings
FROM (SELECT artist_id, SUM(sales_price) total_amount,COUNT(*) total_paintings FROM sales
GROUP BY artist_id
HAVING COUNT(*) = 1 OR COUNT(*) = 2) t1
JOIN artists t2 ON t1.artist_id = t2.id;

-- Q. Find the name of artsists who had 0 sales
SELECT * FROM artists
WHERE id NOT IN (SELECT artist_id FROM sales);

-- correlated subquery
SELECT * FROM artists t1
WHERE NOT EXISTS (SELECT 1 FROM sales t2
	    WHERE t2.artist_id = t1.id)

-- Q. Write a query to identify duplicate records
INSERT INTO artists VALUES(5,'Kate','Smith');
INSERT INTO artists VALUES(6,'Natali','Wein');
SELECT * FROM artists;

-- duplicate records
SELECT first_name,last_name, COUNT(*) FROM artists
GROUP BY first_name,last_name
HAVING COUNT(*) > 1;
