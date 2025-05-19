{% macro create_lag_cols(lag_cols, partition_col, order_col, asc_desc='ASC') %}
    {% for lag_col in lag_cols %}
        LAG({{ lag_col }}) OVER (
            PARTITION BY {{ partition_col }}
                ORDER BY {{ order_col }} {{ asc_desc }}
        ) AS {{ lag_col + '_lag' }}
        {% if not loop.last %}
            ,
        {% endif %}
    {% endfor %}
{% endmacro %}