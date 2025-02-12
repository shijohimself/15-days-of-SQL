# CREATE AND DROP
CREATE DATABASE IF NOT EXISTS srishti_db;
DROP DATABASE srishti_db;

-- CREATING TABLES
DROP TABLE srishti_db.users;
CREATE TABLE srishti_db.users(
    user_id INTEGER,
    name VARCHAR(20),
    email VARCHAR(30),
    password VARCHAR(20)
);
INSERT INTO srishti_db.users VALUES(1,'shijo','shijo1920@gmail.com','password'),(2,'srishti','srishti@gmail.com','chips');
SELECT * FROM srishti_db.users;
TRUNCATE TABLE srishti_db.users; -- delets the data inside the table!

CREATE DATABASE shijo_db;
USE shijo_db;
CREATE TABLE IF NOT EXISTS users(
   id INT,
   name VARCHAR(20)
);
INSERT INTO users VALUES(1,'shijo'),(2,'srishti');
SELECT * FROM users;
DROP TABLE users;
DROP DATABASE shijo_db;

USE srishti_db;
DROP TABLE users;

CREATE TABLE srishti_db.users(
    user_id INTEGER AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    email VARCHAR(30),
    password VARCHAR(20),
    CONSTRAINT users_email_name_unique UNIQUE(name,email),
    CONSTRAINT users_user_id_pk PRIMARY KEY(user_id)
);

ALTER TABLE users ADD COLUMN address VARCHAR(100) NOT NULL;
SELECT * FROM users;
ALTER TABLE users ADD COLUMN last_name VARCHAR(20) NOT NULL AFTER name;
-- adding multiple new columns
ALTER TABLE users
ADD COLUMN bank_statement INTEGER,
ADD COLUMN married_status VARCHAR(2);

-- dropping a column
ALTER TABLE users DROP COLUMN address;
-- deleting multiple columns
ALTER TABLE users
DROP COLUMN bank_statement,
DROP COLUMN married_status;

-- renaming a column 
ALTER TABLE users RENAME COLUMN name TO first_name; 
-- modifying a column
ALTER TABLE users MODIFY COLUMN first_name VARCHAR(100) NOT NULL;
-- modifying multiple columns
ALTER TABLE users 
MODIFY COLUMN last_name VARCHAR(30) NOT NULL,
MODIFY COLUMN email VARCHAR(50) NOT NULL;

-- ADDING AND DROPPING A CONSTRAINT
ALTER TABLE users
ADD CONSTRAINT users_email_unqiue UNIQUE(email);
ALTER TABLE users
DROP CONSTRAINT users_email_unqiue;

INSERT INTO users VALUES(1,'Shijo','shijo1920@gmail.com','pass');
INSERT INTO users(name,email,password) VALUES('srishti','srishti@gmail.com','srishti');
INSERT INTO users(name,email,password) VALUES('Rahul','rahul@gmail.com','password');
SELECT * FROM users;

CREATE TABLE IF NOT EXISTS student(
  student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  age INTEGER,
  CONSTRAINT student_age_check CHECK(age >= 8 and age <= 20)
);

INSERT INTO student(name,age) VALUES('Shijo',18);
INSERT INTO student(name,age) VALUES('Srishti',26); # check contsraint violation
INSERT INTO student(name,age) VALUES('Shijo',7);

CREATE TABLE IF NOT EXISTS tickets(
   ticket_id INTEGER PRIMARY KEY AUTO_INCREMENT,
   name VARCHAR(20) NOT NULL,
   travel_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO tickets(name,travel_date) VALUES('Shijo','21-02-24');
INSERT INTO tickets(name) VALUES('Srishti');
SELECT * FROM tickets;

-- FOREIGN KEY 
CREATE TABLE customers(
  c_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  c_name VARCHAR(30) NOT NULL,
  o_id INTEGER NOT NULL
);
DROP TABLE orders;
CREATE TABLE orders(
  o_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  order_item VARCHAR(30) NOT NULL,
  c_id INTEGER NOT NULL,
  CONSTRAINT customers_c_id_fk FOREIGN KEY (c_id) REFERENCES customers(c_id)
  ON DELETE CASCADE
);
INSERT INTO customers VALUES(1,'shijo',101);
INSERT INTO customers VALUES(2,'sam',102);

INSERT INTO orders VALUES(103,'sofa',1);
INSERT INTO orders VALUES(104,'sofa',2);
SELECT * FROM orders;
SELECT * FROM customers;
DELETE FROM cutomers
where c_id = 1;