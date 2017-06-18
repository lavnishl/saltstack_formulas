install_rvm:
  cmd.run:
    - name: curl -sSL https://get.rvm.io | bash
    - user: root
    - unless: /home/rvm/.rvm/bin/rvm --version

ruby-2.2.4:
  rvm.installed:
    - default: True

set_ruby:
  cmd.run:
    - name: 'source /etc/profile.d/rvm.sh; rvm use 2.2.4 -- default'
    - shell: /bin/bash
    - stateful: False
    - require:
      - rvm: ruby-2.2.4
    - unless: 'rvm current | grep 2.2.4'

rails:
  gem.installed:
    - name: serverspec
    - require:
      - rvm: ruby-2.2.4
