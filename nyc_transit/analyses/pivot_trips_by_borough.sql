-- pivot the results by borough.

PIVOT {{ ref('mart__fact_trips_by_borough')}}
ON borough
USING SUM(number_of_trips);