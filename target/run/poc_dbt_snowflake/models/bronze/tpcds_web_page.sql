-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into SANDBOX_DATA_PIPELINE.bronze.tpcds_web_page as DBT_INTERNAL_DEST
        using SANDBOX_DATA_PIPELINE.bronze.tpcds_web_page__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.hash_key = DBT_INTERNAL_DEST.hash_key))

    
    when matched then update set
        etl_updated_ts = DBT_INTERNAL_SOURCE.etl_updated_ts,updated_by = DBT_INTERNAL_SOURCE.updated_by,update_notes = DBT_INTERNAL_SOURCE.update_notes
    

    when not matched then insert
        ("WP_WEB_PAGE_SK", "WP_WEB_PAGE_ID", "WP_REC_START_DATE", "WP_REC_END_DATE", "WP_CREATION_DATE_SK", "WP_ACCESS_DATE_SK", "WP_AUTOGEN_FLAG", "WP_CUSTOMER_SK", "WP_URL", "WP_TYPE", "WP_CHAR_COUNT", "WP_LINK_COUNT", "WP_IMAGE_COUNT", "WP_MAX_AD_COUNT", "HASH_KEY", "ETL_CREATED_TS", "ETL_UPDATED_TS", "UPDATED_BY", "UPDATE_NOTES")
    values
        ("WP_WEB_PAGE_SK", "WP_WEB_PAGE_ID", "WP_REC_START_DATE", "WP_REC_END_DATE", "WP_CREATION_DATE_SK", "WP_ACCESS_DATE_SK", "WP_AUTOGEN_FLAG", "WP_CUSTOMER_SK", "WP_URL", "WP_TYPE", "WP_CHAR_COUNT", "WP_LINK_COUNT", "WP_IMAGE_COUNT", "WP_MAX_AD_COUNT", "HASH_KEY", "ETL_CREATED_TS", "ETL_UPDATED_TS", "UPDATED_BY", "UPDATE_NOTES")

;
    commit;