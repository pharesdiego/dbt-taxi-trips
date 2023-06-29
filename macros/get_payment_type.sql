{% macro get_payment_type(payment_type_id) -%}
  CASE {{payment_type_id}}
    WHEN 1 THEN 'Credit card'
    WHEN 2 THEN 'Cash'
    WHEN 3 THEN 'No charge'
    WHEN 4 THEN 'Dispute'
    WHEN 5 THEN 'Unknown'
    WHEN 6 THEN 'Voided trip'
  END
{%- endmacro %}
