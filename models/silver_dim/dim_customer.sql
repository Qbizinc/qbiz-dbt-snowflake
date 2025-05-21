/*
SQL to create the customer dimension in the Silver Layer.
*/

WITH customer_updates AS (
    SELECT C_CUSTOMER_SK
         , ROW_NUMBER() OVER (
               PARTITION BY C_CUSTOMER_SK ORDER BY C_LAST_REVIEW_DATE DESC
           ) AS row_no
      FROM {{ ref('tpcds_customer') }}
),

source_data AS (
    SELECT c.C_CUSTOMER_SK as customer_sk
         , c.C_CUSTOMER_ID as customer_id
		 , ddh.d_date as first_ship_date --c.C_FIRST_SHIPTO_DATE_SK
		 , dds.d_date as first_sales_date --c.C_FIRST_SALES_DATE_SK		 
         , c.C_PREFERRED_CUST_FLAG as preferred_customer_flg
         , ddr.d_date as last_review_date
         , {{
               dbt_utils.generate_surrogate_key(
                   [
                       'c.C_CUSTOMER_SK',
                       'c.C_CUSTOMER_ID',
					   'c.C_PREFERRED_CUST_FLAG',
                       'ddh.d_date',
                       'dds.d_date',
                       'ddr.d_date'
                   ]
               )
           }} AS hash_key
         , CURRENT_TIMESTAMP AS etl_ts
      FROM {{ ref('tpcds_customer') }} c
      LEFT JOIN {{ ref('tpcds_date_dim') }} ddh
        ON c.C_FIRST_SHIPTO_DATE_SK = ddh.d_date_sk
	  LEFT JOIN {{ ref('tpcds_date_dim') }} dds
        ON c.C_FIRST_SALES_DATE_SK = dds.d_date_sk
	  LEFT JOIN {{ ref('tpcds_date_dim') }} ddr
        ON c.C_LAST_REVIEW_DATE = ddr.d_date_sk
    {% if is_incremental() %}
     WHERE c.C_LAST_REVIEW_DATE > (
         SELECT MAX(valid_from) FROM {{ this }}
     )
    {% endif %}
),

ranked_data AS (
    SELECT *
         , {{
               ranked_data_columns(
                   scd_key_col='customer_sk',
                   primary_update_time_col='last_review_date',
                   secondary_update_time_col='etl_ts'
               )
           }}
      FROM source_data
),

valid_data AS (
    SELECT hash_key
         , customer_sk
         , customer_id
         , preferred_customer_flg
         , first_ship_date
         , first_sales_date
         , last_review_date
         , etl_ts
		 , combined_update_ts
         , {{
               scd_time_columns(
                   scd_key_col='customer_sk',
                   initial_record_time_col='last_review_date'
               )
           }}
      FROM ranked_data
)

SELECT {{
           dbt_utils.generate_surrogate_key(
               ['vd.hash_key', 'vd.combined_update_ts']
           )
       }} AS dim_customer_id
     , vd.customer_sk
     , vd.customer_id
     , vd.preferred_customer_flg
     , vd.first_ship_date
     , vd.first_sales_date
     , vd.last_review_date
     , vd.etl_ts
     , vd.hash_key
     , vd.valid_from
     , vd.valid_to
     , vd.is_current
     , vd.first_record_flg
     , {{ audit_columns() }}
  FROM valid_data vd
