#!/bin/bash -ex

readonly user=${DEFAULT_USER-$(whoami)}
readonly SRCDIR=/home/$user/provision-files

setupOrbitsService() {
  mkdir -p /opt/compose/$1
  cp ${SRCDIR}/docker-compose/orbits-$1.yml /opt/compose/$1/docker-compose.yml
}

fetchFrontendAssets() {
  local version=${1-0.2.1}
  local nginx_dir=${2-/opt/compose/nginx/static}
  local tmp=$(mktemp -d '/tmp/XXXXX')

  curl -s -o $tmp/frontend.tar.gz -L https://github.com/joelgtsantos/cms-frontend/releases/download/$version/build.tar.gz
  tar -xzf $tmp/frontend.tar.gz --strip-components 1 -C $nginx_dir
}

# CMS Orbits images/services
docker image pull joelgtsantos/cms-triton:latest
docker image pull joelgtsantos/cmsusers:latest
docker image pull cmsorbits/cms-naiad:0.1.0
docker image pull cmsorbits/cms-galatea:0.2.0
docker image pull cmsorbits/cms-sao:0.5.2
docker image pull cmsorbits/cms-neso:0.3.3

readonly orbits="triton \
  users \
  galatea \
  sao \
  neso \
  naiad"

for container in ${orbits[@]}; do
  setupOrbitsService $container
  systemctl enable compose@$container
  systemctl start compose@$container
done

# CMS Orbits frontend
fetchFrontendAssets 0.2.1 /opt/compose/nginx/static