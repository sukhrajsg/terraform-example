#!/bin/bash

##########################################
## Author: EXAMPLE	                    ##
## Created: EXAMPLE			            ##
## Last updated: EXAMPLE	        	##
## Title: 5-perform_sync_old_new_s3.sh	##
##########################################

## Variables ##

diff_script_dir=/files/diff-scripts

old_mirror_bucket=s3://EXAMPLE-rep-mirror-copy
new_mirror_bucket=s3://EXAMPLE-rep-new-mirror

## Perform sync from new to old ##

aws s3 sync $new_mirror_bucket $old_mirror_bucket --delete --cli-connect-timeout 0 --cli-read-timeout 0 > $diff_script_dir/logs/5-sync_output.log  
