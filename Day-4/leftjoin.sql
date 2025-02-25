select * from paintings;
select * from artists;
select * from collectors;
select * from sales;

-- Fetch names of all the artsits along with their painting name
-- If an artist does not have a painting yet display as 'NA'
SELECT t1.id,CONCAT(first_name,' ',last_name) artist_name,
	CASE WHEN t2.name IS NULL THEN 'NA'
	     ELSE t2.name
	END AS painting_name
FROM artists t1 
LEFT JOIN paintings t2 ON t1.id = t2.artist_id

SELECT t1.id,CONCAT(first_name,' ',last_name) artist_name,
	COALESCE(t2.name , 'NA') painting_name
FROM artists t1 
LEFT JOIN paintings t2 ON t1.id = t2.artist_id;


