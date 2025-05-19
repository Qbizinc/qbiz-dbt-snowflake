{% macro apple_json_get(json_col, secondary_key, primary_key='transaction') -%}

    CASE WHEN JSON_EXTRACT_PATH_TEXT(
                  {{ json_col }}
                  , 'data'
                  , '{{ primary_key }}'
                  , '{{ secondary_key }}'
              ) = '' THEN NULL
         ELSE JSON_EXTRACT_PATH_TEXT(
                  {{ json_col }}
                  , 'data'
                  , '{{ primary_key }}'
                  , '{{ secondary_key }}'
              )
     END

{%- endmacro %}
