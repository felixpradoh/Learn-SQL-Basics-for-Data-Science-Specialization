-- Question 1

CREATE TABLE IF NOT EXISTS fireIncidents
USING csv
OPTIONS (
  header "true",
  path "/mnt/davis/fire-incidents/fire-incidents-2016.csv",
  inferSchema "true"
    )
-- What is the first value for "Incident Number"?
-- Answer: 16000003

-------------------------------------------------------------------------------

-- Question 2

SELECT *
FROM fireIncidents
LIMIT 10

-- What is the first value for "Incident Number" on April 4th, 2016?
-- Answer: 16037478

-------------------------------------------------------------------------------

-- Question 3

SELECT *
FROM fireIncidents
WHERE `Incident Date` = '04/04/2016'
LIMIT 10

-- Is the first fire call in this table on Brooke or Conor's birthday?  Conor's birthday is 4/4 and Brooke's is 9/27 (in MM/DD format).

-- [ ] Brooke's birthday
-- [x] Conor's birthday

-------------------------------------------------------------------------------

-- Question 4

SELECT *
FROM fireIncidents
WHERE `Incident Date` = '04/04/2016'
  OR `Incident Date` = '09/27/2016'
ORDER BY `Incident Date` ASC

-- What is the "Station Area" for the first fire call in this table?  Note that this table is a subset of the dataset.
-- Answer: 29

-------------------------------------------------------------------------------

-- Question 5

SELECT *
FROM fireIncidents
WHERE `Station Area` > 20
AND (`Incident Date` = '2016-04-04'
OR `Incident Date` = '2016-27-09')

-- How many incidents were on Conor's birthday in 2016?
-- Answer: 80

-------------------------------------------------------------------------------

-- Question 6

SELECT `Ignition Cause`,
  COUNT(`Ignition Cause`) as counts
FROM fireIncidents
GROUP BY `Ignition Cause`

-- How many fire calls had an "Ignition Cause" of "4 act of nature"?
-- Answer: 5

-------------------------------------------------------------------------------

-- Question 7

SELECT `Ignition Cause`,
  COUNT(`Ignition Cause`) as counts
FROM fireIncidents
GROUP BY `Ignition Cause`
ORDER BY counts ASC

-- What is the most common "Ignition Cause"? 
-- Hint: Put the entire string.
-- Answer: 2 unintentional
-------------------------------------------------------------------------------

-- Question 8

CREATE TABLE IF NOT EXISTS fireCalls
USING csv
OPTIONS (
  header "true",
  path "/mnt/davis/fire-calls/fire-calls-truncated-comma.csv",
  inferSchema "true"
    )

SELECT *
FROM fireIncidents
JOIN fireCalls
ON fireIncidents.Battalion = fireCalls.Battalion

SELECT COUNT(*)
FROM(
  SELECT *
  FROM fireIncidents
  JOIN fireCalls
  ON fireIncidents.Battalion = fireCalls.Battalion

-- What is the total incidents from the two joined tables?
-- Answer: 847094402


-------------------------------------------------------------------------------