#!/bin/bash
wget -P /usr/local http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
cd /usr/local || exit
rpm -ivh nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum -y install nginx
systemctl start nginx
systemctl enable nginx
sed -i "3s/server_name  localhost;/server_name  $1;/" /etc/nginx/conf.d/default.conf
sed -i "8a\\        proxy_pass  $2;" /etc/nginx/conf.d/default.conf
nginx -t
systemctl stop nginx
systemctl start nginx