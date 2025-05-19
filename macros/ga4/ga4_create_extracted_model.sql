{% macro ga4_create_extracted_model(source_table, lookback_days_start=7) -%}

    WITH array_fields_serialized AS (
        SELECT batch_event_index
             , batch_ordering_id
             , batch_page_id
             , JSON_SERIALIZE(ecommerce) AS ecommerce
             , event_date
             , event_name
             , event_params
             , JSON_SERIALIZE(event_params) AS event_params_text
             , event_timestamp
             , hash_key
             , stream_id
             , JSON_SERIALIZE(traffic_source) AS traffic_source
             , user_properties
             , JSON_SERIALIZE(user_properties) AS user_properties_text
             , user_pseudo_id
          FROM {{ source_table }}
         WHERE TRUE
             {{ apply_date_filters('event_date', lookback_days_start=lookback_days_start) }}
    ),

    {{
        create_extraction_query(
            columns=[
                'batch_event_index',
                'batch_ordering_id',
                'batch_page_id',
                'ecommerce',
                'event_date',
                'event_name',
                'event_params_text',
                'event_timestamp',
                'stream_id',
                'traffic_source',
                'user_properties_text',
                'user_pseudo_id'
            ],
            event_params=[
                ({'field_key': 'aav_option'}),
                ({'field_key': 'aav_topic'}),
                ({'field_key': 'campaign'}),
                ({'field_key': 'content_type'}),
                ({'field_key': 'engagement_time_msec', 'value_type': 'int'}),
                ({'field_key': 'firebase_screen'}),
                ({'field_key': 'firebase_screen_class'}),
                ({'field_key': 'firebase_screen_id', 'value_type': 'int'}),
                ({'field_key': 'ga_session_id', 'value_type': 'int', 'null_value': 'NULL'}),
                ({'field_key': 'ga_session_number', 'value_type': 'int', 'null_value': 'NULL'}),
                ({'field_key': 'kinship_id', 'alias': 'kinship_user_id', 'null_value': 'NULL'}),
                ({'field_key': 'link_text'}),
                ({'field_key': 'link_url'}),
                ({'field_key': 'logged_in_state'}),
                ({'field_key': 'offer_category'}),
                ({'field_key': 'offer_code'}),
                ({'field_key': 'page_location'}),
                ({'field_key': 'page_referrer'}),
                ({'field_key': 'page_title'}),
                ({'field_key': 'pagetype', 'alias': 'page_type'}),
                ({'field_key': 'transaction_id', 'alias': 'event_params_transaction_id'})
            ],
            user_properties=[
                ({'field_key': 'locale'})
            ],
            source_table='array_fields_serialized'
        )
    }}

{%- endmacro %}
