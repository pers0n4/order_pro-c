FROM oraclelinux:8

ARG ORACLE_PRECOMP=oracle-instantclient-precomp-21.4.0.0.0-1.el8.x86_64.rpm
ENV PATH=$PATH:/usr/lib/oracle/21/client64/bin

RUN dnf -y install oracle-instantclient-release-el8 \
    && dnf -y install oracle-instantclient-basic oracle-instantclient-devel oracle-instantclient-sqlplus \
    && rm -rf /var/cache/dnf

WORKDIR /tmp/
COPY $ORACLE_PRECOMP ./

RUN dnf -y install $ORACLE_PRECOMP \
    && rm -rf /tmp/*

RUN dnf -y install gcc make \
    && rm -rf /var/cache/dnf

COPY proc.mk procdemo.pc ./

CMD [ "sqlplus", "-v" ]
