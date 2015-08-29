#!/usr/bin/perl

use strict;
use warnings;
use HTML::Strip;

my @input_directory  = </media/colby/MyPassport/sec-edgar-data/10-K/*>;
my $output_directory = "/media/colby/MyPassport/sec-edgar-data/10-K-sanitized";

my $total_file_count   = 12673;
my $current_file_count = 0;

foreach my $current_file ( @input_directory )
{
    open( my $INPUT, "<$current_file" ) or die "Failed to open INPUT: $!";
    my $output_file = $current_file;
    $output_file =~ s/.*\///;
    open( my $OUTPUT, ">$output_directory/$output_file" ) or die "Failed to open OUTPUT: $!";
    
    my $hs = HTML::Strip->new();
    
    while ( <$INPUT> )
    {
        my $current_line = $_;
        my $clean_text = $hs->parse( $current_line );
        print $OUTPUT $clean_text;
    }
    
    $hs->eof;
    
    close $INPUT;
    close $OUTPUT;
    
    $current_file_count++;
    print "Current file: " . $current_file_count . "/$total_file_count\n" if ( $current_file_count % 100 == 0 );
}
