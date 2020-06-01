#!/bin/bash -ex

readonly user=${DEFAULT_USER-$(whoami)}

installCMS () {
  # TODO: Refactor this to be parametrizable
  readonly AS_USER=${1-$user}
  # Latest commit in Jan 2018, which supports C# and Rust
  # after that are too many breaking changes
  readonly CMS_REVISION=${2-d930038459287d5d9858c16ee94340d248c37130}

  cd /home/${AS_USER}

  # Change to non root user, otherwise the "isolate" compilation won't work
  su "$AS_USER" -c 'git clone https://github.com/cms-dev/cms.git cms-src'

  cd /home/${AS_USER}/cms-src
  su "$AS_USER" -c "git checkout ${CMS_REVISION} && git submodule update --init"
  ./prerequisites.py install -y

  cd /home/${AS_USER}/cms-src
  pip2 install -r requirements.txt
  pip2 install psycopg2-binary

  # HEADS UP: Ignore setup.py install warning while extracting cms-1.4.dev0-py2.7.egg
  python2 setup.py install
}

installCMS "$@"
