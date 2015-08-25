#!/bin/bash

# Format: gvkeyx|from|thru|conm|tic|gvkey|co_conm|co_tic|co_cik
cat master.10k | awk '
BEGIN {
    FS="|"
    print "USE SP500;"
    # print "CREATE TABLE master ( cik VARCHAR(15), co_conm VARCHAR(75), form_type VARCHAR(10), date VARCHAR(10), filename VARCHAR(100));"
} {
    cik       = $1
    co_conm   = sub(/\\/, "", $2)
    form_type = $3
    date      = $4
    filename  = "/" $5
    
    print "INSERT INTO master VALUES (\"" cik "\", \"" co_conm "\", \"" form_type "\", \"" date "\", \"" filename "\");"
}' | mysql -u root -p
