-- Uses Window functions with QUALIFY and ROW_NUMBER to remove
-- duplicate rows. Prefer rows with a later time stamp. 
-- The definition of a unique does not take into account timestamp

SELECT
    insert_timestamp,
    event_id,
    event_type,
    user_id,
    event_timestamp
FROM 
    events
QUALIFY
    ROW_NUMBER() OVER (PARTITION BY event_id, event_type, user_id ORDER BY insert_timestamp DESC) = 1;

