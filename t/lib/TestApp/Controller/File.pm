package TestApp::Controller::File;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Controller::PSGI'; }

use Plack::App::Directory;

my $app_directory = Plack::App::Directory->new(root => TestApp->path_to('../../..'))->to_app;

sub call {
    my ( $env ) = @_;

    $app_directory->( $env );
}

1;
