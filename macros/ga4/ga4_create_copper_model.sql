/*
Defines SQL macro to build GA4 copper models
*/

{% macro ga4_create_copper_model(src, lookback_start=7) %}

    SELECT app_info
         , batch_event_index
         , batch_ordering_id
         , batch_page_id
         , collected_traffic_source
         , device
         , ecommerce
         , event_bundle_sequence_id
         , event_date AS event_date_string
         , event_dimensions
         , event_name
         , event_params
         , event_previous_timestamp AS event_previous_timestamp_unix
         , event_server_timestamp_offset AS event_server_timestamp_offset_micros
         , event_timestamp AS event_timestamp_unix
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
         , user_first_touch_timestamp AS user_first_touch_timestamp_unix
         , user_id
         , user_ltv
         , user_properties
         , user_pseudo_id
         , {{ audit_columns() }}
      FROM {{ src }}
      WHERE TRUE
        {{ apply_date_filters('CAST(event_date AS DATE)', lookback_days_start=lookback_start) }}

{% endmacro %}
