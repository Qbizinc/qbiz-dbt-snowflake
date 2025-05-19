/*
SQL script to create the tpcds web_page model in the lookup schema
*/
SELECT
    WP_WEB_PAGE_SK,
    WP_WEB_PAGE_ID,
    WP_REC_START_DATE,
    WP_REC_END_DATE,
    WP_CREATION_DATE_SK,
    WP_ACCESS_DATE_SK,
    WP_AUTOGEN_FLAG,
    WP_CUSTOMER_SK,
    WP_URL,
    WP_TYPE,
    WP_CHAR_COUNT,
    WP_LINK_COUNT,
    WP_IMAGE_COUNT,
    WP_MAX_AD_COUNT,
    md5(cast(coalesce(cast(WP_WEB_PAGE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_WEB_PAGE_ID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_REC_START_DATE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_REC_END_DATE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_CREATION_DATE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_ACCESS_DATE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_AUTOGEN_FLAG as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_CUSTOMER_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_URL as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_TYPE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_CHAR_COUNT as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_LINK_COUNT as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_IMAGE_COUNT as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WP_MAX_AD_COUNT as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS HASH_KEY,
    convert_timezone('UTC', current_timestamp()) AS etl_created_ts
    , convert_timezone('UTC', current_timestamp()) AS etl_updated_ts
    , CAST(CURRENT_USER AS VARCHAR) AS updated_by
    , NVL('', NULL) AS update_notes
FROM QBIZ_DATA.TPCDS.WEB_PAGE