SELECT * FROM branch;
SELECT * FROM accounts;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM transactions;

SELECT t.trns_id , t.trns_type, t.amount  
FROM transactions t
WHERE trns_type = 'wire transfer';

-- 1.) Fetch all transactions data.
SELECT * FROM transactions;

-- 2.) Fetch account_number and acc type from all accounts
SELECT account_number,acc_type FROM accounts;

-- 3.) Fetch customer id and name of all active customers
SELECT customer_id, first_name,last_name FROM customers
WHERE is_active = 'true';

-- 4) Fetch customer id and name of all active customers who were born after 2000.
SELECT customer_id,first_name,last_name,dob FROM customers
WHERE is_active = 'true' AND dob > '2000-01-01';

-- 5) Find employees whose salary ranges from 50k to 70k
SELECT emp_id,first_name,last_name FROM employees
WHERE salary BETWEEN 50000 AND 70000;

-- 6) Find customers who have not provided basic information such as address or phone number.
SELECT customer_id,first_name,last_name,phone_no,address FROM customers
WHERE phone_no IS NULL OR address IS NULL;

-- 7) Find customers having "oo" in their name.
SELECT * FROM customers
WHERE first_name LIKE '%oo%' OR last_name LIKE '%oo%';

-- 8) Identify the total no of wire transfer transactions.
SELECT COUNT(*) FROM transactions
WHERE trns_type = 'wire transfer';

-- 9) Identify the unique transaction type.
SELECT DISTINCT(trns_type) FROM transactions;

-- 10) Fetch the first 5 transactions
SELECT * FROM transactions
LIMIT 5;

-- 11) Fetch the inactive customers name, phone no, address and dob. Display the the oldest customer first.
SELECT * FROM customers
WHERE is_active = 'false'
ORDER BY dob;

-- 12) Find the customers who are from either "77 Lien Park", "337 Westend Park" or "9 Troy Plaza".
SELECT * FROM customers
WHERE address IN ('77 Lien Park','337 Westend Park','9 Troy Plaza')

-- 13) Fetch all customers who have "Park" or "Plaza" in their address.
SELECT * FROM customers
WHERE address LIKE '%Plaza%' OR address LIKE '%Park%';

