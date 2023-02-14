CREATE OR REPLACE TEMPORARY VIEW fireCallsParquet
USING parquet
OPTIONS (
  path "/mnt/davis/fire-calls/fire-calls-clean.parquet/"
);

CREATE DATABASE IF NOT EXISTS Databricks;
USE Databricks;
DROP TABLE IF EXISTS fireCallsPartitioned;

CREATE TABLE fireCallsPartitioned
USING DELTA
PARTITIONED BY (Priority)
AS
  SELECT * FROM fireCallsParquet;


-- Question 1
%fs ls dbfs:/user/hive/warehouse/databricks.db/firecallspartitioned

-- How many folders were created? Enter the number of records you see from the output below (include the _delta_log in your count)
-- Enter answer here : 9

-------------------------------------------------------------------------------

-- Question 2
-- Delete all the records where City is null. How many records are left in the delta table?

DELETE FROM fireCallsPartitioned 
WHERE City IS NULL;

SELECT COUNT(*)
FROM fireCallsPartitioned;

-- Enter answer here : 416869

-------------------------------------------------------------------------------

-- Question 3
-- After you deleted all records where the City is null, how many files were removed? Hint: Look at operationsMetrics in the transaction log using the DESCRIBE HISTORY command.

DESCRIBE HISTORY fireCallsPartitioned

-- "Go to operationMetrics and check "numRemovedFiles": "22"
-- Enter answer here : 22

-------------------------------------------------------------------------------

-- Question 4
-- There are quite a few missing Call_Type_Group values. Use the UPDATE command to replace any null values with Non Life-threatening.

UPDATE fireCallsPartitioned 
SET Call_Type_Group = 'Non Life-threatening'
WHERE Call_Type_Group IS NULL;

SELECT Call_Type_Group,
       COUNT(*) as Counts
FROM fireCallsPartitioned
GROUP BY
  Call_Type_Group;

-- After you replace the null values, how many Non Life-threatening call types are there?
-- Enter answer here : 302506

-------------------------------------------------------------------------------

-- Question 5
-- Travel back in time to the earliest version of the Delta table (version 0). How many records were there?

SELECT COUNT(*)
FROM fireCallsPartitioned
  VERSION AS OF 0

-- Enter answer here : 417419

-------------------------------------------------------------------------------
