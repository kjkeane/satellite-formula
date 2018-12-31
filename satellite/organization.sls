include:
  - .install

{% for id, organization in salt['pillar.get']('satellite:organizations', {}).items() %}
{{ id }}:
  cmd.wait:
    - name: |
      hammer organization create
      --name '{{ organization.get('name', '') }}'
      --label '{{ organization.get('label', '') }}'
      --description '{{ organization.get('description', '') }}'
    - require:
      - satellite_installer
{% endfor %}

{% for id, location in salt['pillar.get']('satellite:locations', {}).items() %}
{{ id }}:
  cmd.wait:
    - name: |
      hammer location add-organization
      --name '{{ location.get('name', '') }}'
      --organization '{{ location.get('organization', '') }}'
    - require:
      - satellite_installer
{% endfor %}
