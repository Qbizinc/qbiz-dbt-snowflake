{% macro list_size_history_columns(lob) -%}
      id::TEXT AS iterable_list_id
    , "size"::INT AS list_size
    , '{{ lob }}' AS line_of_business
    , ingestedat::TIMESTAMP AS transfer_ts
    , {{ dbt_utils.generate_surrogate_key(
            [
                  'iterable_list_id'
                , 'list_size'  
                , 'line_of_business'
                , 'transfer_ts'
            ]
        )
        }} AS hash_key
    , {{ audit_columns() }}
{%- endmacro %}