{% macro accumulate_by_month(source_table
                           , date_field
                           , date_field_name
                           , accumulated_field_name
                           , filter_for_current=TRUE
                           , extra_fields=[]
                           , sum_fields=[]
                           ) -%}
       SELECT count(*) AS {{accumulated_field_name}}
            , extract(YEAR FROM {{date_field}}) || '-' || LPAD(extract(MONTH FROM {{date_field}}), 2, '0') AS {{date_field_name}}
           {% for item in extra_fields -%}
            , {{ item }}
           {%- endfor -%}
           {% for item in sum_fields -%}
            , SUM( {{ item }} ) AS total_{{item}}
           {%- endfor -%}
            , {{ audit_columns() }}
         FROM {{ ref(source_table) }} AS st
         {% if filter_for_current|as_bool -%}
         WHERE is_current
         {% endif %}
         GROUP BY {{date_field_name}}
           {% for item in extra_fields -%}
            , {{ item }}
           {%- endfor -%}
{%- endmacro %}
