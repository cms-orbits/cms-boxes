# CMS in Vagrant boxes

A [CMS](https://github.com/cms-dev/cms) (Programming Contest Management System)
up and running for development purposes in vagrant boxes.

Organizing a [*classic* programming
contest](https://en.wikipedia.org/wiki/Competitive_programming) could be quite
challenging, from participant enrollment to code evaluation, even though there
are many contest management systems dating from 90's that solve the latter
problem, provision them correctly is even harder.

This repository aims to provide you an easier way to spin up a
[CMS](https://github.com/cms-dev/cms) platform (which is a very mature and not
too old), using Vagrant and different ways to provision the environment (plain
old shell scripts or Ansible).

By the way, everything regarding to CMS configuration and installation comes
from the [CMS manual](http://cms.readthedocs.io/en/latest/index.html).

## Usage

First of all you need [Oracle VM
VirtualBox](https://www.virtualbox.org/wiki/Downloads) and
[Vagrant](https://www.vagrantup.com/docs/installation/) installed in your host
machine, then you can clone this repository and use any of the host distribution
and provisioning strategy **flavors**.

For example to spin up  a **simple all-in-one(bulky) instance** you need to:

```shell
git clone https://github.com/jossemarGT/cms-boxes.git
cd cms-boxes/ubuntu1604/bulky
vagrant up
```

### Flavors

From a big all-in-one VM to a virtual local cloud, you only need to move to the
directory flavor you like to use and run `vagrant up`, each flavor
can be customized to suit your needs.

- All-in-one, shell script provision -> `ubuntu1604/bulky`
- Distributed hosts, shell script provision -> TODO
- Distributed hosts, Ansible provision -> TODO

**Note**: All the VM's used within this project derives from [Ubuntu 16.04,
v20170616.0.0](https://atlas.hashicorp.com/ubuntu/boxes/xenial64) public Vagrant
box. You are free to change the Linux distribution and Box version as you
please, but bear in mind that some package may brake, therefore, the
provisioning scripts should not work as expected.

## Credits

- [CMS](https://github.com/cms-dev/cms) by [CMS-dev community](https://github.com/cms-dev/cms/blob/master/AUTHORS.txt)
- [CMS manual](http://cms.readthedocs.io/en/latest/index.html) by [CMS-dev community](https://github.com/cms-dev/cms/blob/master/AUTHORS.txt)
