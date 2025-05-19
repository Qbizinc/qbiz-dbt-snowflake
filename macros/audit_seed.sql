{% macro audit_seed(seed_name) -%}

WITH {{seed_name}}_audit AS (
     SELECT s.*
     , {{
           dbt_utils.generate_surrogate_key(
            dbt_utils.get_filtered_columns_in_relation(ref(seed_name))
                  )
        }} AS hash_key
     ,  {{ audit_columns() }}
     FROM {{ ref( seed_name ) }} AS s
)
SELECT * from {{seed_name}}_audit

{%- endmacro %}
