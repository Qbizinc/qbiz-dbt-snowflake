{% macro list_columns(lob) -%}
      id::TEXT AS iterable_list_id
    , "name" AS list_name
    , lower(listtype) AS list_type
    , "description" AS list_description
    , {{ from_unixtime_ms('createdat') }} AS source_created_ts
    , '{{ lob }}' AS line_of_business
    , {{
        dbt_utils.generate_surrogate_key(
            [
            'iterable_list_id'
            , 'list_type'  
            , 'list_name'
            , 'list_description'
            , 'line_of_business'
            ]
        )
    }} AS hash_key
    , {{ audit_columns() }}
{%- endmacro %}