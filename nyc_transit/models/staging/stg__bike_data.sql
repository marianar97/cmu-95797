-- selecting data from a source called bike_data in the main schema. 
with source as (
    select * from {{ source('main', 'bike_data') }}
),

-- query then renames columns and specifies their data types in a temporary table called renamed
-- coalesce return the first non-null value in a list. We use it to merge two columns together
renamed as (
    select
        tripduration::int as tripduration,
        coalesce(starttime, started_at)::timestamp as start_time,
        coalesce(stoptime, ended_at)::timestamp as stoptime,
        coalesce("start station id", start_station_id)::varchar as start_station_id,
        coalesce("start station name", start_station_name):: varchar as start_station_name,
        coalesce("start station latitude", start_lat):: double as start_station_latitude,
        coalesce("start station longitude",start_lng):: double as start_station_longitude,
        coalesce("end station id", "end_station_id")::varchar as start_duration_id,
        coalesce("end station name", "end_station_name"):: varchar as start_station_name,
        coalesce("end station latitude", "end_lat"):: double as start_station_latitude,
        coalesce("end station longitude", "end_lng"):: double as start_station_longitude,
        coalesce(bikeid,ride_id)::varchar as ride_id,
        case
            when member_casual = 'member' or usertype = 'Subscriber' then 'member'
            when member_casual = 'casual' or usertype = 'Customer' then 'casual'
        end as user_type,
        "birth year":: int as birth_year,
        gender,
        rideable_type,
        filename
    from source
)

-- selecting all columns from the renamed table
select * from renamed

