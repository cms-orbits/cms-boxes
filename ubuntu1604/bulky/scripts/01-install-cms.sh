#!/bin/bash -ex


installCMS () {
  # TODO: Refactor this to be parametrizable
  readonly AS_USER=${1-ubuntu}
  # There isn't a 1.4-rc1 yet, so I'm going to stick to this commit
  readonly CMS_REVISION=${2-f7ebce619b886cbdd4620123889860a908f4ca65}

  cd /home/${AS_USER}

  # Change to non root user, otherwise the "isolate" compilation won't work
  su "$AS_USER" -c 'git clone https://github.com/cms-dev/cms.git cms-src'

  cd /home/${AS_USER}/cms-src
  su "$AS_USER" -c "git checkout ${CMS_REVISION} && git submodule update --init"
  ./prerequisites.py install -y

  cd /home/${AS_USER}/cms-src
  pip2 install -r requirements.txt

  # HEADS UP: Ignore setup.py install warning while extracting cms-1.4.dev0-py2.7.egg
  python2 setup.py install
}

installCMS "$@"
