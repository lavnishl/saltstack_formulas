# http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
# dont think can use http link directly , as we need to accept licence b4 downloading
java_package:
  archive:
    - extracted
    - name: /opt/
    - source: salt://jdk8/jdk-8u65-linux-x64.tar.gz
    - source_hash: md5=196880a42c45ec9ab2f00868d69619c0
    - archive_format: tar
    - if_missing: /opt/jdk1.8.0_65/

java_symlink:
  file.symlink:
    - name: /opt/java
    - target: jdk1.8.0_65
    - require:
      - archive: java_package

JAVA_HOME:
  file.append:
    - name: /home/tomcatuser/.bashrc
    - text: export JAVA_HOME="/opt/java"
    - text: export PATH=$JAVA_HOME/bin:$PATH

# GLOBAL_JAVA_HOME:
#  file.append:
#    - name: /etc/profile.d/myglobalenvvariables.sh
#    - text: export JAVA_HOME="/opt/java"

#install_java_alternative:
#  alternatives.install:
#    - name: java
#    - link: /usr/bin/java
#    - path: /opt/java/bin/java
#    - priority: 1
#    - require:
#      - file: java_symlink

#set_java_alternative:
#  alternatives.set:
#    - name: java
#    - path: /opt/java/bin/java
#    - require:
#      - alternatives: install_java_alternative
