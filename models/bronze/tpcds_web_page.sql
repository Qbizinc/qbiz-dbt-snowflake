/*
SQL script to create the tpcds web_page model in the lookup schema
*/
SELECT
    WP_WEB_PAGE_SK,
    WP_WEB_PAGE_ID,
    WP_REC_START_DATE,
    WP_REC_END_DATE,
    WP_CREATION_DATE_SK,
    WP_ACCESS_DATE_SK,
    WP_AUTOGEN_FLAG,
    WP_CUSTOMER_SK,
    WP_URL,
    WP_TYPE,
    WP_CHAR_COUNT,
    WP_LINK_COUNT,
    WP_IMAGE_COUNT,
    WP_MAX_AD_COUNT,
    {{
        dbt_utils.generate_surrogate_key(
            [
                'WP_WEB_PAGE_SK',
                'WP_WEB_PAGE_ID',
                'WP_REC_START_DATE',
                'WP_REC_END_DATE',
                'WP_CREATION_DATE_SK',
                'WP_ACCESS_DATE_SK',
                'WP_AUTOGEN_FLAG',
                'WP_CUSTOMER_SK',
                'WP_URL',
                'WP_TYPE',
                'WP_CHAR_COUNT',
                'WP_LINK_COUNT',
                'WP_IMAGE_COUNT',
                'WP_MAX_AD_COUNT'
            ]
        )
    }} AS HASH_KEY,
    {{ audit_columns() }}
FROM {{ source('TPCDS', 'WEB_PAGE') }}
