#!/bin/bash -ex

readonly user=${DEFAULT_USER-$(whoami)}
readonly SRCDIR=/home/$user/provision-files

setupConf() {
  mkdir -p /opt/compose/mongodb/scripts
  cp ${SRCDIR}/mongodb/init-orbits.js /opt/compose/mongodb/scripts/
  cp ${SRCDIR}/docker-compose/mongodb.yml /opt/compose/mongodb/docker-compose.yml
}

setupConf
systemctl enable compose@mongodb
systemctl start compose@mongodb
