-- selecting data from a source called central_park_weather in the main schema. 
with source as (
    select * from {{ source('main', 'central_park_weather') }}
),

-- query then renames columns and specifies their data types in a temporary table called renamed
renamed as (
    select
        station,
        name,
        date::date as date,
        awnd::double as awnd,
        prcp::double as prcp,
        snow::double as snow,
        snwd::double as snwd,
        tmax::int as tmax,
        tmin::int as tmin,
        filename
    from source
)

-- selecting all columns from the renamed table
select * from renamed

