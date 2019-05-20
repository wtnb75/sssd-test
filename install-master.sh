#! /bin/sh
set -x

yum -y install openldap-servers openldap-clients nss-util openssl openssh-ldap

slapd -u ldap -h "ldapi:/// ldap:///"

for i in /vagrant/master/1/*.ldif; do
  ldapadd -H ldapi:/// -f $i
done
pkill slapd

slapd -u ldap -h "ldapi:/// ldap:///"

for i in /vagrant/master/2/*.ldif; do
  ldapadd -H ldapi:/// -f $i
done

# pkill slapd
# systemctl start slapd
