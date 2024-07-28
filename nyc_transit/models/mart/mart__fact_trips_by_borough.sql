select 
    loc.borough as borough,
    COUNT(pulocationid) AS number_of_trips
from 
    {{ ref('mart__fact_all_taxi_trips') }} AS trips
join 
    {{ ref('mart__dim_locations') }} AS loc
on 
    loc.locationid = trips.pulocationid 
group by all

