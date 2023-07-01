{% macro get_trip_fields(provider) -%}
  {{get_vendor('vendorid')}} as vendor,
  cast({{provider}}_pickup_datetime as timestamp) as pickup_time,
  cast({{provider}}_dropoff_datetime as timestamp) as dropoff_time,
  pulocationid as pickup_location_id,
  dolocationid as dropoff_location_id,
  cast(passenger_count as integer) as number_of_passengers,
  trip_distance,
  {{get_rate_type('ratecodeid')}} as rate_type,
  {{get_payment_type('payment_type')}} as payment_type,
  tip_amount,
  total_amount
{%- endmacro %}