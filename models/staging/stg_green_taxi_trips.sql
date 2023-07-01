select
  {{get_trip_fields('lpep')}},
  if (trip_type = 1, 'Street hail', 'Dispatch') as trip_type
from {{ source('staging', 'green_trips') }}
