package AutoTest::Exceptions;

use Exception::Class (
  'RPC'           => { 'description' => 'RPC related exception' },
  'DeepRecursion' => { 'description' => 'Deep recursive call exception' }
);

1;
