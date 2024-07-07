-- selecting data from a source called green_tripdata in the main schema. 
with source as (
    select * from {{ source('main', 'green_tripdata') }}
),

-- query then renames columns and specifies their data types in a temporary table called renamed
renamed as (
    select
        vendorID::int as vendor_id,
        lpep_pickup_datetime::timestamp as lpep_pickup_timestamp,
        lpep_dropoff_datetime::timestamp as lpep_dropoff_timestamp,
        store_and_fwd_flag:: char as store_and_fwd_flag,
        RatecodeID::int as ratecode_id,
        PULocationID::bigint as pu_location_id,
        DOLocationID::bigint as do_location_id,
        passenger_count::int as passanger_count,
        trip_distance::double as trip_distance,
        fare_amount::double as fare_amount,
        extra::double as extra,
        mta_tax::double as mta_tax,
        tip_amount::double as tip_amount,
        tolls_amount::double as tolls_amount,
        ehail_fee::double as ehail_fee,
        improvement_surcharge::double as improvement_surcharge,
        total_amount::double as total_amount,
        payment_type::int as payment_type,
        trip_type::int as trip_type,
        congestion_surcharge::double as congestion_surcharge,
        filename
    from source
)

-- selecting all columns from the renamed table
select * from renamed

