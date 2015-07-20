package AutoTest;
use Moose;
use namespace::autoclean;
use Catalyst::Runtime 5.80;
use RapidApp 1.0000;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory
#RapidApp::AuthCore
#  Authentication
#  Session
#  Session::State::Cookie
#  Session::Store::File
  #Authentication
  #Session
  #Session::State::Cookie
  #Session::Store::File
  #SmartURI

#  -Debug
#  Static::Simple
use Catalyst qw /
  -Debug
  ConfigLoader
/;

with (
  'Catalyst::Plugin::AutoAssets',
  'Catalyst::Plugin::RapidApp::RapidDbic',
  'Catalyst::Plugin::RapidApp::NavCore',
  'Catalyst::Plugin::RapidApp::CoreSchemaAdmin',
  'Catalyst::Plugin::RapidApp::TabGui'
);

extends 'Catalyst';

our $VERSION = 0.1000;
our $TITLE   = 'AutoTest v' . $VERSION;

# This is used to allow greater recursion inside the debugger since
# pathing algorithms use recursion to track VLANs.  It can't be
# debugged without it.

$DB::deep = 10000;

# If we need to debug SQL/DBIC calls to the console, enable this
#set $ENV{DBIC_TRACE_PROFILE} = console;

my $tpl_regex = '^site\/';

__PACKAGE__->config(
  'name' => 'AutoTest',

  # Disable deprecated behavior needed by old applications
  'disable_component_resolution_regex_fallback' => 1,
  'enable_catalyst_header'                      => 1,   # Send X-Catalyst header
  'use_request_uri_for_path'                    => 1,   # Use REQUEST_URI versus PATH_INFO for nginx
  'Plugin::ConfigLoader'                        => {
    'file'   => __PACKAGE__->path_to('etc'),
    'driver' => { 'General' => { '-InterPolateEnv' => 1 } }
  },

  # The general 'RapidApp' config controls aspects of the special components that
  # are globally injected/mounted into the Catalyst application dispatcher:
  'RapidApp' => {
    ## To change the root RapidApp module to be mounted someplace other than
    ## at the root (/) of the Catalyst app (default is '' which is the root)
    module_root_namespace => '',

    ## To load additional, custom RapidApp modules (under the root module):
    #load_modules => { somemodule => 'Some::RapidApp::Module::Class' }
  },

  'Plugin::RapidApp::NavCore' => {},

  # Override the table class so this application can extend and change behaviors
  'Plugin::RapidApp::RapidDbic' => { table_class => 'AutoTest::Modules::TableBase', },

  'Plugin::RapidApp::TabGui' => {
    title              => $TITLE,
    nav_title          => 'Reports',
    nav_title_iconcls  => 'icon-bb-logo',
    navtree_init_width => 210,

    # banner_template => 'banner.html',
    # dashboard_url => '/tple/site/dashboard.md',
    template_navtree_regex => $tpl_regex
  },

  'Controller::RapidApp::Template' => {
    default_template_extension => 'html',
    access_params              => {
      writable_regex     => $tpl_regex,
      creatable_regex    => $tpl_regex,
      deletable_regex    => $tpl_regex,
      external_tpl_regex => '^site\/',
    }
  },

  'Model::RapidApp' => {
    root_template_prefix => 'site/public/page/',
    root_template        => 'site/public/page/home'
  },

  'Controller::RapidApp::Template' => {
    default_template_extension => 'html',
    access_params              => {
      writable_regex     => $tpl_regex,
      creatable_regex    => $tpl_regex,
      deletable_regex    => $tpl_regex,
      external_tpl_regex => '^site\/',
    }
  }
);

# Start the application
__PACKAGE__->setup();

=head1 NAME

AutoTest - Catalyst/RapidApp based application

=head1 SYNOPSIS

	script/autotest_server.pl

=head1 DESCRIPTION

Provides a web based front end (MVC) to the project called AutoTest.

=head1 SEE ALSO

L<RapidApp>, L<Catalyst>

=head1 AUTHOR

Andrew Baumhauer <andy.baumhauer@interactivedata.com>

=head1 LICENSE

=cut

1;
