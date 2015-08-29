#!/usr/bin/perl

use strict;
use warnings;

my %count;
my $str = "stakeholder";

my @dictionary = [ "arts", "asset", "charitable", "charities", "charity", "citizen", "client", "communities", "community", "complied", "complies", "comply", "complying", "consumer", "customer", "earning", "education", "emission", "emit", "emits", "emitted", "employee", "engagement", "environment", "environmental", "ethnic", "ethnicity", "footprint", "government", "governmental", "green", "homeless ", "illiteracy", "income", "law", "legal", "legality", "legislation", "marginalized", "minorities", "minority", "moral", "nonprofit", "owner", "partner", "philanthropic", "philanthropies", "philanthropy", "pollute", "polluted", "pollution", "profit", "purchaser", "regulation", "regulator", "requirement", "revenue", "safety", "sales", "shareholder", "social", "socially", "societal", "stakeholder", "statute", "statutes", "steward", "stewardship", "stockholder", "supplier", "suppliers", "sustainability", "sustainable", "underprivileged", "wealth" ];

open(INPUT, "<10-K/entergy-sucks.txt") or die "Failed to open INPUT: $!";

while ( <INPUT> )
{
    my $current_line = $_;
    chomp $current_line;
    
    foreach my $str (split /\s+/, $current_line)
    {
        next if ( $str !~ /shareholder/i );
        $str =~ s/.*(shareholder).*/$1/i;
        $str = lc $str;
        $count{$str}++;
    }
}

close INPUT;

foreach my $str (sort keys %count) {
    printf "%-31s %s\n", $str, $count{$str};
}
