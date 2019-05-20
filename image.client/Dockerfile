FROM joshhsoj1902/docker-wait-for-it:0.0.3 AS wfi

FROM centos:centos7
COPY --from=wfi /wait-for-it.sh /wait-for-it.sh
RUN yum -y install sssd dstat iotop lsof strace tdb-tools ldb-tools && \
    yum clean all && \
    chmod +x /wait-for-it.sh
