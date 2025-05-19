{% macro get_json_keys(attribute_keys_table='user_attribute_keys_audit', json_attribute_name='Jsonb') -%}

    {% set json_keys_query %}
        SELECT attribute_name FROM {{ ref(attribute_keys_table) }}
    {% endset %}
    {% set json_keys_result = run_query(json_keys_query) %}
    {% if execute %}
        {% set json_keys = json_keys_result.columns[0].values() %}
    {% else %}
        {% set json_keys = ('') %}
    {% endif -%}

    CASE WHEN attribute_name = '{{ json_attribute_name }}' THEN ARRAY{{ json_keys }}
         ELSE NULL
     END

{%- endmacro %}
