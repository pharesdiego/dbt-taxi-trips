select
  {{get_vendor('vendorid')}} as vendor,
  cast(lpep_pickup_datetime as timestamp) as pickup_time,
  cast(lpep_dropoff_datetime as timestamp) as dropoff_time,
  cast(passenger_count as integer) as number_of_passengers,
  trip_distance,
  {{get_rate_type('ratecodeid')}} as rate_type,
  {{get_payment_type('payment_type')}} as payment_type,
  tip_amount,
  total_amount
from {{ source('staging', 'green_trips') }}
