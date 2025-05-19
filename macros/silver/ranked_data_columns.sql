{%
    macro combined_update_time_col(
              scd_key_col,
              primary_update_time_col,
              secondary_update_time_col,
              combined_ts_col_name
    )
-%}
    {% if secondary_update_time_col != '' %}
        CASE WHEN SUM(1) OVER (
                      PARTITION BY {{ scd_key_col }}
                                 , {{ primary_update_time_col }}
                  ) > 1 THEN {{ secondary_update_time_col }}
             ELSE {{ primary_update_time_col }}
         END AS {{ combined_ts_col_name }}
    {% else %}
        {{ primary_update_time_col }} AS {{ combined_ts_col_name }}
    {% endif %}

{%- endmacro %}


{%
    macro incremental_row_num_col(
              scd_key_col,
              primary_update_time_col,
              secondary_update_time_col,
              row_num_col_name
    )
-%}

    CASE WHEN NOT {{ scd_key_col }} IN (
                  SELECT {{ scd_key_col }} FROM {{ this }}
              ) THEN ROW_NUMBER() OVER (
                         PARTITION BY {{ scd_key_col }}
                         ORDER BY {{ primary_update_time_col }} ASC
                         {%- if secondary_update_time_col != '' -%}
                             , {{ secondary_update_time_col }} ASC
                         {%- endif -%}
                     )
         ELSE 0
     END AS {{ row_num_col_name }}

{%- endmacro %}


{%
    macro initial_row_num_col(
              scd_key_col,
              primary_update_time_col,
              secondary_update_time_col,
              row_num_col_name
    )
-%}

    ROW_NUMBER() OVER (
        PARTITION BY {{ scd_key_col }}
            ORDER BY {{ primary_update_time_col }} ASC
            {%- if secondary_update_time_col != '' -%}
                , {{ secondary_update_time_col }} ASC
            {%- endif -%}
    ) AS {{ row_num_col_name }}

{%- endmacro %}


{%
    macro ranked_data_columns(
              scd_key_col,
              primary_update_time_col,
              secondary_update_time_col='',
              combined_ts_col_name='combined_update_ts',
              row_num_col_name='row_num'
    )
-%}
    {{ combined_update_time_col(
           scd_key_col=scd_key_col,
           primary_update_time_col=primary_update_time_col,
           secondary_update_time_col=secondary_update_time_col,
           combined_ts_col_name=combined_ts_col_name
       )
    }}
    {% if is_incremental() %}
        , {{
              incremental_row_num_col(
                  scd_key_col=scd_key_col,
                  primary_update_time_col=primary_update_time_col,
                  secondary_update_time_col=secondary_update_time_col,
                  row_num_col_name=row_num_col_name
              )
          }}
    {% else %}
        , {{
              initial_row_num_col(
                  scd_key_col=scd_key_col,
                  primary_update_time_col=primary_update_time_col,
                  secondary_update_time_col=secondary_update_time_col,
                  row_num_col_name=row_num_col_name
              )
          }}
    {% endif %}

{%- endmacro %}
