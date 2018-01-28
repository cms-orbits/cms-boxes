#!/bin/bash -ex

readonly AS_USER=${1-ubuntu}

# Adds cmsdb password and runs the migrations
migrateSchema() {
  local dbpswd=${1-notsecure}
  cd /home/${AS_USER}

  sed -i "s/your_password_here/${dbpswd}/" provision-files/cms-config/cms.conf

  set -x
  cp provision-files/cms-config/*.conf cms-src/config/

  cd /home/${AS_USER}/cms-src
  ./prerequisites.py install -y

  cmsInitDB
}

# Create First Admin user
initialAdmUsr() {
  local adminpswd=${2-admin}
  cmsAddAdmin admin --password "$adminpswd"
}

# Create con_test
initialContest() {
  cd /home/${AS_USER}
  su "$AS_USER" -c 'git clone https://github.com/cms-dev/con_test.git cms-dummy-contest'

  # Create three dummy Users
  for i in $(seq 1 3); do cmsAddUser -p "p${i}" aname alastname "u${i}"; done;

  # Import dummy contest with the given "task"
  cmsImportContest --loader italy_yaml --import-task cms-dummy-contest/
}

migrateSchema "$@"
initialAdmUsr "$@"
initialContest "$@"
