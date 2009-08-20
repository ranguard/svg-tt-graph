package iCal::2::RSS

use strict;
use warnings;
use XML::RSS;
use iCal::Parser;

my $VERSION = 0.1;

=head1 NAME

iCal::2::RSS

=head1 SYNOPSIS

  my $ical_to_rss = iCal::2::RSS->new({
      ical_file => '/path/to/ical.ics',
  });

  my $rss = $ical_to_rss->rss({
      title => 'London.pm Meetings',
      link => 'http://london.pm.org',
      description => 'The London.pm events feed',
  });


=head1 DESCRIPTION

This module lets you convert an iCal file into a RSS (or atom) feed.

=cut

sub function_name {
    my $self = shift;
    my ( args ) = @_;

    return;
}


=head2 TODO

Accept a ical_url instead of ical_file

=cut


1;