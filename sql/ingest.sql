--bike_data
CREATE TABLE bike_data AS 
SELECT * FROM read_csv_auto('data/data/citibike-tripdata.csv.gz'); -- 4780363

--central_park_weather
create table central_park_weather AS 
SELECT * FROM read_csv('data/data/central_park_weather.csv', header = true);

--fhv_bases
create table fhv_bases AS
SELECT * FROM read_csv('data/data/fhv_bases.csv', header = true);

--fhv_tripdata
create table fhv_tripdata as select * from
read_parquet('./data/data/taxi/fhv_tripdata.parquet', union_by_name=True, filename=True);

--fhvhv_tripdata
create table fhvhv_tripdata as select * from
read_parquet('./data/data/taxi/fhvhv_tripdata.parquet', union_by_name=True, filename=True);

--green_tripdata
create table green_tripdata as select * from
read_parquet('./data/data/taxi/green_tripdata.parquet', union_by_name=True, filename=True);

--yellow_tripdata
create table yellow_tripdata as select * from
read_parquet('./data/data/taxi/yellow_tripdata*.parquet', union_by_name=True, filename=True);