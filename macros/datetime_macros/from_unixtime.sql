{% macro from_unixtime(column_name, div=1) -%}

  TIMESTAMP 'epoch' + {{ column_name }} / {{ div }} * INTERVAL '1 second'

{%- endmacro %}
