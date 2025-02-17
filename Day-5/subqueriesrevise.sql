SELECT * FROM sql_cx_live.movies;
USE sql_cx_live;
SELECT * FROM movies
WHERE score = (SELECT MAX(score) FROM movies);

# independent sq - scalar subq
# find the movie with highest profit(vs order by)
SELECT * FROM movies
WHERE (gross - budget) = (SELECT MAX(gross - budget) FROM movies);

# find how many movies have a rating > the avg of all the movie ratings
# find the count of above average movies
SELECT COUNT(*) FROM movies
WHERE score > (SELECT AVG(score) FROM movies);
SELECT COUNT(*) FROM movies;

# find the highest rated movie of year 1980
SELECT * FROM movies
WHERE year = 1980 AND score = (SELECT MAX(score) FROM movies
WHERE year = 1980);

# find the highest rated movie among all movies whose number of votes are >
# the dataset avg votes
SELECT * FROM movies
WHERE score = (SELECT MAX(score) FROM movies
               WHERE votes > (SELECT AVG(votes) FROM movies));

CREATE DATABASE zomato;
USE zomato;

SELECT * FROM zomato.users;
SELECT * FROM zomato.orders;

# independent subq - row subq
# find the users who never ordered
SELECT * FROM users 
WHERE user_id NOT IN (SELECT DISTINCT(user_id) FROM orders);

# find all the movies made by top 3 directors 
# (in terms of total gross income)
USE sql_cx_live;
select * FROM movies;
SELECT * FROM movies WHERE 
director IN (SELECT director FROM movies
             GROUP BY director
             ORDER BY SUM(gross) DESC
             LIMIT 3);

WITH cte as (SELECT director FROM movies
             GROUP BY director
             ORDER BY SUM(gross) DESC
             LIMIT 3)
SELECT * FROM movies
WHERE director IN (SELECT * FROM cte);

# find all movies of all those actors whose filmography's avg rating > 8.5
# (take 25000 vote as cutoff)
SELECT * FROM movies
WHERE star IN (SELECT star FROM movies
               GROUP BY star
               HAVING AVG(score) > 8.5)
AND votes >= 25000;

SELECT star FROM movies
WHERE AVG(score) > 8.5
GROUP BY star;

# independent sq -> table subq
# find the most profitable movie of each year
SELECT * FROM movies;
SELECT * FROM movies
WHERE (year,gross-budget) IN (SELECT year,MAX(gross-budget) 
                              FROM movies
                              GROUP BY year);

# find the highest rated movie of each genre votes cutoff of 25000
SELECT * FROM movies
WHERE (genre,score) IN (SELECT genre,MAX(score) FROM movies
                        WHERE votes > 25000
                        GROUP BY genre
						);


# find the highest grossing movie of top 5 actor/director combo in terms of 
# total gross income
WITH cte as (SELECT star,director, MAX(gross) as 'total_gross' FROM movies
                                     GROUP BY star,director
                                     ORDER BY SUM(gross) DESC
									 LIMIT 5)
SELECT * FROM movies
WHERE (star,director,gross) IN (SELECT * FROM cte);
SELECT star,director, SUM(gross) as 'total_gross' FROM movies
GROUP BY star,director
ORDER BY total_gross DESC
LIMIT 5;


# correlated subq
# find all the movies that have a rating higher than the avg rating of movies
#in the same genre 
SELECT * FROM movies m1
WHERE score > (SELECT AVG(score) FROM movies m2 WHERE m2.genre = m1.genre);

# FIND THE FAV FOOD OF EACH CUSTOMER
USE zomato;
WITH cte as (SELECT t1.user_id,t1.name,t4.f_name,COUNT(*) as 'count' FROM users t1
            JOIN orders t2 ON t1.user_id = t2.user_id
            JOIN order_details t3 ON t3.order_id = t2.order_id
			JOIN food t4 ON t4.f_id = t3.f_id
			GROUP BY t1.user_id,t1.name,t4.f_id,t4.f_name)

SELECT * FROM cte m1
WHERE count = (SELECT MAX(count) FROM cte m2 WHERE m2.user_id = m1.user_id);


# display all movie names , genre , score and avg(score) of genre
USE sql_cx_live;
SELECT name,genre,score,ROUND((SELECT AVG(score) FROM movies m2 WHERE m2.genre = m1.genre),1) as 'avg_score_of_genre' FROM movies m1;

# display avg rating of all the restaurants
USE zomato;
SELECT t1.r_id,t1.r_name,AVG(restaurant_rating) FROM restaurants t1
JOIN orders t2 ON t1.r_id = t2.r_id
GROUP BY r_id,r_name;

# using subquery in from clause
SELECT r_name, avg_rating
FROM (SELECT r_id,AVG(restaurant_rating) as 'avg_rating' FROM orders
      GROUP BY r_id) t1 JOIN restaurants t2 ON t1.r_id = t2.r_id;

# find genres having avg scores > avg score of all movies
SELECT * FROM movies;
SELECT genre, AVG(score) FROM movies
GROUP BY genre
HAVING AVG(score) > (SELECT AVG(score) FROM movies);

# using sq with insert
USE zomato;
SELECT user_id FROM orders t1
JOIN users t2 ON t1.order_id = t2.order_id
GROUP BY user_id







