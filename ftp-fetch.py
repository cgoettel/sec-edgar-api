#!/usr/bin/python

from ftplib import FTP
import re
import os
import errno

def handleDownload(block):
    local_file_handle.write(block)

def mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as exc: # Python >2.5
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else: raise

user = 'anonymous'
# Uses your e-mail address as the password.
password = 'colby.goettel@gmail.com'

ftp = FTP('ftp.sec.gov')
ftp.login(user, password)

with open('cik-master.10k', 'r') as master_list:
    for line in master_list:
        fields = line.split('|')
        
        CIK      = fields[0]
        date     = fields[1]
        ftp_file = fields[2]
        ftp_file = ftp_file.rstrip()
        
        local_file = '10-K/10-K_' + CIK + "_" + date + ".html"
        
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
