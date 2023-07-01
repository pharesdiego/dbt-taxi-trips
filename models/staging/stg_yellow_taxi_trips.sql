with trips as (
  select *, row_number() over(partition by vendorid, tpep_pickup_datetime) as rn
  from {{ source('staging', 'trips') }}
  where vendorid is not null
)
select
  {{get_trip_fields('tpep')}},
  'Street hail' as trip_type
from trips