{% macro create_change_flags(flag_cols) %}
    {% for flag_col in flag_cols %}
        CASE WHEN {{ flag_col + '_lag' }} IS NULL THEN FALSE
             WHEN {{ flag_col + '_lag'}} <> {{ flag_col }} THEN TRUE
             ELSE FALSE
         END AS {{ flag_col + '_change_flag' }}
        {% if not loop.last %}
            ,
        {% endif %}
    {% endfor %}
{% endmacro %}