-- selecting data from a source called yellow_tripdata in the main schema. 
with source as (
    select * from {{ source('main', 'yellow_tripdata') }}
),

-- query then renames columns and specifies their data types in a temporary table called renamed
renamed as (
    select
        VendorID::int as vendor_id,
        tpep_pickup_datetime::timestamp as tpep_pickup_timestamp,
        tpep_dropoff_datetime::timestamp as tpep_dropoff_timestamp,
        passenger_count::int as passanger_count,
        trip_distance::double as trip_distance,
        RatecodeID::int as ratecode_id, 
        store_and_fwd_flag::char as store_and_fwd_flag,
        PULocationID::bigint as pu_location_id,
        DOLocationID::bigint as do_location_id,
        payment_type::int as payment_type,
        fare_amount::double as fare_amount, 
        extra::double as extra,
        mta_tax::double as mta_tax,
        tip_amount::double as tip_amount,
        tolls_amount::double as tolls_amount,
        improvement_surcharge::double as improvement_surcharge,
        total_amount::double as total_amount,
        congestion_surcharge::double as congestion_surcharge,
        airport_fee::double as airport_fee,
        filename
    from source
)

-- selecting all columns from the renamed table
select * from renamed