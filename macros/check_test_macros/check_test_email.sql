{% macro check_test_email(col) -%}

    {{
        check_test_lookup(
            test_col=col,
            rule_col='test_rule',
            rule_type_col='rule_type',
            rule_type='email',
            lookup_source=ref('test_rules')
        )
    }}

{%- endmacro %}
