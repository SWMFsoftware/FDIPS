#!/usr/bin/perl -i
use strict;
our @Arguments       = @ARGV;
our $Code            = "FDIPS";
our $MakefileDefOrig = 'src/Makefile.def';
require "share/Scripts/Config.pl";

our %Remaining; # Unprocessed arguments

foreach (@Arguments){
    warn "WARNING: Unknown flag $_\n" if $Remaining{$_};
}


exit;

