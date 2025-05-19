-- loops through the column names passed (aggregated if needed)
{%
    macro loop_through_columns(
              columns, prefix='', is_aggregated=false, aggregate_func='MAX'
          )
-%}

    {% for col in columns -%}
        {%- if is_aggregated -%}
            {{ aggregate_func }}({{ prefix }}{{ col }}) AS {{ col }}
        {%- else -%}
            {{ prefix }}{{ col }}
        {%- endif %}
        {%- if not loop.last %}
            ,
        {%- endif -%}
    {%- endfor %}

{%- endmacro %}


-- assigns default values to the nested field dictionary if they are not already defined
{%- macro process_field(field) -%}

    {% if field.null_value is not defined -%}
        {%- do field.update({'null_value': '\'\''}) -%}
    {%- endif %}
    {% if field.alias is not defined -%}
        {%- do field.update({'alias': field['field_key']}) -%}
    {%- endif %}
    {% if field.value_type is not defined -%}
        {%- do field.update({'value_type': 'string'}) -%}
    {%- endif %}

{%- endmacro -%}


-- loops through the nested field dictionaries, selecting the values specified by the dictionary key argument
{%
    macro loop_through_nested_fields(
              nested_fields,
              field_dict_key,
              is_aggregated=false,
              aggregate_func='MAX'
          )
-%}

    {% for curr_field in nested_fields -%}
        {{ process_field(field=curr_field) }}
        {%- set field_val = curr_field[field_dict_key] -%}
        {% if is_aggregated -%}
            {{ aggregate_func }}({{ field_val }}) AS {{ field_val }}
        {% else -%}
            {{ field_val }}
        {%- endif %}
        {% if not loop.last -%}
            ,
        {%- endif %}
    {%- endfor %}

{%- endmacro %}


-- selects the appropriate parameter value (string, int, float or double) according to the nested field dictionaries passed
{% macro expand_value_columns(value_fields, prefix) -%}

    {%- set key_col = prefix + '_key' -%}

    {% for curr_value in value_fields -%}
        {{ process_field(field=curr_value) }}
        {% if curr_value['value_type'] == 'string' -%}
            {%- set value_col = prefix + '_string_value' -%}
        {% elif curr_value['value_type'] == 'int' -%}
            {%- set value_col = prefix + '_int_value' -%}
        {% elif curr_value['value_type'] == 'float' -%}
            {%- set value_col = prefix + '_float_value' -%}
        {% else -%}
            {%- set value_col = prefix + '_double_value' -%}
        {%- endif %}
        CASE WHEN {{ key_col }} = '{{ curr_value["field_key"] }}' THEN
        {% if curr_value['value_type'] == 'string' -%}
            SUBSTRING({{ value_col }}, 2, LENGTH({{ value_col }}) - 2)
        {% else -%}
            {{ value_col }}
        {%- endif %}
             ELSE CAST({{ curr_value['null_value'] }} AS VARCHAR)
         END AS {{ curr_value['alias'] }}
        {% if not loop.last -%}
            ,
        {%- endif %}
    {%- endfor %}

{%- endmacro %}


-- explodes the nested event_params and user_parameters value fields in the source data
{%
    macro explode_nested_fields(
              columns, source_table, group_by_column
          )
-%}

       SELECT s.{{ group_by_column }}
            , {{ loop_through_columns(columns=columns, prefix='s.') }}
            , ep."key" AS event_params_key
            , JSON_SERIALIZE(ep."value"."string_value") AS event_params_string_value
            , JSON_SERIALIZE(ep."value"."int_value") AS event_params_int_value
            , JSON_SERIALIZE(ep."value"."float_value") AS event_params_float_value
            , JSON_SERIALIZE(ep."value"."double_value") AS event_params_double_value
            , up."key" AS user_properties_key
            , JSON_SERIALIZE(up."value"."string_value") AS user_properties_string_value
            , JSON_SERIALIZE(up."value"."int_value") AS user_properties_int_value
            , JSON_SERIALIZE(up."value"."float_value") AS user_properties_float_value
            , JSON_SERIALIZE(up."value"."double_value") AS user_properties_double_value
         FROM {{ source_table }} AS s
    LEFT JOIN s.event_params AS ep
           ON TRUE
    LEFT JOIN s.user_properties AS up
           ON TRUE

{%- endmacro %}


-- combines all the above to explode and then flatten nested array data
{%
    macro create_extraction_query(
              columns,
              event_params,
              user_properties,
              source_table,
              group_by_column='hash_key'
          )
-%}

    exploded_data AS (
        {{
            explode_nested_fields(
                columns=columns,
                source_table=source_table,
                group_by_column=group_by_column
            )
        }}
    ),

    extracted_data AS (
        SELECT {{ group_by_column }}
             , {{ loop_through_columns(columns=columns) }}
             , {{ expand_value_columns(value_fields=event_params, prefix='event_params') }}
             , {{ expand_value_columns(value_fields=user_properties, prefix='user_properties') }}
          FROM exploded_data
    ),

    collapsed_data AS (
          SELECT {{ group_by_column }}
               , {{ loop_through_columns(columns=columns, is_aggregated=true) }}
               , {{
                     loop_through_nested_fields(
                         nested_fields=event_params,
                         field_dict_key='alias',
                         is_aggregated=true
                     )
                 }}
               , {{
                     loop_through_nested_fields(
                         nested_fields=user_properties,
                         field_dict_key='alias',
                         is_aggregated=true
                     )
                 }}
            FROM extracted_data
        GROUP BY {{ group_by_column }}
    )

    SELECT {{ group_by_column }}
         , {{ loop_through_columns(columns=columns) }}
         , {{
               loop_through_nested_fields(
                   nested_fields=event_params, field_dict_key='alias'
               )
           }}
         , {{
               loop_through_nested_fields(
                   nested_fields=user_properties, field_dict_key='alias'
               )
           }}
         , {{ audit_columns() }}
      FROM collapsed_data

{%- endmacro %}


-- selects the string parameter value associated with an event_params key using regex
{% macro extract_event_params_string(event_params_key, alias_name) -%}

    REGEXP_SUBSTR(
        JSON_SERIALIZE(event_params),
        '"{{ event_params_key }}","value":\\{"string_value":"([\\w\-]+)"',
        1,
        1,
        'e'
    ) AS {{ alias_name }}

{%- endmacro %}
