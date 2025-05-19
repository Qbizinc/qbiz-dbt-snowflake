/*
SQL script to create the tpcds store model in the Bronze Layer
*/
SELECT
    S_STORE_SK,
    S_STORE_ID,
    S_REC_START_DATE,
    S_REC_END_DATE,
    S_CLOSED_DATE_SK,
    S_STORE_NAME,
    S_NUMBER_EMPLOYEES,
    S_FLOOR_SPACE,
    S_HOURS,
    S_MANAGER,
    S_MARKET_ID,
    S_GEOGRAPHY_CLASS,
    S_MARKET_DESC,
    S_MARKET_MANAGER,
    S_DIVISION_ID,
    S_DIVISION_NAME,
    S_COMPANY_ID,
    S_COMPANY_NAME,
    S_STREET_NUMBER,
    S_STREET_NAME,
    S_STREET_TYPE,
    S_SUITE_NUMBER,
    S_CITY,
    S_COUNTY,
    S_STATE,
    S_ZIP,
    S_COUNTRY,
    S_GMT_OFFSET,
    S_TAX_PRECENTAGE,
    md5(cast(coalesce(cast(S_STORE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_STORE_ID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_REC_START_DATE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_REC_END_DATE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_CLOSED_DATE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_STORE_NAME as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_NUMBER_EMPLOYEES as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_FLOOR_SPACE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_HOURS as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_MANAGER as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_MARKET_ID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_GEOGRAPHY_CLASS as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_MARKET_DESC as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_MARKET_MANAGER as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_DIVISION_ID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_DIVISION_NAME as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_COMPANY_ID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_COMPANY_NAME as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_STREET_NUMBER as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_STREET_NAME as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_STREET_TYPE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_SUITE_NUMBER as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_CITY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_COUNTY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_STATE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_ZIP as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_COUNTRY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_GMT_OFFSET as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(S_TAX_PRECENTAGE as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS HASH_KEY,
    convert_timezone('UTC', current_timestamp()) AS etl_created_ts
    , convert_timezone('UTC', current_timestamp()) AS etl_updated_ts
    , CAST(CURRENT_USER AS VARCHAR) AS updated_by
    , NVL('', NULL) AS update_notes
FROM QBIZ_DATA.TPCDS.STORE