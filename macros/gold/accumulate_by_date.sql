{% macro accumulate_by_date(source_table
                          , date_field
                          , date_field_name
                          , accumulated_field_name
                          , filter_for_current=TRUE
                          , extra_fields=[]
                          , sum_fields=[]
                          ) -%}
    SELECT count(*) AS {{ accumulated_field_name }}
           {% for item in sum_fields -%}
         , SUM( {{ item }} ) AS total_{{item}}
           {%- endfor -%}
           {% for item in extra_fields -%}
         , {{ item }}
           {%- endfor -%}
         , {{ date_field }} AS {{date_field_name}}
         , {{ audit_columns() }}
      FROM {{ ref( source_table ) }} AS st
      {% if filter_for_current|as_bool -%}
      WHERE is_current
      {% endif %}
      GROUP BY {{ date_field }}
     {%- for item in extra_fields -%}
       , {{ item }}
     {%- endfor -%}
{%- endmacro %}
