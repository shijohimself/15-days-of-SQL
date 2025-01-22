USE campusx;
SELECT * FROM smartphones;
# find top 5 samsung phones with biggest screen size
SELECT * FROM smartphones WHERE brand_name = 'samsung'
ORDER BY screen_size DESC
LIMIT 5;
# sort data with max number of cameras
SELECT brand_name,model,price,(num_rear_cameras + num_front_cameras) AS total_cameras
FROM smartphones WHERE 1
ORDER BY total_cameras DESC;

# SORT ACCORDING TO HIGHER PPI VALUES
SELECT brand_name,model,
(ROUND(SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size)) AS 'ppi'
FROM smartphones WHERE 1
ORDER BY ppi DESC;

# query the phone with second largest battery capacity
SELECT model,battery_capacity FROM smartphones
ORDER BY battery_capacity DESC LIMIT 1,1;

# find the name and rating of the worst rated apple phone
SELECT model,rating
FROM smartphones
WHERE brand_name = 'apple'
ORDER BY rating LIMIT 1;

# sort phones alphabetically and then on the basis of price
SELECT * FROM smartphones
ORDER BY brand_name ASC,price ASC;

# sort phones alphabetically and then on the basis of rating
SELECT * FROM smartphones
ORDER BY brand_name ASC, rating DESC;

# group smartphones by brand and get the count, average , max , min 
SELECT brand_name, COUNT(*) AS 'num_of_phones',
ROUND(AVG(price),2) AS 'avg price',
MAX(rating) AS 'max rating',
ROUND(AVG(screen_size),2) AS 'avg_screen_size',
ROUND(AVG(battery_capacity),2) AS 'avg battery capacity'
FROM smartphones
GROUP BY brand_name
ORDER BY num_of_phones DESC;

# group smartphones by whether they have nfc and get the avg
SELECT has_nfc, ROUND(AVG(price)) AS 'avg price',
ROUND(AVG(rating)) AS 'avg rating'  
FROM smartphones
GROUP BY has_nfc;

# group smartphones by the brand and processor brand and get the count of models and the average primary resolution(rear)
SELECT brand_name, processor_brand,
COUNT(*) AS 'num phones',
AVG(primary_camera_rear) AS 'avg cam resolution'
FROM smartphones
GROUP BY brand_name,processor_brand
ORDER BY brand_name;

# find the top 5 most costly phone brands
SELECT brand_name, AVG(price) AS 'avg_price'
FROM smartphones
GROUP BY brand_name
ORDER BY avg_price DESC
LIMIT 5;

# WHICH BRAND MAKES THE SMALLEST SCREEN SMARTPHONES
SELECT brand_name,ROUND(AVG(screen_size)) AS 'avg_screen_size'
FROM smartphones
GROUP BY brand_name
ORDER BY avg_screen_size
LIMIT 1;

# group smartphones by the brand, and find the brand with highest num of models that have both NFC and an IR blaster
SELECT brand_name,
COUNT(*) AS 'num_of_models'
FROM smartphones
WHERE has_nfc = 'True' AND has_ir_blaster = 'True'
GROUP BY brand_name
ORDER BY num_of_models DESC
LIMIT 1;

# find all samsung 5g enabled smartphones and find out the avg price for nfc and non-nfc phone

SELECT brand_name , has_nfc , ROUND(AVG(price)) AS 'avg_price'
FROM smartphones
WHERE brand_name = 'samsung' AND has_5g = 'True'
GROUP BY has_nfc;

# HAVING CLAUSE
SELECT brand_name,
COUNT(*) AS 'count',
AVG(price) AS 'avg_price'
FROM smartphones
GROUP BY brand_name
HAVING count > 20
ORDER BY avg_price DESC;

# find the avg rating of top 3 smartphone brands which have more than 20 phones
SELECT brand_name,COUNT(*) AS 'count', ROUND(AVG(rating)) as 'avg_rating'
FROM smartphones 
GROUP BY brand_name
HAVING count > 20;

# find the top 3 brands with the highest avg ram that have a refresh rate of at least 90 hz and fast charging available and dont consider brands which have less than 10 phones
SELECT brand_name ,COUNT(*) AS 'count', AVG(ram_capacity) AS 'avg_ram'
FROM smartphones
WHERE refresh_rate >= 90 AND fast_charging_available = 1
GROUP BY brand_name
HAVING count >= 10
ORDER BY avg_ram DESC
LIMIT 3;

# find the avg price of all the phone brands with avg rating > 70 and num_phones more than 10 among all 5g enabled phones
SELECT brand_name,
AVG(price) AS 'avg_price'
FROM smartphones
WHERE has_5g = 'True'
GROUP BY brand_name
HAVING AVG(rating) > 70 AND COUNT(*) > 10
ORDER BY avg_price DESC; 

# NEW DATASET
SELECT * FROM ipl_data;

# find top 5 batsman in ipl
SELECT batter, SUM(total_run) AS 'total_run'
FROM ipl_data
GROUP BY batter
ORDER BY total_run DESC
LIMIT 5;

# FIND THE SECOND HIGHEST SIX HITTER IN IPL
SELECT batter, COUNT(*) AS 'total_six'
FROM ipl_data
WHERE batsman_run = 6
GROUP BY batter
ORDER BY total_six DESC
LIMIT 1,1;

#find top 5 batsman with highest strike rate who have played min 1000 balls
SELECT batter , SUM(batsman_run) AS 'total_runs', COUNT(batsman_run) AS 'balls_played',
(SUM(batsman_run)/COUNT(batsman_run) * 100) AS 'strike_rate'
FROM ipl_data
GROUP BY batter
HAVING balls_played > 1000
ORDER BY strike_rate DESC LIMIT 5;