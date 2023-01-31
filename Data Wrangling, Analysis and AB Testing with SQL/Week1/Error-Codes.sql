-- Exercise 1:
-- Goal: Here we use users table to pull a list of user email addresses. Edit the query to pull email addresses, but only for non-deleted users.

SELECT email_address
FROM dsv1069.users
WHERE deleted_at IS NULL;

-- Exercise 2:
-- Goal: Use the items table to count the number of items for sale in each category
SELECT email_address
FROM dsv1069.users
WHERe deleted_at IS NULL;

-- Exercise 3:
-- Goal: Select all of the columns from the result when you JOIN the users table to the orders table
SELECT *
FROM dsv1069.users AS U
JOIN dsv1069.orders AS O 
ON U.id = O.user_id

-- Exercise 4:
-- Goal: Check out the query below. This is not the right way to count the number of viewed_item events.
--       Determine what is wrong and correct the error.
SELECT COUNT(DISTINCT event_id) AS events 
FROM dsv1069.events 
WHERE event_name = 'view_item'

-- Exercise 5:
-- Goal: Compute the number of items in the items table which have been ordered. The query below runs, but it isn’t right. 
--       Determine what is wrong and correct the error or start from scratch
SELECT COUNT(DISTINCT O.item_id) AS item_count
FROM dsv1069.orders AS O
JOIN dsv1069.items AS I
ON O.item_id = I.id

-- Exercise 6:
-- Goal: For each user figure out IF a user has ordered something, and when their first purchase was.
--       The query below doesn’t return info for any of the users who haven’t ordered anything.
SELECT
  U.id AS user_id,
  MIN(O.paid_at) AS min_paid_at
FROM
  dsv1069.orders AS O
RIGHT JOIN
  dsv1069.users AS U
ON
  O.user_id = U.id
GROUP BY
  U.id

-- Exercise 7:
-- Goal: Figure out what percent of users have ever viewed the user profile page, but this query isn’t right. 
--       Check to make sure the number of users adds up, and if not, fix the query.

SELECT
  (CASE WHEN first_view IS NULL then False
        ELSE True END) AS has_viewed_profile_page,
  COUNT(user_id) as users
      -- Here we create the first_profile_views table --
  FROM
    (SELECT 
      users.id AS user_id,
      MIN(event_time) AS first_view
    FROM
      dsv1069.users
      LEFT JOIN
        dsv1069.events
      ON
        events.user_id = users.id
      WHERE 
        event_name='view_user_profile'
      GROUP BY
        users.id)
    first_profile_view
  GROUP BY
    (CASE WHEN first_view IS NULL THEN False
          ELSE True END)
        