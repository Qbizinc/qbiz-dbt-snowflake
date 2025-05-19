{%
    macro apply_date_filters(
        date_col,
        lookback_days_start=var('lookback_window')['default']['start_days'],
        lookback_days_end=var('lookback_window')['default']['end_days']
    )
-%}
                            
    {% if is_incremental() and lookback_days_start is none -%}
     AND {{ date_col }}  >= (
             SELECT MAX({{ date_col }})
             FROM {{ this }}
         )
    {%- endif %}
    
    {% if is_incremental() and lookback_days_start is not none -%}
        AND DATE_TRUNC('day', {{ date_col}} ) >= DATE_TRUNC(
                'day', {{ get_lookback_dt(lookback_days_start) }}
            )
    {%- endif %}

    {% if lookback_days_end is not none and date_col is not none -%}
        AND DATE_TRUNC('day', {{ date_col }}) <= DATE_TRUNC(
                'day', {{ get_lookback_dt(lookback_days_end) }}
            )
    {%- endif %}

{%- endmacro %}
