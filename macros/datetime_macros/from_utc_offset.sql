{% macro from_utc_offset(column_name, offset) -%}

  CONVERT_TIMEZONE('{{offset}}', 'UTC', {{column_name}})
  
{%- endmacro %}
