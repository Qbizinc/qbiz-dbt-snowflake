{% macro from_utc_offset_string(column_name, offset, dt_format='YYYY-MM-DD HH24:MI:SS') -%}

  CONVERT_TIMEZONE('{{offset}}', 
                   'UTC', 
                   TO_TIMESTAMP({{column_name}}, '{{dt_format}}')::timestamp
                   ) 
  
{%- endmacro %}
