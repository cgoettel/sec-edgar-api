#!/usr/bin/perl

use strict;
use warnings;

my $flag = 1;

open(INPUT, "<10-K/10-K_65984_2015-02-26.html") or die "Failed to open INPUT: $!";
open(OUTPUT, ">10-K/test.txt") or die "Failed to open OUTPUT: $!";

while ( <INPUT> )
{
    if ( $_ !~ /<html>/ and $flag )
    {
        next;
    }
    else
    {
        $flag = 0;
    }
    
    my $current_line = $_;
    $current_line =~ s/<.*?>/\n/g;
    $current_line =~ s/&#160;/ /g;
    $current_line =~ s/&#252;//g;
    print OUTPUT $current_line;
}

close INPUT;
close OUTPUT;
