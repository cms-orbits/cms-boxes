#!/bin/bash -ex

readonly user=${DEFAULT_USER-$(whoami)}
readonly SRCDIR=/home/$user/provision-files

setupConf() {
  mkdir -p /opt/compose/rabbitmq
  cp ${SRCDIR}/docker-compose/rabbitmq.yml /opt/compose/rabbitmq/docker-compose.yml
}

setupConf
systemctl enable compose@rabbitmq
systemctl start compose@rabbitmq

