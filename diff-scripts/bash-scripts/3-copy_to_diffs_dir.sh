#!/bin/bash

##########################################
## Author: EXAMPLE						##
## Created: EXAMPLE						##
## Last updated: EXAMPLE				##
## Title: 3-copy_to_diffs_bucket.sh		##
##########################################

## Variables ##

diff_script_dir=/files/diff-scripts

path_dir_sync_output=$diff_script_dir/output/sync-output.txt
path_dir_cp_output=$diff_script_dir/output/cp-output.txt
path_dir_rm_output=$diff_script_dir/output/rm-output.txt

diff_files_dir=/files/diff-files

old_mirror_bucket=s3://EXAMPLE-rep-mirror-copy
new_mirror_bucket=s3://EXAMPLE-rep-new-mirror
diffs_mirror_bucket=s3://EXAMPLE-rep-diffs

## Clear diffs bucket ##
# First, we need to clear the diffs bucket

rm -r $diff_files_dir

## Clearing the outputs ##
# This simply clears the below outputs ready to be appended to

> $path_dir_cp_output
> $path_dir_rm_output
> $diff_script_dir/logs/3-cp-output.log

## Diffs ##
# This takes the snyc output and sorts it in terms of copy or delete

while IFS= read -r line; do
	first_char=$(cut -c-1 <<< "$line") # Gets the first character of each line
	dir_path=$(echo $line | sed 's/.*\: //') # Gets ONLY the path directory
	if [[ $first_char == "c" ]]; then
		aws s3 cp "$new_mirror_bucket/$dir_path" "$diff_files_dir/$dir_path" --cli-connect-timeout 0 --cli-read-timeout 0 >> $diff_script_dir/logs/3-cp-output.log # Copies the 'copy' items from the new mirror bucket to that of the diffs and then appends it to the output file (just for logging)
	else
		echo $dir_path >> $path_dir_rm_output # Appends files to be delete
	fi
done < $path_dir_sync_output # Specifies the output used for the while function

cp $path_dir_rm_output $diff_script_dir/logs/3-rm_output.log # Add rm output to logs
