{% macro demographic_cte(name, demographic_type, is_first=FALSE, demographic_source='dim_user_demographics') -%}
    {% if is_first|as_bool -%}
       WITH {{ name }}
    {% else %}
       , {{ name }}
    {% endif %}
     AS (
          SELECT dud.kinship_user_id, dud.demographic_detail AS {{ demographic_type }}
          FROM {{ ref(demographic_source) }} AS dud
          WHERE dud.demographic_type = '{{ demographic_type }}'
    )
{%- endmacro %}
