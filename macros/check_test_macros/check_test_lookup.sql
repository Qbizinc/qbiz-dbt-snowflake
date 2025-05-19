{% macro check_test_lookup(test_col, rule_col, rule_type_col, rule_type, lookup_source) %}

    {%- set patterns = dbt_utils.get_column_values(
        table=lookup_source,
        column=rule_col,
        where=rule_type_col + " = '" + rule_type + "'"
    ) -%}

    CASE {% for pattern in patterns -%}
            WHEN {{ test_col }} ILIKE '{{ pattern }}' THEN TRUE
         {% endfor -%}
        ELSE FALSE
    END

{%- endmacro %}
