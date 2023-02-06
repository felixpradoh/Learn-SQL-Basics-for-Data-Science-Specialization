-- 0. Liquid Tags - (Variables)
{% assign ds = '2018-01-01' %}
SELECT
    id
    -- '{{ds}}' AS variable_column
FROM users
WHERE
    created_at <= '{{ds}}'

------------------------------------------------------------

-- 1. Create Query
{% assign ds = '2018-01-01' %}

SELECT
    users.id                                               AS user_id,
    IF(users.created_at  = '{{ds}}', 1, 0)                 AS created_today,
    IF(users.deleted_at <= '{{ds}}', 1, 0)                 AS is_deleted,
    IF(users.deleted_at  = '{{ds}}', 1, 0)                 AS is_deleted_today,
    IF(users_with_orders.user_id IS NOT NULL, 1, 0)        AS has_ever_ordered,
    IF(users_with_orders_today.user_id IS NOT NULL, 1, 0)  AS ordered_today,
    '{{ds}}'                                               AS ds
FROM
    users
LEFT OUTER JOIN
    (
    SELECT
        DISTINCT user_id
    FROM
        orders
    WHERE
        created_at <= '{{ds}}'
    ) AS users_with_orders
ON 
    users_with_orders.user_id = users.id

LEFT OUTER JOIN
    (
    SELECT
        DISTINCT user_id
    FROM
        orders
    WHERE
        created_at = '{{ds}}'
    ) AS users_with_orders_today
ON 
    users_with_orders_today.user_id = users.id
WHERE
    users.created_at <= '{{ds}}'
------------------------------------------------------------

-- 2. Create Table
CREATE TABLE IF NOT EXISTS user_info
(
    user_id           INT(10) NOT NULL,
    created_today     INT(1)  NOT NULL,
    is_deleted        INT(1)  NOT NULL,
    is_deleted_today  INT(1)  NOT NULL,
    has_ever_ordered  INT(1)  NOT NULL,
    ordered_today     INT(1)  NOT NULL,
    ds                DATE    NOT NULL,
);

DESCRIBE user_info;
------------------------------------------------------------

-- 3. Insert Into Table
{% assign ds = '2018-01-01' %}
INSERT INTO
    user_info
SELECT
    users.id                                               AS user_id,
    IF(users.created_at  = '{{ds}}', 1, 0)                 AS created_today,
    IF(users.deleted_at <= '{{ds}}', 1, 0)                 AS is_deleted,
    IF(users.deleted_at  = '{{ds}}', 1, 0)                 AS is_deleted_today,
    IF(users_with_orders.user_id IS NOT NULL, 1, 0)        AS has_ever_ordered,
    IF(users_with_orders_today.user_id IS NOT NULL, 1, 0)  AS ordered_today,
    '{{ds}}'                                               AS ds
FROM
    users
LEFT OUTER JOIN
    (
    SELECT
        DISTINCT user_id
    FROM
        orders
    WHERE
        created_at <= '{{ds}}'
    ) AS users_with_orders
ON 
    users_with_orders.user_id = users.id

LEFT OUTER JOIN
    (
    SELECT
        DISTINCT user_id
    FROM
        orders
    WHERE
        created_at = '{{ds}}'
    ) AS users_with_orders_today
ON 
    users_with_orders_today.user_id = users.id
WHERE
    users.created_at <= '{{ds}}'
------------------------------------------------------------

-- Data Engineering Questions:
-- How do you check that the table contains what you expect?
-- How do insert by day?
-- How to backfill the data?