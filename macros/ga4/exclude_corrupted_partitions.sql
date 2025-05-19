{% macro exclude_corrupted_partitions(partition_dates) -%}

    AND partition_0 NOT IN (
            {%- for partition_date in partition_dates -%}
                '{{ partition_date }}'
                {%- if not loop.last -%}
                    ,
                {%- endif -%}
            {%- endfor -%}
        )

{%- endmacro %}
