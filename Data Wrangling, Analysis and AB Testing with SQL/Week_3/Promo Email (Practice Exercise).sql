-- Exercise 1: Create the right subtable for recently viewed events using the view_item_events table.

SELECT *
FROM dsv1069.view_item_events

-- Exercise 2: Check your joins. Join your tables together recent_views, users, items

SELECT *
FROM
    (
    SELECT user_id,
           item_id,
           event_time,
           ROW_NUMBER( ) OVER (PARTITION BY user_id ORDER BY event_time DESC) AS view_number
    FROM
        dsv1069.view_item_events
    ) AS recent_views

JOIN dsv1069.users
    ON   users.id = recent_views.user_id
JOIN dsv1069.items
    ON   items.id = recent_views.item_id

-- Exercise 3: Clean up your columns. The goal of all this is to return all of the information we’ll
--             need to send users an email about the item they viewed more recently. Clean up this query
--             outline from the outline in EX2 and pull only the columns you need. Make sure they are named
--             appropriately so that another human can read and understand their contents.

-- Exercise 4: Consider any edge cases. If we sent an email to everyone in the results of this
--             query, what would we want to filter out. Add in any extra filtering that you think would make this
--             email better. For example should we include deleted users? Should we send this email to users
--             who already ordered the item they viewed most recently?