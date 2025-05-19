{% macro convert_string_columns_to_ints(columns) %}

    {% for col in columns -%}
        CAST(REGEXP_REPLACE({{ col }}, '\\.0', '') AS INTEGER) AS {{ col }}
        {%- if not loop.last -%}
            ,
        {% endif -%}
    {%- endfor %}

{% endmacro %}
