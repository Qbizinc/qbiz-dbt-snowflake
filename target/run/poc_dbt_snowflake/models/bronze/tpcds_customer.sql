-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into SANDBOX_DATA_PIPELINE.bronze.tpcds_customer as DBT_INTERNAL_DEST
        using SANDBOX_DATA_PIPELINE.bronze.tpcds_customer__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.hash_key = DBT_INTERNAL_DEST.hash_key))

    
    when matched then update set
        etl_updated_ts = DBT_INTERNAL_SOURCE.etl_updated_ts,updated_by = DBT_INTERNAL_SOURCE.updated_by,update_notes = DBT_INTERNAL_SOURCE.update_notes
    

    when not matched then insert
        ("C_CUSTOMER_SK", "C_CUSTOMER_ID", "C_CURRENT_CDEMO_SK", "C_CURRENT_HDEMO_SK", "C_CURRENT_ADDR_SK", "C_FIRST_SHIPTO_DATE_SK", "C_FIRST_SALES_DATE_SK", "C_SALUTATION", "C_FIRST_NAME", "C_LAST_NAME", "C_PREFERRED_CUST_FLAG", "C_BIRTH_DAY", "C_BIRTH_MONTH", "C_BIRTH_YEAR", "C_BIRTH_COUNTRY", "C_LOGIN", "C_EMAIL_ADDRESS", "C_LAST_REVIEW_DATE", "HASH_KEY", "ETL_CREATED_TS", "ETL_UPDATED_TS", "UPDATED_BY", "UPDATE_NOTES")
    values
        ("C_CUSTOMER_SK", "C_CUSTOMER_ID", "C_CURRENT_CDEMO_SK", "C_CURRENT_HDEMO_SK", "C_CURRENT_ADDR_SK", "C_FIRST_SHIPTO_DATE_SK", "C_FIRST_SALES_DATE_SK", "C_SALUTATION", "C_FIRST_NAME", "C_LAST_NAME", "C_PREFERRED_CUST_FLAG", "C_BIRTH_DAY", "C_BIRTH_MONTH", "C_BIRTH_YEAR", "C_BIRTH_COUNTRY", "C_LOGIN", "C_EMAIL_ADDRESS", "C_LAST_REVIEW_DATE", "HASH_KEY", "ETL_CREATED_TS", "ETL_UPDATED_TS", "UPDATED_BY", "UPDATE_NOTES")

;
    commit;