-- Exercise 0: ​Count how many users we have 

SELECT COUNT(*)
FROM dsv1069.users
LIMIT 100


-- Exercise 1: ​Find out how many users have ever ordered 

SELECT
    COUNT(DISTINCT user_id)  AS users_with_orders
FROM
    dsv1069.orders

-- Exercise 2: Goal find how many users have reordered the same item 

SELECT
    COUNT(DISTINCT user_id) AS users_who_reordered
FROM
    (
    SELECT 
        user_id,
        item_id,
        COUNT(DISTINCT line_item_id) AS times_user_ordered
    FROM dsv1069.orders
    GROUP BY
        user_id,
        item_id
    ) AS user_level_orders
WHERE times_user_ordered > 1


-- Exercise 3: Do users even order more than once? 

SELECT
    COUNT(DISTINCT user_id)
FROM
    (
    SELECT 
        user_id,
        COUNT(DISTINCT invoice_id) AS order_count
    FROM dsv1069.orders
    GROUP BY user_id
    ) AS user_level
WHERE order_count > 1


-- Exercise 4: Orders per item 

SELECT
    item_id,
    COUNT(line_item_id) AS times_ordered
FROM dsv1069.orders
GROUP BY
    item_id

-- Exercise 5: Orders per category 

SELECT
    item_category,
    COUNT(line_item_id) AS times_ordered
FROM dsv1069.orders
GROUP BY
    item_category

-- Exercise 6: Goal: Do user order multiple things from the same category? 
SELECT
    items_category,
    AVG(times_category_ordered) AS avg_times_category_ordered
FROM
    (
    SELECT
        user_id,
        item_category,
        COUNT(DISTINCT line_item_id) AS times_category_ordered
    FROM 
        dsv1069.orders
    GROUP BY
        user_id,
        item_category,
    ) AS user_level
GROUP BY
    item_category
    
-- Exercise 7: Goal: Find the average time between orders. Decide if this analysis is necessary 

SELECT
    first_orders.user_id,
    DATE(first_orders.paid_at)                               AS first_order_date,
    DATE(second_orders.paid_at)                              AS secon_order_date,
    DATE(second_orders.paid_at) - DATE(first_orders.paid_at) AS date_diff
FROM
    (
    SELECT
        user_id,
        invoice_id,
        paid_at,
        DENSE_RANK( ) OVER (PARTITION BY user_id ORDER BY paid_at ASC)
            AS order_num
    FROM
        dsv1069.orders
    ) AS first_orders
JOIN
    (
    SELECT
        user_id,
        invoice_id,
        paid_at,
        DENSE_RANK( ) OVER (PARTITION BY user_id ORDER BY paid_at ASC)
            AS order_num
    FROM
        dsv1069.orders
    ) AS second_orders
ON 
    first_orders.user_id = second_orders.user_id
WHERE
    first_orders.order_num = 1
AND
    second_orders.order_num = 2