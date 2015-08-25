#!/usr/bin/python

from ftplib import FTP
import re
import os

def handleDownload(block):
    local_file_handle.write(block)

user = 'anonymous'
# Uses your e-mail address as the password.
password = 'colby.goettel@gmail.com'

ftp = FTP('ftp.sec.gov')
ftp.login(user, password)

# There's a better way of doing this, I know. This gets the job done. Someone who knows Python better than me could (pretty please?) submit a pull request to better-ify it. Thanks.
def fetch_quarterly_reports():
    filing_years = [ '1993', '1994', '1995', '1996', '1997', '1998', '1999', '2000', '2001', '2002', '2003', '2004', '2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015' ]
    filing_quarters = ['QTR1', 'QTR2', 'QTR3', 'QTR4' ]

    for current_year in filing_years:
        for current_quarter in filing_quarters:
            local_file = 'full-index/' + current_year + '.' + current_quarter + '.Z'
            ftp_file = '/edgar/full-index/' + current_year + '/' + current_quarter + '/master.Z'
            
            # Open the file for writing in binary mode
            print 'Opening local file ' + local_file
            local_file_handle = open(local_file, 'wb')
            
            # Download the file a chunk at a time
            # Each chunk is sent to handleDownload
            # We append the chunk to the file and then print a '.' for progress
            # RETR is an FTP command
            print 'Getting ' + ftp_file
            ftp.retrbinary('RETR ' + ftp_file, handleDownload)
            print ''
            
            # Clean up time
            print 'Closing file ' + local_file
            local_file_handle.close()

def fetch_annual_10K():
    pass

# Master format is: CIK|Company Name|Form Type|Date Filed|Filename
# Master file found at ftp://ftp.sec.gov/edgar/full-index/master.Z
with open('master', 'r') as master_list:
    for line in master_list:
        fields = line.split('|')
        
        CIK          = fields[0]
        company_name = fields[1]
        form_type    = fields[2]
        date_filed   = fields[3]
        ftp_file     = '/' + fields[4]
        ftp_file = ftp_file.rstrip()
        
        if form_type != '10-K':
            continue
        
        os.makedirs('10-K/' + CIK)
        
        # Replace the '/' in the filename with a dash.
        local_file = re.sub(r'.*/', '', ftp_file)
        local_file = '10-K/' + CIK + '/' + local_file
        
        # Open the file for writing in binary mode
        print 'Opening local file ' + local_file
        local_file_handle = open(local_file, 'wb')
        
        # Download the file a chunk at a time
        # Each chunk is sent to handleDownload
        # We append the chunk to the file and then print a '.' for progress
        # RETR is an FTP command
        print 'Getting ' + ftp_file
        ftp.retrbinary('RETR ' + ftp_file, handleDownload)
        
        # Clean up time
        print 'Closing file ' + local_file + '\n'
        local_file_handle.close()

ftp.quit()
