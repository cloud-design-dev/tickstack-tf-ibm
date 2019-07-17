- hosts: instances
  become: true
  vars:
    chronograf_public_url: "http://${fqdn}/"
    influxdb_admin_pw: "${admin_pass}"
    influxdb_chronograf_pw: "${chronograf_pw}"
    influxdb_telegraf_pw: "${telegraf_pw}"
    influxdb_chronograf_oauth_secret: "${salt}"
    influxdb_chronograf_oauth_github_secret: "${chron_oauth_secret}"
    influxdb_chronograf_oauth_github_id: "${chron_oauth_id}"
    influxdb_chronograf_oauth_github_org: "${gh_org}"
    telegraf_agent_version: "1.11.2"
  roles:
    - { role: mediapeers.ansible-role-influxdb}
    - { role: dj-wasabi.telegraf }
