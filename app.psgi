use Modern::Perl;
use Plack::Request;
use ACME::MinutesToDegrees;
use JSON::Any;
 
my $j = JSON::Any->new;
my $mtd = ACME::MinutesToDegrees->new;

sub {
  my $json;
  my $req = Plack::Request->new(shift);
  if(my $when = $req->body_parameters->{when}) {
    my $dt = $mtd->parse_when($when);
    my $difference = $mtd->degrees_between($dt->hour, $dt->minute);
    $json = $j->encode({guessed_date=>"$dt",degrees_difference=>$difference});
  } else {
    $json = $j->encode({code=>'Need to POST {when=>"[TIME]"}'});
  }
  [ 200, [ 'Content-Type' => 'application/json' ], [$json] ];
};

=head1 NAME

app.psgi - a sample plack based application

=head1 SYNOPSIS

    plackup -Ilib app.psgi

=head1 DESCRIPTION

This is a little plack application you can POST classic html parameters
and get back the guessed time and degrees difference.  Examples:

Running the app

    plackup -Ilib app.psgi

Using curl to test the service

    curl localhost:5000 
    {"code":"Need to POST {when=>\"[TIME]\"}"}

    curl localhost:5000 --data 'when=9:15'
    {"degrees_difference":180,"guessed_date":"2011-08-25T09:15:00"}

=head1 AUTHOR

John Napiorkowski L<email:jjnapiork@cpan.org>

=head1 SEE ALSO

L<Plack::Request>, L<JSON::Any>, L<ACME::MinutesToDegrees

=head1 COPYRIGHT & LICENSE

Copyright 2011, John Napiorkowski L<email:jjnapiork@cpan.org>

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

