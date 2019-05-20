FROM joshhsoj1902/docker-wait-for-it:0.0.3 AS wfi

FROM centos:centos7 AS build
RUN yum -y install rpm-build yum-utils libldb-devel automake autoconf gettext libtool gettext-devel popt-devel libdhash-devel libcollection-devel libini_config-devel pam-devel openldap-devel pcre-devel krb5-devel c-ares-devel bind-utils glib2-devel dbus-devel libxslt-devel xml-common doxygen libselinux-devel libsemanage-devel keyutils-libs-devel pkgconfig diffstat findutils libnl3-devel systemd-devel cifs-utils-devel libnfsidmap-devel samba4-devel samba-winbind libsmbclient-devel systemtap-sdt-devel jansson-devel http-parser-devel curl-devel libuuid-devel docbook-style-xsl nss-devel make curl git

#RUN curl -L https://github.com/SSSD/sssd/archive/master.tar.gz | tar xfz - -C /
#RUN git clone --depth 1 https://github.com/SSSD/sssd /sssd-master
ADD master.tar.gz /
WORKDIR /sssd-master
RUN autoreconf -ivf
RUN ./configure --without-python2-bindings --without-python3-bindings
RUN make
RUN make install

FROM centos:centos7
COPY --from=wfi /wait-for-it.sh /
COPY --from=build /usr/local/ /usr/local/
RUN yum -y install libtalloc libldb libdhash libini_config c-ares libcollection samba-client-libs jansson libsmbclient libnl3 && \
    yum -y install sssd dstat iotop lsof strace tdb-tools ldb-tools && \
    yum clean all && \
    chmod +x /wait-for-it.sh
