-- Q. Find the collectors who did not purchase any paintings
SELECT * FROM sales;
SELECT * FROM artists;

SELECT t1.* FROM collectors t1
LEFT JOIN sales t2 ON t1.id = t2.collector_id
WHERE t2.collector_id IS NULL;

-- Q. Find how much each artists made from sales. and how many paintings did they sell.
SELECT t1.id , CONCAT(t1.first_name,' ',t1.last_name) artist_name,SUM(t2.sales_price) sales_price FROM artists t1
JOIN sales t2 ON t1.id = t2.artist_id
GROUP BY t1.id,t1.first_name,t1.last_name;

-- Q.Dispaly all the available paintings and all the artists. if a painting was sold then mark as 'sold'
-- and if more than 1 painting of an artist was sold then display a '**' beside their name

SELECT t1.name as painting_name,CONCAT(t2.first_name,' ',t2.last_name),COUNT(*) total_count ,
	CASE WHEN COUNT(*) > 1 THEN '**' 
	     ELSE 'Sold'
	END AS mark
FROM paintings t1
JOIN artists t2 ON t1.artist_id = t2.id
LEFT JOIN sales t3 ON t1.artist_id = t3.artist_id
GROUP BY t1.id,t1.name,t2.first_name,t2.last_name;