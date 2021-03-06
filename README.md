# CMS in Vagrant boxes

A [CMS](https://github.com/cms-dev/cms) (Programming Contest Management System)
up and running for development purposes in vagrant boxes.

To organize a *classic*
[programming contest](https://en.wikipedia.org/wiki/Competitive_programming)
could be challenging, from participant enrollment to code evaluation, even using
specialized software like contest management systems, you could stumble with
other problem, as for example to provision and scale such complex solutions.

This repository aims to provide an easier way to spin up a
[CMS](https://github.com/cms-dev/cms) programming contest platform using several
provision strategies(from shell scripts in just one host to Ansible in multiples
ones). Bear in mind that everything regarding to CMS configuration comes from
the [CMS manual](http://cms.readthedocs.io/en/latest/index.html).

## Usage

First of all you need
[Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Downloads) and
[Vagrant](https://www.vagrantup.com/docs/installation/) installed in your host
machine, then you can clone this repository and use any of the provisioning
strategy **flavors** and cluster topology.

For example to spin up a **all-in-one (bulky) instance** you need to:

```shell
git clone https://github.com/cms-orbits/cms-boxes.git
cd cms-boxes/bulky
vagrant up
```

### Flavors

Each *flavor* is determined by the tools that are being used to provision the
environment and the cluster topology, the ones you could find in this
repository are:

- All-in-one host, shell script provision -> `bulky`
- Multiple hosts with Docker containers, shell script provision -> `orbits-docker`

**Note**: All the virtual machines created by this project makes use of the
[Ubuntu](https://app.vagrantup.com/ubuntu) public Vagrant box image. You are
free to change the Linux distribution and Box version as you please, but bear in
mind that some packages may change their names and configurations from Linux
distribution to other, therefore, the provisioning scripts should not work as
expected.

## Credits

- [CMS](https://github.com/cms-dev/cms) by [CMS-dev community](https://github.com/cms-dev/cms/blob/master/AUTHORS.txt)
- [CMS manual](http://cms.readthedocs.io/en/latest/index.html) by [CMS-dev community](https://github.com/cms-dev/cms/blob/master/AUTHORS.txt)
