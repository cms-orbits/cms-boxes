#!/bin/bash -ex

readonly user=${DEFAULT_USER-$(whoami)}
readonly SRCDIR=/home/$user/provision-files

setupOrbitsService() {
  mkdir -p /opt/compose/$1
  cp ${SRCDIR}/docker-compose/orbits-$1.yml /opt/compose/$1/docker-compose.yml
  cp ${SRCDIR}/docker-compose/orbits-overrides.yml /opt/compose/$1/docker-compose.override.yml
}

setupOrbitsTriton() {
  mkdir -p /opt/compose/triton/conf

  cp ${SRCDIR}/docker-compose/orbits-triton.yml /opt/compose/triton/docker-compose.yml
  cp ${SRCDIR}/docker-compose/orbits-overrides.yml /opt/compose/triton/docker-compose.override.yml

  cp ${SRCDIR}/envoy/api-gateway.yml /opt/compose/triton/conf/api-gateway.yml

  systemctl enable --now compose@$container
}

fetchFrontendAssets() {
  local version=${1-0.2.2}
  local nginx_dir=${2-/opt/compose/nginx/static}
  local tmp=$(mktemp -d '/tmp/XXXXX')

  curl -s -o $tmp/frontend.tar.gz -L https://github.com/joelgtsantos/cms-frontend/releases/download/$version/build.tar.gz
  tar -xzf $tmp/frontend.tar.gz --strip-components 1 -C $nginx_dir
}

# CMS Orbits images/services
docker image pull cmsorbits/cms-users:1.2
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
  systemctl enable --now compose@$container
done

# CMS Orbits API Gateway
setupOrbitsTriton

# CMS Orbits frontend
fetchFrontendAssets 0.2.2 /opt/compose/nginx/static
