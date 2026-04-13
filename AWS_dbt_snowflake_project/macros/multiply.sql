
{% macro multiply(x, y, precision, extras=[]) -%}
    ROUND({{ x }} * {{ y }}, {{ precision }})
    {% for col in extras %}
        + {{ col }}
    {% endfor %}
{%- endmacro %}