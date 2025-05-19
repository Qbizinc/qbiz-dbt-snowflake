{% macro check_test_kinship_user(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('cpd_user_profile_user_profile'),
            ref_col='kinship_user_id',
        )
    }}

{%- endmacro %}

{% macro check_test_the_wildest_user(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('kinship_user_profile'),
            ref_col='the_wildest_user_id',
        )
    }}

{%- endmacro %}
