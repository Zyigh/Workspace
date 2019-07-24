FROM {{ language }}

{% if hasWorkdir %}
WORKDIR /workspace
{% endif %}
ADD / .

{% for step in steps %}
RUN {{ step }}
{% endfor %}

{% if cmd %}
CMD {{ cmd }}
{% endif %}
