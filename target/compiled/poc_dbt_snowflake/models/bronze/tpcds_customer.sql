/*
SQL script to create the tpcds customer model in the Bronze Layer
*/
SELECT
    C_CUSTOMER_SK
    , C_CUSTOMER_ID
    , C_CURRENT_CDEMO_SK
    , C_CURRENT_HDEMO_SK
    , C_CURRENT_ADDR_SK
    , C_FIRST_SHIPTO_DATE_SK
    , C_FIRST_SALES_DATE_SK
    , C_SALUTATION
    , C_FIRST_NAME
    , C_LAST_NAME
    , C_PREFERRED_CUST_FLAG
    , C_BIRTH_DAY
    , C_BIRTH_MONTH
    , C_BIRTH_YEAR
    , C_BIRTH_COUNTRY
    , C_LOGIN
    , C_EMAIL_ADDRESS
    , C_LAST_REVIEW_DATE
	, md5(cast(coalesce(cast(C_CUSTOMER_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_CUSTOMER_ID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_CURRENT_CDEMO_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_CURRENT_HDEMO_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_CURRENT_ADDR_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_FIRST_SHIPTO_DATE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_FIRST_SALES_DATE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_SALUTATION as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_FIRST_NAME as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_LAST_NAME as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_PREFERRED_CUST_FLAG as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_BIRTH_DAY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_BIRTH_MONTH as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_BIRTH_YEAR as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_BIRTH_COUNTRY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_LOGIN as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_EMAIL_ADDRESS as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(C_LAST_REVIEW_DATE as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS hash_key
	, convert_timezone('UTC', current_timestamp()) AS etl_created_ts
    , convert_timezone('UTC', current_timestamp()) AS etl_updated_ts
    , CAST(CURRENT_USER AS VARCHAR) AS updated_by
    , NVL('', NULL) AS update_notes
FROM QBIZ_DATA.TPCDS.CUSTOMER