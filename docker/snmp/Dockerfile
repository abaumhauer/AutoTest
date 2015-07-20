FROM abaumhauer/cpanm:latest
MAINTAINER Andrew Baumahuer <andy@baumhauer.us>
ENV VERSION=5.7.3
COPY net-snmp-$VERSION/ ./net-snmp-$VERSION/
WORKDIR /var/tmp/net-snmp-$VERSION
RUN dnf -y install file \
    && ./configure --disable-manuals \
       --with-default-snmp-version="2" \
       --with-sys-contact="GNOC@interactivedata.com" \
       --with-sys-location="docker" \
       --with-logfile="/var/log/snmpd.log" \
       --with-persistent-directory="/var/net-snmp" \
    && make && make install && rm -rf /var/tmp/net-snmp-$VERSION \
    && dnf -y clean all ;
COPY mibs/ /usr/local/share/snmp/mibs/
COPY snmp.conf /usr/local/etc/snmp/
ENTRYPOINT ["/bin/bash"]
