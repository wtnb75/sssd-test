#! /bin/sh

cd $(dirname $0)

slapd -u ldap -h "ldapi:/// ldap:///"

for i in 1/*.ldif ; do
  ldapadd -H ldapi:/// -f $i
done
pkill slapd

slapd -u ldap -h "ldapi:/// ldap:///"

for i in 2/*.ldif ; do
  ldapadd -H ldapi:/// -f $i
done

sleep infinity
