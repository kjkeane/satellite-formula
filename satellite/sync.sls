include:
  - .install

{% for id, organizations in salt['pillar.get']('satellite:organizations', {}).items() %}
{% set vals = organization.get('sync_plans', {}) %}
{% for plan, planargs in vals %}
satellite_create_sync_plan:
  cmd.wait:
    - name: |
      hammer sync-plan create
      --name '{{ planargs.get('name', '') }}'
      --organization '{{ planargs.get('organization', salt['pillar.get']('satellite:organization') }}'
      --interval {{ planargs.get('interval', 'daily') }}
      --enabled true
    - require:
      - satellite_installer

satellite_apply_sync_plan:
  cmd.wait:
    - name: |
      hammer production set-sync-plan
      --name '{{ planargs.get('name', '') }}'
      --sync-plan '{{ planargs.get('name', '') }}'
      --organization '{{ planargs.get('organization', salt['pillar.get']('satellite:organization') }}'
    - require:
      - satellite_create_sync_plan
{% endfor %}
{% endfor %}
