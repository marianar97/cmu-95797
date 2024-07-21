WITH trips_with_boroughs AS (
    SELECT
        t.type,
        t.pickup_datetime,
        t.dropoff_datetime,
        t.duration_min,
        t.duration_sec,
        t.pulocationid,
        t.dolocationid,
        p.borough AS pu_borough,
        d.borough AS do_borough,
        WEEKDAY(t.pickup_datetime) AS weekday
    FROM
        {{ ref('mart__fact_all_taxi_trips') }} t
    JOIN
        {{ ref('mart__dim_locations') }} p ON t.pulocationid = p.locationid --began location
    JOIN
        {{ ref('mart__dim_locations') }}d ON t.dolocationid = d.locationid -- end location
)
SELECT
    weekday,
    COUNT(*) AS total_trips,
    COUNT(CASE WHEN pu_borough <> do_borough THEN 1 END) AS trips_different_boroughs, -- if began borough <> end borough count as 1 else 0
    ROUND(
        COUNT(CASE WHEN pu_borough <> do_borough THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS percentage_different_boroughs
FROM
    trips_with_boroughs
GROUP BY
    weekday
ORDER BY
    weekday;
