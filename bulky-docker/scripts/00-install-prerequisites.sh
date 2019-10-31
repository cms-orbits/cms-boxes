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

  # Contest Languages (Workers' dependencies)
  # apt-get install -y  gcc python python3 openjdk-8-jdk openjdk-11-jdk \
  #                     php7.2-cli php7.2-fpm fpc \
  #                     haskell-platform rustc mono-mcs
}

installReqs "$@"
