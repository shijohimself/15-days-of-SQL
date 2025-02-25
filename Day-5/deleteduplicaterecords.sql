SELECT a.*, a.ctid FROM artists a;

-- Delete duplicate records using ctid but problems may arise during duplicate records
DELETE FROM artists
WHERE ctid IN (
	           SELECT MAX(ctid)
               FROM artists
               GROUP BY first_name,last_name
               HAVING COUNT(*) > 1);

SELECT * FROM artists;

-- Another solution which works fine in all the case and with multiple duplicate records
INSERT INTO artists VALUES(5,'Kate','Smith'); 
INSERT INTO artists VALUES(6,'Natali','Wein');
SELECT * FROM artists;

DELETE FROM artists
WHERE ctid NOT IN (SELECT MIN(ctid) FROM artists
                   GROUP BY first_name,last_name);

-- Imagine a table with 1 million records and 10K duplicate records. How to delete faster?
INSERT INTO artists VALUES(2,'Kate','Smith'); 
INSERT INTO artists VALUES(3,'Natali','Wein');

SELECT * FROM artists;
SELECT DISTINCT * FROM artists;

CREATE TABLE artists_bkp as 
SELECT DISTINCT * FROM artists;

SELECT * FROM artists_bkp;
TRUNCATE TABLE artists;

INSERT INTO artists
SELECT * FROM artists_bkp;

DROP TABLE artists_bkp;

-- Option 2 -- not recommended in production or dev env
SELECT * FROM artists;
-- backup table
CREATE TABLE artists_bkp as 
SELECT DISTINCT * FROM artists;

-- drop actual table
DROP TABLE artists;
-- then rename the backup table
ALTER TABLE artists_bkp RENAME TO artists;