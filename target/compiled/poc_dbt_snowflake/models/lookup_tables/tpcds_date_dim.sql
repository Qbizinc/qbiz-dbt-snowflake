/*
SQL script to create the tpcds date_dim model in the lookup schema
*/
SELECT
    D_DATE_SK
    , D_DATE_ID
    , D_DATE
    , D_MONTH_SEQ
    , D_WEEK_SEQ
    , D_QUARTER_SEQ
    , D_YEAR
    , D_DOW
    , D_MOY
    , D_DOM
    , D_QOY
    , D_FY_YEAR
    , D_FY_QUARTER_SEQ
    , D_FY_WEEK_SEQ
    , D_DAY_NAME
    , D_QUARTER_NAME
    , D_HOLIDAY
    , D_WEEKEND
    , D_FOLLOWING_HOLIDAY
    , D_FIRST_DOM
    , D_LAST_DOM
    , D_SAME_DAY_LY
    , D_SAME_DAY_LQ
    , D_CURRENT_DAY
    , D_CURRENT_WEEK
    , D_CURRENT_MONTH
    , D_CURRENT_QUARTER
    , D_CURRENT_YEAR
    , md5(cast(coalesce(cast(D_DATE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_DATE_ID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_DATE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_MONTH_SEQ as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_WEEK_SEQ as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_QUARTER_SEQ as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_YEAR as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_DOW as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_MOY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_DOM as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_QOY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_FY_YEAR as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_FY_QUARTER_SEQ as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_FY_WEEK_SEQ as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_DAY_NAME as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_QUARTER_NAME as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_HOLIDAY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_WEEKEND as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_FOLLOWING_HOLIDAY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_FIRST_DOM as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_LAST_DOM as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_SAME_DAY_LY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_SAME_DAY_LQ as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_CURRENT_DAY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_CURRENT_WEEK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_CURRENT_MONTH as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_CURRENT_QUARTER as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(D_CURRENT_YEAR as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS HASH_KEY
    , convert_timezone('UTC', current_timestamp()) AS etl_created_ts
    , convert_timezone('UTC', current_timestamp()) AS etl_updated_ts
    , CAST(CURRENT_USER AS VARCHAR) AS updated_by
    , NVL('', NULL) AS update_notes
FROM QBIZ_DATA.TPCDS.DATE_DIM