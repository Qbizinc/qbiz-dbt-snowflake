/*
SQL script to create the tpcds web_sales model in the bronze schema
*/
SELECT
    WS_SOLD_DATE_SK,
    WS_SOLD_TIME_SK,
    WS_SHIP_DATE_SK,
    WS_ITEM_SK,
    WS_BILL_CUSTOMER_SK,
    WS_BILL_CDEMO_SK,
    WS_BILL_HDEMO_SK,
    WS_BILL_ADDR_SK,
    WS_SHIP_CUSTOMER_SK,
    WS_SHIP_CDEMO_SK,
    WS_SHIP_HDEMO_SK,
    WS_SHIP_ADDR_SK,
    WS_WEB_PAGE_SK,
    WS_WEB_SITE_SK,
    WS_SHIP_MODE_SK,
    WS_WAREHOUSE_SK,
    WS_PROMO_SK,
    WS_ORDER_NUMBER,
    WS_QUANTITY,
    WS_WHOLESALE_COST,
    WS_LIST_PRICE,
    WS_SALES_PRICE,
    WS_EXT_DISCOUNT_AMT,
    WS_EXT_SALES_PRICE,
    WS_EXT_WHOLESALE_COST,
    WS_EXT_LIST_PRICE,
    WS_EXT_TAX,
    WS_COUPON_AMT,
    WS_EXT_SHIP_COST,
    WS_NET_PAID,
    WS_NET_PAID_INC_TAX,
    WS_NET_PAID_INC_SHIP,
    WS_NET_PAID_INC_SHIP_TAX,
    WS_NET_PROFIT,
    md5(cast(coalesce(cast(WS_SOLD_DATE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_SOLD_TIME_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_SHIP_DATE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_ITEM_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_BILL_CUSTOMER_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_BILL_CDEMO_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_BILL_HDEMO_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_BILL_ADDR_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_SHIP_CUSTOMER_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_SHIP_CDEMO_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_SHIP_HDEMO_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_SHIP_ADDR_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_WEB_PAGE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_WEB_SITE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_SHIP_MODE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_WAREHOUSE_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_PROMO_SK as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_ORDER_NUMBER as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_QUANTITY as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_WHOLESALE_COST as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_LIST_PRICE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_SALES_PRICE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_EXT_DISCOUNT_AMT as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_EXT_SALES_PRICE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_EXT_WHOLESALE_COST as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_EXT_LIST_PRICE as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_EXT_TAX as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_COUPON_AMT as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_EXT_SHIP_COST as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_NET_PAID as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_NET_PAID_INC_TAX as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_NET_PAID_INC_SHIP as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_NET_PAID_INC_SHIP_TAX as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(WS_NET_PROFIT as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS HASH_KEY,
    convert_timezone('UTC', current_timestamp()) AS etl_created_ts
    , convert_timezone('UTC', current_timestamp()) AS etl_updated_ts
    , CAST(CURRENT_USER AS VARCHAR) AS updated_by
    , NVL('', NULL) AS update_notes
FROM QBIZ_DATA.TPCDS.WEB_SALES