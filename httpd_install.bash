#!/usr/bin/env bash
yum -y install httpd telnet wget createrepo yum-utils
systemctl enable httpd
systemctl start httpd
systemctl status httpd

cat > /etc/yum.repos.d/cloudera-manager.repo << EOF
[cloudera-manager]
name=Cloudera Manager 7.1.4
baseurl=https://archive.cloudera.com/cm7/7.1.4/redhat7/yum/
gpgkey=https://archive.cloudera.com/cm7/7.1.4/redhat7/yum/RPM-GPG-KEY-cloudera
gpgcheck=1
enabled=1
autorefresh=0

[postgresql10]
name=Postgresql 10
baseurl=https://archive.cloudera.com/postgresql10/redhat7/
gpgkey=https://archive.cloudera.com/postgresql10/redhat7/RPM-GPG-KEY-PGDG-10
enabled=1
gpgcheck=1
EOF

mkdir -p /var/www/html/cm7/7.1.4/redhat7/yum
reposync -r cloudera-manager -p /var/www/html
mv /var/www/html/cloudera-manager/RPMS /var/www/html/cm7/7.1.4/redhat7/yum
createrepo /var/www/html/cm7/7.1.4/redhat7/yum
wget https://archive.cloudera.com/cm7/7.1.4/redhat7/yum/RPM-GPG-KEY-cloudera -P /var/www/html/cm7/7.1.4/redhat7/yum

sed -i 's/https:\/\/archive\.clouder\.com/http:\/\/bigdataserver-1/g' /etc/yum.repos.d/cloudera-manager.repo
