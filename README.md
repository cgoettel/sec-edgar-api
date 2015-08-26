# sec-edgar-api
Retrieves all of the 10-K filings listed in the master file in `/edgar/full-index/master` and stores them in `10-K/` based on CIK.

The end goal was to grab every 10-K filing for an S&P500 company. To do this, we did the following:

- Took all of the master files for every quarter since 1994Q1 and parsed out any line containing "10-K". NOTE: discarded 10-K/A, etc.
- These lines were then thrown into an SQL table. NOTE: the SQL statements needed to create the tables is generated in the supplied AWK code. The only thing the user needs to do is ensure that MySQL is installed and that a database named SP500 exists.
- Next, took a master list of S&P500 companies and threw those into another SQL table.
- Selected all similar results with this command: `SELECT cik,date,filename FROM master WHERE cik IN (SELECT co_cik FROM sp500) INTO OUTFILE 'cik-master.10k' FIELDS TERMINATED BY '|';`.
- Ran through `cik-master.10k` and FTP'd all of the 10-K filings. NOTE: this is a huge amount of data. Close to 70GB so make sure you have enough disk space to grab it. Also, it takes about 22 hours to download. Because I knew it wouldn't be too long, I figured it was faster to just download the files than figure out how to multithread an FTP download in Python.
