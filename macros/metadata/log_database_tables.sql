{% macro log_database_tables() %}
{#
This macro runs the list_tables query and logs the result to dbt logs: 
`dbt run-operation log_database_tables`
#}
    {% set query_result = list_tables() %}
    {% set result = run_query(query_result) %}
    
    {# Log the result to the dbt logs #}
    {% if result %}
        {% for row in result %}
            {% do log( '{"table_path": "' ~ row[0] ~ '"}', info=True) %}
        {% endfor %}
    {% endif %}
{% endmacro %}