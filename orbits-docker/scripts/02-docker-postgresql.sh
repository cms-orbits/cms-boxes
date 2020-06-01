#!/bin/bash -ex

readonly user=${DEFAULT_USER-$(whoami)}
readonly SRCDIR=/home/$user/provision-files

setupConf() {
  mkdir -p /opt/compose/postgresql/scripts
  cp ${SRCDIR}/postgresql/init-cms-database.sh /opt/compose/postgresql/scripts/
  cp ${SRCDIR}/docker-compose/postgresql.yml /opt/compose/postgresql/docker-compose.yml
}

docker image pull postgres:9.5

setupConf
systemctl enable compose@postgresql
systemctl start compose@postgresql
