FROM abaumhauer/perl:22
MAINTAINER Andrew Baumahuer <andy@baumhauer.us>
WORKDIR /var/tmp
RUN curl -L http://cpanmin.us | /usr/bin/perl - -fn App::cpanminus && rm -rf /root/.cpanm/work/*
ENTRYPOINT [ "/usr/bin/perl" ]
CMD        [ "/bin/bash" ]
