-- 1. Try Create Table AS
CREATE TABLE
    view_item_events_1
AS
SELECT
    event_id,
    event_time,
    user_id,
    platform,
    MAX(CASE WHEN parameter_name = 'item_id'
             THEN parameter_value
             ELSE NULL
        END)  AS item_id,
    MAX(CASE WHEN parameter_name = 'referrer'
             THEN parameter_value
             ELSE NULL
        END)  AS referrer,
FROM
    events
WHERE
    event_name = 'view_item'
GROUP BY
    event_id,
    event_time,
    user_id,
    platform
ORDER BY
    event_id;

-- 2. Check this new table
DESCRIBE view_item_events_1
SELECT * FROM view_item_events_1 LIMIT 10
DROP TABLE view_item_events_1;

-- 3. Edit the Query
SELECT
    event_id,
    TIMESTAMP(event_time) AS event_time,
    user_id,
    platform,
    MAX(CASE WHEN parameter_name = 'item_id'
             THEN parameter_value
             ELSE NULL
        END)  AS item_id,
    MAX(CASE WHEN parameter_name = 'referrer'
             THEN parameter_value
             ELSE NULL
        END)  AS referrer,
FROM
    events
WHERE
    event_name = 'view_item'
GROUP BY
    event_id,
    event_time,
    user_id,
    platform
ORDER BY
    event_id;

-- 4. Create the TABLE
CREATE TABLE 'view_item_events' (
    event_id     VARCHAR(32) NOT NULL PRIMARY KEY,
    event_time   VARCHAR(26),
    user_id      INT(10),
    platform     VARCHAR(10),
    item_id      INT(10),
    referrer     VARCHAR(17)
    );

-- 5. Insert Data - Table Exists

CREATE TABLE IF NOT EXISTS 'view_item_events' (
    event_id     VARCHAR(32) NOT NULL PRIMARY KEY,
    event_time   VARCHAR(26),
    user_id      INT(10),
    platform     VARCHAR(10),
    item_id      INT(10),
    referrer     VARCHAR(17)
    );

INSERT INTO
    'view_item_events'

SELECT
    event_id,
    TIMESTAMP(event_time) AS event_time,
    user_id,
    platform,
    MAX(CASE WHEN parameter_name = 'item_id'
             THEN parameter_value
             ELSE NULL
        END)  AS item_id,
    MAX(CASE WHEN parameter_name = 'referrer'
             THEN parameter_value
             ELSE NULL
        END)  AS referrer,
FROM
    events
WHERE
    event_name = 'view_item'
GROUP BY
    event_id,
    event_time,
    user_id,
    platform
ORDER BY
    event_id;



-- 6. Insert Data - Bad Columns
INSERT INTO
    'view_item_events'

SELECT
    /*event_id, */
    TIMESTAMP(event_time) AS event_time,
    user_id,
    platform,
    MAX(CASE WHEN parameter_name = 'item_id'
             THEN parameter_value
             ELSE NULL
        END)  AS item_id,
    MAX(CASE WHEN parameter_name = 'referrer'
             THEN parameter_value
             ELSE NULL
        END)  AS referrer,
FROM
    events
WHERE
    event_name = 'view_item'
GROUP BY
    event_id,
    event_time,
    user_id,
    platform
ORDER BY
    event_id;

-- 7. Insert Data Into Table - Good
REPLACE INTO
    'view_item_events'

SELECT
    event_id,
    TIMESTAMP(event_time) AS event_time,
    user_id,
    platform,
    MAX(CASE WHEN parameter_name = 'item_id'
             THEN parameter_value
             ELSE NULL
        END)  AS item_id,
    MAX(CASE WHEN parameter_name = 'referrer'
             THEN parameter_value
             ELSE NULL
        END)  AS referrer,
FROM
    events
WHERE
    event_name = 'view_item'
GROUP BY
    event_id,
    event_time,
    user_id,
    platform
ORDER BY
    event_id;