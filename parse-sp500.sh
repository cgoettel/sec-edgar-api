#!/bin/bash

# Format: gvkeyx|from|thru|conm|tic|gvkey|co_conm|co_tic|co_cik
cat SP500_Constituents_1993-2014.txt | awk '
BEGIN {
    FIELDWIDTHS = "10 8 13 62 13 11 61 12 10"
    print "USE SP500;"
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
    sub(/ *$/, "", co_cik)
    
    print "INSERT INTO data VALUES (\"" gvkeyx "\", \"" from_date "\", \"" thru_date "\", \"" conm "\", \"" tic "\", \"" gvkey "\", \"" co_conm "\", \"" co_tic "\", \"" co_cik "\");"
}'
