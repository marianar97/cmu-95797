-- selecting data from a source called fhv_tripdata in the main schema. 
with source as (
    select * from {{ source('main', 'fhv_tripdata') }}
),

-- query then renames columns and specifies their data types in a temporary table called renamed. Dropped SR_flag as it was all nulls
renamed as (
    select
        dispatching_base_num,
        pickup_timestamp::timestamp as pickup_timestamp,
        dropOff_timestamp::timestamp as dropoff_timestamp,
        PUlocationID::bigint as pu_location_id, -- convert to bigint as these are numbers representing distinct zones
        DOlocationID::bigint as do_location_id, -- convert to bigint as these are numbers representing distinct zones
        Affiliated_base_number::varchar affiliated_base_number,
        filename
    from source
)

-- selecting all columns from the renamed table
select * from renamed

