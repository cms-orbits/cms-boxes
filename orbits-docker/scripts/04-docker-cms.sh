#!/bin/bash -ex

readonly user=${DEFAULT_USER-$(whoami)}
readonly SRCDIR=/home/$user/provision-files

setupStandard() {
  mkdir -p /opt/compose/$1
  cp ${SRCDIR}/docker-compose/cms-standard.yml /opt/compose/$1/docker-compose.yml
}

setupService() {
  mkdir -p /opt/compose/$1
  cp ${SRCDIR}/docker-compose/$2 /opt/compose/$1/docker-compose.yml
}

docker image pull cmsorbits/cms:20180130

readonly standard_components="cmsAdminWebServer \
  cmsLogService \
  cmsChecker \
  cmsContestWebServer \
  cmsEvaluationService \
  cmsScoringService"

for comp in ${standard_components[@]}; do
  setupStandard $comp
  systemctl enable --now compose@$comp
done

setupService cmsResourceService cms-resource.yml
systemctl enable --now compose@cmsResourceService

setupService cmsWorker cms-worker.yml
systemctl enable --now compose@cmsWorker

setupService cmsProxyService cms-proxy.yml
setupService cmsRankingWebServer cms-ranking.yml






