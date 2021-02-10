#!/usr/bin/env bash
CLOUDERA_MANAGER_REPO_DIR="cm7/7.1.4/redhat7/yum"

yum -y install httpd telnet wget createrepo yum-utils
systemctl enable httpd
systemctl start httpd
systemctl status httpd

wget "https://archive.cloudera.com/${CLOUDERA_MANAGER_REPO_DIR}/cloudera-manager.repo" -P "/etc/yum.repos.d"
mkdir -p "/var/www/html/${CLOUDERA_MANAGER_REPO_DIR}"
reposync -r cloudera-manager -p "/var/www/html"
mv "/var/www/html/cloudera-manager/RPMS" "/var/www/html/${CLOUDERA_MANAGER_REPO_DIR}"
createrepo "/var/www/html/${CLOUDERA_MANAGER_REPO_DIR}"
wget "https://archive.cloudera.com/${CLOUDERA_MANAGER_REPO_DIR}/RPM-GPG-KEY-cloudera" -P "/var/www/html/${CLOUDERA_MANAGER_REPO_DIR}"
sed -i 's/https\:\/\/archive\.cloudera\.com/http\:\/\/bigdataserver-1/g' "/etc/yum.repos.d/cloudera-manager.repo"
