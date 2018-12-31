include:
  - .registration

satellite_package:
  pkg.installed:
    - name: satellite

{% for install in salt['pillar.get']('satellite:install', {}).items %}
satellite_installer:
  cmd.wait:
    - name: |
        satellite-installer --scenario satellite
        --foreman-initial-organization "{{ install.get('organization', '') }}"
        --foreman-initial-location "{{ install.get('location', '') }}"
        --foreman-admin-username {{ install.get('username', 'admin') }}
        --foreman-admin-password {{ install.get('password', '') }}
        --foreman-proxy-dns-managed={{ install.get('dns-managed', 'false') }}
        --foreman-proxy-dhcp-managed={{ install.get('dhcp-managed', 'false') }}
        --certs-server-cert {{ install.get('cert', '/root/sat_cert/satellite_cert.pem') }}
        --certs-server-cert-req {{ install.get('csr', '/root/sat_cert/satellite_csr.pem') }}
        --certs-server-key {{ install.get('key', '/root/sat_cert/satellite_key.pem') }}
        --certs-server-ca-cert {{ install.get('ca_cert', '/root/sat_cert/ca_cert_bundle.pem') }}
      - require:
        - redhat_registration
{% endfor %}
