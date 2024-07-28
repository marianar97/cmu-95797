--Write a query to determine if days immediately preceding precipitation or snow 
-- had more bike trips on average than the days with precipitation or snow.

WITH days_with_precip_snow AS (
    SELECT
        date
    FROM
        {{ref('stg__central_park_weather')}}
    WHERE
        prcp > 0 OR snow > 0
), -- Identifies days with precipitation (prcp > 0) or snow (snow > 0) from the stg__central_park_weather table.

preceding_days AS (
    SELECT
        DATE_ADD(date, - INTERVAL 1 DAY) AS date
    FROM
        days_with_precip_snow
), -- Identifies the days immediately preceding the days with precipitation or snow 

bike_trips_per_day AS (
    SELECT
        CAST(started_at_ts AS DATE) AS trip_date,
        COUNT(*) AS num_trips
    FROM
        {{ ref('mart__fact_all_bike_trips') }}
    GROUP BY
        CAST(started_at_ts AS DATE)
), -- Aggregates the number of bike trips per day from the mart__fact_all_bike_trips table 

avg_trips_precip_snow_days AS (
    SELECT
        AVG(bt.num_trips) AS avg_num_trips
    FROM
        bike_trips_per_day bt
    JOIN
        days_with_precip_snow dps
    ON
        bt.trip_date = dps.date
), -- Calculates the average number of bike trips on days with precipitation or snow

avg_trips_preceding_days AS (
    SELECT
        AVG(bt.num_trips) AS avg_num_trips
    FROM
        bike_trips_per_day bt
    JOIN
        preceding_days pd
    ON
        bt.trip_date = pd.date
) -- Calculates the average number of bike trips on the preceding days


SELECT
    'Days with Precip/Snow' AS period,
    avg_num_trips
FROM
    avg_trips_precip_snow_days

UNION ALL

SELECT
    'Preceding Days' AS period,
    avg_num_trips
FROM
    avg_trips_preceding_days;

-- There are more bike trips on the preceeding days to snow or precipitation