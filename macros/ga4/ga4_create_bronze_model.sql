/*
Defines SQL macro to build GA4 bronze models
*/

{% macro ga4_create_bronze_model(source_table_ref, lookback_start=7) %}
-- GA4 timestamps are measured in microseconds (1/1,000,000th of a second), hence the division variable.
{% set ts_div = 1000000 %}

WITH source_data AS (
    SELECT app_info
         , batch_event_index
         , batch_ordering_id
         , batch_page_id
         , collected_traffic_source
         , device
         , ecommerce
         , event_bundle_sequence_id
         , CAST({{ from_unixtime(column_name='event_timestamp_unix', div=ts_div)}} AS DATE) AS event_date
         , event_dimensions
         , event_name
         , event_params
         , {{
               from_unixtime(
                   column_name='event_previous_timestamp_unix', div=ts_div
               )
           }} AS event_previous_timestamp
         , event_server_timestamp_offset_micros
         , {{
               from_unixtime(column_name='event_timestamp_unix', div=ts_div)
           }} AS event_timestamp
         , event_value_in_usd
         , geo
         , is_active_user
         , items
         , partition_0
         , platform
         , privacy_info
         , publisher
         , session_traffic_source_last_click
         , stream_id
         , traffic_source
         , {{
               from_unixtime(
                   column_name='user_first_touch_timestamp_unix', div=ts_div
               )
           }} AS user_first_touch_timestamp
         , user_id
         , user_ltv
         , user_properties
         , user_pseudo_id
         , {{ extract_event_params_string('kinship_id', 'kinship_user_id') }}
         , {{ check_test_kinship_user('kinship_user_id') }} AS is_test
         , {{
               dbt_utils.generate_surrogate_key(
                   [
                       'app_info'
                       , 'batch_event_index'
                       , 'batch_ordering_id'
                       , 'batch_page_id'
                       , 'collected_traffic_source'
                       , 'device'
                       , 'ecommerce'
                       , 'event_bundle_sequence_id'
                       , 'event_date'
                       , 'event_dimensions'
                       , 'event_name'
                       , 'event_params'
                       , 'event_previous_timestamp'
                       , 'event_server_timestamp_offset_micros'
                       , 'event_timestamp'
                       , 'event_value_in_usd'
                       , 'geo'
                       , bool_to_string('is_active_user')
                       , 'items'
                       , 'platform'
                       , 'privacy_info'
                       , 'publisher'
                       , 'session_traffic_source_last_click'
                       , 'stream_id'
                       , 'traffic_source'
                       , 'user_first_touch_timestamp'
                       , 'user_id'
                       , 'user_ltv'
                       , 'user_properties'
                       , 'user_pseudo_id'
                   ]
               )
           }} AS hash_key
         , {{ audit_columns() }}
      FROM {{ source_table_ref }}
      WHERE TRUE
         {{
             apply_date_filters(
                 'CAST(event_date_string AS DATE)',
                 lookback_days_start=lookback_start
             )
         }}
)
{{
    dbt_utils.deduplicate(
        relation='source_data',
        partition_by='hash_key',
        order_by='event_timestamp DESC',
    )
}}

{% endmacro %}
