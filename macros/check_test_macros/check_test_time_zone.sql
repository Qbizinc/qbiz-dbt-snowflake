{% macro check_test_time_zone(col) -%}

    {{
        check_test_lookup(
            test_col=col,
            rule_col='test_rule',
            rule_type_col='rule_type',
            rule_type='time_zone',
            lookup_source=ref('test_rules')
        )
    }}

{%- endmacro %}
