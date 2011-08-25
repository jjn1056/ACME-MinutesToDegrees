package ACME::MinutesToDegrees;

use Moo;
use DateTime::Format::Natural;

use constant {
  DEGREES_PER_MINUTE => 360/60,
  DEGREES_PER_HOUR => 360/12,
};

has datetime_parser => (
  is=>'ro',
  builder=>'_build_datetime_parser',
);

sub _build_datetime_parser { DateTime::Format::Natural->new }

sub from_time_string {
  my ($self, $string_to_parse) = @_;
  my $when = $self->parse_when($string_to_parse);
  return $self->degrees_between($when->hour, $when->minute);
}

sub parse_when {
  my ($self, $parse_string) = @_;
  $self->datetime_parser->parse_datetime($parse_string);
}

sub degrees_between {
  my ($self, $hour, $minutes) = @_;
  my $difference = abs &hours_to_degrees($hour) - &minutes_to_degrees($minutes);
  return $difference > 180 ? $difference - 180 : $difference;
}
sub minutes_to_degrees { DEGREES_PER_MINUTE * shift }

sub hours_to_degrees {
  my $hour = $_[0] > 11 ? ($_[0]-12) : $_[0];
  return DEGREES_PER_HOUR * $hour;
}

sub run {

  require Getopt::Long;
  require Pod::Usage;

  my $parser = Getopt::Long::Parser->new(
    config => [ "no_ignore_case", "pass_through" ],
  );

  my ($show_help, $parse_when);
  $parser->getoptions(
    'help|?' => \$show_help,
    'when=s' => \$parse_when,
  );

  Pod::Usage::pod2usage(1) if $show_help;

  if($parse_when) {
    my $mtd = ACME::MinutesToDegrees->new;
    my $dt = $mtd->parse_when($parse_when);
    my $difference = $mtd->degrees_between($dt->hour, $dt->minute);

    print "I think you meant to say $dt\n";
    print "Degrees between hour (${\$dt->hour}) and minutes (${\$dt->minute}) hands is: $difference\n";
  }

  return 1;
}

caller(1) ? 1 : &run;

=head1 NAME

MinutesToDegrees - Find degree difference between hour and minute hands for any time

=head1 SYNOPSIS

    ## As a module
    my $mtd = ACME::MinutesToDegrees->new;
    say $mtd->from_time_string("3:30"); ## expect '90'

    ## From the commandline
    lib/ACME/MinutesToDegrees.pm --when 3:30

=head1 OPTIONS

=over 4

=item --help

Print a brief help message and exits.

=item --when

Given a string that is like a date / time, try to figure out that time and then
return the number of degrees difference between the hour and minute hands using
relative (shortest distance between the two) measurements.

=back

=head1 DESCRIPTION

This is an example module intended as a technology demo

=head1 AUTHOR

John Napiorkowski L<email:jjnapiork@cpan.org>

=head1 SEE ALSO

L<Modern::Perl>, L<DateTime::Format::Natural>, L<Getopt::Long>, L<Pod::Usage>

=head1 COPYRIGHT & LICENSE

Copyright 2011, John Napiorkowski L<email:jjnapiork@cpan.org>

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut


