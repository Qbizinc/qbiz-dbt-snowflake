{%
    macro valid_from_col(
        initial_record_time_col,
        update_time_col,
        row_num_col='row_num'
    )
-%}

    CASE WHEN {{ row_num_col }} = 1 THEN {{ initial_record_time_col }}
         ELSE {{ update_time_col }}
     END AS valid_from

{%- endmacro %}


{% macro valid_to_col(scd_key_col, update_time_col) -%}

    NVL(
        LEAD({{ update_time_col }}) OVER (
            PARTITION BY {{ scd_key_col }} ORDER BY {{ update_time_col }} ASC
        ), CAST('4444-04-04' AS TIMESTAMP)
    )AS valid_to

{%- endmacro %}


{% macro is_current_col(scd_key_col, update_time_col) -%}

    CASE WHEN LEAD({{ scd_key_col }}) OVER (
                  PARTITION BY {{ scd_key_col }}
                      ORDER BY {{ update_time_col }} ASC
              ) IS NULL THEN TRUE
         ELSE FALSE
     END AS is_current

{%- endmacro %}


{%
    macro scd_time_columns(
        scd_key_col,
        initial_record_time_col,
        update_time_col='combined_update_ts',
        row_num_col='row_num'
    )
-%}

    {{
        valid_from_col(
            initial_record_time_col=initial_record_time_col,
            update_time_col=update_time_col,
            row_num_col=row_num_col
        )
    }}
    , {{
          valid_to_col(
              scd_key_col=scd_key_col,
              update_time_col=update_time_col
          )
      }}
    , {{
          is_current_col(
              scd_key_col=scd_key_col,
              update_time_col=update_time_col
          )
      }}
    , {{ row_num_col }} = 1 AS first_record_flg

{%- endmacro %}
