-- Question 1

DROP TABLE IF EXISTS newTable;

CREATE EXTERNAL TABLE newTable 
( `Address` STRING,
  `City` STRING,
  `Battalion` STRING,
  `Box` STRING
)
STORED AS parquet
LOCATION '/tmp/newTableLoc';

-- What type of table is "newTable"?
-- [ ] MANAGED
-- [x] EXTERNAL

-------------------------------------------------------------------------------

-- Question 2

INSERT INTO newTable
SELECT Address, City, Battalion, Box
FROM fireCallsJSON
WHERE `Final Priority` = 3;

SELECT COUNT(*)
FROM newTable;

-- How many rows are in "newTable"?
-- Enter answer here: 191039

-------------------------------------------------------------------------------

-- Question 3

SELECT *
FROM newTable
ORDER BY Battalion ASC;

CREATE TABLE IF NOT EXISTS newTablePartitioned
AS
SELECT /*+ REPARTITION(256) */ *
FROM newTable;

DESCRIBE EXTENDED newTablePartitioned;

-- What is the "Battalion" of the first entry in the sorted table?
-- Enter answer here: B01

-------------------------------------------------------------------------------

-- Question 4

SELECT *
FROM newTablePartitioned
ORDER BY Battalion

-- Was this query faster or slower on the table with increased partitions?
-- [x] Slower
-- [ ] Faster

-------------------------------------------------------------------------------

-- Question 5

DROP TABLE newTable;

-- Does the data stored within the table still exist at the original location ('dbfs:/tmp/newTableLoc') after you dropped the table?
-- [x] Yes
-- [ ] No

-------------------------------------------------------------------------------