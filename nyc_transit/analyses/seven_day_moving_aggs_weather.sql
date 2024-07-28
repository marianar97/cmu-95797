-- calculates the 7 day moving min, max, avg, sum for precipitation
-- and snow for every day in the weather data, defining the window only once.
-- The 7 day window centers on the day in question (for each date, the 3 days
-- before, the date & 3 days after).

SELECT
    date,
    prcp,
    snow,
    ROUND(MIN(prcp) OVER moving_window, 2) AS moving_min_prcp,
    ROUND(MAX(prcp) OVER moving_window, 2) AS moving_max_prcp,
    ROUND(AVG(prcp) OVER moving_window, 2) AS moving_avg_prcp,
    ROUND(SUM(prcp) OVER moving_window, 2) AS moving_sum_prcp,
    ROUND(MIN(snow) OVER moving_window, 2) AS moving_min_snow,
    ROUND(MAX(snow) OVER moving_window, 2) AS moving_max_snow,
    ROUND(AVG(snow) OVER moving_window, 2) AS moving_avg_snow,
    ROUND(SUM(snow) OVER moving_window, 2) AS moving_sum_snow
FROM 
    {{ref('stg__central_park_weather')}}
WINDOW moving_window AS (
    ORDER BY date ASC
    RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND
                  INTERVAL 3 DAYS FOLLOWING
    )
ORDER BY 
    date;
