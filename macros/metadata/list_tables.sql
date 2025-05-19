{% macro list_tables() %}

{% set query %}
        SELECT 
            table_schema || '.' || table_name AS full_table_name,
            table_name, 
            table_schema
        FROM information_schema.tables
        WHERE table_schema NOT IN ('information_schema', 'pg_catalog')
        ORDER BY table_schema, table_name
{% endset %}

{{ return(query) }}

{% endmacro %}
