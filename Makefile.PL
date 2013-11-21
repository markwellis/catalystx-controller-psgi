use inc::Module::Install;

all_from('lib/CatalystX/Controller/PSGI.pm');

requires 'Moose';
requires 'namespace::autoclean';
requires 'Catalyst' => '5.90050';

test_requires 'Test::More' => '0.94';
test_requires 'FindBin';
test_requires 'Catalyst::Test';
test_requires 'Plack::Response';
test_requires 'Plack::App::File';

resources(
    'bugtracker'  => 'https://github.com/n0body-/catalystx-controller-psgi/issues',
    'repository'  => 'https://github.com/n0body-/catalystx-controller-psgi.git',
);

auto_install;
WriteAll;
