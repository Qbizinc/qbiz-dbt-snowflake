{% macro from_unixtime_ms(column_name) -%}

  TIMESTAMP 'epoch' + {{ column_name }} / 1000 * INTERVAL '1 second'

{%- endmacro %}
