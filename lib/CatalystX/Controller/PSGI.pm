package CatalystX::Controller::PSGI;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

my @_psgi_actions;
after 'register_actions' => sub {
    my ( $self, $c ) = @_;

    my $class = $self->catalyst_component_name;
    my $namespace = $self->action_namespace( $c );

    if ( my $app = $self->can('call') ){
        push @_psgi_actions, {
            name    => 'call',
            path    => '',
            class   => ref $self,
            app     => $app,
        };
    }

    foreach my $psgi_action ( @_psgi_actions ){
        next if ( $psgi_action->{class} ne $class ) || $psgi_action->{registered};

        my $reverse = "${namespace}/" . $psgi_action->{path};

        my $action = $self->create_action(
            name        => $psgi_action->{name},
            reverse     => $reverse,
            namespace   => $namespace,
            class       => $class,
            attributes  => {Path => [$reverse]},
            code        => sub {
                my ( $self, $c ) = @_;

                my $env = $c->req->env;

                $env->{PATH_INFO} =~ s|^/$namespace||g;
                $env->{SCRIPT_NAME} = "/$namespace";

                $c->res->from_psgi_response( $psgi_action->{app}->( $env ) );
            },
        );

        $c->dispatcher->register( $c, $action );
        $psgi_action->{registered} = 1;
    }
};

sub mount {
    my ( $class, $path, $app ) = @_;

    $path =~ s|^/||g;
    my $name = (split qr|/|, $path)[-1];

    push @_psgi_actions, {
        name    => $name,
        class   => $class,
        path    => $path,
        app     => $app,
    };
}

1;
