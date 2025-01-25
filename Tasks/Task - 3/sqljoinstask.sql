CREATE DATABASE task3;
USE task3;
SELECT t1.Country,SUM(t1.A),SUM(t2.D) FROM task3.country_ab t1
JOIN task3.country_cd t2
ON t1.Country = t2.Country
GROUP BY Country
ORDER BY sum(t1.A) DESC , sum(t2.D) DESC
LIMIT 10;

#q.2 Find out highest CL value for 2020 for every region. 
#Also sort the result in descending order. 
#Also display the CL values in descending order.

SELECT t1.Region,MAX(t2.CL) AS 'max' FROM task3.country_ab t1
JOIN task3.country_cl t2
ON t1.Country = t2.Country
WHERE t1.Edition = 2020
GROUP BY Region
ORDER BY max DESC;

# NEW DATASET
CREATE DATABASE SalesDB;
USE SalesDB;

#Q.3 Find top-5 most sold products.
SELECT t1.Name,SUM(t2.Quantity) as 'sum' FROM SalesDB.Products t1
JOIN SalesDB.Sales1 t2
ON t1.ProductID = t2.ProductID
GROUP BY t1.Name
ORDER BY sum DESC LIMIT 5;

# Q.4 Find sales man who sold most no of products.
SELECT t2.FirstName, t2.LastName , COUNT(*) AS 'total_sold' FROM SalesDB.Sales1 t1
JOIN SalesDB.Employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY FirstName,LastName
ORDER BY total_sold DESC;

#Q.5 Sales man name who has most no of unique customer.
SELECT t2.FirstName, t2.LastName,
COUNT(distinct(CustomerID)) AS 'unique_cust'
FROM SalesDB.Sales1 t1
JOIN SalesDB.Employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY FirstName,LastName
ORDER BY unique_cust DESC;
 
# Q.6 Sales man who has generated most revenue. Show top 5.
# (Quantity * Price) AS 'revenue'
SELECT t3.FirstName, t3.LastName, 
SUM((Quantity * Price)) AS 'revenue' FROM SalesDB.Sales1 t1
JOIN SalesDB.Products t2
ON t1.ProductID = t2.ProductID
JOIN SalesDB.Employees t3
ON t1.SalesPersonID = t3.EmployeeID
GROUP BY FirstName,LastName
ORDER BY revenue DESC
LIMIT 5;

# Q.7. List all customers who have made more than 10 purchases.
SELECT COUNT(DISTINCT(SalesID)) AS 'purchases',t2.FirstName, t2.LastName
FROM SalesDB.Sales1 t1
JOIN SalesDB.Customers t2
ON t1.CustomerID = t2.CustomerID
GROUP BY FirstName,LastName
HAVING purchases > 10;

# Q.8. List all salespeople who have made sales to more than 5 customers.
SELECT EmployeeID,FirstName,LastName,
COUNT(DISTINCT(CustomerID)) AS 'customers'
FROM SalesDB.Sales1 t1
JOIN SalesDB.Employees t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY EmployeeID,FirstName,LastName
HAVING  COUNT(DISTINCT(CustomerID)) > 5;

# Q.9  List all pairs of customers who have made purchases with the same salesperson.
SELECT DISTINCT t1.CustomerID AS 'first_cutomer',t2.CustomerID As 'second_customer',
t2.SalesPersonID AS 'sales_person'
FROM SalesDB.Sales1 t1
JOIN SalesDB.Sales1 t2
ON t1.SalesPersonID = t2.SalesPersonID AND t1.CustomerID <> t2.CustomerID;

















