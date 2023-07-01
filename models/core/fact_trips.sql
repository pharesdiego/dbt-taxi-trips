{{ config(materialized='table') }} 

with green_trips as (
  select *, 'Green' as taxi_type from {{ ref('stg_green_taxi_trips') }}
),
yellow_trips as (
  select *, 'Yellow' as taxi_type from {{ ref('stg_yellow_taxi_trips') }}
),
all_trips as (
  select * from green_trips
  union all
  select * from yellow_trips
)

select
  vendor,
  pickup_time,
  dropoff_time,
  pickup_location_id,
  pickup_zone.borough as pickup_location_borough,
  pickup_zone.zone as pickup_location_zone,
  dropoff_location_id,
  dropoff_zone.borough as dropoff_zone_borough,
  dropoff_zone.zone as dropoff_zone_zone,
  number_of_passengers,
  trip_distance,
  rate_type,
  payment_type,
  tip_amount,
  total_amount,
  trip_type
from all_trips
inner join
  {{ ref('dim_zones') }} as pickup_zone on pickup_location_id = pickup_zone.locationid
inner join
  {{ ref('dim_zones') }} as dropoff_zone on dropoff_location_id = dropoff_zone.locationid
