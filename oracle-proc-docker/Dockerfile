FROM oraclelinux:8

ARG ORACLE_PRECOMP=oracle-instantclient-precomp-21.4.0.0.0-1.el8.x86_64.rpm
ENV PATH=$PATH:/usr/lib/oracle/21/client64/bin \
    LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib

RUN dnf -y install gcc make \
    && rm -rf /var/cache/dnf

RUN dnf -y install oracle-instantclient-release-el8 \
    && dnf -y install oracle-instantclient-basic oracle-instantclient-devel oracle-instantclient-sqlplus oracle-instantclient-tools \
    && rm -rf /var/cache/dnf

WORKDIR /tmp/
COPY $ORACLE_PRECOMP ./

RUN dnf -y install $ORACLE_PRECOMP \
    && rm -rf /var/cache/dnf \
    && rm -rf /tmp/* \
    && sed -i 's/\$ORACLE_HOME\/sdk\/include/\/usr\/include\/oracle\/21\/client64/g' /usr/lib/oracle/21/client64/lib/precomp/admin/pcscfg.cfg

COPY procdemo.pc demo_proc_ic.mk ./

CMD [ "sqlplus", "-v" ]
