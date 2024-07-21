SELECT COUNT(*) AS taxi_trips_ending_at_airport
FROM {{ ref('mart__fact_all_taxi_trips') }} as f 
INNER JOIN {{ ref('mart__dim_locations') }} as d 
    ON f.dolocationid = d.locationID
WHERE service_zone = 'Airports' OR service_zone = 'EWR';

