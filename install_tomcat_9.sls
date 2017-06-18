include:
  - install_jdk8

tomcat-server:
  archive:
    - extracted
    - name: /opt/
    - source: salt://tomcat/apache-tomcat-9.0.0.M1.tar.gz
    - source_hash: md5=e794b1c8a4d1427db42b3cc033e0ba2e
    - archive_format: tar
    - if_missing: /opt/apache-tomcat-9.0.0.M1/

tomcat_symlink:
  file.symlink:
    - name: /opt/tomcat
    - target: apache-tomcat-9.0.0.M1
    - require:
      - archive: tomcat-server

configure_tomcat_salt_module:
  file.managed:
    - source: salt://tomcat/tomcat-users-for-salt-module.xml
    - name: /opt/tomcat/conf/tomcat-users.xml 
    - require:
      - file: tomcat_symlink

copy_startup_script_with_java_home:
  file.managed:
    - source: salt://tomcat/startup_with_java_home.sh
    - name: /opt/tomcat/bin/startup.sh
    - require:
      - file: configure_tomcat_salt_module

tomcat_server_start_direct:
  cmd.run:
    - name: /opt/tomcat/bin/startup.sh
    - unless: 'ps -ef | grep apache.catalina.startup.Bootstra[p]'
    - require:
      - file: copy_startup_script_with_java_home