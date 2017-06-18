include:
  - install_tomcat_9

{% set app_version = salt['pillar.get']('appversion') %}
echo_app_version:
  cmd.run:
    - name : "echo 'deploying application with version = {{ app_version }}'"

deploy_war:
  tomcat.war_deployed:
    - name: /order-management
    - war: salt://application/order-management.war
    - force: True
    - require:
      - file: /opt/tomcat
