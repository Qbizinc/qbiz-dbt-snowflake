{%
    macro fact_user_journey_data_from_ga4_table(
              ga4_property_name,
              extracted_table,
              base_table,
              lookback_days_start=7
          )
-%}



       SELECT e.hash_key AS user_journey_event_id
            , a.user_activity_id
            , CAST('{{ ga4_property_name }}' AS VARCHAR) AS ga4_property_name
            , e.kinship_user_id
            , e.user_pseudo_id
            , CAST(e.ga_session_id AS BIGINT) AS ga_session_id
            , CAST(e.ga_session_number AS INTEGER) AS ga_session_number
            , e.event_date
            , e.event_timestamp AS event_ts
            , e.batch_event_index
            , e.batch_ordering_id
            , e.batch_page_id
            , e.event_params_transaction_id
            , e.campaign
            , e.offer_category
            , e.offer_code
            , e.logged_in_state
            , e.link_text
            , e.link_url
            , JSON_EXTRACT_PATH_TEXT(e.ecommerce, 'transaction_id', TRUE) AS ecommerce_transaction_id
            , SPLIT_PART(e.page_location, '?', 2) AS content_context
            , SPLIT_PART(e.page_referrer, '?', 1) AS page_referrer
            , SPLIT_PART(e.page_referrer, '?', 2) AS page_referrer_context
            , e.stream_id
            , e.locale
            , c.content_id
            , t.traffic_source_id
            , e.etl_updated_ts AS etl_watermark_ts
            , e.hash_key
            , b.is_test
            , {{ audit_columns() }}
         FROM {{ extracted_table }} AS e
    LEFT JOIN {{ base_table }} AS b
           ON e.hash_key = b.hash_key
    LEFT JOIN {{ ref('dim_user_activities') }} AS a
           ON e.event_name = a.user_activity
    LEFT JOIN {{ ref('dim_content') }} AS c
           ON e.content_type = c.content_type
              AND SPLIT_PART(e.page_location, '?', 1) = c.page_location
              AND e.page_title = c.page_title
    LEFT JOIN {{ ref('dim_traffic_source') }} AS t
           ON NVL(JSON_EXTRACT_PATH_TEXT(e.traffic_source, 'medium', TRUE), '') = t.traffic_source_medium
              AND NVL(JSON_EXTRACT_PATH_TEXT(e.traffic_source, 'name', TRUE), '') = t.traffic_source_name
              AND NVL(JSON_EXTRACT_PATH_TEXT(e.traffic_source, 'source', TRUE), '') = t.traffic_source_source
        WHERE TRUE
            {{ apply_date_filters('e.event_date', lookback_days_start=lookback_days_start) }}

{%- endmacro %}


{% macro dim_content_from_ga4_table(extracted_table, lookback_days_start=7) -%}

    SELECT content_type
         , SPLIT_PART(page_location, '?', 1) AS page_location
         , page_title
      FROM {{ extracted_table }}
     WHERE content_type <> ''
        OR page_location <> ''
        OR page_title <> ''
         {{ apply_date_filters('event_date', lookback_days_start=lookback_days_start) }}

{%- endmacro %}


{% macro dim_traffic_source_from_ga4_table(extracted_table, lookback_days_start=7) -%}

    SELECT NVL(JSON_EXTRACT_PATH_TEXT(traffic_source, 'name', TRUE), '') AS traffic_source_name
         , NVL(JSON_EXTRACT_PATH_TEXT(traffic_source, 'medium', TRUE), '') AS traffic_source_medium
         , NVL(JSON_EXTRACT_PATH_TEXT(traffic_source, 'source', TRUE), '') AS traffic_source_source
      FROM {{ extracted_table }}
     WHERE TRUE
         {{ apply_date_filters('event_date', lookback_days_start=7) }}

{%- endmacro %}
