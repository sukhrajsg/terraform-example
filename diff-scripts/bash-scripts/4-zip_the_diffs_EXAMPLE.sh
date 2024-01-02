#!/bin/bash

##########################################
## Author: EXAMPLE	                    ##
## Created: EXAMPLE			            ##
## Last updated: EXAMPLE	        	##
## Title: 5_zip_the_diffs_EXAMPLE.sh	##
##########################################

## Variables ##
diff_script_dir=/files/diff-scripts

path_dir_rm_output=$diff_script_dir/output/rm-output.txt

diff_files_dir=/files/diff-files
zip_file=$diff_files_dir/diffs.zip

diffs_mirror_bucket=s3://EXAMPLE-rep-diffs

mirror_file_path=$diff_files_dir/archive.ubuntu.com/ubuntu

pool_main_path=$mirror_file_path/pool/main
pool_universe_path=$mirror_file_path/pool/universe

## Zipping the diffs ##
# This takes the files from the diffs bucket, zip it up, and send it elsewhere.
# This version will specifically select the main pool, the dists, and select universe files for EXAMPLE purposes

aws s3 rm $diffs_mirror_bucket --recursive

zip -r $zip_file $mirror_file_path/dists $pool_main_path $path_dir_rm_output $pool_universe_path/0 $pool_universe_path/2 $pool_universe_path/3 $pool_universe_path/4 $pool_universe_path/6 $pool_universe_path/7 $pool_universe_path/9 $pool_universe_path/d $pool_universe_path/g/galera-4 $pool_universe_path/g/gcc-10 $pool_universe_path/l/libdbd-mysql-perl $pool_universe_path/m/maria* $pool_universe_path/p/php* $pool_universe_path/s/syslinux > $diff_script_dir/logs/4-zip-output.log

aws s3 mv $zip_file $diffs_mirror_bucket
