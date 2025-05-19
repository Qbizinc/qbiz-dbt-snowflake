-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into SANDBOX_DATA_PIPELINE.bronze.tpcds_store_sales as DBT_INTERNAL_DEST
        using SANDBOX_DATA_PIPELINE.bronze.tpcds_store_sales__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.hash_key = DBT_INTERNAL_DEST.hash_key))

    
    when matched then update set
        etl_updated_ts = DBT_INTERNAL_SOURCE.etl_updated_ts,updated_by = DBT_INTERNAL_SOURCE.updated_by,update_notes = DBT_INTERNAL_SOURCE.update_notes
    

    when not matched then insert
        ("SS_SOLD_DATE_SK", "SS_SOLD_TIME_SK", "SS_ITEM_SK", "SS_CUSTOMER_SK", "SS_CDEMO_SK", "SS_HDEMO_SK", "SS_ADDR_SK", "SS_STORE_SK", "SS_PROMO_SK", "SS_TICKET_NUMBER", "SS_QUANTITY", "SS_WHOLESALE_COST", "SS_LIST_PRICE", "SS_SALES_PRICE", "SS_EXT_DISCOUNT_AMT", "SS_EXT_SALES_PRICE", "SS_EXT_WHOLESALE_COST", "SS_EXT_LIST_PRICE", "SS_EXT_TAX", "SS_COUPON_AMT", "SS_NET_PAID", "SS_NET_PAID_INC_TAX", "SS_NET_PROFIT", "HASH_KEY", "ETL_CREATED_TS", "ETL_UPDATED_TS", "UPDATED_BY", "UPDATE_NOTES")
    values
        ("SS_SOLD_DATE_SK", "SS_SOLD_TIME_SK", "SS_ITEM_SK", "SS_CUSTOMER_SK", "SS_CDEMO_SK", "SS_HDEMO_SK", "SS_ADDR_SK", "SS_STORE_SK", "SS_PROMO_SK", "SS_TICKET_NUMBER", "SS_QUANTITY", "SS_WHOLESALE_COST", "SS_LIST_PRICE", "SS_SALES_PRICE", "SS_EXT_DISCOUNT_AMT", "SS_EXT_SALES_PRICE", "SS_EXT_WHOLESALE_COST", "SS_EXT_LIST_PRICE", "SS_EXT_TAX", "SS_COUPON_AMT", "SS_NET_PAID", "SS_NET_PAID_INC_TAX", "SS_NET_PROFIT", "HASH_KEY", "ETL_CREATED_TS", "ETL_UPDATED_TS", "UPDATED_BY", "UPDATE_NOTES")

;
    commit;