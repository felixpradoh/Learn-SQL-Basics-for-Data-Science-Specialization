-- Exercise 1: ​We’ll be using the users table to answer the question “How many new users are added each day?“. 
--             Start by making sure you understand the columns in the table.  

SELECT
  id,
  parent_user_id,
  merged_at
FROM 
  dsv1069.users
ORDER BY
  parent_user_id ASC


-- Exercise 2: ​Without worrying about deleted user or merged users, count the number of users 
--             added each day. 

SELECT
  DATE(created_at) AS day,
  COUNT(*)         As users
FROM
  dsv1069.users
WHERE
  deleted_at IS NULL
AND
  id != parent_user_id
GROUP BY
  DATE(created_at)

-- Exercise 3: ​Consider the following query. Is this the right way to count merged or deleted 
--             users? If all of our users were deleted tomorrow what would the result look like? 

SELECT  
  DATE(created_at) AS day, 
  COUNT(*)         AS users 
FROM  
  dsv1069.users 
WHERE 
  deleted_at IS NULL 
AND  
  (id != parent_user_id OR parent_user_id IS NULL)
GROUP BY
  DATE(created_at)


-- Exercise 4: ​Count the number of users deleted each day. Then count the number of users 
--             removed due to merging in a similar way.  


SELECT  
  DATE(created_at) AS day, 
  COUNT(*)         AS deleted_users
FROM  
  dsv1069.users 
WHERE 
  deleted_at IS NOT NULL 
GROUP BY
  DATE(created_at)


-- Exercise 5: ​Use the pieces you’ve built as subtables and create a table that has a column for 
--             the date, the number of users created, the number of users deleted and the number of users 
--             merged that day.  

SELECT
  new.day,
  new.new_users_added,
  deleted.deleted_users,
  merged.merged_users
FROM
  (SELECT
    DATE(created_at) AS day,
    COUNT(*)         AS new_users_added
   FROM
    dsv1069.users
   GROUP BY
    DATE(created_at)
  ) new
LEFT JOIN
  (SELECT  
    DATE(deleted_at) AS day, 
    COUNT(*)         AS deleted_users
  FROM  
    dsv1069.users 
  WHERE 
    deleted_at IS NOT NULL 
  GROUP BY
    DATE(deleted_at)
  ) deleted
ON
   deleted.day = new.day
LEFT JOIN
  (SELECT
    DATE(merged_at) AS day,
    COUNT(*)        AS merged_users
  FROM
    dsv1069.users
  WHERE
    id != parent_user_id
  AND
    parent_user_id IS NOT NULL
  GROUP BY
    DATE(merged_at)
    ) merged
ON
 merged.day = deleted.day

-- Exercise 6: Refine your query from #5 to have informative column names and so that null 
-- columns return 0. 

SELECT
  new.day,
  new.new_users_added,
  COALESCE(deleted.deleted_users, 0) AS deleted_users,
  COALESCE(merged.merged_users, 0) AS merged_users,
  (new.new_users_added - COALESCE(deleted.deleted_users, 0) - COALESCE(merged.merged_users, 0)) AS net_added_users
FROM
  (SELECT
    DATE(created_at) AS day,
    COUNT(*)         AS new_users_added
   FROM
    dsv1069.users
   GROUP BY
    DATE(created_at)
  ) new
LEFT JOIN
  (SELECT  
    DATE(deleted_at) AS day, 
    COUNT(*)         AS deleted_users
  FROM  
    dsv1069.users 
  WHERE 
    deleted_at IS NOT NULL 
  GROUP BY
    DATE(deleted_at)
  ) deleted
ON
   deleted.day = new.day
LEFT JOIN
  (SELECT
    DATE(merged_at) AS day,
    COUNT(*)        AS merged_users
  FROM
    dsv1069.users
  WHERE
    id != parent_user_id
  AND
    parent_user_id IS NOT NULL
  GROUP BY
    DATE(merged_at)
    ) merged
ON
 merged.day = deleted.day


-- Exercise 7: What if there were days where no users were created, but some users were deleted or merged. 
--             Does the previous query still work? 

--             No, it doesn’t. Use the dates_rollup as a backbone for this 
--             query, so that we won’t miss any dates. 

