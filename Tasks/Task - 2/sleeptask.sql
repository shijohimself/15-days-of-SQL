#Problem 1: Find out the average sleep duration of top 15 male candidates who's sleep duration are equal to 7.5 or greater than 7.5.
USE campusx;
SELECT ROUND(AVG(`Sleep duration`),2)
FROM sleep
WHERE gender = 'Male' AND `Sleep duration` >= 7.5
ORDER BY `Sleep duration` DESC LIMIT 15;

#Problem 2:Show avg deep sleep time for both gender. Round result at 2 decimal places.
# Note: sleep time and deep sleep percentage will give you, deep sleep time.
SELECT * FROM campusx.sleep;
SELECT Gender , ROUND(AVG((`Deep sleep percentage`/100) * `Sleep duration`),2) AS 'deep_sleep_time'
FROM sleep
GROUP BY Gender;

#Problem 3: Find out the lowest 10th to 30th light sleep percentage records where deep sleep percentage values are between 25 to 45. 
# Display age, light sleep percentage and deep sleep percentage columns only.
SELECT age, `Light sleep percentage`, `Deep sleep percentage`
FROM sleep
WHERE `Deep sleep percentage` BETWEEN 25 AND 45
ORDER BY `Light sleep percentage`
LIMIT 10,20;

# Problem 4: Group by on exercise frequency and smoking status and show average deep sleep time, average light sleep time and avg rem sleep time.
#Note the differences in deep sleep time for smoking and non smoking status

SELECT `Exercise frequency`,`Smoking status`, AVG((`Deep sleep percentage`/100) * `Sleep duration`) AS 'deep_sleep_time',
AVG((`Light sleep percentage`/100) * `Sleep duration`) AS 'light_sleep_time',
AVG((`REM sleep percentage`/100) * `Sleep duration`) AS 'REM_sleep_time'
FROM sleep
GROUP BY `Exercise frequency`,`Smoking status`
ORDER BY `Smoking status` ASC, deep_sleep_time DESC;

#Problem 5:Group By on Awekning and show AVG Caffeine consumption, AVG Deep sleep time and AVG Alcohol consumption only for people who do exercise atleast 3 days a week. 
#Show result in descending order awekenings
SELECT * FROM campusx.sleep;
SELECT Awakenings , AVG(`Caffeine consumption`) as 'avg_caffeine',
AVG((`Deep sleep percentage`/100) * `Sleep duration`) AS 'deep_sleep_time',
AVG(`Alcohol consumption`) AS 'avg_alcohol_consumption' 
FROM sleep
WHERE `Exercise frequency` >= 3
GROUP BY Awakenings
ORDER BY Awakenings DESC; 