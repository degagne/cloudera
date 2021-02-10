#!/usr/bin/env bash
CLOUDERA_MANAGER_REPO_DIR="cm7/7.1.4/redhat7/yum"

yum -y install httpd telnet wget createrepo yum-utils
systemctl enable httpd
systemctl start httpd
systemctl status httpd

wget "https://archive.cloudera.com/${CLOUDERA_MANAGER_REPO_DIR}/cloudera-manager.repo" -P /etc/yum.repos.d
cd /var/www/html
mkdir -p ${CLOUDERA_MANAGER_REPO_DIR}
reposync -r cloudera-manager
mv cloudera-manager/RPMS ${CLOUDERA_MANAGER_REPO_DIR}
createrepo ${CLOUDERA_MANAGER_REPO_DIR}
wget https://archive.cloudera.com/${CLOUDERA_MANAGER_REPO_DIR}/RPM-GPG-KEY-cloudera -P ${CLOUDERA_MANAGER_REPO_DIR}

sed -i "s/^baseurl=.*/http://bigdataserver-1/${CLOUDERA_MANAGER_REPO_DIR}\//g" /etc/yum.repos.d/cloudera-manager.repo
sed -i "s/^gpgkey=.*/http://bigdataserver-1/${CLOUDERA_MANAGER_REPO_DIR}\/RPM-GPG-KEY-cloudera/g" /etc/yum.repos.d/cloudera-manager.repo
