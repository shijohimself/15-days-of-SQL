CREATE DATABASE IF NOT EXISTS campusx;
DROP DATABASE campusx;

CREATE TABLE campusx.users(
    user_id INT,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);
INSERT INTO campusx.users VALUES(1,'Shijo','shijo@gmail.com','gamil'),(2,'Manish','Manish@gmail.com','yahoo');
SELECT * FROM campusx.users;
TRUNCATE TABLE campusx.users;

DROP TABLE campusx.users;

CREATE TABLE campusx.users(
    user_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255),
    CONSTRAINT users_email_unique UNIQUE(email,name),
    CONSTRAINT users_id_pk PRIMARY KEY (user_id,name)
);
INSERT INTO campusx.users VALUES(1,'Shijo','shijo@gmail.com','gamil'),(2,'Manish','Manish@gmail.com','yahoo');
INSERT INTO campusx.users VALUES(3,'Ramesh','shijo@gmail.com','abcd'),(4,'Suresh','shijo@gmail.com','xyz'); # this will not work because of unique constraint


CREATE TABLE IF NOT EXISTS campusx.student(
    student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    age INT,
    CONSTRAINT students_age_check CHECK (age > 8 and age < 25)
);

SELECT * FROM  campusx.student;
INSERT INTO campusx.student(name,age) VALUES('George', 21),('Max', 20);
INSERT INTO campusx.student(name,age) VALUES('Lily', 7),('Tom', 54); # check violation

DROP TABLE campusx.tickets;
CREATE TABLE IF NOT EXISTS campusx.tickets(
	ticket_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    travel_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO campusx.tickets(name,travel_date) VALUES('Tom','23-08-23');
INSERT INTO campusx.tickets(name) VALUES('Max');
SELECT * FROM campusx.tickets;

# foreign key example with customers and orders table.
CREATE TABLE campusx.customers(
	cid INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE
);
DROP TABLE campusx.orders;
CREATE TABLE campusx.orders(
	order_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    cust_id INTEGER NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT orders_cid_fk FOREIGN KEY (cust_id) REFERENCES customers(cid)
);

# Alter command
# ADD COLUMN
ALTER TABLE campusx.customers ADD COLUMN password VARCHAR(200) NOT NULL;
ALTER TABLE campusx.customers ADD COLUMN surname VARCHAR(50) NOT NULL AFTER name;

# Adding multiple new columns
ALTER TABLE campusx.customers 
ADD COLUMN pan_number VARCHAR(200) NOT NULL AFTER surname,
ADD COLUMN joining_date DATETIME DEFAULT current_timestamp AFTER password;

# deleting a column
ALTER TABLE campusx.customers DROP COLUMN pan_number;
#deleting multiple columns
ALTER TABLE campusx.customers
DROP COLUMN surname,
DROP COLUMN password;

# modify columns
ALTER TABLE campusx.customers MODIFY COLUMN email INTEGER NULL;

# adding a contsraint
ALTER TABLE campusx.customers ADD CONSTRAINT cust_name_unique UNIQUE (name);
# deleting a constraint
ALTER TABLE campusx.customers DROP CONSTRAINT cust_name_unique;
ALTER TABLE campusx.customers RENAME COLUMN name TO full_name;

SELECT * FROM campusx.customers;
SHOW CREATE TABLE campusx.customers;