#!/bin/bash

# Format: gvkeyx|from|thru|conm|tic|gvkey|co_conm|co_tic|co_cik
cat SP500_Constituents_1993-2014.txt | awk '
BEGIN {
    FIELDWIDTHS = "10 8 13 62 13 11 61 12 10"
    print "USE SP500;"
    # print "CREATE TABLE data ( gvkeyx VARCHAR(6), from_date VARCHAR(8), thru_date VARCHAR(8), conm VARCHAR(50), tic VARCHAR(10), gvkey VARCHAR(10), co_conm VARCHAR(62), co_tic VARCHAR(10), co_cik VARCHAR(15));"
} {
    gvkeyx    = $1
    from_date = $2
    thru_date = $3
    conm      = $4
    tic       = $5
    gvkey     = $6
    co_conm   = $7
    co_tic    = $8
    co_cik    = $9
    
    # Remove preceding and trailing whitespace.
    sub(/^ */, "", gvkeyx)
    sub(/ *$/, "", gvkeyx)
    sub(/^ */, "", from_date)
    sub(/ *$/, "", from_date)
    sub(/^ */, "", thru_date)
    sub(/ *$/, "", thru_date)
    sub(/^ */, "", conm)
    sub(/ *$/, "", conm)
    sub(/^ */, "", tic)
    sub(/ *$/, "", tic)
    sub(/^ */, "", gvkey)
    sub(/ *$/, "", gvkey)
    sub(/^ */, "", co_conm)
    sub(/ *$/, "", co_conm)
    sub(/^ */, "", co_tic)
    sub(/ *$/, "", co_tic)
    sub(/^ */, "", co_cik)
    sub(/^0*/, "", co_cik)
    sub(/ *$/, "", co_cik)
    
    print "INSERT INTO sp500 VALUES (\"" gvkeyx "\", \"" from_date "\", \"" thru_date "\", \"" conm "\", \"" tic "\", \"" gvkey "\", \"" co_conm "\", \"" co_tic "\", \"" co_cik "\");"
}' | mysql -u root -p
