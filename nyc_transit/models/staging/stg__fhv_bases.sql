-- selecting data from a source called fhv_bases in the main schema. 
with source as (
    select * from {{ source('main', 'fhv_bases') }}
),

-- query then renames columns and specifies their data types in a temporary table called renamed. No changes, kept all data  types as varchar
renamed as (
    select
        base_number
        base_name,
        dba,
        dba_category,
        filename
    from source
)

-- selecting all columns from the renamed table
select * from renamed

