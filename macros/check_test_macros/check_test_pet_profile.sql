{% macro check_test_pet_profile(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('kinship_pet_profile'),
            ref_col='pet_profile_id',
        )
    }}

{%- endmacro %}


{% macro check_test_kinship_pet(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('cpd_pet_profile_pet_profile'),
            ref_col='kinship_pet_id',
        )
    }}
    OR {{
           check_test_in_other_table(
               col=col,
               ref_table=ref('cpd_pet_profile_pet_profile_bkp'),
               ref_col='kinship_pet_id',
           )
    }}

{%- endmacro %}
