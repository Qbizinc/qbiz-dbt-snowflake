/*
A collection of macros specific to the vetinsight_postgres and vetinsight_postgres_uk models.
*/

{% macro check_test_vetinsight_us_consultation(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_consultations'),
            ref_col='consultation_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_uk_consultation(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_uk_consultations'),
            ref_col='consultation_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_uk_conversation(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_uk_conversations'),
            ref_col='conversation_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_us_external_pet(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_external_pet_identities'),
            ref_col='vetinsight_pet_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_uk_external_pet(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_uk_external_pet_identities'),
            ref_col='vetinsight_pet_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_us_external_user(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_external_identities'),
            ref_col='vetinsight_user_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_uk_external_user(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_uk_external_identities'),
            ref_col='vetinsight_user_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_uk_partner(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_uk_partners'),
            ref_col='partner_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_us_pet(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_pets'),
            ref_col='vetinsight_pet_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_uk_pet(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_uk_pets'),
            ref_col='vetinsight_pet_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_uk_practice(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_uk_practices'),
            ref_col='practice_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_uk_practice_group(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_uk_practice_groups'),
            ref_col='practice_group_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_us_tags(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_tags'),
            ref_col='tag_id'
        )
    }}
    OR {{
           check_test_in_other_table(
               col=col,
               ref_table=ref('vetinsight_postgres_predefined_tags'),
               ref_col='tag_id'
           )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_uk_tags(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_uk_tags'),
            ref_col='tag_id'
        )
    }}
    OR {{
           check_test_in_other_table(
               col=col,
               ref_table=ref('vetinsight_postgres_uk_predefined_tags'),
               ref_col='tag_id'
           )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_us_user(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_users'),
            ref_col='vetinsight_user_id'
        )
    }}

{%- endmacro %}


{% macro check_test_vetinsight_uk_user(col) -%}

    {{
        check_test_in_other_table(
            col=col,
            ref_table=ref('vetinsight_postgres_uk_users'),
            ref_col='vetinsight_user_id'
        )
    }}

{%- endmacro %}
