-- Find the average time between taxi pick ups per zone
WITH trip_differences AS (
    SELECT
        l.zone,
        t.pickup_datetime,
        LEAD(t.pickup_datetime) OVER (PARTITION BY l.zone ORDER BY t.pickup_datetime) AS next_pickup_datetime
    FROM
        {{ ref('mart__fact_all_trips') }}
    JOIN
        {{ ref('mart__dim_locations') }} l ON t.pulocationid = l.locationid
) -- Use lead or lag to find the next trip per zone for each record

-- calculate the average time between pick ups per zone
SELECT
    zone,
    AVG(EXTRACT(EPOCH FROM (next_pickup_datetime - pickup_datetime)) / 60.0) AS avg_time_between_pickups_minutes
FROM
    trip_differences
WHERE
    next_pickup_datetime IS NOT NULL
GROUP BY
    zone
ORDER BY
    zone;