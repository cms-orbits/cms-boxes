#!/bin/bash -ex

readonly user=${DEFAULT_USER-$(whoami)}
readonly host_ip=$(hostname -I | cut -d' ' -f1)
readonly dbpswd=${2-notsecure}

# Adds cmsdb password and runs the migrations
migrateSchema() {
  docker  container run --rm -e CMS_DB_PSWD=$dbpswd -e CMS_DB_HOST=$host_ip \
          cmsorbits/cms:20180130 cmsInitDB
}

# Create First Admin user
initialAdmUsr() {
  local adminpswd=${2-admin}
  docker  container run --rm -e CMS_DB_PSWD=$dbpswd -e CMS_DB_HOST=$host_ip \
          cmsorbits/cms:20180130 cmsAddAdmin admin --password "$adminpswd"
}

# Create con_test
initialContest() {
  cd /home/${user}
  git clone https://github.com/cms-dev/con_test.git cms-dummy-contest

  # Create three dummy Users
  for i in $(seq 1 3); do
    docker  container run --rm -e CMS_DB_PSWD=$dbpswd -e CMS_DB_HOST=$host_ip \
            cmsorbits/cms:20180130 cmsAddUser -p "p${i}" aname alastname "u${i}";
  done

  # Import dummy contest with the given "task"
  docker container run --rm -e CMS_DB_PSWD=$dbpswd -e CMS_DB_HOST=$host_ip \
          -v $(pwd)/cms-dummy-contest:/usr/local/src/cms-dummy-contest \
          -w /usr/local/src/ cmsorbits/cms:20180130 \
          cmsImportContest --loader italy_yaml --import-task cms-dummy-contest/
}

migrateSchema "$@"
initialAdmUsr "$@"
initialContest "$@"

docker system prune --force --volumes
