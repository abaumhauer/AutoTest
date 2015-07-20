use strict;
use warnings;

use AutoTest;

my $app = AutoTest->apply_default_middlewares(AutoTest->psgi_app);
$app;

