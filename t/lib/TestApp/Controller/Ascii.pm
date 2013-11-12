package TestApp::Controller::Ascii;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Controller::PSGI'; }

use Plack::Response;

my $lolcopter = <<END;
ROFL:ROFL:ROFL:ROFL
         _^___
 L    __/   [] \    
LOL===__        \ 
 L      \________]
         I   I
        --------/
END

my $hypnotoad = <<END;
               ,'``.._   ,'``.
              :,--._:)\,:,._,.:       All Glory to
              :`--,''   :`...';\      the HYPNO TOAD!
               `,'       `---'  `.
               /                 :
              /                   \
            ,'                     :\.___,-.
           `...,---'``````-..._    |:       \
             (                 )   ;:    )   \  _,-.
              `.              (   //          `'    \
               :               `.//  )      )     , ;
             ,-|`.            _,'/       )    ) ,' ,'
            (  :`.`-..____..=:.-':     .     _,' ,'
             `,'\ ``--....-)='    `._,  \  ,') _ '``._
          _.-/ _ `.       (_)      /     )' ; / \ \`-.'
         `--(   `-:`.     `' ___..'  _,-'   |/   `.)
             `-. `.`.``-----``--,  .'
               |/`.\`'        ,','); SSt
                   `         (/  (/
END

my $lolcopter_app = sub {
    my ( $env ) = @_;

    my $res = Plack::Response->new(200);
    $res->content_type('text/html');
    $res->body( "<pre>${lolcopter}</pre>" );

    return $res->finalize;
};

my $hypnotoad_app = sub {
    my ( $env ) = @_;

    my $res = Plack::Response->new(200);
    $res->content_type('text/html');
    $res->body( "<pre>${hypnotoad}</pre>" );

    return $res->finalize;
};

__PACKAGE__->mount( '/lol/copter' => $lolcopter_app );
__PACKAGE__->mount( '/hypnotoad' => $hypnotoad_app );

sub index: Private {
    my ( $self, $c ) = @_;

    $c->res->body('sub index: Private');
}

sub other: Path('other') Args(0) {
    my ( $self, $c ) = @_;

    $c->res->body('normal controller methods work as well!');
}

1;
