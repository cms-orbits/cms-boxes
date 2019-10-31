#!/bin/bash -ex

readonly user=${DEFAULT_USER-$(whoami)}
readonly SRCDIR=/home/$user/provision-files

createHier() {
  mkdir -p /opt/compose
  chown $user:$user -R /opt/compose
}

installDockerComposeServiceTemplate () {
  local HOST_IP=$(hostname -I | cut -d' ' -f1)
  sed -i "s/127.0.0.1/$HOST_IP/" ${SRCDIR}/systemd/compose@.service
  cp ${SRCDIR}/systemd/compose@.service /etc/systemd/system/compose@.service
  systemctl daemon-reload
}

createHier
installDockerComposeServiceTemplate

