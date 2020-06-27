#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.31.0.100 terraform.example.com terraform
172.31.0.110 openstack.example.com openstack
172.31.0.102 worker2.example.com worker2
EOF


# Install Openstack
echo "[TASK 2] Install Base Packages"
apt-get update >/dev/null 2>&1
sudo snap install microstack --classic --beta
sudo sleep 10
sudo microstack.init --auto

# Credentials
echo "To interact with your OpenStack via the web GUI visit http://172.31.0.110/ and log in with"
echo "username: admin, password: keystone"


# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc
