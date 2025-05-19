{% macro get_lookback_dt(n_days) -%}
    DATEADD(day, -{{n_days}}, {{ dbt.current_timestamp() }})
{%- endmacro %}
