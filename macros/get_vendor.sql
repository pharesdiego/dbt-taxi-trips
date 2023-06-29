{% macro get_vendor(vendorid) -%}
    if ({{vendorid}} = 1, "Creative Mobile Technologies, LLC", "VeriFone Inc.")
{%- endmacro %}
