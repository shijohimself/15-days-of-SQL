SELECT * FROM campusx.college;
USE campusx;
SELECT `Power Station`, AVG(`Monitored Cap.(MW)`) AS 'mon_cap',
COUNT(*) AS 'occurence'
FROM powergen
GROUP BY `Power Station`
HAVING (mon_cap BETWEEN 1000 AND 2000) AND occurence > 200
ORDER BY occurence ASC;

# Q.7
SELECT State , ROUND(AVG(Value),2) as 'avg_value' , COUNT(*) as 'occurence'
FROM college
WHERE Year IN (2013,2017,2021) AND Type = 'Public In-State'
GROUP BY State
HAVING occurence BETWEEN 6 AND 10;

# q.8
SELECT State, AVG(value) AS 'avg'
FROM college
WHERE Expense = 'Fees/Tuition' AND Type LIKE 'Public%'
GROUP BY State
ORDER BY avg ASC
LIMIT 1;

# Q.9
SELECT State , AVG(Value) as 'cost'
FROM college 
WHERE Type = 'Private' AND Year IN (2021) AND 
(Expense Like '%Tuition%' OR Expense LIKE '%Room%')
GROUP BY State
ORDER BY cost DESC
LIMIT 1,1;

#q.10
SELECT * FROM campusx.shipping;
SELECT Mode_of_Shipment, Warehouse_block,
SUM(Discount_offered) AS 'd_offered', AVG(Discount_offered)
FROM shipping
WHERE Gender = 'M' AND Product_importance = 'high'
GROUP BY Mode_of_Shipment, Warehouse_block
ORDER BY Mode_of_Shipment DESC, Warehouse_block ASC;


