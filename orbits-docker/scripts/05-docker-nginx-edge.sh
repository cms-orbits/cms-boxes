#!/bin/bash -ex

readonly user=${DEFAULT_USER-$(whoami)}
readonly SRCDIR=/home/$user/provision-files

setupConf() {
  mkdir -p /opt/compose/nginx/confs
  mkdir -p /opt/compose/nginx/static

  cp ${SRCDIR}/nginx/upstreams-*.conf  ${SRCDIR}/nginx/site-*.conf /opt/compose/nginx/confs
  cp ${SRCDIR}/docker-compose/nginx.yml /opt/compose/nginx/docker-compose.yml
}

setupConf
systemctl enable --now compose@nginx
