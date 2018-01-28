#!/bin/bash -ex

readonly SRCDIR=/home/ubuntu/provision-files

installReqs () {
  # Disable installing recommended or suggested packages
  cp ${SRCDIR}/apt-get/no-recommend /etc/apt/apt.conf.d/01-norecommend

  # Refresh repository indexes
  apt-get update

  # Base dependencies and libs
  apt-get install -y  build-essential gettext python2.7 python-dev \
                      iso-codes shared-mime-info cgroup-lite stl-manual \
                      python-pip libpq-dev libyaml-dev libffi-dev libcups2-dev \
                      libcap-dev

  # Database
  apt-get install -y postgresql postgresql-client

  # Contest Languages
  apt-get install -y  openjdk-8-jre openjdk-8-jdk gcj-jdk \
                      php7.0-cli php7.0-fpm fpc \
                      haskell-platform rustc mono-mcs

  # Update pip
  pip install --force-reinstall -U setuptools
  pip install --force-reinstall -U pip

  # Optional: HTTP proxy, database management UI
  apt-get install -y nginx phppgadmin

  # I'm  removing the Printing service dependencies
  # apt-get install -y texlive-latex-base a2ps
}

installReqs "$@"
