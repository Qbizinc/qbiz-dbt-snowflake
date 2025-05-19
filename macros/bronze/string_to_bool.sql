{% macro string_to_bool(col) %}

    CASE WHEN {{ col }} = 'true' THEN TRUE
         WHEN {{ col }} = 'false' THEN FALSE
         ELSE NULL
     END

{% endmacro %}
