#!/bin/bash -ex

readonly user=${DEFAULT_USER-$(whoami)}
readonly SRCDIR=/home/$user/provision-files

installReqs () {
  # Disable installing recommended or suggested packages
  cp ${SRCDIR}/apt-get/no-recommend /etc/apt/apt.conf.d/01-norecommend

  # Refresh repository indexes
  apt-get update

  # Docker engine and postgresql-client
  apt-get install -y docker.io docker-compose

  # Add vagrant to docker group
  usermod -a -G docker vagrant
  usermod -a -G docker ubuntu
}

installReqs "$@"
