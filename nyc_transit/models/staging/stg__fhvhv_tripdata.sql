-- selecting data from a source called fhvhv_tripdata in the main schema. 
with source as (
    select * from {{ source('main', 'fhvhv_tripdata') }}
),

-- query then renames columns and specifies their data types in a temporary table called renamed
-- coalesce return the first non-null value in a list. We use it to merge two columns together
-- originating_base_num and dispatching_base_num are similar, used coscale to keep the first out of the two columns
renamed as (
    select
        hvfhs_license_num,
        coalesce(dispatching_base_num,originating_base_num)::varchar as dispatching_base_num,
        request_timestamp::timestamp as request_timestamp,
        on_scene_timestamp::timestamp as on_scene_timestamp,
        pickup_timestamp::timestamp as pickup_timestamp,
        dropoff_timestamp::timestamp as dropoff_timestamp,
        PULocationID::int as PULocationID,
        DOLocationID::int as DOLocationID,
        trip_miles::double as trip_miles,
        trip_time::int as trip_time,
        base_passenger_fare::double as base_passenger_fare,
        tolls::double as tolls,
        bcf::double as bcf,
        sales_tax::double as sales_tax,
        congestion_surcharge::double as congestion_surcharge,
        airport_fee::double as airport_fee,
        tips::double as tips,
        driver_pay::double as driver_pay,
        shared_request_flag::char as shared_request_flag, 
        shared_match_flag::char as shared_match_flag, 
        -- access_a_ride_flag remove as it is N or ' ',
        wav_request_flag::char as wav_request_flag,
        wav_match_flag::char as wav_match_flag, 
        filename
    from source
)

-- selecting all columns from the renamed table
select * from renamed

