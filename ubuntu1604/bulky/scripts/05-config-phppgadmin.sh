#!/bin/bash -ex

readonly SRCDIR=/home/ubuntu/provision-files

mv /etc/php/7.0/fpm/pool.d/www.conf{,.back}
cp ${SRCDIR}/php-fpm/pool.d/www.conf /etc/php/7.0/fpm/pool.d/www.conf

systemctl restart php7.0-fpm
