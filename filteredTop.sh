#!/bin/bash        
#title           :filteredTop.sh
#description     :Filters 'top' output.
#author		 :fsgeorgee
#date            :20170916
#version         :0.1
#usage		 :bash filteredTop.sh keyword
#==============================================================================

top -c -p $(pgrep -d',' -f "$1")
