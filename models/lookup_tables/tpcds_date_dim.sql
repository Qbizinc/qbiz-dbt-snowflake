/*
SQL script to create the tpcds date_dim model in the lookup schema
*/
SELECT
    D_DATE_SK
    , D_DATE_ID
    , D_DATE
    , D_MONTH_SEQ
    , D_WEEK_SEQ
    , D_QUARTER_SEQ
    , D_YEAR
    , D_DOW
    , D_MOY
    , D_DOM
    , D_QOY
    , D_FY_YEAR
    , D_FY_QUARTER_SEQ
    , D_FY_WEEK_SEQ
    , D_DAY_NAME
    , D_QUARTER_NAME
    , D_HOLIDAY
    , D_WEEKEND
    , D_FOLLOWING_HOLIDAY
    , D_FIRST_DOM
    , D_LAST_DOM
    , D_SAME_DAY_LY
    , D_SAME_DAY_LQ
    , D_CURRENT_DAY
    , D_CURRENT_WEEK
    , D_CURRENT_MONTH
    , D_CURRENT_QUARTER
    , D_CURRENT_YEAR
    , {{
        dbt_utils.generate_surrogate_key(
            [
                'D_DATE_SK',
                'D_DATE_ID',
                'D_DATE',
                'D_MONTH_SEQ',
                'D_WEEK_SEQ',
                'D_QUARTER_SEQ',
                'D_YEAR',
                'D_DOW',
                'D_MOY',
                'D_DOM',
                'D_QOY',
                'D_FY_YEAR',
                'D_FY_QUARTER_SEQ',
                'D_FY_WEEK_SEQ',
                'D_DAY_NAME',
                'D_QUARTER_NAME',
                'D_HOLIDAY',
                'D_WEEKEND',
                'D_FOLLOWING_HOLIDAY',
                'D_FIRST_DOM',
                'D_LAST_DOM',
                'D_SAME_DAY_LY',
                'D_SAME_DAY_LQ',
                'D_CURRENT_DAY',
                'D_CURRENT_WEEK',
                'D_CURRENT_MONTH',
                'D_CURRENT_QUARTER',
                'D_CURRENT_YEAR'
            ]
        )
    }} AS HASH_KEY
    , {{ audit_columns() }}
FROM {{ source('TPCDS', 'DATE_DIM') }}
