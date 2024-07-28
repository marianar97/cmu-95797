-- Use Window functions with QUALIFY and ROW_NUMBER to remove
-- duplicate rows. Prefer rows with a later time stamp

SELECT
    insert_timestamp,
    event_id,
    event_type,
    user_id,
    event_timestamp,
FROM 
    events
QUALIFY
    ROW_NUMBER() OVER (PARTITION BY insert_timestamp ORDER BY insert_timestamp)  = 1;
