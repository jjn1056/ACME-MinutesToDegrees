#!/usr/bin/env perl

use lib 'maint/lib';
use Maker;

all_from 'lib/ACME/MinutesToDegrees.pm';
requires 'DateTime::Format::Natural' ;
requires 'Moo';
requires 'Getopt::Long';
requires 'Pod::Usage';
requires 'Modern::Perl';
requires 'Plack';
requires 'JSON::Any';

test_requires 'Test::Most';
tests_recursive;
