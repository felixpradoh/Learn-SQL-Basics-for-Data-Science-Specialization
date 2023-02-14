-- Question 1

SELECT 
    COUNT(*) AS counts
FROM 
    fireCalls
-- How many fire calls are in our table?
-- Enter answer here: 240613

-- Question 2
-- How large is our fireCalls dataset in memory? Input just the numeric value (e.g. 51.2)

CACHE TABLE fireCalls

-- View-> Spark UI -> Storage

-- Enter answer here: 59.3

-- Question 3

SELECT `Unit Type`,
        COUNT(`Unit Type`) AS unit_type_count
FROM fireCalls
GROUP BY `Unit Type`
ORDER BY unit_type_count DESC



-- Which Unit Type is most common?

-- [x] ENGINE
-- [ ] MEDIC
-- [ ] TRUCK
-- [ ] RESCUE CAPTAIN


-- Question 4

-- What type of transformation, wide or narrow, did the GROUP BY and ORDER BY queries result in?

-- [x] Wide
-- [ ] Narrow


-- Question 5

-- Looking at the query below, how many tasks are in the last stage of the last job?

-- Enter answer here: 1
