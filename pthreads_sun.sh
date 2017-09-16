#!/bin/bash
#title           :pthreads_sun.sh
#description     :Show process threads and CPU/Mem metrics.
#author          :fsgeorgee
#date            :20170918
#version         :0.1
#usage           :bash pthreads_sun.sh keyword
#==============================================================================

prstat -L -p $PID
