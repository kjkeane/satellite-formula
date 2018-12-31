satellite_packages:
  pkg.installed:
    - pkgs:
      - wget
      - git
      - net-tools
      - bash-completion
      - screen
      - tmux
      - vim-enhanced
      - sos

ntp_package:
  pkg.installed:
    - name: ntp
  service.running:
    - name: ntpd
    - require:
      - pkg: ntp_package
