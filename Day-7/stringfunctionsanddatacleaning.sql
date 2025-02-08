USE sql_cx_live;
SELECT * FROM movies;

-- Wildcards
SELECT * FROM movies
WHERE genre LIKE '_____';
SELECT * FROM movies
WHERE genre LIKE 'D____';
SELECT * FROM movies
WHERE name LIKE '%man%';

SELECT name,UPPER(name),LOWER(name) FROM movies;

SELECT CONCAT(name,' | ',director) FROM movies; # string concatenation
SELECT CONCAT_ws("@",name,director) FROM movies; #concat with seperator

# SUBSTR
SELECT name, SUBSTR(name,1,5) FROM movies;
SELECT name, SUBSTR(name,5,5) FROM movies;
SELECT name, SUBSTR(name,-5,2) FROM movies;

# REPLACE
SELECT REPLACE("Hello world", "world" , 'india');
SELECT name,REPLACE(name,"man","woman") FROM movies;

# REVERSE
SELECT REVERSE("Hello");
#check palindrome
SELECT name FROM movies
WHERE name = REVERSE(name);

#LENGTH AND CHAR_LENGTH
SELECT name,LENGTH(name),CHAR_LENGTH(name) FROM movies;

# thier difference is length calculate the byte and char_length calculates the characters
SELECT name,LENGTH(name),CHAR_LENGTH(name) FROM movies
WHERE LENGTH(name) <> CHAR_LENGTH(name);

SELECT INSERT("Hello World",7,0,'dhoni'); 
SELECT INSERT("Hello World",7,4,'dhoni'); 

SELECT name, left(name,2),right(name,3) FROM movies;

SELECT REPEAT(name,3) FROM movies;

SELECT TRIM("             Hello      ");
SELECT TRIM(LEADING '>' FROM ">>>>>>>>>>Hello>>>>>");
SELECT TRIM(TRAILING '>' FROM ">>>>>>>>>>Hello>>>>>");


SELECT LENGTH(LTRIM("   hELLPOO      "));

-- SUBSTRING_INDEX
SELECT "www.campusx.com", SUBSTRING_INDEX("www.campusx.com",".",-2);
SELECT "www.campusx.com", SUBSTRING_INDEX("www.campusx.com",".",2);

SELECT STRCMP("Delhi","Mumbai");
SELECT STRCMP("Mumbai","Delhi");
SELECT STRCMP("Delhi","DELHI");

SELECT LOCATE("w", 'HELLO world');
# RPAD AND LAPAD
SELECT LPAD("8888888888",13,'+91');
SELECT RPAD("8888888888",13,'+91');

CREATE DATABASE laptop;
USE laptop;
SELECT * FROM laptop;

SELECT COUNT(*) FROM laptop;


#creating backup of table
CREATE TABLE laptop_backup LIKE laptop;

INSERT INTO laptop_backup
select * FROM laptop;
SELECT * FROM laptop_backup;

SELECT * FROM information_schema.Tables
WHERE TABLE_SCHEMA = 'laptop'
AND TABLE_NAME = 'laptop';

# memory occupied in kb
SELECT DATA_LENGTH/1024 FROM information_schema.Tables
WHERE TABLE_SCHEMA = 'laptop'
AND TABLE_NAME = 'laptop';

# if every column value is null

DELETE FROM laptop WHERE `index` IN (SELECT `index` FROM laptop
WHERE Company IS NULL AND TypeName IS NULL AND Inches IS NULL AND ScreenResolution IS NULL AND
Cpu IS NULL AND Ram IS NULL AND Memory IS NULL AND Gpu IS NULL AND OpSys IS NULL AND Weight IS NULL AND Price IS NULL);

SELECT * from laptop;
# change gb in ram to only value which will save space

