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
	, {{
            dbt_utils.generate_surrogate_key(
                [
                      'C_CUSTOMER_SK'
                    , 'C_CUSTOMER_ID'
                    , 'C_CURRENT_CDEMO_SK'
                    , 'C_CURRENT_HDEMO_SK'
                    , 'C_CURRENT_ADDR_SK'
                    , 'C_FIRST_SHIPTO_DATE_SK'
                    , 'C_FIRST_SALES_DATE_SK'
                    , 'C_SALUTATION'
                    , 'C_FIRST_NAME'
                    , 'C_LAST_NAME'
                    , 'C_PREFERRED_CUST_FLAG'
                    , 'C_BIRTH_DAY'
                    , 'C_BIRTH_MONTH'
                    , 'C_BIRTH_YEAR'
                    , 'C_BIRTH_COUNTRY'
                    , 'C_LOGIN'
                    , 'C_EMAIL_ADDRESS'
                    , 'C_LAST_REVIEW_DATE'
                ]
            )
        }} AS hash_key
	, {{ audit_columns() }}
FROM {{ source('TPCDS', 'CUSTOMER') }}
