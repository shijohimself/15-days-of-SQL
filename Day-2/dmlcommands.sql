CREATE DATABASE IF NOT EXISTS campusx;
SELECT * FROM campusx.smartphones WHERE 1;
# filter columns
SELECT brand_name,model,price,rating FROM campusx.smartphones WHERE 1;
SELECT model,battery_capacity,os FROM campusx.smartphones WHERE 1;
# Aliasing
SELECT model,battery_capacity AS 'mah',os AS 'operating sytem' FROM campusx.smartphones WHERE 1;

# creating expressions
SELECT model,SQRT(resolution_width*resolution_width + resolution_height*resolution_height)/screen_size AS 'ppi value'
FROM campusx.smartphones WHERE 1;

# constant
SELECT model, 'smartphone' AS 'type' FROM campusx.smartphones WHERE 1;
#distinct value
SELECT DISTINCT(brand_name) FROM campusx.smartphones WHERE 1;
SELECT DISTINCT(processor_brand) AS 'all processors' FROM campusx.smartphones WHERE 1;

SELECT DISTINCT brand_name,processor_brand
FROM campusx.smartphones WHERE 1;

# filter out samsung phones
SELECT * FROM campusx.smartphones WHERE brand_name = 'samsung';
# phones price > 50000
SELECT * FROM campusx.smartphones WHERE price > 50000;

# find all phones in b/w 10000 and 20000
# 1st method
SELECT * FROM campusx.smartphones WHERE price >= 10000 AND price <= 20000;
# 2nd method
SELECT * FROM campusx.smartphones WHERE price BETWEEN 10000 AND 20000; -- SAME RESULT AS PREVIOUS
# FIND PHONES WITH RATING > 80 AND PRICE < 15000
SELECT * FROM campusx.smartphones WHERE rating > 80 AND price < 15000;

# find all samsung phones with ram > 8gb
SELECT brand_name,model,ram_capacity FROM campusx.smartphones WHERE brand_name = 'samsung' AND ram_capacity > 8;
# find all samsung phones with SNAPDRAGON PROCESSORS
SELECT brand_name,model,ram_capacity,processor_brand FROM campusx.smartphones WHERE brand_name = 'samsung' AND processor_brand = 'snapdragon';
# all the brandS whose price  > 50000
SELECT DISTINCT(brand_name) FROM campusx.smartphones WHERE price > 50000;

# all phones where processor -> snapdragon , exynos, bionic
SELECT * FROM campusx.smartphones WHERE processor_brand IN ('snapdragon','exynos','bionic');
SELECT * FROM campusx.smartphones
WHERE processor_brand NOT IN ('snapdragon','exynos','bionic');

UPDATE campusx.smartphones
SET processor_brand = 'dimensity'
WHERE processor_brand = 'mediatek';

SELECT * FROM campusx.smartphones WHERE price > 200000;
DELETE FROM campusx.smartphones
WHERE price > 200000;

SELECT * FROM campusx.smartphones WHERE primary_camera_rear > 150;
DELETE FROM campusx.smartphones
WHERE primary_camera_rear > 150 AND brand_name = 'samsung';

# max and min
SELECT MAX(price) FROM campusx.smartphones
WHERE 1;
SELECT MIN(price) FROM campusx.smartphones
WHERE 1;
# FIND PRICE OF COSTLIEST SAMSUNG PHONE
SELECT MAX(price) FROM campusx.smartphones
WHERE brand_name = 'samsung';
# avg
SELECT AVG(price) FROM campusx.smartphones
WHERE brand_name = 'apple';
# sum()
SELECT SUM(price) FROM campusx.smartphones
WHERE 1;
#  count total oneplus phones
SELECT COUNT(1) FROM campusx.smartphones
WHERE brand_name = "oneplus";
# count unique processor brands
SELECT COUNT(DISTINCT(processor_brand)) FROM campusx.smartphones;
# STD() AND VARIANCE()
SELECT STD(screen_size) FROM campusx.smartphones
WHERE 1;
SELECT VARIANCE(screen_size) FROM campusx.smartphones
WHERE 1;
