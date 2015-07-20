FROM abaumhauer/rapidapp:latest
ENV APP_HOME /opt/app
ENV LOGDIR $APP_HOME/logs
ENV RAPIDAPP_ISSUE99_IGNORE 1
EXPOSE 3000
WORKDIR $APP_HOME
VOLUME [ "$LOGDIR" ]
RUN dnf -y --exclude=perl* install \
                      expat-devel \
                      libdb-devel \
                      ncurses-devel \
                      readline-devel \
                      postgresql-devel \
   && dnf -y clean all
RUN /usr/bin/cpanm -n \
                      Term::ReadLine::Gnu \
                      Term::ReadKey \
                      Log::Log4perl::Catalyst \
                      Catalyst::Plugin::SmartURI \
                      Catalyst::Plugin::Session::Store::File \
                      Graph \
                      Graph::Easy \
                      List::Compare \
                      List::Uniq \
                      RPC::XML::Client \
                      Catalyst::View::JSON \ 
                      Params::Coerce \
                      Cache::Memory \
                      JSON::XS \
                      DBIx::Class::Helper::Row::ToJSON \
                      DBIx::Class::TimeStamp \
                      DBIx::Class::EncodedColumn \
                      TryCatch \
                      SNMP::Info Catalyst::View::Wkhtmltopdf \
                      Cache::Redis  \
                      NetAddr::IP \
                      Catalyst::Controller::ActionRole \
                      URI::SmartURI \
                      Catalyst::Controller::REST \
                      Catalyst::Authentication::Credential::Authen::Simple \
                      Authen::Simple::Passwd \
                      Authen::Simple::LDAP \
                      Catalyst::ActionRole::NoSSL \
                      DBIx::Class::Cursor::Cached \
                      DBD::Pg \
   && rm -rf /root/.cpanm/work/*
COPY script $APP_HOME/script/
COPY .htpasswd $APP_HOME/
COPY etc $APP_HOME/etc/
COPY lib $APP_HOME/lib/
COPY root $APP_HOME/root/
ENTRYPOINT [ "/usr/bin/perl", "-Ilib" ]
CMD [ "script/autotest_server.pl" ]
