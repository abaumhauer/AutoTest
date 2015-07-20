FROM fedora:latest
MAINTAINER Andrew Baumahuer <andy@baumhauer.us>
WORKDIR /var/tmp
# Build the latest stable version of perl into /opt/perl and
# don't make the man pages.  Mount the /lib64 libraries from
# the base system
RUN dnf -y clean all                                               \
    && dnf -y install tar coreutils gcc bison byacc make procps-ng \
    && curl http://www.cpan.org/src/5.0/perl-5.22.0.tar.gz         \
    | gzip -dc | tar xf -                                          \
    && cd perl-5.22.0                                              \
    && ./Configure -de -Dprefix=/usr                               \
       -Dman1dir=none -Dman3dir=none                               \
       -Doptimize='-O3 -march=native -pipe -fPIC'                  \
    && make all install distclean                                  \
    && cd .. && rm -rf perl-5.22.0                                 \
    && dnf -y clean all                                            ;

RUN /usr/bin/h2ph -r -l;
ENTRYPOINT [ "/usr/bin/perl"  ]
CMD        [ "-d", "-E", "42" ]
