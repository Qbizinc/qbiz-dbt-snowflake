{% macro bool_to_string(boolean_col) -%}

    CASE WHEN {{ boolean_col }} THEN 'TRUE'
         ELSE 'FALSE'
     END

{%- endmacro %}
