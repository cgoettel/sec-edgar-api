#!/usr/bin/perl

use strict;
use warnings;

# Whenever printing this hash, always sort by key so the order remains the same throughout iterations.
my %dictionary = ( 
                  "arts"            => 0,
                  "asset"           => 0,
                  "charitable"      => 0,
                  "charities"       => 0,
                  "charity"         => 0,
                  "citizen"         => 0,
                  "client"          => 0,
                  "communities"     => 0,
                  "community"       => 0,
                  "complied"        => 0,
                  "complies"        => 0,
                  "comply"          => 0,
                  "consumer"        => 0,
                  "customer"        => 0,
                  "earning"         => 0,
                  "education"       => 0,
                  "emission"        => 0,
                  "emit"            => 0,
                  "employee"        => 0,
                  "engagement"      => 0,
                  "environment"     => 0,
                  "ethnic"          => 0,
                  "footprint"       => 0,
                  "government"      => 0,
                  "green"           => 0,
                  "homeless"        => 0,
                  "illiteracy"      => 0,
                  "income"          => 0,
                  "law"             => 0,
                  "legal"           => 0,
                  "legislation"     => 0,
                  "marginalized"    => 0,
                  "minorities"      => 0,
                  "minority"        => 0,
                  "moral"           => 0,
                  "nonprofit"       => 0,
                  "owner"           => 0,
                  "partner"         => 0,
                  "philanthropic"   => 0,
                  "philanthropies"  => 0,
                  "philanthropy"    => 0,
                  "pollute"         => 0,
                  "pollution"       => 0,
                  "profit"          => 0,
                  "purchaser"       => 0,
                  "regulation"      => 0,
                  "regulator"       => 0,
                  "requirement"     => 0,
                  "revenue"         => 0,
                  "safety"          => 0,
                  "sales"           => 0,
                  "shareholder"     => 0,
                  "social"          => 0,
                  "societal"        => 0,
                  "stakeholder"     => 0,
                  "statute"         => 0,
                  "steward"         => 0,
                  "stockholder"     => 0,
                  "supplier"        => 0,
                  "sustainability"  => 0,
                  "sustainable"     => 0,
                  "underprivileged" => 0,
                  "wealth"          => 0,
);

my @input_directory  = </media/colby/MyPassport/sec-edgar-data/10-K-test/*>;

my $total_file_count   = 12673;
my $current_file_count = 0;

open( my $OUTPUT, ">word-frequency.csv" ) or die "Failed to open OUTPUT: $!";

# Set up output file header.
print $OUTPUT "file name|filing date|word count|";
foreach my $word (sort keys %dictionary)
{
    print $OUTPUT "$word|";
}
print $OUTPUT "\n";

# Count words and word frequency in each file, and output them to the .csv.
foreach my $current_file ( @input_directory )
{
    open( my $INPUT, "<$current_file" ) or die "Failed to open INPUT: $!";
    my $file_name = $current_file;
    $file_name =~ s/.*\///;
    
    # Grab the filing date from the file name
    my $filing_date = $file_name;
    $filing_date =~ s/10-K_[0-9]+_(.*).html/$1/;
    
    my $word_count = 0;
    
    while ( <$INPUT> )
    {
        my $current_line = $_;
        chomp $current_line;
        
        $word_count += scalar(split(/\s+/, $current_line));
        
        # Split the line by whitespace.
        foreach my $string (split /\s+/, $current_line)
        {
            # Check if current line contains the word in the dictionary. If it does, strip nonsense surrounding it and add to its count, otherwise skip the line.
            foreach my $word (sort keys %dictionary)
            {
                my $regex = qr/$word/;
                next if ( $string !~ /${regex}/ );
                $string =~ s/.*(${regex}).*/$1/;
                $string = lc $string;
                # print $string . "\n";
                $dictionary{$string}++;
            }
        }
    }
    
    close $INPUT;
    
    print $OUTPUT "$file_name|$filing_date|$word_count|";
    foreach my $word (sort keys %dictionary)
    {
        print $OUTPUT "$dictionary{$word}|";
        
        # Zero out counts for next run.
        $dictionary{$word} = 0;
    }
    print $OUTPUT "\n";
    
    # OG progress bar.
    $current_file_count++;
    print "Current file: " . $current_file_count . "/$total_file_count\n" if ( $current_file_count % 100 == 0 );
}

close $OUTPUT;
