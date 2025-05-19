{% macro check_test_in_other_table(col, ref_table, ref_col, prefix='') -%}

CASE WHEN {{ col }} ~ '^{{ prefix }}.*' THEN NVL(
              SUBSTRING({{ col }}, LEN('{{ prefix }}') + 1) IN (
                  SELECT {{ ref_col }}
                  FROM {{ ref_table }}
                  WHERE is_test
              )
              , FALSE
          )
     ELSE NVL(
              {{ col }} IN (
                  SELECT {{ ref_col }}
                  FROM {{ ref_table }}
                  WHERE is_test
              )
              , FALSE
          )
 END

{%- endmacro %}
