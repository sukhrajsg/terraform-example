#!/bin/bash

##########################################
## Author: EXAMPLE	                    ##
## Created: EXAMPLE			            ##
## Last updated: EXAMPLE		        ##
## Title: 2-create_sync_output.sh	    ##
##########################################

## Variables ##

root_dir=/files/diff-scripts

path_dir_sync_output=$root_dir/output/sync-output.txt

old_mirror_bucket=s3://EXAMPLE-rep-mirror-copy
new_mirror_bucket=s3://EXAMPLE-rep-new-mirror

## Executing a sync dryrun ##
# This section performs a sync dryrun between two different buckets
# The awk command prints the output as "command: path_dir" e.g. "copy: archive.ubuntu.com/ubunutu/dist/file.eg"
# The output is copied into a .txt file

aws s3 sync $new_mirror_bucket $old_mirror_bucket --dryrun --delete --cli-connect-timeout 0 --cli-read-timeout 0 | awk 'match($3,"^(s3://[^/]+/)(.*)",a) {print $2,a[2]}' > $path_dir_sync_output

cp $path_dir_sync_output $root_dir/logs/2-sync-output.log
