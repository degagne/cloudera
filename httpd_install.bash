#!/usr/bin/env bash
yum -y install httpd telnet wget createrepo yum-utils
systemctl enable httpd
systemctl start httpd
systemctl status httpd

mkdir -p /var/www/html/cloudera-repos
wget --recursive --no-parent --no-host-directories https://archive.cloudera.com/cdh7/7.1.4/parcels/ -P /var/www/html/cloudera-repos
chmod -R ugo+rX /var/www/html/cloudera-repos/cdh7
