USE campusx;
CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51);

SELECT AVG(marks) FROM marks;
SELECT *,AVG(marks) OVER() FROM marks;
SELECT *,AVG(marks) OVER(PARTITION BY branch) FROM marks;

SELECT *,
AVG(marks) OVER() as 'overall_avg',
MAX(marks) OVER(),
MIN(marks) OVER(),
MAX(marks) OVER(PARTITION BY branch),
MIN(marks) OVER(PARTITION BY branch)
FROM marks;

# find the students whose marks are higher than the avg marks of their respective branch
SELECT* FROM (SELECT *,
AVG(marks) OVER(PARTITION BY branch) as 'branch_avg'
FROM marks) t
WHERE t.marks > t.branch_avg;

SELECT *,
RANK() OVER(ORDER BY marks DESC)
FROM marks;

SELECT *,
RANK() OVER(PARTITION BY branch ORDER BY marks DESC),
DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC)
FROM marks;

SELECT *,
ROW_NUMBER() OVER(PARTITION BY branch)
FROM marks;
SELECT *,
CONCAT(branch,"-",ROW_NUMBER() OVER(PARTITION BY branch))
FROM marks;

# find top 2 most paying customers of each month
USE zomato;
SELECT * FROM orders;

SELECT * FROM (SELECT MONTHNAME(date) as 'month_name',user_id,SUM(amount) AS 'total',
               RANK() OVER(PARTITION BY MONTHNAME(date) ORDER BY Sum(amount) DESC) as 'rank'
               FROM orders
               GROUP BY MONTHNAME(date),user_id
			   ORDER BY month_name DESC) t
WHERE t.rank < 3;

USE campusx;
SELECT *,
FIRST_VALUE(marks) OVER(ORDER BY marks DESC)
FROM marks;

SELECT *,
LAST_VALUE(marks) OVER(ORDER BY marks DESC)
FROM marks; # This will not show the desired output because of the frame set to default

SELECT *,
LAST_VALUE(marks) OVER(ORDER BY marks DESC
				       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks;

SELECT *,
LAST_VALUE(marks) OVER(PARTITION BY branch 
					   ORDER BY marks DESC
				       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks;


# find second topper name in every branch
SELECT *,
NTH_VALUE(name,2) OVER(PARTITION BY branch 
					   ORDER BY marks DESC
				       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks;

SELECT *,
NTH_VALUE(name,5) OVER(PARTITION BY branch 
					   ORDER BY marks DESC
				       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM marks;

SELECT * FROM (SELECT *,
                       FIRST_VALUE(name) OVER(PARTITION BY branch
					   ORDER BY marks DESC
					   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as 'topper_name',
                       FIRST_VALUE(marks) OVER(PARTITION BY branch
					   ORDER BY marks DESC
					   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as 'topper_marks'
                       FROM marks) t
WHERE t.name = topper_name AND t.marks = topper_marks;
			
SELECT * FROM marks;
SELECT *,
LAG(marks) OVER(PARTITION BY branch ORDER BY student_id),
LEAD(marks) OVER(PARTITION BY branch ORDER BY student_id)
FROM marks;


USE zomato;
SELECT * FROM orders;

SELECT MONTHNAME(date),SUM(amount),
((SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY MONTHNAME(date) Desc))/ LAG(SUM(amount)) OVER(ORDER BY MONTHNAME(date) Desc)*100)
FROM orders
GROUP BY MONTHNAME(date)