#! /bin/sh

yum -y install sssd dstat iotop lsof strace tdb-tools

install -c -m 600 -o root -g root /vagrant/client/sssd.conf /etc/sssd/sssd.conf
sed -i -e 's,master,192.168.3.10,g;' /etc/sssd/sssd.conf
systemctl start sssd
