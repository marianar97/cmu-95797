-- Write a query to compare an individual fare to the zone, borough and overall
-- average fare using the fare_amount in yellow taxi trip data.

SELECT 
    t.pulocationid,
    l.zone,
    l.borough,
    t.fare_amount AS individual_fare,
    ROUND(AVG(t.fare_amount) OVER (PARTITION BY l.zone) ,2) AS avg_zone_fare,
    ROUND(AVG(t.fare_amount) OVER (PARTITION BY l.borough) ,2) AS avg_borough_fare,
    ROUND(AVG(t.fare_amount) OVER () ,2) AS avg_overall_fare
FROM 
    {{ ref('stg__yellow_tripdata') }} t
JOIN 
    {{ ref('mart__dim_locations') }} l
ON 
    t.pulocationid = l.locationid;
