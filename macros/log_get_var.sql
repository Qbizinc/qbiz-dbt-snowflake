-- to use run: 
-- dbt run-operation print_var --args '{"var_name": "base_variable_name", "nested_keys": ["key_1"]}'
-- the above command will print the output of the variable to the console
-- pass nested_keys to isolate nested key-values
{% macro print_var(var_name, nested_keys=[]) %}
    {% set base_var = var(var_name) %}

    {% if nested_keys %}
        {% for key in nested_keys %}
            {% set base_var = base_var[key] %}
        {% endfor %}
    {% endif %}

    {{ log(base_var, info=True) }}
{% endmacro %}