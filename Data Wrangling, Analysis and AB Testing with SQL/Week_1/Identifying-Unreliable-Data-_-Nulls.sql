-- Exercise 1: ​Using any methods you like determine if you can you trust this events table. 

SELECT
  DATE(event_time) AS date,
  COUNT(*)         AS rows
FROM
  dsv1069.events_201701
GROUP BY
  DATE(event_time)

-- Exercise 2: Using any methods you like, determine if you can you trust this events table. (HINT: When did we start recording events on mobile) 

SELECT
  DATE(event_time) AS date,
  platform,
  COUNT(*)
FROM
  dsv1069.events_ex2
GROUP BY
  DATE(event_time),
  event_name,
  platform

-- Exercise 3: ​Imagine that you need to count item views by day. You found this table item_views_by_category_temp - should you use it to answer your questiuon? 

SELECT
  COUNT(DISTINCT event_id) AS event_count
FROM
  dsv1069.events
WHERE
 event_time = 'view_item'

-- Exercise 4: ​Using any methods you like, decide if this table is ready to be used as a source of truth. 

SELECT 
  DATE(event_time) AS date, 
  COUNT(*) AS row_count
FROM 
  dsv1069.raw_events 
GROUP BY
  DATE(event_time)

-- Exercise 5: ​Is this the right way to join orders to users? Is this the right way  this join.  

SELECT
  COUNT(*)
FROM
  dsv1069.orders
JOIN 
  dsv1069.users
ON orders.user_id = COALESCE(users.parent_user_id, users.id)