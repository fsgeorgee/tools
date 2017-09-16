# Collection of Unix tools
## Purpose

On my daily job I need to perform different analysis and monitoring on Linux, Solaris and sometimes AIX. To make my life a little easier I end up writing a bunch of scripts.

I hope these tools can be of use to someone else, so I'm sharing them here. Do whatever you feel like with these, if you do see room for improvement, please send a pull request!

___
## Linux :penguin:

### filteredTop

Uses pgrep to run top only on processes matching a specific keyword.

**Usage:**

filtered_top.sh KEYWORD

![filtered_top snippet](https://github.com/fsgeorgee/tools/blob/master/images/filtered_top.png "filtered_top snippet")
___
## Solaris

### pthreads_sun.sh

Prints information regarding the process threads.

**Usage:** 

prstat.sh PID

![prstat snippet](https://github.com/fsgeorgee/tools/blob/master/images/prstat.png "prstat snippet")
___
## Cross-platform

### diskLatency.sh

Writes an empty file using dd and measures the time spent.
Useful to check if the disk or the remote storage is writing fast enough.

**Usage:**

diskLatency.sh

![diskLatency snippet](https://github.com/fsgeorgee/tools/blob/master/images/disk_latency.png "diskLatency snippet")

### killZombies.sh

Script that checks for a given processes name and tries to kill remaining instances. It loops over a list of IP address.
- SERVERS = array to hold the IP addresses to ssh into. Note that the script expects the ssh not to require a password.
**Usage:**

killZombies.sh process_name

### getMaxHeap.sh

Parses the GC logs in all files terminated in .log in the current directory (or a single file if -f FILENAME is used) and prints the defined Xmx and the max heap reached.

**Usage:**

- getMaxHeap.sh 
- getMaxHeap.sh -f file

![getMaxHeap snippet](https://github.com/fsgeorgee/tools/blob/master/images/getmaxheap.png "getMaxHeap snippet")

### psloop.sh

Monitors a process and writes a file with PID|VsizeKB|RsizeKB|VsizePG|pmem|time|etime|cpu%|args.

![psloop snippet](https://github.com/fsgeorgee/tools/blob/master/images/psloop.png "psloop snippet")

