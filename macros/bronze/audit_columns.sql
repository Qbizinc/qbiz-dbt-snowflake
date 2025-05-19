{% macro audit_columns(update_note_string) -%}

    {{ dbt.current_timestamp() }} AS etl_created_ts
    , {{ dbt.current_timestamp() }} AS etl_updated_ts
    , CAST(CURRENT_USER AS VARCHAR) AS updated_by
    , NVL('{{ update_note_string }}', NULL) AS update_notes

{%- endmacro %}
