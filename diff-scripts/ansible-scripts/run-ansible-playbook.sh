#!/bin/bash

##########################################
## Author: EXAMPLE                     	##
## Created: EXAMPLE 		           	##
## Last updated: EXAMPLE        		##
## Title: run-ansible-playbook.sh	    ##
##########################################

ansible-playbook -i /files/diff-scripts/ansible-scripts/inventory.yaml /files/diff-scripts/ansible-scripts/playbook.yaml > /files/diff-scripts/logs/ansible-output.log
