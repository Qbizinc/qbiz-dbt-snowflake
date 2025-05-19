
  
    

create or replace transient table SANDBOX_DATA_PIPELINE.bronze.tpcds_store
    
  (
    S_STORE_SK numeric(38,0),
    S_STORE_ID TEXT,
    S_REC_START_DATE date,
    S_REC_END_DATE date,
    S_CLOSED_DATE_SK numeric(38,0),
    S_STORE_NAME TEXT,
    S_NUMBER_EMPLOYEES numeric(38,0),
    S_FLOOR_SPACE numeric(38,0),
    S_HOURS TEXT,
    S_MANAGER TEXT,
    S_MARKET_ID numeric(38,0),
    S_GEOGRAPHY_CLASS TEXT,
    S_MARKET_DESC TEXT,
    S_MARKET_MANAGER TEXT,
    S_DIVISION_ID numeric(38,0),
    S_DIVISION_NAME TEXT,
    S_COMPANY_ID numeric(38,0),
    S_COMPANY_NAME TEXT,
    S_STREET_NUMBER TEXT,
    S_STREET_NAME TEXT,
    S_STREET_TYPE TEXT,
    S_SUITE_NUMBER TEXT,
    S_CITY TEXT,
    S_COUNTY TEXT,
    S_STATE TEXT,
    S_ZIP TEXT,
    S_COUNTRY TEXT,
    S_GMT_OFFSET numeric(5,2),
    S_TAX_PRECENTAGE numeric(5,2),
    hash_key TEXT,
    etl_created_ts timestamp_tz,
    etl_updated_ts timestamp_tz,
    updated_by TEXT,
    update_notes TEXT
    
    )

    

    
    as (
    select S_STORE_SK, S_STORE_ID, S_REC_START_DATE, S_REC_END_DATE, S_CLOSED_DATE_SK, S_STORE_NAME, S_NUMBER_EMPLOYEES, S_FLOOR_SPACE, S_HOURS, S_MANAGER, S_MARKET_ID, S_GEOGRAPHY_CLASS, S_MARKET_DESC, S_MARKET_MANAGER, S_DIVISION_ID, S_DIVISION_NAME, S_COMPANY_ID, S_COMPANY_NAME, S_STREET_NUMBER, S_STREET_NAME, S_STREET_TYPE, S_SUITE_NUMBER, S_CITY, S_COUNTY, S_STATE, S_ZIP, S_COUNTRY, S_GMT_OFFSET, S_TAX_PRECENTAGE, hash_key, etl_created_ts, etl_updated_ts, updated_by, update_notes
    from (
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
    ) as model_subq
    )
;


  