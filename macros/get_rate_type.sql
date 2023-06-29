{% macro get_rate_type(ratecodeid) -%}
  CASE {{ratecodeid}}
    WHEN 1 THEN 'Standard'
    WHEN 2 THEN 'Airport (JFK)'
    WHEN 3 THEN 'Newark'
    WHEN 4 THEN 'Nassau or Westchester'
    WHEN 5 THEN 'Negotiated'
    WHEN 6 THEN 'Group ride'
  END
{%- endmacro %}
