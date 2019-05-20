# note

it was misconfiguration. [client/sssd.conf](client/sssd.conf) invalidate cache every seconds.

```
[domain/LDAP]
entry_cache_timeout = 1
ldap_sudo_full_refresh_interval = 1
ldap_sudo_smart_refresh_interval = 1
```

# LDAP + SSSD test

- chmod 600 client/sssd.conf
- docker-compose build
- docker-compose up -d
- docker exec client id user1
  - found
- docker exec client dstat
  - continuous disk write (80-100KB/s)
  - process `sssd_be` writes to /var/lib/sss/db/cache_LDAP.ldb
- compare old/new data
  - docker exec client ldbsearch -H /var/lib/sss/db/cache_LDAP.ldb > a
  - sleep 1
  - docker exec client ldbsearch -H /var/lib/sss/db/cache_LDAP.ldb > b
  - diff -u a b

## test on Fedora

- docker-compose -f docker-compose.yml -f docker-compose.fedora.yml build
- docker-compose -f docker-compose.yml -f docker-compose.fedora.yml up -d
- docker exec client dstat
- compare old/new data
  - docker exec client ldbsearch -H /var/lib/sss/db/cache_LDAP.ldb > a
  - sleep 1
  - docker exec client ldbsearch -H /var/lib/sss/db/cache_LDAP.ldb > b
  - diff -u a b

## test on HEAD

- docker-compose -f docker-compose.yml -f docker-compose.head.yml build
- docker-compose -f docker-compose.yml -f docker-compose.head.yml up -d
- docker exec client dstat
- compare old/new data
  - docker exec client ldbsearch -H /usr/local/var/lib/sss/db/cache_LDAP.ldb > a
  - sleep 1
  - docker exec client ldbsearch -H /usr/local/var/lib/sss/db/cache_LDAP.ldb > b
  - diff -u a b

