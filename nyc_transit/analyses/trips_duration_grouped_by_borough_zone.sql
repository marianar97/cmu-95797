--Calculate the number of trips and average duration by borough and zone

SELECT 
    loc.borough,
    loc.zone,
    COUNT(trips.pickup_datetime) AS num_trips,
    ROUND(AVG(trips.duration_min), 2) AS avg_duration_min
FROM 
    {{ ref('mart__fact_all_taxi_trips') }} trips
JOIN 
    {{ ref('mart__dim_locations') }} loc
ON 
    trips.pulocationid = loc.locationid
GROUP BY 
    loc.borough, 
    loc.zone;
