{% macro check_test_not_livemode(columns) -%}

    CASE

    {%- for col in columns %}
        WHEN NVL({{ col }}, TRUE) THEN FALSE
    {%- endfor %}
        ELSE TRUE
    END

{%- endmacro %}
