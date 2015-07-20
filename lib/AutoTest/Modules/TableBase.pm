package AutoTest::Modules::TableBase;
use Moose;
use namespace::autoclean;
use feature 'switch';
extends 'Catalyst::Plugin::RapidApp::RapidDbic::TableBase';
use RapidApp::Util qw(:all);

sub BUILD {
  my $self = shift;
# Stuff we change during BUILD becomes the new base config....
  $self->apply_extconfig(
    'pageSize' => 20
  );
}
__PACKAGE__->meta->make_immutable;

1;
