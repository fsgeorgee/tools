#!/bin/sh

LOG=diskLatency.$$.log

for i in `seq 1 200`
do
	echo "Time to write 500Kb to disk:" >> $LOG 2>&1
	PATH=`getconf PATH`
	dd if=/dev/zero of=ddfile bs=500k count=1 2> $LOG
	rm ddfile
done

exit 0
