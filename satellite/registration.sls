{% set username = ['pillar.get']('satellite:register:username', 'admin') %}
{% set password = ['pillar.get']('satellite:register:password', '') %}

redhat_registration:
  cmd.run:
    - name: |
      subscription-manager register
      --username {{ username }}
      --password {{ password }}
      --auto-attach
