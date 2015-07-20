FROM abaumhauer/snmp:latest
MAINTAINER Andrew Baumahuer <andy@baumhauer.us>
WORKDIR /var/tmp
RUN /usr/bin/cpanm -n \
               MooseX::Daemonize \
               RapidApp \
               Term::Size::Any \
    && rm -rf /root/.cpanm/work/*
ENTRYPOINT [ "/usr/bin/perl" ]
CMD        [ "/bin/bash" ]
