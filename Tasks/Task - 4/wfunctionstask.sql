CREATE DATABASE task4;
USE task4;
SELECT * FROM insurance;

# What are the top 5 patients who claimed the highest insurance amounts?
SELECT *,
RANK() OVER(ORDER BY claim DESC)
from insurance
LIMIT 5;

# What is the average insurance claimed by patients based on the number of children they have?
SELECT * FROM (SELECT *,
AVG(claim) OVER(PARTITION BY children ORDER BY claim 
				ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'avg_claim',
ROW_NUMBER() OVER(PARTITION BY children) as 'row_num'
FROM insurance) t
WHERE t.row_num = 1;

# What is the highest and lowest claimed amount by patients in each region?
SELECT * FROM (SELECT *,
               MAX(claim) OVER(PARTITION BY region ORDER BY claim DESC
			   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'max_claim',
			   MIN(claim) OVER(PARTITION BY region ORDER BY claim DESC
			   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as 'min_claim'
FROM insurance) t
WHERE t.claim = max_claim or t.claim = min_claim
ORDER BY max_claim DESC;

# What is the percentage of smokers in each age group?
# What is the difference between the claimed amount of each patient and the first claimed amount of first patient?
SELECT *,
ROUND(claim - FIRST_VALUE(claim) OVER(),2) AS 'diff'
FROM insurance;

# For each patient, calculate the difference between their claimed amount and the average claimed amount of patients with the same number of children.
SELECT *,
(claim - AVG(claim) OVER(PARTITION BY children)) as diff 
FROM insurance
ORDER BY diff DESC;

# Show the patient with the highest BMI in each region and their respective rank.
SELECT * FROM (SELECT *,
MAX(bmi) OVER(PARTITION BY region) as 'max_bmi',
RANK() OVER(partition by region ORDER BY bmi) as 'rank',
RANK() OVER(ORDER BY bmi) as 'overall_rank'
FROM insurance) t
WHERE t.rank = 1;

# Calculate the difference between the claimed amount of each patient and the claimed amount of the patient who has the highest BMI in their region.
SELECT *,
claim - MAX(claim) OVER(PARTITION BY region ORDER BY bmi DESC
				ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED following)
FROM insurance;

-- For each patient, calculate the difference in claim amount between the patient 
-- and the patient with the highest claim amount among patients with the smoker status, 
-- within the same region. Return the result in descending order difference.

SELECT *,
(claim - FIRST_VALUE(claim) OVER(PARTITION BY smoker,region)) as 'condition'
FROM insurance;

# For each patient, find the maximum BMI value among their next three records (ordered by age).
SELECT *,
MAX(bmi) OVER(ORDER BY age
		      ROWS BETWEEN 1 FOLLOWING AND 3 FOLLOWING)
FROM insurance;

# For each patient, find the rolling average of the last 2 claims.
SELECT *,
AVG(claim) OVER(ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM insurance;

-- Find the first claimed insurance value for male and female patients,
-- within each region order the data by patient age in ascending order, 
-- and only include patients who are non-diabetic and have a bmi value between 25 and 30.

SELECT * FROM (SELECT *,
FIRST_VALUE(claim) OVER(PARTITION BY gender,region) as 'first_claim',
ROW_NUMBER() OVER(PARTITION BY gender,region) as 'row_num'
FROM insurance
WHERE diabetic = 'No' AND bmi BETWEEN 25 and 30) t
WHERE t.row_num = 1
ORDER BY age ASC;







