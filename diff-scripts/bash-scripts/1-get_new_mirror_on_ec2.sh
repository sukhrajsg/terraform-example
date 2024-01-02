#!/bin/bash

##########################################
## Author: EXAMPLE 	                    ##
## Created: EXAMPLE 			        ##
## Last updated: EXAMPLE 	        	##
## Title: 1-get_new_mirror_on_ec2.sh    ##
##########################################

## Variables ##

root_dir=/files/diff-scripts

path_dir_apt_mirror_output=$root_dir/output/apt-mirror-output.txt 
path_dir_new_mirror=/files/mirror

new_mirror_bucket=s3://EXAMPLE-rep-new-mirror

## Get new mirror ##
# Getting new mirror, adding that ouutput to the below and cleaning useless files (just in case)

apt-mirror > $root_dir/logs/1-apt-mirror.log
/files/var/clean.sh

## Upload mirror to bucket ##

aws s3 sync $path_dir_new_mirror $new_mirror_bucket --delete --cli-connect-timeout 0 --cli-read-timeout 0 > $root_dir/logs/1-aws-s3-first-sync.log # Some logging
