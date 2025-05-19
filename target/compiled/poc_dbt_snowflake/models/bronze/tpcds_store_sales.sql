/*
SQL script to create the tpcds store_sales model in the lookup schema
*/
SELECT
    SS_SOLD_DATE_SK,
    SS_SOLD_TIME_SK,
    SS_ITEM_SK,
    SS_CUSTOMER_SK,
    SS_CDEMO_SK,
    SS_HDEMO_SK,
    SS_ADDR_SK,
    SS_STORE_SK,
    SS_PROMO_SK,
    SS_TICKET_NUMBER,
    SS_QUANTITY,
    SS_WHOLESALE_COST,
    SS_LIST_PRICE,
    SS_SALES_PRICE,
    SS_EXT_DISCOUNT_AMT,
    SS_EXT_SALES_PRICE,
    SS_EXT_WHOLESALE_COST,
    SS_EXT_LIST_PRICE,
    SS_EXT_TAX,
    SS_COUPON_AMT,
    SS_NET_PAID,
    SS_NET_PAID_INC_TAX,
    SS_NET_PROFIT,
    md5(cast(coalesce(cast(SS_SOLD_DATE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_SOLD_TIME_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_ITEM_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_CUSTOMER_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_CDEMO_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_HDEMO_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_ADDR_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_STORE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_PROMO_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_TICKET_NUMBER as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_QUANTITY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_WHOLESALE_COST as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_LIST_PRICE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_SALES_PRICE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_EXT_DISCOUNT_AMT as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_EXT_SALES_PRICE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_EXT_WHOLESALE_COST as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_EXT_LIST_PRICE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_EXT_TAX as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_COUPON_AMT as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_NET_PAID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_NET_PAID_INC_TAX as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(SS_NET_PROFIT as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS HASH_KEY,
    convert_timezone('UTC', current_timestamp()) AS etl_created_ts
    , convert_timezone('UTC', current_timestamp()) AS etl_updated_ts
    , CAST(CURRENT_USER AS VARCHAR) AS updated_by
    , NVL('', NULL) AS update_notes
FROM QBIZ_DATA.TPCDS.STORE_SALES