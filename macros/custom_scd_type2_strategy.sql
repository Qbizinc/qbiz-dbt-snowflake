-- macros/custom_scd_type2_strategy.sql

{% macro get_incremental_custom_scd_type2_sql(arg_dict) %}

    {% set target_relation = arg_dict['target_relation'] %}
    {% set temp_relation = arg_dict['temp_relation'] %}
    {% set unique_key = arg_dict['unique_key'] %}
    {% set dest_columns = arg_dict['dest_columns'] %}

    {% set insert_cols_csv = dest_columns | map(attribute="name") | join(', ') %}

    -- Close out old records
    UPDATE {{ target_relation }} AS t
    SET 
        valid_to = s.valid_from,
        is_current = FALSE
    FROM {{ temp_relation }} AS s
    WHERE t.{{unique_key}} = s.{{unique_key}}
      AND t.is_current = TRUE
      AND t.hash_key != s.hash_key;

    -- Insert new and changed records
    INSERT INTO {{ target_relation }} ({{ insert_cols_csv }})
    SELECT {{ insert_cols_csv }}
    FROM {{ temp_relation }} AS s
    WHERE NOT EXISTS (
        SELECT 1
        FROM {{ target_relation }} AS t
        WHERE t.{{unique_key}} = s.{{unique_key}}
          AND t.hash_key = s.hash_key
          AND t.is_current = TRUE
    );

{% endmacro %}