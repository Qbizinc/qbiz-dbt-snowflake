{% macro create_bronze_iterable_list_users(iterable_list_id) %}
WITH source_data AS (   

    SELECT 
          iterable_list_id
        , email
        , source_created_ts
        , {{ check_test_email('email') }} as is_test
    FROM {{ ref('iterable_all_lists_copper') }}
    WHERE TRUE
        AND iterable_list_id = '{{ iterable_list_id }}' 
        {{ apply_date_filters('etl_updated_ts') }}
),
list_users AS (
    SELECT 
          s.iterable_list_id
        , s.email
        , u.kinship_user_id
        , s.source_created_ts
        , s.is_test
        , {{ audit_columns() }}
        , {{ dbt_utils.generate_surrogate_key(
                ['s.iterable_list_id'
                 , 's.email'
                 , 'u.kinship_user_id' 
                ]
             )
           }} as hash_key
    FROM source_data s
    LEFT JOIN {{ ref('cpd_user_profile_user_profile') }} u
        ON s.email = u.email
)
{{
    dbt_utils.deduplicate(
        relation='list_users',
        partition_by='hash_key',
        order_by='source_created_ts DESC', 
    )
}}
{% endmacro %}