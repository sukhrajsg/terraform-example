#!/bin/bash

##################################################
## Author: EXAMPLE 		                        ##
## Created: EXAMPLE 		            		##
## Last updated: EXAMPLE 	            		##
## Title: 0-pause-before-scripts-start.ish    	##
##################################################

## Variables ##

root_file=/files/diff-scripts/logs/0-pause-message.txt

date > $root_file

echo "Warning, the diffs ansible playbook will run in 5 minutes from the above time. 

If you do not want it to run make sure to kill the bash script process - Use 'ps aux' to find the task and kill using 'kill <pid>.'

See you, space cowboy." >> $root_file

