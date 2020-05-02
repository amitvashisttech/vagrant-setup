#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.42.42.100 master.example.com master
172.42.42.101 worker1.example.com worker1
172.42.42.102 worker2.example.com worker2
EOF


# Stop and disable firewalld
echo "[TASK 2] Stop and Disable firewalld"
systemctl disable firewalld >/dev/null 2>&1
systemctl stop firewalld



# Install Kubernetes
echo "[TASK 9] Install Base Packages SSHPASS & Python"
apt-get update >/dev/null 2>&1
#apt-get install -y ansible sshpass python wget default-jdk >/dev/null 2>&1
apt-get install -y  sshpass python wget >/dev/null 2>&1


# Enable ssh password authentication
echo "[TASK 11] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
#echo "[TASK 12] Set root password"
#echo root:kubeadmin | /usr/sbin/chpasswd >/dev/null 2>&1

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc